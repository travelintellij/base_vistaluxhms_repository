package com.vistaluxhms.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import com.vistaluxhms.model.CentralConfigEntityDTO;
import com.vistaluxhms.model.UserDetailsObj;
import com.vistaluxhms.services.SettingsAndOtherServicesImpl;
import com.vistaluxhms.services.UserDetailsServiceImpl;
// ===== AI MODIFICATION START =====
// Change: Added imports for dashboard lead analytics
// Reason: Dashboard needs lead statistics data for charts
// Scope: LoginController — home() method
import com.vistaluxhms.repository.LeadEntityRepository;
import com.vistaluxhms.entity.Workload_Status_Entity;
import com.vistaluxhms.util.VistaluxConstants;
import java.util.List;
// ===== AI MODIFICATION END =====
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.security.Principal;

@Controller
public class LoginController {

    @Autowired
    UserDetailsServiceImpl userDetailsService;

    @Autowired
    private SettingsAndOtherServicesImpl settingService;

    // ===== AI MODIFICATION START =====
    // Change: Autowired LeadEntityRepository for dashboard analytics
    // Reason: Dashboard needs lead count data for charts
    // Scope: LoginController — used in home() method
    @Autowired
    private LeadEntityRepository leadEntityRepository;
    // ===== AI MODIFICATION END =====

    @RequestMapping("/welcome")
    public ModelAndView firstPage(@RequestHeader(value = "Authorization") String authorizationHeader) {
        // System.out.println("Request Header is " + authorizationHeader);
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        } else {
            username = principal.toString();
        }
        UserDetailsObj userObj = (UserDetailsObj) userDetailsService.loadUserByUsername(username);

        ModelAndView mapview = new ModelAndView("welcome");
        mapview.addObject("address", userObj.getAddress());
        mapview.addObject("fixedIncentive", userObj.getFixedIncentive());
        mapview.addObject("Id", userObj.getUserId());
        mapview.addObject("mobile", userObj.getMobile());
        mapview.addObject("name", userObj.getName());
        mapview.addObject("shift", userObj.getShift());
        mapview.addObject("type", userObj.getType());
        mapview.addObject("dob", userObj.getDob());
        mapview.addObject("doj", userObj.getDoj());
        mapview.addObject("designation", userObj.getDesignation());
        mapview.addObject("active", userObj.isActive());
        // mapview.addObject("userRole", userObj.getRoles());
        mapview.addObject("email", userObj.getEmail());
        mapview.addObject("userObj", userObj);
        // mapview.addObject(userObj);

