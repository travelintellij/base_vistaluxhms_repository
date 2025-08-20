package com.vistaluxhms.services;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.vistaluxhms.entity.*;
import com.vistaluxhms.model.ClientEntityDTO;
import com.vistaluxhms.model.MyTravelClaimsDTO;
import com.vistaluxhms.repository.ClientEntityRepository;
import com.vistaluxhms.repository.MyTravelClaimsEntityRepository;
import com.vistaluxhms.repository.TravelClaimBillRepository;
import com.vistaluxhms.repository.Vlx_City_Master_Repository;
import com.vistaluxhms.util.VistaluxConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.criteria.*;
import javax.transaction.Transactional;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Stream;

@Service
public class MyClaimsServicesImpl {
    @Autowired
    TravelClaimBillRepository travelClaimBillRepository;

    @Autowired
    MyTravelClaimsEntityRepository travelClaimRepository;

    @Autowired
    StatusServiceImpl statusService;

    SimpleDateFormat formatter = new SimpleDateFormat("dd-MMM-yyyy");

    @Transactional
    public void saveOrUpdateClaim(MyTravelClaimsDTO dto, MultipartFile[] files) throws IOException {
        MyTravelClaimsEntity entity;

        if (dto.getTravelClaimId() != null) {
            entity = travelClaimRepository.findById(dto.getTravelClaimId())
                    .orElse(new MyTravelClaimsEntity());
        } else {
            entity = new MyTravelClaimsEntity();
        }

        mapDtoToEntity(dto, entity);

        // save claim first
        MyTravelClaimsEntity savedClaim = travelClaimRepository.save(entity);

        // clear old bills if updating
        if (savedClaim.getBills() != null) {
            savedClaim.getBills().clear();
        }

        if (files != null) {
            for (MultipartFile file : files) {
                if (!file.isEmpty()) {
                    TravelClaimBillEntity bill = new TravelClaimBillEntity();
                    bill.setClaim(savedClaim);
                    bill.setFileName(file.getOriginalFilename());
                    bill.setFileType(file.getContentType());
                    bill.setBillFile(file.getBytes());
                    savedClaim.getBills().add(bill);
                }
            }
        }

        travelClaimRepository.save(savedClaim);
    }

    private void mapDtoToEntity(MyTravelClaimsDTO dto, MyTravelClaimsEntity entity) {
        entity.setSource(dto.getSource());
        entity.setDestination(dto.getDestination());
        entity.setExpenseStartDate(dto.getExpenseStartDate());
        entity.setExpenseEndDate(dto.getExpenseEndDate());
        entity.setClaimDetails(dto.getClaimDetails());
        entity.setTravelMode(dto.getTravelMode());
        entity.setKms(dto.getKms());
        entity.setTravelExpense(dto.getTravelExpense());
        entity.setFoodExpense(dto.getFoodExpense());
        entity.setParkingExpense(dto.getParkingExpense());
        entity.setOtherExpense1(dto.getOtherExpense1());
        entity.setOtherExpense2(dto.getOtherExpense2());
        entity.setOtherExpense3(dto.getOtherExpense3());
        entity.setOtherExpensesDetails(dto.getOtherExpensesDetails());
        entity.setClaimentId(dto.getClaimentId());
        entity.setApproverId(dto.getApproverId());
        entity.setApproverRemarks(dto.getApproverRemarks());
        entity.setClaimStatus(dto.getClaimStatus());
    }


