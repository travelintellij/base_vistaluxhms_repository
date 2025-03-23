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
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

@Controller
//@SessionAttributes("QUOTATION_OBJ")
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

    @Autowired
    QuotationValidator quotationValidator;

    @Autowired
    SessionServiceImpl sessionService;

    @Value("${ANY_ROOM_CHILD_NO_BED_ALLOWED}")
    private int ANY_ROOM_CHILD_NO_BED_ALLOWED;

    @ModelAttribute("QUOTATION_OBJ")
    public QuotationEntityDTO getQuotationFromSession(HttpSession session) {
        QuotationEntityDTO quotation = (QuotationEntityDTO) session.getAttribute("QUOTATION_OBJ");
        return (quotation != null) ? quotation : new QuotationEntityDTO(); // Ensure a non-null object
    }


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
    public ModelAndView view_add_quotation_form(@ModelAttribute("QUOTATION_OBJ") QuotationEntityDTO quotationEntityDTO, HttpSession session,BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        session.removeAttribute("QUOTATION_OBJ");
        session.removeAttribute("QUOTATION_OBJ_"+ userObj.getUserId());

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


    //@PostMapping(value = "review_process_create_quotation")
    @RequestMapping(value="review_process_create_quotation",method= {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView review_process_create_quotation(@ModelAttribute("QUOTATION_OBJ") QuotationEntityDTO quotationEntityDTO, BindingResult result, HttpSession session, final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("forward:view_add_quotation_form");

        if (quotationEntityDTO.getRoomDetails() == null) {
            quotationEntityDTO = (QuotationEntityDTO) session.getAttribute("QUOTATION_OBJ_" + userObj.getUserId());
            if (quotationEntityDTO.getRoomDetails() == null) {
                quotationEntityDTO.setRoomDetails(new ArrayList<>());
            }
        }
        List<QuotationRoomDetailsDTO> validRooms = quotationEntityDTO.getRoomDetails().stream()
                .filter(room -> room.getRoomCategoryId() > 0 && room.getMealPlanId() > 0)
                .collect(Collectors.toList());
        quotationEntityDTO.setRoomDetails(validRooms);
        quotationValidator.validate(quotationEntityDTO, result);
        if (result.hasErrors()) {
            return view_add_quotation_form(quotationEntityDTO, session,result);
        } else {
            int grandTotalSum = 0;
            List<SessionRateMappingEntity> sessionRateMappingEntities = sessionService.getMappingsByRateTypeId(quotationEntityDTO.getRateTypeId());
            for (QuotationRoomDetailsDTO quotationRoomDTO : validRooms) {
                quotationRoomDTO.setRoomCategoryName(salesService.findRoomCategoryById(quotationRoomDTO.getRoomCategoryId()).getRoomCategoryName());
                quotationRoomDTO.setMealPlanName(VistaluxConstants.MEAL_PLANS_MAP.get(quotationRoomDTO.getMealPlanId()));
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
            }
            quotationEntityDTO.setGrandTotal(grandTotalSum);
        }

        //session.
        //session.setAttribute("QUOTATION_OBJ", quotationEntityDTO);
        //session.removeAttribute("QUOTATION_OBJ_" + userObj.getUserId());
        session.setAttribute("QUOTATION_OBJ_" + userObj.getUserId(), quotationEntityDTO);
        modelView.addObject("QUOTATION_OBJ", quotationEntityDTO);
        modelView.setViewName("quotation/reviewQuotation");
        return modelView;
    }

    private int processTotalPrice(QuotationRoomDetailsDTO quotationRoomDTO, SessionDetailsEntity sessionDetailsEntity) {
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

        if (quotationRoomDTO.getChildWithBed() > 0) {
            childWithBedPrice = (sessionDetailsEntity.getPerson2() * ANY_ROOM_EXTRA_BED_CHILD_PERCENTAGE / 100) * quotationRoomDTO.getChildWithBed();
            totalPrice += childWithBedPrice;
            quotationRoomDTO.setChildWithBedPrice(childWithBedPrice);
        }

        if (quotationRoomDTO.getChildNoBed() > 0) {
            childNoBedPrice = (sessionDetailsEntity.getPerson2() * ANY_ROOM_CHILD_NO_BED_PERCENTAGE / 100) * quotationRoomDTO.getChildNoBed();
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

    @RequestMapping(value="process_quotation",params = "Email",method= {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView process_quotation_email(@ModelAttribute("QUOTATION_OBJ") QuotationEntityDTO quotationEntityDTO,
                                                        BindingResult result,HttpSession session,final RedirectAttributes redirectAttrib) {
        //ModelAndView modelView = review_process_create_quotation(quotationEntityDTO,result,sessionredirectAttrib);

        ModelAndView modelView = new ModelAndView();
        UserDetailsObj userObj = getLoggedInUser();
        String sessionKey = "QUOTATION_OBJ_" + userObj.getUserId();
        QuotationEntityDTO sessionQuotation = (QuotationEntityDTO) session.getAttribute(sessionKey);
        sessionQuotation.setGuestName(quotationEntityDTO.getGuestName());
        sessionQuotation.setDiscount(quotationEntityDTO.getDiscount());
        sessionQuotation.setMobile(quotationEntityDTO.getMobile());
        sessionQuotation.setEmail(quotationEntityDTO.getEmail());
        if (sessionQuotation != null) {
            quotationEntityDTO = sessionQuotation;
        }
        modelView.setViewName("redirect:review_process_create_quotation");
        List<String> recipientEmails = validateAndExtractEmails(quotationEntityDTO.getEmail(), result);
        if (result.hasErrors()) {
            modelView = review_process_create_quotation(quotationEntityDTO,result,session,redirectAttrib);
            result.rejectValue("email", "error.email", "Invalid Email Format.");
            session.setAttribute("QUOTATION_OBJ_" + userObj.getUserId(), quotationEntityDTO);
            modelView.addObject("QUOTATION_OBJ", quotationEntityDTO);
            modelView.setViewName("quotation/reviewQuotation");
            modelView.addObject("Error", "Invalid Email Provided.");
            return modelView;
        }

        notifyQuotationReceiverByEmail(quotationEntityDTO,recipientEmails,"FITQuotation.ftl");
        System.out.println("Quotation Sent Successfully!! ");
        redirectAttrib.addFlashAttribute("Success","Quotation is sent successfully !! ");
        //session.removeAttribute(sessionKey);
        return modelView;
    }

    @RequestMapping(value="process_quotation",params = "Back",method= {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView process_quotation_back(@ModelAttribute("QUOTATION_OBJ") QuotationEntityDTO quotationEntityDTO,
                                          BindingResult result,HttpSession session,final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser();
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
        String sessionKey = "QUOTATION_OBJ_" + userObj.getUserId();
        QuotationEntityDTO sessionQuotation = (QuotationEntityDTO) session.getAttribute(sessionKey);

        modelView.addObject("QUOTATION_OBJ",sessionQuotation);
        return modelView;
    }


    private void notifyQuotationReceiverByEmail(QuotationEntityDTO quotationEntityDTO, List<String> recipientEmails,String templateName) {
        if(emailNotifyActive) {
            Mail mail = new Mail();
            //String leadReferenceNumber = "ATT-" + leadRecorderObj.getLeadId();
            String emailSubject = "Quotation: Ashoka Tiger Trail | " + quotationEntityDTO.getGuestName() + " | Jim Corbett ";
            mail.setSubject(emailSubject);
            AshokaTeam userObj = userDetailsService.findUserByID(getLoggedInUser().getUserId());
            //mail.setTo(quotationEntityDTO.getEmail());
            InternetAddress[] emailAddresses = new InternetAddress[recipientEmails.size()];
            for (int i = 0; i < recipientEmails.size(); i++) {
                try {
                    emailAddresses[i] = new InternetAddress(recipientEmails.get(i).trim());
                } catch (AddressException e) {
                    throw new RuntimeException(e);
                }
            }
            mail.setToList(emailAddresses);
            mail.setCc(userObj.getEmail());
            try {
                Map<String, Object> model = new HashMap<String, Object>();
                //model.put("leadId", leadReferenceNumber);
                model.put("contactName",quotationEntityDTO.getGuestName());
                model.put("remarks", quotationEntityDTO.getRemarks());
                model.put("roomDetails", quotationEntityDTO.getRoomDetails());
                System.out.println("Room Details " + quotationEntityDTO.getRoomDetails().size());
                System.out.println("Map Value " + model.get("roomDetails"));
                model.put("quotationAdvisor", userObj.getName());
                model.put("grandTotalSum", quotationEntityDTO.getGrandTotal());
                model.put("discount", quotationEntityDTO.getDiscount());
                model.put("finalPrice", quotationEntityDTO.getGrandTotal()-quotationEntityDTO.getDiscount());
                model.put("serviceAdvisorMobile", userObj.getMobile());

                mail.setModel(model);
                //emailService.sendEmailMessageUsingTemplate(mail,templateName);
                emailService.sendEmailMessageUsingTemplate_MultipleRecipients(mail,templateName);
            } catch (MessagingException | IOException | TemplateException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        else {
            System.out.println("Email Notification DISABLE. ");
        }
    }

    private List<String> validateAndExtractEmails(String emailInput, Errors errors) {
        List<String> emailList = new ArrayList<>();
        if (emailInput != null && !emailInput.trim().isEmpty()) {
            // Split input using comma ',' or semicolon ';' as delimiter
            String[] emails = emailInput.split("[,;]");
            for (String email : emails) {
                email = email.trim(); // Remove spaces
                if (!isValidEmail(email)) {
                    errors.rejectValue("email", "error.email", "Invalid email format: " + email);
                } else {
                    emailList.add(email);
                }
            }
        }
        if (emailList.isEmpty()) {
            errors.rejectValue("email", "error.email", "At least one valid email is required.");
        }
        return emailList;
    }

    private boolean isValidEmail(String email) {
        String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
        return email.matches(emailRegex);
    }

}
