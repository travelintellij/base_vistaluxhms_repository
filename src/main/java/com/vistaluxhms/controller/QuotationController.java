package com.vistaluxhms.controller;

import com.vistaluxhms.entity.*;
import com.vistaluxhms.model.*;
import com.vistaluxhms.repository.Vlx_City_Master_Repository;
import com.vistaluxhms.services.*;
import com.vistaluxhms.util.VistaluxConstants;
import com.vistaluxhms.validator.LeadValidator;
import com.vistaluxhms.validator.QuotationValidator;
import freemarker.template.TemplateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.mail.MessagingException;
import javax.transaction.Transactional;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@Controller
public class QuotationController {

    @Autowired
    UserDetailsServiceImpl userDetailsService;

    @Autowired
    ClientServicesImpl clientService;

    @Autowired
    Vlx_City_Master_Repository cityRepository;

    @Autowired
    VlxCommonServicesImpl commonService;

    @Autowired
    SalesRelatesServicesImpl salesService;

    @Autowired
    LeadValidator leadValidator;

    @Autowired
    LeadServicesImpl leadService;
    @Autowired
    EmailServiceImpl emailService;

    @Value("${email.client.valid}")
    private boolean emailClientNotifyActive;

    @Autowired
    QuotationValidator quotationValidator;

    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

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

    @RequestMapping("view_add_quotation_form")
    public ModelAndView view_add_quotation_form(@ModelAttribute("QUOTATION_OBJ") QuotationEntityDTO quotationEntityDTO, BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        if (quotationEntityDTO.getRoomDetails() == null || quotationEntityDTO.getRoomDetails().isEmpty()) {
            quotationEntityDTO.setRoomDetails(new ArrayList<>()); // Only initialize if it's empty
        }


        ModelAndView modelView = new ModelAndView("quotation/createQuotation");
        Map<Long, String> mapSalesPartner =  salesService.getActiveSalesPartnerMap(true);
        modelView.addObject("SALES_PARTNER_MAP", mapSalesPartner);
        List<RateTypeEntity> listRateType = salesService.findAllActiveRateTypes(true);
        Map<Integer, String> rateTypeMap = listRateType.stream()
                .collect(Collectors.toMap(RateTypeEntity::getRateTypeId, RateTypeEntity::getRateTypeName));
        modelView.addObject("RATE_TYPE_MAP", rateTypeMap);
        List<MasterRoomDetailsEntity> listRoomType = salesService.findActiveRoomsList();
        Map<Integer, String> roomTypeMap = listRoomType.stream()
                .collect(Collectors.toMap(MasterRoomDetailsEntity::getRoomCategoryId, MasterRoomDetailsEntity::getRoomCategoryName));
        modelView.addObject("ROOM_TYPE_MAP", roomTypeMap);
        modelView.addObject("MEAL_PLAN_MAP",VistaluxConstants.MEAL_PLANS_MAP);

        modelView.addObject("userName", userObj.getUsername());

        return modelView;
    }

    @PostMapping(value="create_create_quotation")
    public ModelAndView create_create_quotation(@ModelAttribute("QUOTATION_OBJ") QuotationEntityDTO quotationEntityDTO,BindingResult result, final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser(); // Retrieve logged-in user details
        ModelAndView modelView = new ModelAndView("forward:view_add_quotation_form");  // Return to the same JSP

        /*for (QuotationRoomDetailsDTO emp : quotationEntityDTO.getRoomDetails()) {
            System.out.println(emp); // Calls toString() implicitly
        }*/

        // Initialize roomDetails list if null
        if (quotationEntityDTO.getRoomDetails() == null) {
            quotationEntityDTO.setRoomDetails(new ArrayList<>());
        }

        // Remove empty rows from roomDetails list
        List<QuotationRoomDetailsDTO> validRooms = quotationEntityDTO.getRoomDetails().stream()
                .filter(room -> room.getRoomCategoryId() > 0 && room.getMealPlanId() > 0)
                .collect(Collectors.toList());

        quotationEntityDTO.setRoomDetails(validRooms);

        quotationValidator.validate(quotationEntityDTO,result);
        if(result.hasErrors()) {
            System.out.println("Rejecting this because of adult issue");
            modelView = view_add_quotation_form( quotationEntityDTO, result);
            return modelView;
        }

        // Add object back to model so JSP can retrieve it
        modelView.addObject("QUOTATION_OBJ", quotationEntityDTO);
        return modelView;
    }



}
