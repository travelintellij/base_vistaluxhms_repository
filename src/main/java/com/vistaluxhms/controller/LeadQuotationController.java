package com.vistaluxhms.controller;

import com.lowagie.text.DocumentException;
import com.vistaluxhms.entity.*;
import com.vistaluxhms.model.*;
import com.vistaluxhms.repository.Vlx_City_Master_Repository;
import com.vistaluxhms.services.*;
import com.vistaluxhms.util.VistaluxConstants;
import com.vistaluxhms.validator.LeadSystemQuotationValidator;
import com.vistaluxhms.validator.LeadValidator;
import com.vistaluxhms.validator.QuotationValidator;
import freemarker.core.Configurable;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
//@SessionAttributes("QUOTATION_OBJ")
public class LeadQuotationController {

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

    @Autowired
    WhatsAppMessagingService whatsAppService;

    @Value("${ANY_ROOM_CHILD_NO_BED_PERCENTAGE}")
    private int ANY_ROOM_CHILD_NO_BED_PERCENTAGE;

    @Value("${ANY_ROOM_EXTRA_BED_ADULT_PERCENTAGE}")
    private int ANY_ROOM_EXTRA_BED_ADULT_PERCENTAGE;

    @Value("${ANY_ROOM_EXTRA_BED_CHILD_PERCENTAGE}")
    private int ANY_ROOM_EXTRA_BED_CHILD_PERCENTAGE;

    @Value("${ANY_ROOM_STANDARD_OCCUPANCY_INCREASE_PERCENTAGE}")
    private int ANY_ROOM_STANDARD_OCCUPANCY_INCREASE_PERCENTAGE;

    @Value("${all.email.notify.communication.active}")
    private boolean emailNotifyActive;

    @Value("${email.notify.communication.email}")
    private String emailNotifyBcc;

    private static final DateTimeFormatter OUTPUT_FORMAT = DateTimeFormatter.ofPattern("dd MMM yyyy");

    @Autowired
    LeadSystemQuotationValidator quotationValidator;

    @Autowired
    SessionServiceImpl sessionService;

    @Value("${ANY_ROOM_CHILD_NO_BED_ALLOWED}")
    private int ANY_ROOM_CHILD_NO_BED_ALLOWED;

    @Autowired
    private Configuration freemarkerConfig;

    @ModelAttribute("QUOTATION_OBJ")
    public QuotationEntityDTO getQuotationFromSession(HttpSession session) {
        QuotationEntityDTO quotation = (QuotationEntityDTO) session.getAttribute("QUOTATION_OBJ");
        return (quotation != null) ? quotation : new QuotationEntityDTO(); // Ensure a non-null object
    }


    SimpleDateFormat formatter = new SimpleDateFormat("dd-MMM-yyyy");