    public List<MyTravelClaimsEntity> filterTravelClaims(MyTravelClaimsDTO searchTravelObj, boolean isAllowedAdmin) {
        //Pageable pageable = PageRequest.of(pageable., pageSize);

        return travelClaimRepository.findAll(new Specification<MyTravelClaimsEntity>() {
            private static final long serialVersionUID = 1L;

            @Override
            public Predicate toPredicate(Root<MyTravelClaimsEntity> travelClaimsEntityRoot, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<>();
                if (searchTravelObj.getTravelClaimId() != null && searchTravelObj.getTravelClaimId() != 0) {
                    predicates.add(criteriaBuilder.equal(travelClaimsEntityRoot.get("travelClaimId"), searchTravelObj.getTravelClaimId()));
                }
                else{
                    // Date filtering logic
                    Calendar cal = Calendar.getInstance();
                    Date periodStart = null;
                    Date periodEnd = null;

                    int dateSelOpt = searchTravelObj.getDateSelOpt() > 0 ? searchTravelObj.getDateSelOpt() : 1;

                    switch (dateSelOpt) {
                        case 1: // Current month
                        default:
                            cal.setTime(new Date());
                            cal.set(Calendar.DAY_OF_MONTH, 1);
                            periodStart = cal.getTime();

                            cal.add(Calendar.MONTH, 1);
                            cal.set(Calendar.DAY_OF_MONTH, 1);
                            cal.add(Calendar.DATE, -1);
                            periodEnd = cal.getTime();
                            break;

                        case 2: // Previous month
                            cal.setTime(new Date());
                            cal.add(Calendar.MONTH, -1);
                            cal.set(Calendar.DAY_OF_MONTH, 1);
                            periodStart = cal.getTime();

                            cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
                            periodEnd = cal.getTime();
                            break;

                        case 3: // Current FY
                            cal.setTime(new Date());
                            int year = cal.get(Calendar.YEAR);
                            int month = cal.get(Calendar.MONTH) + 1;

                            if (month >= 4) {
                                cal.set(year, Calendar.APRIL, 1);
                                periodStart = cal.getTime();

                                cal.set(year + 1, Calendar.MARCH, 31);
                                periodEnd = cal.getTime();
                            } else {
                                cal.set(year - 1, Calendar.APRIL, 1);
                                periodStart = cal.getTime();

                                cal.set(year, Calendar.MARCH, 31);
                                periodEnd = cal.getTime();
                            }
                            break;

                        case 4: // Previous FY
                            cal.setTime(new Date());
                            year = cal.get(Calendar.YEAR);
                            month = cal.get(Calendar.MONTH) + 1;

                            if (month >= 4) {
                                cal.set(year - 1, Calendar.APRIL, 1);
                                periodStart = cal.getTime();

                                cal.set(year, Calendar.MARCH, 31);
                                periodEnd = cal.getTime();
                            } else {
                                cal.set(year - 2, Calendar.APRIL, 1);
                                periodStart = cal.getTime();

                                cal.set(year - 1, Calendar.MARCH, 31);
                                periodEnd = cal.getTime();
                            }
                            break;

                        case 5: // DTO range
                            if (searchTravelObj.getExpenseStartDate() != null && searchTravelObj.getExpenseEndDate() != null) {
                                periodStart = searchTravelObj.getExpenseStartDate();
                                periodEnd = searchTravelObj.getExpenseEndDate();
                            }
                            break;
                    }

                    if (periodStart != null && periodEnd != null) {
                        predicates.add(criteriaBuilder.and(
                                criteriaBuilder.lessThanOrEqualTo(travelClaimsEntityRoot.get("expenseStartDate"), periodEnd),
                                criteriaBuilder.greaterThanOrEqualTo(travelClaimsEntityRoot.get("expenseEndDate"), periodStart)
                        ));
                    }
                }

                System.out.println("Admin or approver is " + isAllowedAdmin + "    | Claimant Id is " + searchTravelObj.getClaimentId());

                if(!isAllowedAdmin || searchTravelObj.getClaimentId()!=null) {
                    if(searchTravelObj.getClaimentId()>0) {
                        predicates.add(criteriaBuilder.equal(travelClaimsEntityRoot.get("claimentId"), searchTravelObj.getClaimentId()));
                    }
                }
                if(searchTravelObj.getClaimStatus()>0) {
                    predicates.add(criteriaBuilder.equal(travelClaimsEntityRoot.get("claimStatus"), searchTravelObj.getClaimStatus()));
                }

                return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
            }
        });
    }

    public MyTravelClaimsEntity findTravelClaimById(Long travelClaimId){
        //return travelClaimRepository.findById(travelClaimId).get();

        return travelClaimRepository.findById(travelClaimId)
                .orElseThrow(() -> new IllegalArgumentException("Claim not found"));
    }

    public MyTravelClaimsDTO findTravelClaimDTOById(MyTravelClaimsDTO dto,Long travelClaimId){
        return mapEntityToDTO(dto,travelClaimRepository.findById(travelClaimId).get());
    }


