package com.vistaluxhms.services;

import com.vistaluxhms.entity.*;
import com.vistaluxhms.model.LeadFollowupReportDTO;
import com.vistaluxhms.repository.Leads_Followup_Repository;
import org.springframework.beans.factory.annotation.Autowired;
import com.vistaluxhms.util.VistaluxConstants;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.*;
import javax.servlet.ServletOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

@Service
public class LeadFollowupReportService {

    @Autowired
    private Leads_Followup_Repository followupRepository;

    @Autowired
    private UserDetailsServiceImpl userDetailsService;

    public List<Leads_Followup_Entity> filterFollowups(LeadFollowupReportDTO filter, int currentUserId, boolean isAdmin) {
        return followupRepository.findAll(new Specification<Leads_Followup_Entity>() {
            @Override
            public Predicate toPredicate(Root<Leads_Followup_Entity> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicates = new ArrayList<>();
                Join<Leads_Followup_Entity, LeadEntity> leadJoin = root.join("leadEntity", JoinType.INNER);

                // Date Filter (Next Followup Time)
                if (filter.getStartDate() != null && !filter.getStartDate().isEmpty()) {
                    LocalDateTime start = LocalDate.parse(filter.getStartDate()).atStartOfDay();
                    LocalDateTime end = LocalDate.parse(filter.getEndDate()).atTime(LocalTime.MAX);
                    predicates.add(cb.between(root.get("nextfollowuptime"), start, end));
                }

                // Status Filter (100 = All Open/WIP Category, 200 = All Closed/Terminal Category)
                if (filter.getLeadStatus() == VistaluxConstants.VIEW_ALL_OPEN_LEADS_WL_STATUS) {
                    Root<Workload_Status_Entity> workloadStatusRoot = query.from(Workload_Status_Entity.class);
                    predicates.add(cb.equal(workloadStatusRoot.get("workloadCategory"), VistaluxConstants.VIEW_WL_OPEN));
                    predicates.add(cb.equal(leadJoin.get("leadStatus"), workloadStatusRoot.get("workloadStatusId")));
                } else if (filter.getLeadStatus() == VistaluxConstants.VIEW_ALL_CLOSED_LEADS_WL_STATUS) {
                    Root<Workload_Status_Entity> workloadStatusRoot = query.from(Workload_Status_Entity.class);
                    predicates.add(cb.equal(workloadStatusRoot.get("workloadCategory"), VistaluxConstants.VIEW_WL_CLOSED));
                    predicates.add(cb.equal(leadJoin.get("leadStatus"), workloadStatusRoot.get("workloadStatusId")));
                } else if (filter.getLeadStatus() > 0) {
                    predicates.add(cb.equal(leadJoin.get("leadStatus"), filter.getLeadStatus()));
                }

                // Permission & Ownership/Contribution Logic
                if (isAdmin) {
                    // Admin: If a specific owner is selected, filter by that user (Owner or Contributor)
                    if (filter.getLeadOwner() > 0) {
                        predicates.add(createOwnerOrContributorPredicate(cb, query, leadJoin, filter.getLeadOwner()));
                    }
                } else {
                    // Standard User: Always filter by their own ID (Owner or Contributor)
                    predicates.add(createOwnerOrContributorPredicate(cb, query, leadJoin, currentUserId));
                }

                query.distinct(true);
                return cb.and(predicates.toArray(new Predicate[0]));
            }
        });
    }

    /**
     * Builds a predicate that matches if the user is the direct Lead Owner 
     * OR if the user is part of the Lead's team (Contributor).
     */
    private Predicate createOwnerOrContributorPredicate(CriteriaBuilder cb, CriteriaQuery<?> query, 
                                                       Join<Leads_Followup_Entity, LeadEntity> leadJoin, 
                                                       int targetUserId) {
        // 1. User is the Primary Lead Owner
        Predicate isOwner = cb.equal(leadJoin.get("leadOwner"), targetUserId);
        
        // 2. User is part of the Lead's Team (Contributor)
        // We use a subquery to avoid complex joins and potential duplicate rows
        Subquery<Long> teamSubquery = query.subquery(Long.class);
        Root<LeadEntity> subLead = teamSubquery.from(LeadEntity.class);
        Join<LeadEntity, AshokaTeam> subTeam = subLead.join("team");
        
        teamSubquery.select(subLead.get("leadId"))
            .where(cb.and(
                cb.equal(subLead.get("leadId"), leadJoin.get("leadId")),
                cb.equal(subTeam.get("userId"), targetUserId)
            ));
        
        Predicate isContributor = cb.exists(teamSubquery);
        
        return cb.or(isOwner, isContributor);
    }

    public void exportFollowupsToExcel(List<Leads_Followup_Entity> list, OutputStream out) throws IOException {
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Followups Report");

        // Header
        Row header = sheet.createRow(0);
        String[] columns = {"Lead ID", "Client Name", "Last Response", "Response Time", "Next Follow-up", "Next Plan", "Owner"};
        
        for (int i = 0; i < columns.length; i++) {
            Cell cell = header.createCell(i);
            cell.setCellValue(columns[i]);
            CellStyle headerStyle = workbook.createCellStyle();
            org.apache.poi.ss.usermodel.Font font = workbook.createFont();
            font.setBold(true);
            headerStyle.setFont(font);
            cell.setCellStyle(headerStyle);
        }

        // Data
        int rowNum = 1;
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MMM-yyyy HH:mm");
        
        for (Leads_Followup_Entity f : list) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(f.getLeadEntity().getLeadId());
            row.createCell(1).setCellValue(f.getLeadEntity().getClient() != null ? f.getLeadEntity().getClient().getClientName() : "");
            row.createCell(2).setCellValue(f.getResponse() != null ? f.getResponse() : "");
            row.createCell(3).setCellValue(f.getFollowuptime() != null ? f.getFollowuptime().format(formatter) : "");
            row.createCell(4).setCellValue(f.getNextfollowuptime() != null ? f.getNextfollowuptime().format(formatter) : "");
            row.createCell(5).setCellValue(f.getNextactionplan() != null ? f.getNextactionplan() : "");
            String ownerName = String.valueOf(f.getLeadEntity().getLeadOwner());
            try {
                AshokaTeam owner = userDetailsService.findUserByID(f.getLeadEntity().getLeadOwner());
                if (owner != null) {
                    ownerName = owner.getUsername();
                }
            } catch (Exception e) {
                // Keep ID as fallback
            }
            row.createCell(6).setCellValue(ownerName);
        }

        // Auto-size columns
        for (int i = 0; i < columns.length; i++) {
            sheet.autoSizeColumn(i);
        }

        workbook.write(out);
        workbook.close();
    }
}