    private UserDetailsObj getLoggedInUser() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        } else {
            username = principal.toString();
        }
        UserDetailsObj userObj = (UserDetailsObj) userDetailsService.loadUserByUsername(username);

        return userObj;
    }


    @RequestMapping(value="view_system_leads_quotes",method= {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView view_system_leads_quotes( @ModelAttribute("LEAD_OBJ") LeadEntityDTO leadRecorderObj,
                                           BindingResult result, HttpSession session, final RedirectAttributes redirectAttrib){

        System.out.println("Lead id received is " + leadRecorderObj.getLeadId());
        ModelAndView modelView = new ModelAndView("quotation/view_lead_system_quote");
        LeadEntity leadEntity = leadService.findLeadById(leadRecorderObj.getLeadId());
        leadRecorderObj.updateLeadVoFromEntity(leadEntity);
        leadRecorderObj.setLeadOwnerName(userDetailsService.findUserByID(leadRecorderObj.getLeadOwner()).getUsername());
        leadRecorderObj.setStatusName(commonService.findWorkLoadStatusById(leadRecorderObj.getLeadStatus()).getWorkloadStatusName());
        leadRecorderObj.setFormattedCheckInDate(formatter.format(leadEntity.getCheckInDate()));
        leadRecorderObj.setFormattedCheckOutDate(formatter.format(leadEntity.getCheckOutDate()));
        //modelView.addObject("LEAD_OBJ",leadRecorderObj);
        //leadRecorderObj.setLeadId(new Long(35));
        //System.out.println(filterObj);
        //List<WorkLoadStatusVO> lead_wl_statusList = commonService.find_All_Active_Status_Workload_Obj(VistaluxConstants.WORKLOAD_LEAD_STATUS);
        return modelView;
    }


    @RequestMapping("view_create_lead_system_quotation")
    public ModelAndView view_create_lead_system_quotation(@ModelAttribute("LEAD_SYSTEM_QUOTATION_OBJ") LeadSystemQuotationEntityDTO quotationEntityDTO,@ModelAttribute("LEAD_OBJ") LeadEntityDTO leadRecorderObj, HttpSession session, BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        session.removeAttribute("QUOTATION_OBJ");
        session.removeAttribute("QUOTATION_OBJ_" + userObj.getUserId());

        if (quotationEntityDTO.getRoomDetails() == null || quotationEntityDTO.getRoomDetails().isEmpty()) {
            quotationEntityDTO.setRoomDetails(new ArrayList<>()); // Only initialize if it's empty
        }
        ModelAndView modelView = new ModelAndView("quotation/createLeadSystemQuotation");
        Map<Long, String> mapSalesPartner = salesService.getActiveSalesPartnerMap(true);
        modelView.addObject("SALES_PARTNER_MAP", mapSalesPartner);
        List<RateTypeEntity> listRateType = salesService.findAllActiveRateTypes(true);
        Map<Integer, String> rateTypeMap = listRateType.stream()
                .collect(Collectors.toMap(RateTypeEntity::getRateTypeId, RateTypeEntity::getRateTypeName));
        modelView.addObject("RATE_TYPE_MAP", rateTypeMap);
        List<MasterRoomDetailsEntity> listRoomType = salesService.findActiveRoomsList();
        Map<Integer, String> roomTypeMap = listRoomType.stream()
                .collect(Collectors.toMap(MasterRoomDetailsEntity::getRoomCategoryId, MasterRoomDetailsEntity::getRoomCategoryName));
        modelView.addObject("ROOM_TYPE_MAP", roomTypeMap);
        modelView.addObject("MEAL_PLAN_MAP", VistaluxConstants.MEAL_PLANS_MAP);
        modelView.addObject("userName", userObj.getUsername());

        LeadEntity leadEntity = leadService.findLeadById(leadRecorderObj.getLeadId());
        leadRecorderObj.updateLeadVoFromEntity(leadEntity);
        leadRecorderObj.setLeadOwnerName(userDetailsService.findUserByID(leadRecorderObj.getLeadOwner()).getUsername());
        leadRecorderObj.setStatusName(commonService.findWorkLoadStatusById(leadRecorderObj.getLeadStatus()).getWorkloadStatusName());
        leadRecorderObj.setFormattedCheckInDate(formatter.format(leadEntity.getCheckInDate()));
        leadRecorderObj.setFormattedCheckOutDate(formatter.format(leadEntity.getCheckOutDate()));
        quotationEntityDTO.setLeadEntity(leadEntity);
        quotationEntityDTO.setClientEntity(leadEntity.getClient());

        return modelView;
    }


    @RequestMapping(value = "review_process_create_system_quotation", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView review_process_create_system_quotation(@ModelAttribute("LEAD_SYSTEM_QUOTATION_OBJ") LeadSystemQuotationEntityDTO quotationEntityDTO,@ModelAttribute("LEAD_OBJ") LeadEntityDTO leadRecorderObj, BindingResult result, HttpSession session, final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("forward:view_add_quotation_form");

        if (quotationEntityDTO.getRoomDetails() == null) {
            quotationEntityDTO = (LeadSystemQuotationEntityDTO) session.getAttribute("QUOTATION_OBJ_" + userObj.getUserId());
            if (quotationEntityDTO.getRoomDetails() == null) {
                quotationEntityDTO.setRoomDetails(new ArrayList<>());
            }
        }
        List<LeadSystemQuotationRoomDetailsEntity> validRooms = quotationEntityDTO.getRoomDetails().stream()
                .filter(room -> room.getRoomCategoryId() > 0 && room.getMealPlanId() > 0)
                .collect(Collectors.toList());

        quotationEntityDTO.setRoomDetails(validRooms);

        quotationValidator.validate(quotationEntityDTO, result);
        if (result.hasErrors()) {
            modelView =  view_create_lead_system_quotation(quotationEntityDTO,leadRecorderObj, session,  result);
            return modelView;
        } else {
            int grandTotalSum = 0;
            ClientEntity clientEntity = clientService.findClientById(quotationEntityDTO.getClientEntity().getClientId());
            quotationEntityDTO.setClientEntity(clientEntity);
            List<SessionRateMappingEntity> sessionRateMappingEntities = sessionService.getMappingsByRateTypeId(clientEntity.getSalesPartner().getRateTypeEntity().getRateTypeId());
            List<LeadSystemQuotationRoomDetailsEntityDTO> listRoomDetailsDTO = new ArrayList<LeadSystemQuotationRoomDetailsEntityDTO>() ;

            for (LeadSystemQuotationRoomDetailsEntity quotationRoomDetailsEntity : validRooms) {
                LeadSystemQuotationRoomDetailsEntityDTO quotationRoomDTO = new LeadSystemQuotationRoomDetailsEntityDTO();
                quotationRoomDTO.updateLeadRoomDetailsDTOFromLeadRoomEntity(quotationRoomDetailsEntity);
                //quotationRoomDTO.setRoomCategoryName(salesService.findRoomCategoryById(quotationRoomDTO.getRoomCategoryId()).getRoomCategoryName());
                //quotationRoomDTO.setMealPlanName(VistaluxConstants.MEAL_PLANS_MAP.get(quotationRoomDTO.getMealPlanId()));
                LocalDate checkIn = quotationRoomDTO.getCheckInDate();
                LocalDate checkOut = quotationRoomDTO.getCheckOutDate();
                int totalAdultPrice = 0;
                int totalChildWithBedPrice = 0;
                int totalChildNoBedPrice = 0;
                int totalExtraBedPrice = 0;

                while (!checkIn.isAfter(checkOut.minusDays(1))) { // Loop from check-in to checkout - 1 day
                    SessionDetailsEntity sessionDetailsEntity = sessionService.getSessionDetails_Rate_And_Date_and_MealPlan(
                            sessionRateMappingEntities, checkIn, quotationRoomDTO.getRoomCategoryId(), quotationRoomDTO.getMealPlanId()
                    );

                    if (sessionDetailsEntity != null) {
                        int dayPrice = processTotalPrice(quotationRoomDTO, sessionDetailsEntity);
                        grandTotalSum += dayPrice;

                        totalAdultPrice += quotationRoomDTO.getAdultPrice();
                        totalChildWithBedPrice += quotationRoomDTO.getChildWithBedPrice();
                        totalChildNoBedPrice += quotationRoomDTO.getChildNoBedPrice();
                        totalExtraBedPrice += quotationRoomDTO.getExtraBedPrice();
                    }
                    checkIn = checkIn.plusDays(1);
                }
                quotationRoomDTO.setAdultPrice(totalAdultPrice);
                quotationRoomDTO.setChildWithBedPrice(totalChildWithBedPrice);
                quotationRoomDTO.setChildNoBedPrice(totalChildNoBedPrice);
                quotationRoomDTO.setExtraBedPrice(totalExtraBedPrice);
                quotationRoomDTO.setTotalPrice(totalAdultPrice + totalChildWithBedPrice + totalChildNoBedPrice + totalExtraBedPrice);
                quotationRoomDTO.setFormattedCheckInDate(checkIn.format(OUTPUT_FORMAT));
                quotationRoomDTO.setFormattedCheckOutDate(checkOut.format(OUTPUT_FORMAT));
                quotationRoomDTO.setRoomCategoryName(salesService.findRoomCategoryById(quotationRoomDTO.getRoomCategoryId()).getRoomCategoryName());
                quotationRoomDTO.setMealPlanName(VistaluxConstants.MEAL_PLANS_MAP.get(quotationRoomDTO.getMealPlanId()));
                listRoomDetailsDTO.add(quotationRoomDTO);
            }
            quotationEntityDTO.setGrandTotal(grandTotalSum);
            quotationEntityDTO.setRoomDetailsDTO(listRoomDetailsDTO);
        }
        session.setAttribute("QUOTATION_OBJ_" + userObj.getUserId(), quotationEntityDTO);

        modelView.addObject("QUOTATION_OBJ", quotationEntityDTO);
        LeadEntity leadEntity = leadService.findLeadById(quotationEntityDTO.getLeadEntity().getLeadId());
        leadRecorderObj.updateLeadVoFromEntity(leadEntity);
        leadRecorderObj.setLeadOwnerName(userDetailsService.findUserByID(leadRecorderObj.getLeadOwner()).getUsername());
        leadRecorderObj.setStatusName(commonService.findWorkLoadStatusById(leadRecorderObj.getLeadStatus()).getWorkloadStatusName());
        leadRecorderObj.setFormattedCheckInDate(formatter.format(leadEntity.getCheckInDate()));
        leadRecorderObj.setFormattedCheckOutDate(formatter.format(leadEntity.getCheckOutDate()));

        modelView.setViewName("quotation/reviewSystemQuotation");
        return modelView;
    }

    private int processTotalPrice(LeadSystemQuotationRoomDetailsEntityDTO quotationRoomDTO, SessionDetailsEntity sessionDetailsEntity) {
        int totalPrice = 0;
        int childWithBedPrice = 0;
        int childNoBedPrice = 0;
        int extraBedPrice = 0;

        if (quotationRoomDTO.getAdults() == 1) {
            quotationRoomDTO.setAdultPrice(sessionDetailsEntity.getPerson1());
            totalPrice += sessionDetailsEntity.getPerson1();
        } else if (quotationRoomDTO.getAdults() == 2) {
            quotationRoomDTO.setAdultPrice(sessionDetailsEntity.getPerson2());
            totalPrice += sessionDetailsEntity.getPerson2();
        } else if (quotationRoomDTO.getAdults() == 3) {
            quotationRoomDTO.setAdultPrice(sessionDetailsEntity.getPerson3());
            totalPrice += sessionDetailsEntity.getPerson3();
        } else if (quotationRoomDTO.getAdults() == 4) {
            quotationRoomDTO.setAdultPrice(sessionDetailsEntity.getPerson4());
            totalPrice += sessionDetailsEntity.getPerson4();
        } else if (quotationRoomDTO.getAdults() == 5) {
            quotationRoomDTO.setAdultPrice(sessionDetailsEntity.getPerson5());
            totalPrice += sessionDetailsEntity.getPerson5();
        } else if (quotationRoomDTO.getAdults() == 6) {
            quotationRoomDTO.setAdultPrice(sessionDetailsEntity.getPerson6());
            totalPrice += sessionDetailsEntity.getPerson6();
        }

        if (quotationRoomDTO.getCwb() > 0) {
            childWithBedPrice = (sessionDetailsEntity.getPerson2() * ANY_ROOM_EXTRA_BED_CHILD_PERCENTAGE / 100) * quotationRoomDTO.getCwb();
            totalPrice += childWithBedPrice;
            quotationRoomDTO.setChildWithBedPrice(childWithBedPrice);
        }

        if (quotationRoomDTO.getCnb() > 0) {
            childNoBedPrice = (sessionDetailsEntity.getPerson2() * ANY_ROOM_CHILD_NO_BED_PERCENTAGE / 100) * quotationRoomDTO.getCnb();
            totalPrice += childNoBedPrice;
            quotationRoomDTO.setChildNoBedPrice(childNoBedPrice);
        }

        if (quotationRoomDTO.getExtraBed() > 0) {
            extraBedPrice = (sessionDetailsEntity.getPerson2() * ANY_ROOM_EXTRA_BED_ADULT_PERCENTAGE / 100) * quotationRoomDTO.getExtraBed();
            totalPrice += extraBedPrice;
            quotationRoomDTO.setExtraBedPrice(extraBedPrice);
        }

        return totalPrice;
    }




    @RequestMapping(value = "process_system_quotation", params = "Back", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView process_system_quotation_back(@ModelAttribute("QUOTATION_OBJ") QuotationEntityDTO quotationEntityDTO,
                                               BindingResult result, HttpSession session, final RedirectAttributes redirectAttrib) {
        ModelAndView modelView = process_quotation_back(quotationEntityDTO,result, session, redirectAttrib);
        modelView.setViewName("quotation/createLeadSystemQuotation");
        return modelView;
    }

    public ModelAndView process_quotation_back(@ModelAttribute("QUOTATION_OBJ") QuotationEntityDTO quotationEntityDTO,
                                               BindingResult result, HttpSession session, final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("quotation/createQuotation");
        Map<Long, String> mapSalesPartner = salesService.getActiveSalesPartnerMap(true);
        modelView.addObject("SALES_PARTNER_MAP", mapSalesPartner);
        List<RateTypeEntity> listRateType = salesService.findAllActiveRateTypes(true);
        Map<Integer, String> rateTypeMap = listRateType.stream()
                .collect(Collectors.toMap(RateTypeEntity::getRateTypeId, RateTypeEntity::getRateTypeName));
        modelView.addObject("RATE_TYPE_MAP", rateTypeMap);
        List<MasterRoomDetailsEntity> listRoomType = salesService.findActiveRoomsList();
        Map<Integer, String> roomTypeMap = listRoomType.stream()
                .collect(Collectors.toMap(MasterRoomDetailsEntity::getRoomCategoryId, MasterRoomDetailsEntity::getRoomCategoryName));
        modelView.addObject("ROOM_TYPE_MAP", roomTypeMap);
        modelView.addObject("MEAL_PLAN_MAP", VistaluxConstants.MEAL_PLANS_MAP);
        modelView.addObject("userName", userObj.getUsername());
        String sessionKey = "QUOTATION_OBJ_" + userObj.getUserId();
        QuotationEntityDTO sessionQuotation = (QuotationEntityDTO) session.getAttribute(sessionKey);

        modelView.addObject("QUOTATION_OBJ", sessionQuotation);
        return modelView;
    }

    /*public ModelAndView process_quotation_back(@ModelAttribute("QUOTATION_OBJ") QuotationEntityDTO quotationEntityDTO,
                                               BindingResult result, HttpSession session, final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("quotation/createQuotation");
        Map<Long, String> mapSalesPartner = salesService.getActiveSalesPartnerMap(true);
        modelView.addObject("SALES_PARTNER_MAP", mapSalesPartner);
        List<RateTypeEntity> listRateType = salesService.findAllActiveRateTypes(true);
        Map<Integer, String> rateTypeMap = listRateType.stream()
                .collect(Collectors.toMap(RateTypeEntity::getRateTypeId, RateTypeEntity::getRateTypeName));
        modelView.addObject("RATE_TYPE_MAP", rateTypeMap);
        List<MasterRoomDetailsEntity> listRoomType = salesService.findActiveRoomsList();
        Map<Integer, String> roomTypeMap = listRoomType.stream()
                .collect(Collectors.toMap(MasterRoomDetailsEntity::getRoomCategoryId, MasterRoomDetailsEntity::getRoomCategoryName));
        modelView.addObject("ROOM_TYPE_MAP", roomTypeMap);
        modelView.addObject("MEAL_PLAN_MAP", VistaluxConstants.MEAL_PLANS_MAP);
        modelView.addObject("userName", userObj.getUsername());
        String sessionKey = "QUOTATION_OBJ_" + userObj.getUserId();
        QuotationEntityDTO sessionQuotation = (QuotationEntityDTO) session.getAttribute(sessionKey);

        modelView.addObject("QUOTATION_OBJ", sessionQuotation);
        return modelView;
    }
    */

    @Transactional
    @PostMapping("create_create_lead_system_quotation")
    public ModelAndView create_create_lead_system_quotation(@ModelAttribute("LEAD_SYSTEM_QUOTATION_OBJ") LeadSystemQuotationEntity leadSystemQuotationEntity,  BindingResult result,final RedirectAttributes redirectAttrib ) {
        ModelAndView modelAndView = new ModelAndView("redirect:view_system_leads_quotes");


        return modelAndView;
    }




}