    private MyTravelClaimsDTO mapEntityToDTO(MyTravelClaimsDTO dto,MyTravelClaimsEntity entity) {
        dto.setSource(entity.getSource());
        dto.setDestination(entity.getDestination());
        dto.setExpenseStartDate(entity.getExpenseStartDate());
        dto.setExpenseEndDate(entity.getExpenseEndDate());
        dto.setClaimDetails(entity.getClaimDetails());
        dto.setTravelMode(entity.getTravelMode());
        dto.setKms(entity.getKms());
        dto.setTravelExpense(entity.getTravelExpense());
        dto.setFoodExpense(entity.getFoodExpense());
        dto.setParkingExpense(entity.getParkingExpense());
        dto.setOtherExpense1(entity.getOtherExpense1());
        dto.setOtherExpense2(entity.getOtherExpense2());
        dto.setOtherExpense3(entity.getOtherExpense3());
        dto.setOtherExpensesDetails(entity.getOtherExpensesDetails());
        dto.setClaimentId(entity.getClaimentId());
        dto.setApproverId(entity.getApproverId());
        dto.setApproverRemarks(entity.getApproverRemarks());
        dto.setBillsEntity(entity.getBills());
        dto.setFormattedExpenseStartDate(formatter.format(entity.getExpenseStartDate()));
        dto.setFormattedExpenseEndDate(formatter.format(entity.getExpenseEndDate()));
        if(statusService.findStatusById(entity.getClaimStatus())!=null) {
            dto.setStatusName(statusService.findStatusById(entity.getClaimStatus()).getStatusName());
        }
        dto.setTravelModeName(VistaluxConstants.CLAIM_TRAVEL_MODE.get(entity.getTravelMode()));
        int totalClaimAmount = entity.getTravelExpense() + entity.getFoodExpense() + entity.getParkingExpense() + entity.getOtherExpense1() + entity.getOtherExpense2() + entity.getOtherExpense3();
        dto.setTotalClaimAmount(totalClaimAmount);
        dto.setClaimStatus(entity.getClaimStatus());
        return dto;
    }

    public TravelClaimBillEntity findTravelClaimBillById(Long travelClaimBillId){
        return travelClaimBillRepository.findById(travelClaimBillId).get();
    }


    public void saveTravelClaimEntity(MyTravelClaimsEntity travelClaimsEntity){
        travelClaimRepository.save(travelClaimsEntity);
    }

    public void saveTravelClaimBill(TravelClaimBillEntity travelClaimBillEntity){
        travelClaimBillRepository.save(travelClaimBillEntity);
    }

    public void deleteAllTravelBills( List<TravelClaimBillEntity> travelClaimBillEntityList){
        travelClaimBillRepository.deleteAll(travelClaimBillEntityList);
    }


    public byte[] generatePdf(List<MyTravelClaimsDTO> claimsList) {
        ByteArrayOutputStream out = new ByteArrayOutputStream();

        try {
            Document document = new Document(PageSize.A4);
            PdfWriter.getInstance(document, out);
            document.open();

            // Title
            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16);
            document.add(new Paragraph("Travel Claims Report", titleFont));
            document.add(Chunk.NEWLINE);

            // Table with headers
            PdfPTable table = new PdfPTable(7); // 7 columns
            table.setWidthPercentage(100);

            // Header row
            Stream.of("Claim ID", "Claimant", "Source", "Destination",
                            "Expense Start Date", "Expense End Date", "Status")
                    .forEach(headerTitle -> {
                        PdfPCell header = new PdfPCell();
                        Font headFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD);
                        header.setBackgroundColor(BaseColor.LIGHT_GRAY);
                        header.setHorizontalAlignment(Element.ALIGN_CENTER);
                        header.setPhrase(new Phrase(headerTitle, headFont));
                        table.addCell(header);
                    });

            // Rows
            for (MyTravelClaimsDTO claim : claimsList) {
                table.addCell(String.valueOf(claim.getTravelClaimId()));
                table.addCell(claim.getClaimantName());
                table.addCell(claim.getSource());
                table.addCell(claim.getDestination());
                table.addCell(claim.getFormattedExpenseStartDate());
                table.addCell(claim.getFormattedExpenseEndDate());
                table.addCell(claim.getStatusName());
            }

            document.add(table);
            document.close();

        } catch (DocumentException e) {
            e.printStackTrace();
        }

        return out.toByteArray();
    }

}