        // System.out.println(userObj);
        return mapview;
    }

    @RequestMapping(value = "/hello", method = RequestMethod.POST)
    public String hello() {
        return "Hello World";
    }

    @RequestMapping("/user")
    public String user() {
        return "<H1> Welcome User </H1>";
    }

    @RequestMapping("/admin")
    public String admin() {
        return "<H1> Welcome Admin </H1>";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView loginPage(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView modelView = new ModelAndView();
        modelView.setViewName("/login");
        // System.out.println("Login controller is invoked. ");

        return modelView;

    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logoutPage(HttpServletRequest request, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        return "redirect:/";
    }

    @GetMapping("/view_workloadhome")
    public String home(Model model, Principal principal) {
        // ===== ORIGINAL CODE (kept) =====
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        boolean isAdmin = authentication.getAuthorities().stream()
                .anyMatch(auth -> auth.getAuthority().equals("ROLE_ADMIN"));

        boolean isLeadManager = authentication.getAuthorities().stream()
                .anyMatch(auth -> auth.getAuthority().equals("ROLE_LEAD_MANAGER"));

        CentralConfigEntityDTO centralConfigEntity = settingService.getCentralConfig();

        String roleMessage = isAdmin ? "Admin" : "User";
        model.addAttribute("message", roleMessage);

        String username = principal.getName();
        UserDetailsObj userObj = (UserDetailsObj) userDetailsService.loadUserByUsername(username);
        model.addAttribute("userName", userObj.getUsername());
        model.addAttribute("userDisplayName", userObj.getName());
        model.addAttribute("hotelName", centralConfigEntity.getHotelName());
        model.addAttribute("isAdmin", isAdmin);

        // ===== AI MODIFICATION START =====
        // Change: Added lead analytics data for dashboard charts
        // Reason: Dashboard needs graphical lead analytics — admin sees all, user sees
        // own
        // Scope: LoginController.home() — resortHomePage.jsp dashboard
        try {
            int userId = userObj.getUserId();
            boolean showAllLeads = isAdmin || isLeadManager;

            // Get lead status names from workload_status table
            List<Workload_Status_Entity> leadStatusList = leadEntityRepository
                    .find_All_Status_Workload_Obj(VistaluxConstants.WORKLOAD_LEAD_STATUS);

            // Build status names and counts
            StringBuilder statusLabelsJson = new StringBuilder("[");
            StringBuilder statusCountsJson = new StringBuilder("[");
            long totalLeads;
            long qualifiedLeads;
            long flaggedLeads;

            if (showAllLeads) {
                totalLeads = leadEntityRepository.count();
                qualifiedLeads = leadEntityRepository.countByQualifiedTrue();
                flaggedLeads = leadEntityRepository.countByFlaggedTrue();

                for (int i = 0; i < leadStatusList.size(); i++) {
                    Workload_Status_Entity status = leadStatusList.get(i);
                    long count = leadEntityRepository.countByLeadStatus(status.getWorkloadStatusId());
                    statusLabelsJson.append("\"" + status.getWorkloadStatusName() + "\"");
                    statusCountsJson.append(count);
                    if (i < leadStatusList.size() - 1) {
                        statusLabelsJson.append(",");
                        statusCountsJson.append(",");
                    }
                }
            } else {
                totalLeads = leadEntityRepository.countByLeadOwner(userId);
                qualifiedLeads = leadEntityRepository.countByLeadOwnerAndQualifiedTrue(userId);
                flaggedLeads = leadEntityRepository.countByLeadOwnerAndFlaggedTrue(userId);

                for (int i = 0; i < leadStatusList.size(); i++) {
                    Workload_Status_Entity status = leadStatusList.get(i);
                    long count = leadEntityRepository.countByLeadOwnerAndLeadStatus(userId,
                            status.getWorkloadStatusId());
                    statusLabelsJson.append("\"" + status.getWorkloadStatusName() + "\"");
                    statusCountsJson.append(count);
                    if (i < leadStatusList.size() - 1) {
                        statusLabelsJson.append(",");
                        statusCountsJson.append(",");
                    }
                }
            }

            statusLabelsJson.append("]");
            statusCountsJson.append("]");

            model.addAttribute("totalLeads", totalLeads);
            model.addAttribute("qualifiedLeads", qualifiedLeads);
            model.addAttribute("flaggedLeads", flaggedLeads);
            model.addAttribute("statusLabels", statusLabelsJson.toString());
            model.addAttribute("statusCounts", statusCountsJson.toString());
            model.addAttribute("showAllLeads", showAllLeads);

        } catch (Exception e) {
            // Graceful fallback — dashboard still renders without charts
            model.addAttribute("totalLeads", 0L);
            model.addAttribute("qualifiedLeads", 0L);
            model.addAttribute("flaggedLeads", 0L);
            model.addAttribute("statusLabels", "[]");
            model.addAttribute("statusCounts", "[]");
            model.addAttribute("showAllLeads", false);
        }
        // ===== AI MODIFICATION END =====

        return "resortHomePage";
    }

    @RequestMapping("AdminHome")
    public ModelAndView showAdminHome(@ModelAttribute("userobj") @Valid UserDetailsObj userDetailsObj,
            BindingResult result, ModelMap model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        } else {
            username = principal.toString();
        }

        UserDetailsObj userObj = (UserDetailsObj) userDetailsService.loadUserByUsername(username);

        ModelAndView mapview = new ModelAndView();
        // mapview.addObject("userRole", userObj.getRoles());
        mapview.addObject("userName", userObj.getUsername());
        mapview.setViewName("admin/AdminHome");
        mapview.addObject("userName", userObj.getUsername());
        mapview.addObject("address", userObj.getAddress());
        mapview.addObject("fixedIncentive", userObj.getFixedIncentive());
        mapview.addObject("Id", userObj.getUserId());
        mapview.addObject("mobile", userObj.getMobile());
        mapview.addObject("name", userObj.getName());
        mapview.addObject("shift", userObj.getShift());
        mapview.addObject("type", userObj.getType());
        mapview.addObject("dob", userObj.getDob());
        mapview.addObject("doj", userObj.getDoj());
        mapview.addObject("designation", userObj.getDesignation());
        mapview.addObject("active", userObj.isActive());
        mapview.addObject("email", userObj.getEmail());
        mapview.addObject(userObj);
        return mapview;
    }

}
