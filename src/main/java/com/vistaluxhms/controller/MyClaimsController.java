package com.vistaluxhms.controller;

import com.vistaluxhms.entity.City_Entity;
import com.vistaluxhms.entity.ClientEntity;
import com.vistaluxhms.entity.MyTravelClaimsEntity;
import com.vistaluxhms.entity.SalesPartnerEntity;
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

import javax.transaction.Transactional;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Controller
public class MyClaimsController {

    @Autowired
    UserDetailsServiceImpl userDetailsService;

    @Autowired
    MyClaimsServicesImpl travelClaimService;

    @Autowired
    MyTravelClaimsalidator travelClaimValidator;

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
            travelClaimService.saveOrUpdateClaim(claimObj, bills);
            redirectAttrib.addFlashAttribute("Success", "Travel claim submitted successfully.");
            modelView.setViewName("redirect:view_travel_claims");
        }
        return modelView;
    }

    @RequestMapping("view_travel_claim_list")
    public ModelAndView view_travel_claim_list(@ModelAttribute("TRAVEL_CLAIM_OBJ") MyTravelClaimsDTO travelClaimsDTO,BindingResult result,@RequestParam(value = "page", defaultValue = "0") int page,
                                          @RequestParam(value = "size", defaultValue = VistaluxConstants.DEFAULT_PAGE_SIZE) int pageSize) {

        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("myclaims/viewTravelClaimListing");

        // Adding user details to the model
        modelView.addObject("userName", userObj.getUsername());
        modelView.addObject("Id", userObj.getUserId());

        // Create PageRequest with pagination
        Pageable pageable = PageRequest.of(page, pageSize);

        // Get the paginated list of filtered clients
        Page<MyTravelClaimsEntity> travelClaimFilteredPage = travelClaimService.filterTravelClaims(travelClaimsDTO, pageable);

        // Convert the filtered list to DTOs
        List<MyTravelClaimsDTO> travelClaimsDTOList = generateTravelClaimObj(travelClaimFilteredPage.getContent());

        // Adding filtered clients and pagination details to the model
        modelView.addObject("TRAVEL_CLAIM_FILTERED_LIST", travelClaimsDTOList);
        modelView.addObject("currentPage", page);
        modelView.addObject("totalPages", travelClaimFilteredPage.getTotalPages());
        modelView.addObject("totalClients", travelClaimFilteredPage.getTotalElements());
        modelView.addObject("pageSize", pageSize);

        modelView.addObject("maxPages", travelClaimFilteredPage.getTotalPages());
        modelView.addObject("page", page);
        //modelView.addObject("sortBy", sortBy);

        // modelView.addObject("cityId", searchClientObj.getCityId());
        //modelView.addObject("active", searchClientObj.isActive());

        // Sales Partner Map for the filter
        modelView.addObject("TRAVEL_CLAIM_OBJ", travelClaimsDTO);
        return modelView;
    }
    private List<MyTravelClaimsDTO> generateTravelClaimObj(List<MyTravelClaimsEntity> listTravelClaime) {
        List<MyTravelClaimsDTO> travelClaimsDTOList = new ArrayList<MyTravelClaimsDTO>();

        return travelClaimsDTOList;
    }

}
