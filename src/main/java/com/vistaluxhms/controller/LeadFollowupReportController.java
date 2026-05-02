package com.vistaluxhms.controller;

import com.vistaluxhms.entity.Leads_Followup_Entity;
import com.vistaluxhms.model.LeadFollowupReportDTO;
import com.vistaluxhms.model.UserDetailsObj;
import com.vistaluxhms.model.WorkLoadStatusVO;
import com.vistaluxhms.services.LeadFollowupReportService;
import com.vistaluxhms.services.UserDetailsServiceImpl;
import com.vistaluxhms.services.VlxCommonServicesImpl;
import com.vistaluxhms.util.VistaluxConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
public class LeadFollowupReportController {

    @Autowired
    private LeadFollowupReportService reportService;

    @Autowired
    private UserDetailsServiceImpl userDetailsService;

    @Autowired
    private VlxCommonServicesImpl commonService;

    private UserDetailsObj getLoggedInUser() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = (principal instanceof UserDetails) ? ((UserDetails) principal).getUsername() : principal.toString();
        return (UserDetailsObj) userDetailsService.loadUserByUsername(username);
    }

    @RequestMapping(value = "view_lead_followup_report", method = {RequestMethod.GET, RequestMethod.POST})


    public ModelAndView viewLeadFollowupReport(@ModelAttribute("FILTER_OBJ") LeadFollowupReportDTO filter) {
        ModelAndView mav = new ModelAndView("leads/view_leadFollowupReport");
        UserDetailsObj user = getLoggedInUser();

        boolean isAdmin = user.getAuthorities().stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN") || a.getAuthority().equals("LEAD_MANAGER"));

        // Simplified Status Filter: 100 for Open, 200 for Closed (System Standard)
        Map<Integer, String> statusMap = new LinkedHashMap<>();
        statusMap.put(0, "*** All Status ***");
        statusMap.put(VistaluxConstants.VIEW_ALL_OPEN_LEADS_WL_STATUS, "Open");
        statusMap.put(VistaluxConstants.VIEW_ALL_CLOSED_LEADS_WL_STATUS, "Closed");
        mav.addObject("LEAD_STATUS_MAP", statusMap);

        // Map for row-level display (actual status like "Failed", "WIP")
        List<WorkLoadStatusVO> allStatusList = commonService.find_All_Active_Status_Workload_Obj(VistaluxConstants.WORKLOAD_LEAD_STATUS);
        Map<Integer, String> fullStatusMap = allStatusList.stream()
                .collect(Collectors.toMap(WorkLoadStatusVO::getWorkloadStatusId, WorkLoadStatusVO::getWorkloadStatusName));
        mav.addObject("FULL_STATUS_MAP", fullStatusMap);

        // Get all users for name resolution in the table
        List<UserDetailsObj> allUsersList = userDetailsService.findAllActiveUsers();
        Map<Integer, String> activeUsersMap = allUsersList.stream()
                .collect(Collectors.toMap(
                    UserDetailsObj::getUserId, 
                    UserDetailsObj::getUsername,
                    (existing, replacement) -> existing
                ));
        mav.addObject("ACTIVE_USERS_MAP", activeUsersMap);

        if (isAdmin) {
            // isAdmin specific logic if any (currently activeUsersMap is used in filter dropdown)
        }

        List<Leads_Followup_Entity> followupList = reportService.filterFollowups(filter, user.getUserId(), isAdmin);

// ✅ Default sort
        if (filter.getSortOrder() == null || filter.getSortOrder().isEmpty()) {
            filter.setSortOrder("asc");
        }

// ✅ Null-safe sorting
        followupList.sort((a, b) -> {

            if (a.getNextfollowuptime() == null && b.getNextfollowuptime() == null) return 0;
            if (a.getNextfollowuptime() == null) return 1;   // nulls last
            if (b.getNextfollowuptime() == null) return -1;

            return "desc".equalsIgnoreCase(filter.getSortOrder())
                    ? b.getNextfollowuptime().compareTo(a.getNextfollowuptime())
                    : a.getNextfollowuptime().compareTo(b.getNextfollowuptime());
        });



        mav.addObject("FOLLOWUP_LIST", followupList);
        mav.addObject("LEAD_STATUS_MAP", statusMap);
        mav.addObject("isAdmin", isAdmin);
        
        return mav;
    }


    @GetMapping("/exportFollowupsExcel")
    public void exportFollowupsExcel(@ModelAttribute("FILTER_OBJ") LeadFollowupReportDTO filter, HttpServletResponse response) throws IOException {
        UserDetailsObj user = getLoggedInUser();
        boolean isAdmin = user.getAuthorities().stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN") || a.getAuthority().equals("LEAD_MANAGER"));

        List<Leads_Followup_Entity> followupList = reportService.filterFollowups(filter, user.getUserId(), isAdmin);
        // ✅ Default sort
        if (filter.getSortOrder() == null || filter.getSortOrder().isEmpty()) {
            filter.setSortOrder("asc");
        }

// ✅ Null-safe sorting (ONLY ONCE)
        followupList.sort((a, b) -> {

            if (a.getNextfollowuptime() == null && b.getNextfollowuptime() == null) return 0;
            if (a.getNextfollowuptime() == null) return 1;   // nulls last
            if (b.getNextfollowuptime() == null) return -1;

            return "desc".equalsIgnoreCase(filter.getSortOrder())
                    ? b.getNextfollowuptime().compareTo(a.getNextfollowuptime())
                    : a.getNextfollowuptime().compareTo(b.getNextfollowuptime());
        });

        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=followups_report.xlsx");

        reportService.exportFollowupsToExcel(followupList, response.getOutputStream());
    }
}
