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
        return modelView;
    }

    @Transactional
    @PostMapping("submit_travel_claim")
    public ModelAndView submitTravelClaim(@ModelAttribute("MY_TRAVEL_CLAIMS_OBJ") MyTravelClaimsDTO claimObj,
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

        // validate using your validator framework
        travelClaimValidator.validate(travelClaimForm, result);

        if (result.hasErrors()) {
            modelView = view_add_travel_claim_form(claimObj, result);
            return modelView;
        } else {
            //travelClaimService.saveClaimWithBills(claimObj, bills != null ? List.of(bills) : List.of());
            redirectAttrib.addFlashAttribute("Success", "Travel claim submitted successfully.");
            modelView.setViewName("redirect:view_travel_claims");
        }

        return modelView;
    }


}
