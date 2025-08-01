package com.vistaluxhms.controller;

import com.vistaluxhms.entity.*;
import com.vistaluxhms.model.*;
import com.vistaluxhms.repository.Vlx_City_Master_Repository;
import com.vistaluxhms.services.*;
import com.vistaluxhms.util.VistaluxConstants;
import com.vistaluxhms.validator.MyTravelClaimsalidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@Controller
public class MyClaimsController {

    @Autowired
    UserDetailsServiceImpl userDetailsService;

    @Autowired
    MyClaimsServicesImpl travelClaimService;

    @Autowired
    MyTravelClaimsalidator travelClaimValidator;

    @Autowired
    StatusServiceImpl statusService;

    @Autowired
    private EmailServiceImpl emailService;

    SimpleDateFormat formatter = new SimpleDateFormat("dd-MMM-yyyy");

    private UserDetailsObj getLoggedInUser() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails)principal).getUsername();
        } else {
            username = principal.toString();
        }
        UserDetailsObj userObj = (UserDetailsObj) userDetailsService.loadUserByUsername(username);

        return userObj;
    }

    @RequestMapping("view_add_claim_form")
    public ModelAndView view_add_client_form(@ModelAttribute("MY_CLAIMS_OBJ") MyClaimsEntityDTO myClaimsEntityDto, BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("myclaims/Add_My_Claim");
        modelView.addObject("CLAIM_TYPE_MAP",VistaluxConstants.CLAIM_TYPE_MAP);
        return modelView;
    }

    @RequestMapping("view_add_travel_claim_form")
    public ModelAndView view_add_travel_claim_form(@ModelAttribute("MY_TRAVEL_CLAIMS_OBJ") MyTravelClaimsDTO myClaimsEntityDto, BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("myclaims/Add_My_Travel_Claim");
        modelView.addObject("CLAIM_TYPE_MAP",VistaluxConstants.CLAIM_TYPE_MAP);
        modelView.addObject("CLAIM_TRAVEL_MODE",VistaluxConstants.CLAIM_TRAVEL_MODE);
        return modelView;
    }

    @RequestMapping("view_view_travel_claim_form")
    public ModelAndView view_view_travel_claim_form(@ModelAttribute("MY_TRAVEL_CLAIMS_OBJ") MyTravelClaimsDTO myClaimsEntityDto, BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("myclaims/view_My_Travel_Claim");
        myClaimsEntityDto = travelClaimService.findTravelClaimDTOById(myClaimsEntityDto,myClaimsEntityDto.getTravelClaimId());
        //modelView.addObject("CLAIM_TYPE_MAP",VistaluxConstants.CLAIM_TYPE_MAP);
        modelView.addObject("CLAIM_TRAVEL_MODE",VistaluxConstants.CLAIM_TRAVEL_MODE);
        modelView.addObject("TRAV_EXP_DEF_STATUS", VistaluxConstants.TRAV_EXP_DEF_STATUS);

        return modelView;
    }


    @Transactional
    @PostMapping("create_create_my_travel_claim")
    public ModelAndView create_create_my_travel_claim(@ModelAttribute("MY_TRAVEL_CLAIMS_OBJ") MyTravelClaimsDTO claimObj,
            @RequestParam(value = "bills", required = false) MultipartFile[] bills,BindingResult result,final RedirectAttributes redirectAttrib) throws IOException {
        UserDetailsObj userObj = getLoggedInUser();
        MyTravelClaimForm travelClaimForm = new MyTravelClaimForm();
        travelClaimForm.setClaim(claimObj);
        travelClaimForm.setBills(bills);
        travelClaimValidator.validate(travelClaimForm, result);
        if (claimObj.getClaimentId() == null || claimObj.getClaimentId() == 0) {
            claimObj.setClaimentId(userObj.getUserId());
        }
        ModelAndView modelView = new ModelAndView();
        if (result.hasErrors()) {
            modelView = view_add_travel_claim_form(claimObj, result);
            return modelView;
        } else {
            claimObj.setClaimStatus(VistaluxConstants.TRAV_EXP_DEF_STATUS);
            travelClaimService.saveOrUpdateClaim(claimObj, bills);
            redirectAttrib.addFlashAttribute("Success", "Travel claim submitted successfully.");
            modelView.setViewName("redirect:view_travel_claim_list?view_travelclaimlist");
        }
        return modelView;
    }

    @RequestMapping(value = "view_travel_claim_list", params = "view_travelclaimlist", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView view_travel_claim_list(@ModelAttribute("TRAVEL_CLAIM_OBJ") MyTravelClaimsDTO travelClaimsDTO,BindingResult result,@RequestParam(value = "page", defaultValue = "0") int page,
                                          @RequestParam(value = "size", defaultValue = VistaluxConstants.DEFAULT_PAGE_SIZE) int pageSize) {

        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("myclaims/viewTravelClaimListing");

        // Adding user details to the model
        modelView.addObject("userName", userObj.getUsername());
        modelView.addObject("Id", userObj.getUserId());

        //filterObj.setLeadOwner(user.getUserId());
        boolean isAllowedAdmin=false;
        if(userObj.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_SUPERADMIN") || a.getAuthority().equals("ROLE_EXPENSE_APPROVER"))) {
            isAllowedAdmin=true;
        }

        //System.out.println("Lead Filter Owner is " + filterObj.getLeadOwner());

        if(!isAllowedAdmin) {
            travelClaimsDTO.setClaimentId(userObj.getUserId());
        }


        // Create PageRequest with pagination
        //Pageable pageable = PageRequest.of(page, pageSize);

        // Get the paginated list of filtered clients
        //Page<MyTravelClaimsEntity> travelClaimFilteredPage = travelClaimService.filterTravelClaims(travelClaimsDTO, pageable,isAllowedAdmin);
        List<MyTravelClaimsEntity> travelClaimFilteredPage = travelClaimService.filterTravelClaims(travelClaimsDTO, isAllowedAdmin);
        // Convert the filtered list to DTOs
        List<MyTravelClaimsDTO> travelClaimsDTOList = generateTravelClaimObj(travelClaimFilteredPage);
        // Adding filtered clients and pagination details to the model
        modelView.addObject("TRAVEL_CLAIM_FILTERED_LIST", travelClaimsDTOList);
        //modelView.addObject("currentPage", page);
        //modelView.addObject("totalPages", travelClaimFilteredPage.getTotalPages());
        ///modelView.addObject("totalClients", travelClaimFilteredPage.getTotalElements());
        //modelView.addObject("pageSize", pageSize);

        //modelView.addObject("maxPages", travelClaimFilteredPage.getTotalPages());
        //modelView.addObject("page", page);
        modelView.addObject("TRAV_EXP_DEF_STATUS", VistaluxConstants.TRAV_EXP_DEF_STATUS);

        List<UserDetailsObj> activeUsersList = userDetailsService.findAllActiveUsers();
        Map<Integer, String> activeUsersMap = (Map<Integer, String>) activeUsersList.stream().collect(
                Collectors.toMap(UserDetailsObj::getUserId, UserDetailsObj::getUsername));
        modelView.addObject("ACTIVE_USERS_MAP", activeUsersMap);
        modelView.addObject("DATE_SEL_OPTIONS", VistaluxConstants.DATE_SEL_OPTIONS);
        List<StatusEntity> listStatus = statusService.findAllActiveStatusList();
        Map<Integer, String> TRAV_EXP_STATUS_MAP = listStatus.stream()
                .collect(Collectors.toMap(
                        StatusEntity::getStatusId,       // key = statusId
                        StatusEntity::getStatusName  // value = statusName
                ));
        modelView.addObject("TRAV_EXP_STATUS_MAP", TRAV_EXP_STATUS_MAP);

        //modelView.addObject("sortBy", sortBy);

        // modelView.addObject("cityId", searchClientObj.getCityId());
        //modelView.addObject("active", searchClientObj.isActive());

        // Sales Partner Map for the filter
        modelView.addObject("TRAVEL_CLAIM_OBJ", travelClaimsDTO);
        return modelView;
    }
    private List<MyTravelClaimsDTO> generateTravelClaimObj(List<MyTravelClaimsEntity> listTravelClaims) {
        List<MyTravelClaimsDTO> travelClaimsDTOList = new ArrayList<MyTravelClaimsDTO>();
        for(int i=0;i<listTravelClaims.size();i++){
            MyTravelClaimsEntity travelClaimsEntity = listTravelClaims.get(i);
            MyTravelClaimsDTO myTravelClaimsDTO = new MyTravelClaimsDTO(travelClaimsEntity);
            myTravelClaimsDTO.setFormattedExpenseStartDate(formatter.format(myTravelClaimsDTO.getExpenseStartDate()));
            myTravelClaimsDTO.setFormattedExpenseEndDate(formatter.format(myTravelClaimsDTO.getExpenseEndDate()));
            myTravelClaimsDTO.setStatusName(statusService.findStatusById(travelClaimsEntity.getClaimStatus()).getStatusName());
            myTravelClaimsDTO.setClaimantName(userDetailsService.findUserByID(travelClaimsEntity.getClaimentId()).getName());
            myTravelClaimsDTO.setClaimStatus(travelClaimsEntity.getClaimStatus());
            travelClaimsDTOList.add(myTravelClaimsDTO);
        }
        return travelClaimsDTOList;
    }

    @RequestMapping(value = "view_travel_claim_list", params = "download_travelclaimlist", method = {RequestMethod.GET, RequestMethod.POST})
    public void download_travelclaimlist(@ModelAttribute("TRAVEL_CLAIM_OBJ") MyTravelClaimsDTO travelClaimsDTO,BindingResult result,HttpServletResponse response) throws IOException {
        UserDetailsObj userObj = getLoggedInUser();
        boolean isAllowedAdmin=false;
        if(userObj.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_SUPERADMIN") || a.getAuthority().equals("ROLE_EXPENSE_APPROVER"))) {
            isAllowedAdmin=true;
        }
        if(!isAllowedAdmin) {
            travelClaimsDTO.setClaimentId(userObj.getUserId());
        }
        List<MyTravelClaimsEntity> travelClaimFilteredPage = travelClaimService.filterTravelClaims(travelClaimsDTO, isAllowedAdmin);
        List<MyTravelClaimsDTO> travelClaimsDTOList = generateTravelClaimObj(travelClaimFilteredPage);

        byte[] pdfBytes = travelClaimService.generatePdf(travelClaimsDTOList);
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=travel_claims.pdf");
        response.getOutputStream().write(pdfBytes);
    }

    @RequestMapping(value = "view_travel_claim_list", params = "email_travelclaimlist", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView email_travelclaimlist(@ModelAttribute("TRAVEL_CLAIM_OBJ") MyTravelClaimsDTO travelClaimsDTO,BindingResult result,HttpServletResponse response,final RedirectAttributes redirectAttrib) throws IOException {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("redirect:view_travel_claim_list?view_travelclaimlist");
        boolean isAllowedAdmin=false;
        if(userObj.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_SUPERADMIN") || a.getAuthority().equals("ROLE_EXPENSE_APPROVER"))) {
            isAllowedAdmin=true;
        }
        if(!isAllowedAdmin) {
            travelClaimsDTO.setClaimentId(userObj.getUserId());
        }
        List<MyTravelClaimsEntity> travelClaimFilteredPage = travelClaimService.filterTravelClaims(travelClaimsDTO, isAllowedAdmin);
        List<MyTravelClaimsDTO> travelClaimsDTOList = generateTravelClaimObj(travelClaimFilteredPage);

        try {
            String subject = "Travel Claims Report";
            String body = buildEmailBody(travelClaimsDTOList); // Create formatted HTML

            // Send using EmailServiceImpl
            emailService.sendMailWithHtml(travelClaimsDTO.getEmailId(), subject, body);
            redirectAttrib.addFlashAttribute("Success", "Email sent successfully!");
            return modelView;
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttrib.addFlashAttribute("Error", "Failed to send email!");
            return modelView;
        }
    }

    private String buildEmailBody(List<MyTravelClaimsDTO> claimsList) {
        if (claimsList == null || claimsList.isEmpty()) {
            return "No claims found for the selected filter criteria.";
        }

        StringBuilder emailBody = new StringBuilder();
        emailBody.append("<p>Dear User,</p>");
        emailBody.append("<p>Please find below the filtered travel claims report:</p>");

        emailBody.append("<table border='1' cellpadding='6' cellspacing='0' style='border-collapse:collapse; width:100%; font-family: Arial, sans-serif; font-size: 14px;'>");
        emailBody.append("<thead style='background-color:#f2f2f2;'>");
        emailBody.append("<tr>");
        emailBody.append("<th>Claim ID</th>");
        emailBody.append("<th>Claimant</th>");
        emailBody.append("<th>Source</th>");
        emailBody.append("<th>Destination</th>");
        emailBody.append("<th>Start Date</th>");
        emailBody.append("<th>End Date</th>");
        emailBody.append("<th>Status</th>");
        emailBody.append("</tr>");
        emailBody.append("</thead>");
        emailBody.append("<tbody>");

        for (MyTravelClaimsDTO claim : claimsList) {
            emailBody.append("<tr>");
            emailBody.append("<td>").append(claim.getTravelClaimId()).append("</td>");
            emailBody.append("<td>").append(claim.getClaimantName()).append("</td>");
            emailBody.append("<td>").append(claim.getSource()).append("</td>");
            emailBody.append("<td>").append(claim.getDestination()).append("</td>");
            emailBody.append("<td>").append(claim.getFormattedExpenseStartDate()).append("</td>");
            emailBody.append("<td>").append(claim.getFormattedExpenseEndDate()).append("</td>");
            emailBody.append("<td>").append(claim.getStatusName()).append("</td>");
            emailBody.append("</tr>");
        }

        emailBody.append("</tbody>");
        emailBody.append("</table>");
        emailBody.append("<br><p>Regards,<br><b>AxisHMS Pro</b></p>");

        return emailBody.toString();
    }

    private String formatDate(Date date) {
        if (date == null) return "";
        return new SimpleDateFormat("dd-MMM-yyyy").format(date);
    }


    @GetMapping("/travel-claim/bill/{billId}")
    public void viewBill(@PathVariable Long billId, HttpServletResponse response) throws IOException {
        TravelClaimBillEntity bill = travelClaimService.findTravelClaimBillById(billId);

        response.setContentType(bill.getFileType());
        response.setHeader("Content-Disposition", "inline; filename=\"" + bill.getFileName() + "\"");
        response.getOutputStream().write(bill.getBillFile());
        response.flushBuffer();
    }

    @PostMapping("view_edit_travel_claim_form")
    public ModelAndView view_edit_travel_claim_form(@ModelAttribute("MY_TRAVEL_CLAIMS_OBJ") MyTravelClaimsDTO myClaimsEntityDto, BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("myclaims/edit_My_Travel_Claim");
        myClaimsEntityDto = travelClaimService.findTravelClaimDTOById(myClaimsEntityDto,myClaimsEntityDto.getTravelClaimId());
        modelView.addObject("CLAIM_TYPE_MAP",VistaluxConstants.CLAIM_TYPE_MAP);
        modelView.addObject("CLAIM_TRAVEL_MODE",VistaluxConstants.CLAIM_TRAVEL_MODE);
        modelView.addObject("TRAV_EXP_DEF_STATUS", VistaluxConstants.TRAV_EXP_DEF_STATUS);

        List<StatusEntity> listStatus = statusService.findAllActiveStatusList();
        Map<Integer, String> TRAV_EXP_STATUS_MAP = listStatus.stream()
                .collect(Collectors.toMap(
                        StatusEntity::getStatusId,       // key = statusId
                        StatusEntity::getStatusName  // value = statusName
                ));
        modelView.addObject("TRAV_EXP_STATUS_MAP", TRAV_EXP_STATUS_MAP);

        return modelView;
    }




    @Transactional
    @PostMapping("edit_edit_my_travel_claim")
    public ModelAndView edit_edit_my_travel_claim(@ModelAttribute("MY_TRAVEL_CLAIMS_OBJ") MyTravelClaimsDTO claimObj,
                                                  @RequestParam(value = "deleteBillIds", required = false) List<Long> deleteBillIds, @RequestParam(value = "bills", required = false) MultipartFile[] bills,BindingResult result,final RedirectAttributes redirectAttrib) throws IOException {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView();
        MyTravelClaimsEntity existingClaim = travelClaimService.findTravelClaimById(claimObj.getTravelClaimId());
        updateTravelEntity(existingClaim,claimObj);
        boolean isSuperAdmin = userObj.getAuthorities()
                .stream()
                .anyMatch(auth -> auth.getAuthority().equals("ROLE_SUPERADMIN"));
        boolean isExpenseApprover = userObj.getRoles()
                .stream()
                .anyMatch(role -> role.getRoleName().equals("EXPENSE_APPROVER"));
        if(isSuperAdmin || isExpenseApprover){
            existingClaim.setClaimStatus(claimObj.getClaimStatus());
        }

        MyTravelClaimForm travelClaimForm = new MyTravelClaimForm();
        travelClaimForm.setClaim(claimObj);
        travelClaimForm.setBills(bills);
        travelClaimValidator.validate(travelClaimForm, result);
        int remainingFiles = existingClaim.getBills().size() - (deleteBillIds != null ? deleteBillIds.size() : 0);
        if (bills != null) {
            if (remainingFiles + bills.length > 5) {
                result.rejectValue("bills", "too.many.files", "Total files cannot exceed 5 per claim.");
            }
        }
        if (result.hasErrors()) {
            modelView = view_edit_travel_claim_form(claimObj, result);
            return modelView;
        }
        if (deleteBillIds != null && !deleteBillIds.isEmpty()) {
            List<TravelClaimBillEntity> toRemove = existingClaim.getBills().stream()
                    .filter(b -> deleteBillIds.contains(b.getId()))
                    .collect(Collectors.toList());
            existingClaim.getBills().removeAll(toRemove);
        }
        if (bills != null) {
            for (MultipartFile file : bills) {
                if (file.isEmpty()) continue;
                TravelClaimBillEntity bill = new TravelClaimBillEntity();
                bill.setFileName(file.getOriginalFilename());
                bill.setFileType(file.getContentType());
                bill.setBillFile(file.getBytes());
                bill.setClaim(existingClaim);
                existingClaim.getBills().add(bill);
            }
        }
        // Step 4: Now delete the removed ones from DB
        /*if(toRemove.size()>0) {
            travelClaimService.deleteAllTravelBills(toRemove);
        }*/

        travelClaimService.saveTravelClaimEntity(existingClaim);
        redirectAttrib.addFlashAttribute("Success", "Travel claim record updated successfully.");
        modelView.setViewName("redirect:view_travel_claim_list?view_travelclaimlist");
        return modelView;
    }


    private void updateTravelEntity(MyTravelClaimsEntity entity,MyTravelClaimsDTO dto){
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
        //entity.setClaimentId(dto.getClaimentId());
        entity.setApproverId(dto.getApproverId());
        entity.setApproverRemarks(dto.getApproverRemarks());

        //entity.setClaimStatus(dto.getClaimStatus());
    }



}
