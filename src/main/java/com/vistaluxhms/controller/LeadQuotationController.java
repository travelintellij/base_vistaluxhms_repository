package com.vistaluxhms.controller;

import com.lowagie.text.DocumentException;
import com.vistaluxhms.entity.*;
import com.vistaluxhms.model.*;
import com.vistaluxhms.repository.Vlx_City_Master_Repository;
import com.vistaluxhms.services.*;
import com.vistaluxhms.util.VistaluxConstants;
import com.vistaluxhms.validator.LeadSystemQuotationValidator;
import com.vistaluxhms.validator.LeadValidator;
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
import java.util.*;
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

    @Autowired
    LeadQuotationServiceImpl leadQuotationService;

    @Value("${ANY_ROOM_CHILD_NO_BED_ALLOWED}")
    private int ANY_ROOM_CHILD_NO_BED_ALLOWED;

    @Autowired
    private Configuration freemarkerConfig;

    @Autowired
    private SettingsAndOtherServicesImpl settingService;

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

        List<LeadSystemQuotationEntity> listLeadSystemQuotation = leadQuotationService.findLeadSystemQuotations(leadRecorderObj.getLeadId());
        modelView.addObject("LEAD_SYS_QUOTATION_LIST",listLeadSystemQuotation);
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
    public ModelAndView review_process_create_system_quotation(@ModelAttribute("LEAD_SYSTEM_QUOTATION_OBJ") LeadSystemQuotationEntityDTO quotationEntityDTO,BindingResult result,@ModelAttribute("LEAD_OBJ") LeadEntityDTO leadRecorderObj, BindingResult leadBindingresult, HttpSession session, final RedirectAttributes redirectAttrib) {
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
        leadRecorderObj.setLeadId(quotationEntityDTO.getLeadEntity().getLeadId());
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
                quotationRoomDTO.setFormattedCheckInDate(quotationRoomDTO.getCheckInDate().format(OUTPUT_FORMAT));
                quotationRoomDTO.setFormattedCheckOutDate(quotationRoomDTO.getCheckOutDate().format(OUTPUT_FORMAT));
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
    public ModelAndView process_system_quotation_back(@ModelAttribute("LEAD_SYSTEM_QUOTATION_OBJ") LeadSystemQuotationEntityDTO quotationEntityDTO,
                                                      @ModelAttribute("LEAD_OBJ") LeadEntityDTO leadRecorderObj,BindingResult result, HttpSession session, final RedirectAttributes redirectAttrib) {
        ModelAndView modelView = process_quotation_back(quotationEntityDTO,leadRecorderObj,result, session, redirectAttrib);
        modelView.setViewName("quotation/createLeadSystemQuotation");
        return modelView;
    }

    public ModelAndView process_quotation_back(@ModelAttribute("LEAD_SYSTEM_QUOTATION_OBJ") LeadSystemQuotationEntityDTO quotationEntityDTO,@ModelAttribute("LEAD_OBJ") LeadEntityDTO leadRecorderObj,
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
        LeadSystemQuotationEntityDTO sessionQuotation = (LeadSystemQuotationEntityDTO) session.getAttribute(sessionKey);

        modelView.addObject("LEAD_SYSTEM_QUOTATION_OBJ", sessionQuotation);
        LeadEntity leadEntity = leadService.findLeadById(sessionQuotation.getLeadEntity().getLeadId());
        leadRecorderObj.updateLeadVoFromEntity(leadEntity);
        leadRecorderObj.setLeadOwnerName(userDetailsService.findUserByID(leadRecorderObj.getLeadOwner()).getUsername());
        leadRecorderObj.setStatusName(commonService.findWorkLoadStatusById(leadRecorderObj.getLeadStatus()).getWorkloadStatusName());
        leadRecorderObj.setFormattedCheckInDate(formatter.format(leadEntity.getCheckInDate()));
        leadRecorderObj.setFormattedCheckOutDate(formatter.format(leadEntity.getCheckOutDate()));
        modelView.addObject("LEAD_OBJ", leadRecorderObj);
        return modelView;
    }

    @RequestMapping(value = "process_system_quotation", params = "Download", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public void downloadQuotationPdf(@ModelAttribute("LEAD_SYSTEM_QUOTATION_OBJ") LeadSystemQuotationEntityDTO quotationEntityDTO, HttpSession session, HttpServletResponse response) throws IOException, TemplateException, DocumentException {
        generateQuotationPDF(quotationEntityDTO, session, response,"LeadFITPDFQuotation.ftl");
    }

    private void generateQuotationPDF(LeadSystemQuotationEntityDTO quotationEntityDTO, HttpSession session, HttpServletResponse response,String templateName) throws IOException, TemplateException, DocumentException{
        // Prepare data for the template
        Map<String, Object> model = new HashMap<>();

        CentralConfigEntityDTO centralConfigEntity = settingService.getCentralConfig();

        UserDetailsObj userObj = getLoggedInUser();
        String sessionKey = "QUOTATION_OBJ_" + userObj.getUserId();
        LeadSystemQuotationEntityDTO sessionQuotation = (LeadSystemQuotationEntityDTO) session.getAttribute(sessionKey);
        sessionQuotation.setGuestName(quotationEntityDTO.getGuestName());
        sessionQuotation.setDiscount(quotationEntityDTO.getDiscount());
        sessionQuotation.setMobile(quotationEntityDTO.getMobile());
        sessionQuotation.setEmail(quotationEntityDTO.getEmail());
        if (sessionQuotation != null) {
            quotationEntityDTO = sessionQuotation;
        }

        if (sessionQuotation != null) {
            quotationEntityDTO = sessionQuotation;
        }

        model.put("contactName", quotationEntityDTO.getClientEntity().getClientName());
        formatRoomDates(quotationEntityDTO);
        model.put("roomDetails", quotationEntityDTO.getRoomDetailsDTO()); // Fetch dynamically as per your application
        model.put("grandTotalSum", quotationEntityDTO.getGrandTotal());
        model.put("discount", quotationEntityDTO.getDiscount());
        model.put("finalPrice", quotationEntityDTO.getGrandTotal() - quotationEntityDTO.getDiscount());
        model.put("serviceAdvisorMobile", userObj.getMobile());
        model.put("remarks",quotationEntityDTO.getRemarks());

        model.put("centralConfig", centralConfigEntity);

        // Load the Freemarker template
        freemarkerConfig.setClassForTemplateLoading(this.getClass(), "/templates");
        //freemarkerConfig.setDirectoryForTemplateLoading(new File(this.fileStorageLocation.get"));
        freemarkerConfig.setSetting(Configurable.NUMBER_FORMAT_KEY, "computer");
        freemarkerConfig.setAPIBuiltinEnabled(true);
        freemarkerConfig.setTemplateUpdateDelay(0);
        Template template = freemarkerConfig.getTemplate(templateName);
        String htmlContent = FreeMarkerTemplateUtils.processTemplateIntoString(template, model);

        // Generate PDF
        byte[] pdfBytes = new byte[0];
        try {
            pdfBytes = commonService.generatePdfFromHtml(htmlContent);
        } catch (DocumentException e) {
            throw new RuntimeException(e);
        }

        // Set response headers
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=Quotation.pdf");
        response.getOutputStream().write(pdfBytes);
        response.getOutputStream().flush();
    }

    public void formatRoomDates(LeadSystemQuotationEntityDTO quotation) {
        if (quotation != null && quotation.getRoomDetails() != null) {
            for (LeadSystemQuotationRoomDetailsEntityDTO room : quotation.getRoomDetailsDTO()) {
                LocalDate checkIn = room.getCheckInDate();
                LocalDate checkOut = room.getCheckOutDate();
                if (checkIn != null) {
                    room.setFormattedCheckInDate(checkIn.format(OUTPUT_FORMAT));
                }
                if (checkOut != null) {
                    room.setFormattedCheckOutDate(checkOut.format(OUTPUT_FORMAT));
                }
            }
        }
    }


    @RequestMapping(value = "process_system_quotation", params = "Email", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView process_system_quotation_email(@ModelAttribute("LEAD_SYSTEM_QUOTATION_OBJ") LeadSystemQuotationEntityDTO quotationEntityDTO,
                                                BindingResult result,@ModelAttribute("LEAD_OBJ") LeadEntityDTO leadRecorderObj, BindingResult leadBindingresult, HttpSession session, final RedirectAttributes redirectAttrib) {
        //ModelAndView modelView = review_process_create_quotation(quotationEntityDTO,result,sessionredirectAttrib);

        ModelAndView modelView = new ModelAndView();
        UserDetailsObj userObj = getLoggedInUser();
        String sessionKey = "QUOTATION_OBJ_" + userObj.getUserId();
        ClientEntity clientEntity = clientService.findClientById(quotationEntityDTO.getClientEntity().getClientId());
        quotationEntityDTO.setClientEntity(clientEntity);
        LeadSystemQuotationEntityDTO sessionQuotation = (LeadSystemQuotationEntityDTO) session.getAttribute(sessionKey);
        sessionQuotation.setGuestName(quotationEntityDTO.getClientEntity().getClientName());
        sessionQuotation.setDiscount(quotationEntityDTO.getDiscount());
        sessionQuotation.setMobile(String.valueOf(quotationEntityDTO.getClientEntity().getMobile()));
        sessionQuotation.setEmail(quotationEntityDTO.getClientEntity().getEmailId());
        if (sessionQuotation != null) {
            quotationEntityDTO = sessionQuotation;
        }
        modelView.setViewName("redirect:review_process_create_system_quotation");
        redirectAttrib.addFlashAttribute("LEAD_SYSTEM_QUOTATION_OBJ", quotationEntityDTO);
        redirectAttrib.addFlashAttribute("LEAD_OBJ", leadRecorderObj);
        System.out.println("Lead Id in email verification is  " + quotationEntityDTO.getClientEntity().getClientId());
        leadRecorderObj.setLeadId(quotationEntityDTO.getLeadEntity().getLeadId());
        List<String> recipientEmails = validateAndExtractEmails(quotationEntityDTO.getEmail(), result);
        if (result.hasErrors()) {
            modelView = review_process_create_system_quotation(quotationEntityDTO,result,leadRecorderObj, leadBindingresult, session,  redirectAttrib);
            result.rejectValue("email", "error.email", "Invalid Email Format.");
            session.setAttribute("QUOTATION_OBJ_" + userObj.getUserId(), quotationEntityDTO);
            modelView.addObject("QUOTATION_OBJ", quotationEntityDTO);
            modelView.setViewName("quotation/reviewSystemQuotation");
            modelView.addObject("Error", "Invalid Email Provided.");
            return modelView;
        }
        formatRoomDates(quotationEntityDTO);
        notifyQuotationReceiverByEmail(quotationEntityDTO, recipientEmails, "LeadFITQuotation.ftl");
        System.out.println("Quotation Sent Successfully!! ");
        redirectAttrib.addFlashAttribute("Success", "Quotation is sent successfully !! ");
        //session.removeAttribute(sessionKey);
        return modelView;
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

    private void notifyQuotationReceiverByEmail(LeadSystemQuotationEntityDTO quotationEntityDTO, List<String> recipientEmails, String templateName) {

        if (emailNotifyActive) {
            Mail mail = new Mail();
            //String leadReferenceNumber = "ATT-" + leadRecorderObj.getLeadId();
            String emailSubject = "Quotation: Morni Hills Resort | " + quotationEntityDTO.getGuestName() + " | Jim Corbett ";
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
                model.put("contactName", quotationEntityDTO.getClientEntity().getClientName());
                model.put("remarks", quotationEntityDTO.getRemarks());
                model.put("roomDetails", quotationEntityDTO.getRoomDetailsDTO());
                //System.out.println("Room Details " + quotationEntityDTO.getRoomDetails().size());
                //System.out.println("Map Value " + model.get("roomDetails"));
                model.put("quotationAdvisor", userObj.getName());
                model.put("grandTotalSum", quotationEntityDTO.getGrandTotal());
                model.put("discount", quotationEntityDTO.getDiscount());
                model.put("finalPrice", quotationEntityDTO.getGrandTotal() - quotationEntityDTO.getDiscount());
                model.put("serviceAdvisorMobile", userObj.getMobile());

                mail.setModel(model);
                //emailService.sendEmailMessageUsingTemplate(mail,templateName);
                emailService.sendEmailMessageUsingTemplate_MultipleRecipients(mail, templateName);
            } catch (MessagingException | IOException | TemplateException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        } else {
            System.out.println("Email Notification DISABLE. ");
        }
    }



    @Transactional
    @PostMapping("create_create_lead_system_quotation")
    public ModelAndView create_create_lead_system_quotation(@ModelAttribute("LEAD_SYSTEM_QUOTATION_OBJ") LeadSystemQuotationEntity leadSystemQuotationEntity,  BindingResult result,final RedirectAttributes redirectAttrib ) {
        ModelAndView modelAndView = new ModelAndView("redirect:view_system_leads_quotes");
        return modelAndView;
    }


    @RequestMapping(value = "process_system_quotation", params = "whatsapp", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView process_quotation_whatsapp(@ModelAttribute("LEAD_SYSTEM_QUOTATION_OBJ") LeadSystemQuotationEntityDTO quotationEntityDTO,
                                                   BindingResult result,@ModelAttribute("LEAD_OBJ") LeadEntityDTO leadRecorderObj, BindingResult leadBindingresult, HttpSession session, final RedirectAttributes redirectAttrib) {
        //ModelAndView modelView = review_process_create_quotation(quotationEntityDTO,result,sessionredirectAttrib);

        ModelAndView modelView = new ModelAndView();
        UserDetailsObj userObj = getLoggedInUser();

        ClientEntity clientEntity = clientService.findClientById(quotationEntityDTO.getClientEntity().getClientId());
        quotationEntityDTO.setClientEntity(clientEntity);


        String sessionKey = "QUOTATION_OBJ_" + userObj.getUserId();
        LeadSystemQuotationEntityDTO sessionQuotation = (LeadSystemQuotationEntityDTO) session.getAttribute(sessionKey);
        sessionQuotation.setGuestName(quotationEntityDTO.getClientEntity().getClientName());
        sessionQuotation.setDiscount(quotationEntityDTO.getDiscount());
        sessionQuotation.setMobile(String.valueOf(quotationEntityDTO.getClientEntity().getMobile()));
        sessionQuotation.setEmail(quotationEntityDTO.getClientEntity().getEmailId());
        if (sessionQuotation != null) {
            quotationEntityDTO = sessionQuotation;
        }
        modelView.setViewName("redirect:review_process_create_system_quotation");
        redirectAttrib.addFlashAttribute("LEAD_SYSTEM_QUOTATION_OBJ", quotationEntityDTO);
        redirectAttrib.addFlashAttribute("LEAD_OBJ", leadRecorderObj);

        //List<String> recipientEmails = validateAndExtractEmails(quotationEntityDTO.getEmail(), result);
        if (result.hasErrors()) {
            modelView = review_process_create_system_quotation(quotationEntityDTO,result,leadRecorderObj, leadBindingresult, session,  redirectAttrib);
            result.rejectValue("email", "error.email", "Invalid Email Format.");
            session.setAttribute("QUOTATION_OBJ_" + userObj.getUserId(), quotationEntityDTO);
            modelView.addObject("QUOTATION_OBJ", quotationEntityDTO);
            modelView.setViewName("quotation/reviewQuotation");
            modelView.addObject("Error", "Invalid Data Provided.");
            return modelView;
        }

        notifyQuotationReceiverByWhatsapp(quotationEntityDTO);
        System.out.println("Quotation Sent Successfully!! ");
        redirectAttrib.addFlashAttribute("Success", "Quotation is sent successfully !! ");
        //session.removeAttribute(sessionKey);
        return modelView;
    }

    private void notifyQuotationReceiverByWhatsapp(LeadSystemQuotationEntityDTO quotationEntityDTO) {
        UserDetailsObj user = getLoggedInUser();
        System.out.println("Sharing Quotation via Whats app");
        try {
            WhatsAppMessageDTO whatsAppMessageDTO = new WhatsAppMessageDTO();
            whatsAppMessageDTO.setRecipientMobile("91" + quotationEntityDTO.getMobile());
            whatsAppMessageDTO.setRecipientName(quotationEntityDTO.getGuestName());
            String guestDetails = generateGuestDetails(quotationEntityDTO.getRoomDetailsDTO());
            whatsAppMessageDTO.setGuestDetails(guestDetails);
            String roomType = getRoomCategoryName(quotationEntityDTO.getRoomDetailsDTO());
            whatsAppMessageDTO.setRoomType(roomType);
            String mealPlan = getMealPlanName(quotationEntityDTO.getRoomDetailsDTO());
            whatsAppMessageDTO.setMealPlan(mealPlan);
            String checkInDate = getFormattedDate(quotationEntityDTO.getRoomDetailsDTO(), true);
            whatsAppMessageDTO.setCheckInDate(checkInDate);
            String checkOutDate = getFormattedDate(quotationEntityDTO.getRoomDetailsDTO(), false);
            whatsAppMessageDTO.setCheckOutDate(checkOutDate);
            whatsAppMessageDTO.setQueryOwnerName(user.getUsername());
            whatsAppMessageDTO.setQueryOwnerMobile(String.valueOf(user.getMobile()));
            whatsAppMessageDTO.setQueryOwnerEmail(user.getEmail());
            long nettPrice = quotationEntityDTO.getGrandTotal() - quotationEntityDTO.getDiscount();
            whatsAppMessageDTO.setFinalPrice((int)nettPrice);
            whatsAppMessageDTO.setNoOfRooms(quotationEntityDTO.getRoomDetails().size());
            whatsAppService.sendStayQuotationMessage(whatsAppMessageDTO);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    private String generateGuestDetails(List<LeadSystemQuotationRoomDetailsEntityDTO> roomDetailsList) {
        int totalAdults = 0;
        int totalChildren = 0;

        for (LeadSystemQuotationRoomDetailsEntityDTO room : roomDetailsList) {
            totalAdults += room.getAdults() + room.getExtraBed();
            totalChildren += room.getCwb() + room.getCnb() + room.getNoOfChild();
        }
        return totalAdults + " Adults and " + totalChildren + " Children";
    }

    private String getRoomCategoryName(List<LeadSystemQuotationRoomDetailsEntityDTO> roomDetailsList) {
        if (roomDetailsList.isEmpty()) {
            return "No Rooms"; // Handle empty list case
        }

        String firstRoomCategoryName = roomDetailsList.get(0).getRoomCategoryName();
        int firstRoomCategoryId = roomDetailsList.get(0).getRoomCategoryId();

        for (LeadSystemQuotationRoomDetailsEntityDTO room : roomDetailsList) {
            if (room.getRoomCategoryId() != firstRoomCategoryId) {
                return "Multiple"; // Different room categories found
            }
        }

        return firstRoomCategoryName; // All rooms have the same category
    }

    public String getMealPlanName(List<LeadSystemQuotationRoomDetailsEntityDTO> roomDetailsList) {
        if (roomDetailsList.isEmpty()) {
            return "No Meal Plan"; // Handle empty list case
        }

        String firstMealPlanName = roomDetailsList.get(0).getMealPlanName();
        int firstMealPlanId = roomDetailsList.get(0).getMealPlanId();

        for (LeadSystemQuotationRoomDetailsEntityDTO room : roomDetailsList) {
            if (room.getMealPlanId() != firstMealPlanId) {
                return "Multiple"; // Different meal plans found
            }
        }

        return firstMealPlanName; // All rooms have the same meal plan
    }

    public String getFormattedDate(List<LeadSystemQuotationRoomDetailsEntityDTO> roomDetailsList, boolean isCheckInDate) {
        if (roomDetailsList.isEmpty()) {
            return "No Date"; // Handle empty list case
        }

        // Extract the first date based on the parameter
        LocalDate firstDate = isCheckInDate ? roomDetailsList.get(0).getCheckInDate()
                : roomDetailsList.get(0).getCheckOutDate();

        for (LeadSystemQuotationRoomDetailsEntityDTO room : roomDetailsList) {
            LocalDate currentDate = isCheckInDate ? room.getCheckInDate() : room.getCheckOutDate();
            if (!currentDate.equals(firstDate)) {
                return "Multiple"; // If dates are different, return "Multiple"
            }
        }

        // Convert the date to "DD MMM YYYY" format
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yyyy");
        return firstDate.format(formatter);
    }

    @RequestMapping(value = "process_system_quotation", params = "EmailAndWhatsApp", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView process_system_quotation_email_and_whatsapp(@ModelAttribute("LEAD_SYSTEM_QUOTATION_OBJ") LeadSystemQuotationEntityDTO quotationEntityDTO,
                                                             BindingResult result,@ModelAttribute("LEAD_OBJ") LeadEntityDTO leadRecorderObj, BindingResult leadBindingresult, HttpSession session, final RedirectAttributes redirectAttrib) {
        //ModelAndView modelView = review_process_create_quotation(quotationEntityDTO,result,sessionredirectAttrib) {
        ModelAndView modelView = new ModelAndView();
        UserDetailsObj userObj = getLoggedInUser();
        String sessionKey = "QUOTATION_OBJ_" + userObj.getUserId();
        LeadSystemQuotationEntityDTO sessionQuotation = (LeadSystemQuotationEntityDTO) session.getAttribute(sessionKey);

        ClientEntity clientEntity = clientService.findClientById(quotationEntityDTO.getClientEntity().getClientId());
        quotationEntityDTO.setClientEntity(clientEntity);


        sessionQuotation.setGuestName(quotationEntityDTO.getClientEntity().getClientName());
        sessionQuotation.setDiscount(quotationEntityDTO.getDiscount());
        sessionQuotation.setMobile(String.valueOf(quotationEntityDTO.getClientEntity().getMobile()));
        sessionQuotation.setEmail(quotationEntityDTO.getClientEntity().getEmailId());

        if (sessionQuotation != null) {
            quotationEntityDTO = sessionQuotation;
        }

        modelView.setViewName("redirect:review_process_create_system_quotation");
        redirectAttrib.addFlashAttribute("LEAD_SYSTEM_QUOTATION_OBJ", quotationEntityDTO);
        redirectAttrib.addFlashAttribute("LEAD_OBJ", leadRecorderObj);


        List<String> recipientEmails = validateAndExtractEmails(quotationEntityDTO.getEmail(), result);
        if (result.hasErrors()) {
            modelView = review_process_create_system_quotation(quotationEntityDTO,result,leadRecorderObj, leadBindingresult, session,  redirectAttrib);
            result.rejectValue("email", "error.email", "Invalid Email Format.");
            session.setAttribute("QUOTATION_OBJ_" + userObj.getUserId(), quotationEntityDTO);
            modelView.addObject("QUOTATION_OBJ", quotationEntityDTO);
            modelView.setViewName("quotation/reviewQuotation");
            modelView.addObject("Error", "Invalid Email Provided.");
            return modelView;
        }
        // Sending email
        notifyQuotationReceiverByEmail(quotationEntityDTO, recipientEmails, "LeadFITQuotation.ftl");
        // Sending WhatsApp message
        notifyQuotationReceiverByWhatsapp(quotationEntityDTO);
        System.out.println("Quotation Sent Successfully via Email and WhatsApp!!");
        redirectAttrib.addFlashAttribute("Success", "Quotation is sent successfully via Email and WhatsApp!!");
        return modelView;
    }

    @RequestMapping(value = "process_system_quotation", params = "SaveQuotation", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView process_system_quotation_save(@ModelAttribute("LEAD_SYSTEM_QUOTATION_OBJ") LeadSystemQuotationEntityDTO leadSystemQuotationEntityDTO,
                                                      BindingResult result,@ModelAttribute("LEAD_OBJ") LeadEntityDTO leadRecorderObj, BindingResult leadBindingresult, HttpSession session, final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser();

        if(leadSystemQuotationEntityDTO.getLsqid()==null || leadSystemQuotationEntityDTO.getLsqid()==0){
            return add_new_lead_system_quotation(leadSystemQuotationEntityDTO,result,leadRecorderObj, leadBindingresult,  session, redirectAttrib);
        }
        else{
            System.out.println("Update Quotation Entity is invoked with LSQID " + leadSystemQuotationEntityDTO.getLsqid());
            LeadSystemQuotationEntity existingleadSystemQuotationEntity = leadQuotationService.findLeadSystemQuotationByID(leadSystemQuotationEntityDTO.getLsqid());
            LeadSystemQuotationEntity newLeadSystemQuotationEntity = new LeadSystemQuotationEntity();
            String sessionKey = "QUOTATION_OBJ_" + userObj.getUserId();
            LeadSystemQuotationEntityDTO sessionQuotation = (LeadSystemQuotationEntityDTO) session.getAttribute(sessionKey);

            ClientEntity clientEntity = clientService.findClientById(leadSystemQuotationEntityDTO.getClientEntity().getClientId());
            leadSystemQuotationEntityDTO.setClientEntity(clientEntity);
            newLeadSystemQuotationEntity.setClientEntity(clientEntity);

            leadRecorderObj.setLeadId(leadSystemQuotationEntityDTO.getLeadEntity().getLeadId());
            LeadEntity leadEntity = leadService.findLeadById(leadRecorderObj.getLeadId());
            leadSystemQuotationEntityDTO.setLeadEntity(leadEntity);

            sessionQuotation.setGuestName(leadSystemQuotationEntityDTO.getClientEntity().getClientName());
            sessionQuotation.setDiscount(leadSystemQuotationEntityDTO.getDiscount());
            sessionQuotation.setMobile(String.valueOf(leadSystemQuotationEntityDTO.getClientEntity().getMobile()));
            sessionQuotation.setEmail(leadSystemQuotationEntityDTO.getClientEntity().getEmailId());

            if (sessionQuotation != null) {
                leadSystemQuotationEntityDTO = sessionQuotation;
            }
            newLeadSystemQuotationEntity.updateEntityfromVO(leadSystemQuotationEntityDTO);
            newLeadSystemQuotationEntity.setLsqid(leadSystemQuotationEntityDTO.getLsqid());

            List<LeadSystemQuotationRoomDetailsEntity> roomEntities = new ArrayList<>();
            if (leadSystemQuotationEntityDTO.getRoomDetailsDTO() != null) {
                for (LeadSystemQuotationRoomDetailsEntityDTO roomDetail : leadSystemQuotationEntityDTO.getRoomDetailsDTO()) {
                    LeadSystemQuotationRoomDetailsEntity roomEntity = new LeadSystemQuotationRoomDetailsEntity();
                    roomEntity.updateEntityFromVO(roomDetail);
                    roomEntity.setLsqrd(roomDetail.getLsqrd());
                    roomEntity.setLeadSystemQuotationEntity(newLeadSystemQuotationEntity); // set parent reference
                    roomEntities.add(roomEntity); // collect to parent list
                }
            }
            newLeadSystemQuotationEntity.setRoomDetails(roomEntities);

            System.out.println("Existing Entity is " + existingleadSystemQuotationEntity);
            System.out.println("****************************************************************");
            System.out.println("New Entity is " + newLeadSystemQuotationEntity);

            //System.out.println("Before Updating LSQID is " + existingEntity.getLsqid());
            existingleadSystemQuotationEntity.getRoomDetails().clear();
            leadQuotationService.deleteRoomDetails(existingleadSystemQuotationEntity.getRoomDetails());
            leadQuotationService.createQuotationWithRooms(newLeadSystemQuotationEntity);

            redirectAttrib.addFlashAttribute("Success", "Quotation updated successfully.");
            redirectAttrib.addFlashAttribute("LEAD_SYSTEM_QUOTATION_OBJ", leadSystemQuotationEntityDTO);
            redirectAttrib.addFlashAttribute("LEAD_OBJ", leadRecorderObj);
            return new ModelAndView("redirect:view_system_leads_quotes?leadId="+leadRecorderObj.getLeadId());

        }
    }

    public ModelAndView add_new_lead_system_quotation(@ModelAttribute("LEAD_SYSTEM_QUOTATION_OBJ") LeadSystemQuotationEntityDTO quotationEntityDTO,
                                                      BindingResult result,@ModelAttribute("LEAD_OBJ") LeadEntityDTO leadRecorderObj, BindingResult leadBindingresult, HttpSession session, final RedirectAttributes redirectAttrib) {
        //ModelAndView modelView = review_process_create_quotation(quotationEntityDTO,result,sessionredirectAttrib) {
        ModelAndView modelView = new ModelAndView();
        UserDetailsObj userObj = getLoggedInUser();
        String sessionKey = "QUOTATION_OBJ_" + userObj.getUserId();
        LeadSystemQuotationEntityDTO sessionQuotation = (LeadSystemQuotationEntityDTO) session.getAttribute(sessionKey);

        ClientEntity clientEntity = clientService.findClientById(quotationEntityDTO.getClientEntity().getClientId());
        quotationEntityDTO.setClientEntity(clientEntity);

        leadRecorderObj.setLeadId(quotationEntityDTO.getLeadEntity().getLeadId());
        LeadEntity leadEntity = leadService.findLeadById(leadRecorderObj.getLeadId());
        quotationEntityDTO.setLeadEntity(leadEntity);

        sessionQuotation.setGuestName(quotationEntityDTO.getClientEntity().getClientName());
        sessionQuotation.setDiscount(quotationEntityDTO.getDiscount());
        sessionQuotation.setMobile(String.valueOf(quotationEntityDTO.getClientEntity().getMobile()));
        sessionQuotation.setEmail(quotationEntityDTO.getClientEntity().getEmailId());

        if (sessionQuotation != null) {
            quotationEntityDTO = sessionQuotation;
        }
        modelView.setViewName("redirect:view_system_leads_quotes?leadId="+leadRecorderObj.getLeadId());
        redirectAttrib.addFlashAttribute("LEAD_SYSTEM_QUOTATION_OBJ", quotationEntityDTO);
        redirectAttrib.addFlashAttribute("LEAD_OBJ", leadRecorderObj);
        LeadSystemQuotationEntity leadSystemQuotationEntity = new LeadSystemQuotationEntity();
        leadSystemQuotationEntity.updateEntityfromVO(quotationEntityDTO);
        Integer maxVersionId = leadQuotationService.findMaxVersionIdOfQuotationByLeadId(leadRecorderObj.getLeadId());
        leadSystemQuotationEntity.setVersionId((maxVersionId != null ? maxVersionId : 0) + 1);
        List<LeadSystemQuotationRoomDetailsEntity> roomEntities = new ArrayList<>();
        if (quotationEntityDTO.getRoomDetailsDTO() != null) {
            for (LeadSystemQuotationRoomDetailsEntityDTO roomDetail : quotationEntityDTO.getRoomDetailsDTO()) {
                LeadSystemQuotationRoomDetailsEntity roomEntity = new LeadSystemQuotationRoomDetailsEntity();
                roomEntity.updateEntityFromVO(roomDetail);
                roomEntity.setLeadSystemQuotationEntity(leadSystemQuotationEntity); // set parent reference
                roomEntities.add(roomEntity); // collect to parent list
            }
        }
        leadSystemQuotationEntity.setRoomDetails(roomEntities); // ensure this setter exists
        leadQuotationService.createQuotationWithRooms(leadSystemQuotationEntity);
        redirectAttrib.addFlashAttribute("Success", "Quotation is saved successfully. ");
        return modelView;
    }



/*
    @RequestMapping(value = "process_system_quotation", params = "SaveQuotation", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView process_system_quotation_save(@ModelAttribute("LEAD_SYSTEM_QUOTATION_OBJ") LeadSystemQuotationEntityDTO quotationEntityDTO,
                                                                    BindingResult result,@ModelAttribute("LEAD_OBJ") LeadEntityDTO leadRecorderObj, BindingResult leadBindingresult, HttpSession session, final RedirectAttributes redirectAttrib) {
        //ModelAndView modelView = review_process_create_quotation(quotationEntityDTO,result,sessionredirectAttrib) {
        ModelAndView modelView = new ModelAndView();
        UserDetailsObj userObj = getLoggedInUser();
        String sessionKey = "QUOTATION_OBJ_" + userObj.getUserId();
        LeadSystemQuotationEntityDTO sessionQuotation = (LeadSystemQuotationEntityDTO) session.getAttribute(sessionKey);

        ClientEntity clientEntity = clientService.findClientById(quotationEntityDTO.getClientEntity().getClientId());
        quotationEntityDTO.setClientEntity(clientEntity);

        leadRecorderObj.setLeadId(quotationEntityDTO.getLeadEntity().getLeadId());
        LeadEntity leadEntity = leadService.findLeadById(leadRecorderObj.getLeadId());
        quotationEntityDTO.setLeadEntity(leadEntity);

        sessionQuotation.setGuestName(quotationEntityDTO.getClientEntity().getClientName());
        sessionQuotation.setDiscount(quotationEntityDTO.getDiscount());
        sessionQuotation.setMobile(String.valueOf(quotationEntityDTO.getClientEntity().getMobile()));
        sessionQuotation.setEmail(quotationEntityDTO.getClientEntity().getEmailId());

        if (sessionQuotation != null) {
            quotationEntityDTO = sessionQuotation;
        }

        modelView.setViewName("redirect:review_process_create_system_quotation");
        redirectAttrib.addFlashAttribute("LEAD_SYSTEM_QUOTATION_OBJ", quotationEntityDTO);
        redirectAttrib.addFlashAttribute("LEAD_OBJ", leadRecorderObj);

        LeadSystemQuotationEntity leadSystemQuotationEntity = new LeadSystemQuotationEntity();
        leadSystemQuotationEntity.updateEntityfromVO(quotationEntityDTO);
        Integer maxVersionId = leadQuotationService.findMaxVersionIdOfQuotationByLeadId(leadRecorderObj.getLeadId());
        leadSystemQuotationEntity.setVersionId((maxVersionId != null ? maxVersionId : 0) + 1);

        // Prepare list for child entities
        List<LeadSystemQuotationRoomDetailsEntity> roomEntities = new ArrayList<>();
        if (quotationEntityDTO.getRoomDetailsDTO() != null) {
            for (LeadSystemQuotationRoomDetailsEntityDTO roomDetail : quotationEntityDTO.getRoomDetailsDTO()) {
                LeadSystemQuotationRoomDetailsEntity roomEntity = new LeadSystemQuotationRoomDetailsEntity();
                roomEntity.updateEntityFromVO(roomDetail);
                roomEntity.setLeadSystemQuotationEntity(leadSystemQuotationEntity); // set parent reference
                roomEntities.add(roomEntity); // collect to parent list
            }
        }
        // Set the list in the parent entity
        leadSystemQuotationEntity.setRoomDetails(roomEntities); // ensure this setter exists
        // Update parent entity with remaining fields

        // Save using service
        leadQuotationService.createQuotationWithRooms(leadSystemQuotationEntity);

        redirectAttrib.addFlashAttribute("Success", "Quotation is saved successfully. ");
        return modelView;
    }


    @RequestMapping(value = "view_review_system_quotation", method = RequestMethod.GET)
    public ModelAndView viewReviewSystemQuotation(@ModelAttribute("LEAD_SYSTEM_QUOTATION_OBJ") LeadSystemQuotationEntityDTO quotationEntityDTO,BindingResult result,@ModelAttribute("LEAD_OBJ") LeadEntityDTO leadRecorderObj, BindingResult leadBindingresult, HttpSession session,final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser();
        //System.out.println("Lead System Quotation id is " + quotationEntityDTO.getLsqid());
        // 1. Load from DB using your service
        LeadSystemQuotationEntity quotationEntity = leadQuotationService.findLeadSystemQuotationByID(quotationEntityDTO.getLsqid()); // your actual method here

        // 2. Convert to DTO if needed
        //LeadSystemQuotationEntityDTO quotationDTO = new LeadSystemQuotationEntityDTO();
        quotationEntityDTO.updateDTOFromEntity(quotationEntity); // or use a mapper/service

        // 3. Load lead as well
        leadRecorderObj.setLeadId(quotationEntityDTO.getLeadEntity().getLeadId());

        // 4. Put in session (to match existing method's expectations)
        session.setAttribute("QUOTATION_OBJ_" + userObj.getUserId(), quotationEntityDTO);
        ModelAndView modelAndView =  review_process_create_system_quotation(quotationEntityDTO,result,leadRecorderObj, leadBindingresult, session, redirectAttrib);
        // 5. Call the existing method (direct call, not forward)
        return modelAndView;
    }
*/


    @RequestMapping(value = "view_review_system_quotation", method = RequestMethod.GET)
    public ModelAndView viewReviewSystemQuotation(@ModelAttribute("LEAD_SYSTEM_QUOTATION_OBJ") LeadSystemQuotationEntityDTO quotationEntityDTO,BindingResult result,@ModelAttribute("LEAD_OBJ") LeadEntityDTO leadRecorderObj, BindingResult leadBindingresult, HttpSession session,final RedirectAttributes redirectAttrib) {
        ModelAndView modelView = new ModelAndView("quotation/loadSystemQuotation");
        UserDetailsObj userObj = getLoggedInUser();
        LeadSystemQuotationEntity leadSystemQuotationEntity = leadQuotationService.findLeadSystemQuotationByID(quotationEntityDTO.getLsqid()); // your actual method here
        quotationEntityDTO.updateDTOFromEntity(leadSystemQuotationEntity); // or use a mapper/service
        leadRecorderObj.setLeadId(quotationEntityDTO.getLeadEntity().getLeadId());
        session.setAttribute("QUOTATION_OBJ_" + userObj.getUserId(), quotationEntityDTO);

        List<LeadSystemQuotationRoomDetailsEntityDTO> quotationRoomsDTO = new ArrayList<LeadSystemQuotationRoomDetailsEntityDTO>();

        List<LeadSystemQuotationRoomDetailsEntity> quotationRooms = leadSystemQuotationEntity.getRoomDetails();
        for (LeadSystemQuotationRoomDetailsEntity quotationRoomDetailsEntity : quotationRooms) {
            LeadSystemQuotationRoomDetailsEntityDTO quotationRoomDTO = new LeadSystemQuotationRoomDetailsEntityDTO();
            quotationRoomDTO.updateLeadRoomDetailsDTOFromLeadRoomEntity(quotationRoomDetailsEntity);
            quotationRoomDTO.setFormattedCheckInDate(quotationRoomDTO.getCheckInDate().format(OUTPUT_FORMAT));
            quotationRoomDTO.setFormattedCheckOutDate(quotationRoomDTO.getCheckOutDate().format(OUTPUT_FORMAT));
            quotationRoomDTO.setRoomCategoryName(salesService.findRoomCategoryById(quotationRoomDTO.getRoomCategoryId()).getRoomCategoryName());
            quotationRoomDTO.setMealPlanName(VistaluxConstants.MEAL_PLANS_MAP.get(quotationRoomDTO.getMealPlanId()));
            quotationRoomsDTO.add(quotationRoomDTO);
        }
        quotationEntityDTO.setRoomDetailsDTO(quotationRoomsDTO);

        LeadEntity leadEntity = leadService.findLeadById(leadSystemQuotationEntity.getLeadEntity().getLeadId());
        leadRecorderObj.updateLeadVoFromEntity(leadEntity);
        leadRecorderObj.setLeadOwnerName(userDetailsService.findUserByID(leadRecorderObj.getLeadOwner()).getUsername());
        leadRecorderObj.setStatusName(commonService.findWorkLoadStatusById(leadRecorderObj.getLeadStatus()).getWorkloadStatusName());
        leadRecorderObj.setFormattedCheckInDate(formatter.format(leadEntity.getCheckInDate()));
        leadRecorderObj.setFormattedCheckOutDate(formatter.format(leadEntity.getCheckOutDate()));
        return modelView;
    }

    @RequestMapping(value="view_fh_leads_quotes",method= {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView view_fh_leads_quotes( @ModelAttribute("LEAD_OBJ") LeadEntityDTO leadRecorderObj,
                                                  BindingResult result, HttpSession session, final RedirectAttributes redirectAttrib){
        ModelAndView modelView = new ModelAndView("quotation/view_lead_fh_quote");
        LeadEntity leadEntity = leadService.findLeadById(leadRecorderObj.getLeadId());
        leadRecorderObj.updateLeadVoFromEntity(leadEntity);
        leadRecorderObj.setLeadOwnerName(userDetailsService.findUserByID(leadRecorderObj.getLeadOwner()).getUsername());
        leadRecorderObj.setStatusName(commonService.findWorkLoadStatusById(leadRecorderObj.getLeadStatus()).getWorkloadStatusName());
        leadRecorderObj.setFormattedCheckInDate(formatter.format(leadEntity.getCheckInDate()));
        leadRecorderObj.setFormattedCheckOutDate(formatter.format(leadEntity.getCheckOutDate()));
        List<LeadFreeHandQuotationEntity> listLeadFreeHandQuotation = leadQuotationService.findLeadFreeHandQuotations(leadRecorderObj.getLeadId());
        modelView.addObject("LEAD_FH_QUOTATION_LIST",listLeadFreeHandQuotation);
        return modelView;
    }

    @RequestMapping("view_create_lead_fh_quotation")
    public ModelAndView view_create_lead_fh_quotation(@ModelAttribute("LEAD_FH_QUOTATION_OBJ") LeadFreeHandQuotationEntityDTO quotationEntityDTO,BindingResult result,@ModelAttribute("LEAD_OBJ") LeadEntityDTO leadRecorderObj,BindingResult leadBindingResult, HttpSession session ) {
        UserDetailsObj userObj = getLoggedInUser();
        session.removeAttribute("QUOTATION_OBJ");
        session.removeAttribute("QUOTATION_OBJ_" + userObj.getUserId());

        if (quotationEntityDTO.getRoomDetails() == null || quotationEntityDTO.getRoomDetails().isEmpty()) {
            quotationEntityDTO.setRoomDetails(new ArrayList<>()); // Only initialize if it's empty
        }
        ModelAndView modelView = new ModelAndView("quotation/createLeadFHQuotation");
        Map<Long, String> mapSalesPartner = salesService.getActiveSalesPartnerMap(true);
        modelView.addObject("SALES_PARTNER_MAP", mapSalesPartner);
        List<RateTypeEntity> listRateType = salesService.findAllActiveRateTypes(true);
        Map<Integer, String> rateTypeMap = listRateType.stream()
                .collect(Collectors.toMap(RateTypeEntity::getRateTypeId, RateTypeEntity::getRateTypeName));
        modelView.addObject("RATE_TYPE_MAP", rateTypeMap);
        List<MasterRoomDetailsEntity> listRoomType = salesService.findActiveRoomsList();
        Map<Integer, String> roomTypeMap = listRoomType.stream()
                .collect(Collectors.toMap(MasterRoomDetailsEntity::getRoomCategoryId, MasterRoomDetailsEntity::getRoomCategoryName));
        //modelView.addObject("ROOM_TYPE_MAP", roomTypeMap);
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

    @RequestMapping(value = "review_process_create_lead_fh_quotation", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView review_process_create_lead_fh_quotation(@ModelAttribute("LEAD_FH_QUOTATION_OBJ") LeadFreeHandQuotationEntityDTO quotationEntityDTO, BindingResult result, @ModelAttribute("LEAD_OBJ") LeadEntityDTO leadRecorderObj, BindingResult leadBindingResult, HttpSession session, final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("forward:view_create_lead_fh_quotation");
        if (quotationEntityDTO.getRoomDetails() == null) {
            quotationEntityDTO = (LeadFreeHandQuotationEntityDTO) session.getAttribute("QUOTATION_OBJ_" + userObj.getUserId());
            if (quotationEntityDTO.getRoomDetails() == null) {
                quotationEntityDTO.setRoomDetails(new ArrayList<>());
            }
        }
        List<LeadFreeHandQuotationRoomDetailsEntity> validRooms = quotationEntityDTO.getRoomDetails().stream()
                .filter(room -> room.getRoomCategoryName() != null && !room.getRoomCategoryName().trim().isEmpty()
                        && room.getMealPlanId() > 0)
                .collect(Collectors.toList());
        quotationEntityDTO.setRoomDetails(validRooms);
        isValidRoomDetails(validRooms, result);
        leadRecorderObj.setLeadId(quotationEntityDTO.getLeadEntity().getLeadId());
        if (result.hasErrors()) {
            return view_create_lead_fh_quotation( quotationEntityDTO, result, leadRecorderObj, leadBindingResult,  session );
        } else {
            int grandTotalSum = 0;
            ClientEntity clientEntity = clientService.findClientById(quotationEntityDTO.getClientEntity().getClientId());
            quotationEntityDTO.setClientEntity(clientEntity);
            List<LeadFreeHandQuotationRoomDetailsEntityDTO> listRoomDetailsDTO = new ArrayList<LeadFreeHandQuotationRoomDetailsEntityDTO>() ;
            List<SessionRateMappingEntity> sessionRateMappingEntities = sessionService.getMappingsByRateTypeId(clientEntity.getSalesPartner().getRateTypeEntity().getRateTypeId());
            for (LeadFreeHandQuotationRoomDetailsEntity quotationRoomDTO : validRooms) {
                //quotationRoomDTO.setRoomCategoryName(salesService.findRoomCategoryById(quotationRoomDTO.getRoomCategoryId()).getRoomCategoryName());
                //quotationRoomDTO.setMealPlanName(VistaluxConstants.MEAL_PLANS_MAP.get(quotationRoomDTO.getMealPlanId()));
                LeadFreeHandQuotationRoomDetailsEntityDTO quotationRoomDetailsEntityDTO = new LeadFreeHandQuotationRoomDetailsEntityDTO();
                quotationRoomDetailsEntityDTO.updateLeadRoomDetailsDTOFromLeadRoomEntity(quotationRoomDTO);
                //quotationRoomDTO.setRoomCategoryName(salesService.findRoomCategoryById(quotationRoomDTO.getRoomCategoryId()).getRoomCategoryName());
                //quotationRoomDTO.setMealPlanName(VistaluxConstants.MEAL_PLANS_MAP.get(quotationRoomDTO.getMealPlanId()));
                LocalDate checkIn = quotationRoomDTO.getCheckInDate();
                LocalDate checkOut = quotationRoomDTO.getCheckOutDate();
                quotationRoomDetailsEntityDTO.setFormattedCheckInDate(quotationRoomDTO.getCheckInDate().format(OUTPUT_FORMAT));
                quotationRoomDetailsEntityDTO.setFormattedCheckOutDate(quotationRoomDTO.getCheckOutDate().format(OUTPUT_FORMAT));
                quotationRoomDetailsEntityDTO.setMealPlanName(VistaluxConstants.MEAL_PLANS_MAP.get(quotationRoomDTO.getMealPlanId()));
                grandTotalSum += quotationRoomDTO.getTotalPrice();
                listRoomDetailsDTO.add(quotationRoomDetailsEntityDTO);
            }
            quotationEntityDTO.setGrandTotal(grandTotalSum);
            quotationEntityDTO.setRoomDetailsDTO(listRoomDetailsDTO);
        }
        session.setAttribute("QUOTATION_OBJ_" + userObj.getUserId(), quotationEntityDTO);
        leadRecorderObj.setLeadId(quotationEntityDTO.getLeadEntity().getLeadId() );
        LeadEntity leadEntity = leadService.findLeadById(leadRecorderObj.getLeadId());
        leadRecorderObj.updateLeadVoFromEntity(leadEntity);
        leadRecorderObj.setLeadOwnerName(userDetailsService.findUserByID(leadRecorderObj.getLeadOwner()).getUsername());
        leadRecorderObj.setStatusName(commonService.findWorkLoadStatusById(leadRecorderObj.getLeadStatus()).getWorkloadStatusName());
        leadRecorderObj.setFormattedCheckInDate(formatter.format(leadEntity.getCheckInDate()));
        leadRecorderObj.setFormattedCheckOutDate(formatter.format(leadEntity.getCheckOutDate()));
        quotationEntityDTO.setLeadEntity(leadEntity);
        quotationEntityDTO.setClientEntity(leadEntity.getClient());
        modelView.addObject("LEAD_FH_QUOTATION_OBJ", quotationEntityDTO);
        modelView.setViewName("quotation/reviewLeadFHQuotation");
        return modelView;
    }

    private boolean isValidRoomDetails(List<LeadFreeHandQuotationRoomDetailsEntity> roomDetails, Errors errors) {
        boolean isValid = true;
        LocalDate today = LocalDate.now();

        if (roomDetails != null) {
            for (int i = 0; i < roomDetails.size(); i++) {
                LeadFreeHandQuotationRoomDetailsEntity room = roomDetails.get(i);

                // Validate Adults count
                if (room.getAdults() < 1 && room.getNoOfChild() < 1) {
                    errors.rejectValue("roomDetails[" + i + "].adults", "error.roomDetails", "Guests must be greater than zero.");
                    isValid = false;
                }

                // Validate Check-in and Check-out dates
                LocalDate checkIn = room.getCheckInDate();
                LocalDate checkOut = room.getCheckOutDate();

                if (checkIn == null || checkOut == null) {
                    errors.rejectValue("roomDetails[" + i + "].checkInDate", "error.roomDetails", "Check-in and Check-out dates are required.");
                    isValid = false;
                } else {
                    if (checkIn.isBefore(today)) {
                        errors.rejectValue("roomDetails[" + i + "].checkInDate", "error.roomDetails", "Check-in date cannot be in the past.");
                        isValid = false;
                    }

                    if (checkOut.isBefore(today)) {
                        errors.rejectValue("roomDetails[" + i + "].checkOutDate", "error.roomDetails", "Check-out date cannot be in the past.");
                        isValid = false;
                    }

                    if (checkOut.isBefore(checkIn)) {
                        errors.rejectValue("roomDetails[" + i + "].checkOutDate", "error.roomDetails", "Check-out date must be the same or after Check-in date.");
                        isValid = false;
                    }
                }
            }
        }
        return isValid;
    }

    @RequestMapping(value = "process_fh_lead_quotation", params = "Back", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView process_fh_lead_quotation(@ModelAttribute("LEAD_FH_QUOTATION_OBJ") LeadFreeHandQuotationEntityDTO quotationEntityDTO,
                                             BindingResult result,@ModelAttribute("LEAD_OBJ") LeadEntityDTO leadRecorderObj,BindingResult leadBindingResult, HttpSession session, final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("quotation/createLeadFHQuotation");
        Map<Long, String> mapSalesPartner = salesService.getActiveSalesPartnerMap(true);
        //modelView.addObject("SALES_PARTNER_MAP", mapSalesPartner);
        //List<RateTypeEntity> listRateType = salesService.findAllActiveRateTypes(true);
        //Map<Integer, String> rateTypeMap = listRateType.stream()
          //      .collect(Collectors.toMap(RateTypeEntity::getRateTypeId, RateTypeEntity::getRateTypeName));
        //modelView.addObject("RATE_TYPE_MAP", rateTypeMap);
        //List<MasterRoomDetailsEntity> listRoomType = salesService.findActiveRoomsList();
        //Map<Integer, String> roomTypeMap = listRoomType.stream()
          //      .collect(Collectors.toMap(MasterRoomDetailsEntity::getRoomCategoryId, MasterRoomDetailsEntity::getRoomCategoryName));
        //modelView.addObject("ROOM_TYPE_MAP", roomTypeMap);
        modelView.addObject("MEAL_PLAN_MAP", VistaluxConstants.MEAL_PLANS_MAP);
        modelView.addObject("userName", userObj.getUsername());
        String sessionKey = "QUOTATION_OBJ_" + userObj.getUserId();
        LeadFreeHandQuotationEntityDTO sessionQuotation = (LeadFreeHandQuotationEntityDTO) session.getAttribute(sessionKey);
        modelView.addObject("LEAD_FH_QUOTATION_OBJ", sessionQuotation);

        LeadEntity leadEntity = leadService.findLeadById(sessionQuotation.getLeadEntity().getLeadId());
        leadRecorderObj.updateLeadVoFromEntity(leadEntity);
        leadRecorderObj.setLeadOwnerName(userDetailsService.findUserByID(leadRecorderObj.getLeadOwner()).getUsername());
        leadRecorderObj.setStatusName(commonService.findWorkLoadStatusById(leadRecorderObj.getLeadStatus()).getWorkloadStatusName());
        leadRecorderObj.setFormattedCheckInDate(formatter.format(leadEntity.getCheckInDate()));
        leadRecorderObj.setFormattedCheckOutDate(formatter.format(leadEntity.getCheckOutDate()));
        modelView.addObject("LEAD_OBJ", leadRecorderObj);
        return modelView;
    }




    @RequestMapping(value = "process_fh_lead_quotation", params = "Download", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public void downloadQuotationPdf(@ModelAttribute("LEAD_FH_QUOTATION_OBJ") LeadFreeHandQuotationEntityDTO quotationEntityDTO, HttpSession session, HttpServletResponse response) throws IOException, TemplateException, DocumentException {
        generateQuotationPDF(quotationEntityDTO, session, response,"PDFFreeHandQuotation.ftl");
    }

    private void generateQuotationPDF(LeadFreeHandQuotationEntityDTO quotationEntityDTO, HttpSession session, HttpServletResponse response,String templateName) throws IOException, TemplateException, DocumentException{
        // Prepare data for the template
        Map<String, Object> model = new HashMap<>();
        UserDetailsObj userObj = getLoggedInUser();
        String sessionKey = "QUOTATION_OBJ_" + userObj.getUserId();
        LeadFreeHandQuotationEntityDTO sessionQuotation = (LeadFreeHandQuotationEntityDTO) session.getAttribute(sessionKey);
        sessionQuotation.setGuestName(quotationEntityDTO.getGuestName());
        sessionQuotation.setDiscount(quotationEntityDTO.getDiscount());
        sessionQuotation.setMobile(quotationEntityDTO.getMobile());
        sessionQuotation.setEmail(quotationEntityDTO.getEmail());
        if (sessionQuotation != null) {
            quotationEntityDTO = sessionQuotation;
        }

        if (sessionQuotation != null) {
            quotationEntityDTO = sessionQuotation;
        }

        model.put("contactName", quotationEntityDTO.getClientEntity().getClientName());
        formatRoomDates(quotationEntityDTO);
        model.put("roomDetails", quotationEntityDTO.getRoomDetailsDTO()); // Fetch dynamically as per your application
        model.put("grandTotalSum", quotationEntityDTO.getGrandTotal());
        model.put("discount", quotationEntityDTO.getDiscount());
        model.put("finalPrice", quotationEntityDTO.getGrandTotal() - quotationEntityDTO.getDiscount());
        model.put("serviceAdvisorMobile", userObj.getMobile());
        model.put("remarks",quotationEntityDTO.getRemarks());

        // Load the Freemarker template
        freemarkerConfig.setClassForTemplateLoading(this.getClass(), "/templates");
        //freemarkerConfig.setDirectoryForTemplateLoading(new File(this.fileStorageLocation.get"));
        freemarkerConfig.setSetting(Configurable.NUMBER_FORMAT_KEY, "computer");
        freemarkerConfig.setAPIBuiltinEnabled(true);
        freemarkerConfig.setTemplateUpdateDelay(0);
        Template template = freemarkerConfig.getTemplate(templateName);
        String htmlContent = FreeMarkerTemplateUtils.processTemplateIntoString(template, model);

        // Generate PDF
        byte[] pdfBytes = new byte[0];
        try {
            pdfBytes = commonService.generatePdfFromHtml(htmlContent);
        } catch (DocumentException e) {
            throw new RuntimeException(e);
        }

        // Set response headers
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=Quotation.pdf");
        response.getOutputStream().write(pdfBytes);
        response.getOutputStream().flush();
    }

    public void formatRoomDates(LeadFreeHandQuotationEntityDTO quotation) {
        if (quotation != null && quotation.getRoomDetails() != null) {
            for (LeadFreeHandQuotationRoomDetailsEntityDTO room : quotation.getRoomDetailsDTO()) {
                LocalDate checkIn = room.getCheckInDate();
                LocalDate checkOut = room.getCheckOutDate();
                if (checkIn != null) {
                    room.setFormattedCheckInDate(checkIn.format(OUTPUT_FORMAT));
                }
                if (checkOut != null) {
                    room.setFormattedCheckOutDate(checkOut.format(OUTPUT_FORMAT));
                }
            }
        }
    }

    @RequestMapping(value = "process_fh_lead_quotation", params = "Email", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView process_fh_lead_quotation_email(@ModelAttribute("LEAD_FH_QUOTATION_OBJ") LeadFreeHandQuotationEntityDTO quotationEntityDTO,
                                                        BindingResult result,@ModelAttribute("LEAD_OBJ") LeadEntityDTO leadRecorderObj, BindingResult leadBindingresult, HttpSession session, final RedirectAttributes redirectAttrib) {
        //ModelAndView modelView = review_process_create_quotation(quotationEntityDTO,result,sessionredirectAttrib);

        ModelAndView modelView = new ModelAndView();
        UserDetailsObj userObj = getLoggedInUser();
        String sessionKey = "QUOTATION_OBJ_" + userObj.getUserId();
        LeadFreeHandQuotationEntityDTO sessionQuotation = (LeadFreeHandQuotationEntityDTO) session.getAttribute(sessionKey);

        sessionQuotation.setGuestName(quotationEntityDTO.getGuestName());
        sessionQuotation.setDiscount(quotationEntityDTO.getDiscount());
        sessionQuotation.setMobile(String.valueOf(quotationEntityDTO.getClientEntity().getMobile()));
        sessionQuotation.setEmail(quotationEntityDTO.getClientEntity().getEmailId());
        if (sessionQuotation != null) {
            quotationEntityDTO = sessionQuotation;
        }
        modelView.setViewName("redirect:review_process_create_lead_fh_quotation");
        redirectAttrib.addFlashAttribute("LEAD_SYSTEM_QUOTATION_OBJ", quotationEntityDTO);
        redirectAttrib.addFlashAttribute("LEAD_OBJ", leadRecorderObj);
        leadRecorderObj.setLeadId(quotationEntityDTO.getLeadEntity().getLeadId());
        List<String> recipientEmails = validateAndExtractEmails(quotationEntityDTO.getClientEntity().getEmailId(), result);
        if (result.hasErrors()) {
            modelView =review_process_create_lead_fh_quotation(quotationEntityDTO, result,  leadRecorderObj,  leadBindingresult,  session, redirectAttrib);
            result.rejectValue("email", "error.email", "Invalid Email Format.");
            session.setAttribute("QUOTATION_OBJ_" + userObj.getUserId(), quotationEntityDTO);
            modelView.addObject("QUOTATION_OBJ", quotationEntityDTO);
            modelView.setViewName("quotation/reviewLeadFHQuotation");
            modelView.addObject("Error", "Invalid Email Provided.");
            return modelView;
        }
        formatRoomDates(quotationEntityDTO);
        notifyQuotationReceiverByEmail(quotationEntityDTO, recipientEmails, "FreeHandQuotation.ftl");
        System.out.println("Quotation Sent Successfully!! ");
        redirectAttrib.addFlashAttribute("Success", "Quotation is sent successfully !! ");
        //session.removeAttribute(sessionKey);
        return modelView;
    }

    private void notifyQuotationReceiverByEmail(LeadFreeHandQuotationEntityDTO quotationEntityDTO, List<String> recipientEmails, String templateName) {
        if (emailNotifyActive) {
            Mail mail = new Mail();
            //String leadReferenceNumber = "ATT-" + leadRecorderObj.getLeadId();
            String emailSubject = "Quotation: Ashoka Tiger Trail | " + quotationEntityDTO.getClientEntity().getClientName() + " | Jim Corbett ";
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
                model.put("contactName", quotationEntityDTO.getClientEntity().getClientName());
                model.put("remarks", quotationEntityDTO.getRemarks());
                model.put("roomDetails", quotationEntityDTO.getRoomDetailsDTO());
                //System.out.println("Room Details " + quotationEntityDTO.getRoomDetails().size());
                //System.out.println("Map Value " + model.get("roomDetails"));
                model.put("quotationAdvisor", userObj.getName());
                model.put("grandTotalSum", quotationEntityDTO.getGrandTotal());
                model.put("discount", quotationEntityDTO.getDiscount());
                model.put("finalPrice", quotationEntityDTO.getGrandTotal() - quotationEntityDTO.getDiscount());
                model.put("serviceAdvisorMobile", userObj.getMobile());

                mail.setModel(model);
                //emailService.sendEmailMessageUsingTemplate(mail,templateName);
                emailService.sendEmailMessageUsingTemplate_MultipleRecipients(mail, templateName);
            } catch (MessagingException | IOException | TemplateException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        } else {
            System.out.println("Email Notification DISABLE. ");
        }
    }


    @RequestMapping(value = "process_fh_lead_quotation", params = "SaveQuotation", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView process_fh_lead_quotation_save(@ModelAttribute("LEAD_FH_QUOTATION_OBJ") LeadFreeHandQuotationEntityDTO leadFHQuotationEntityDTO,
                                                      BindingResult result,@ModelAttribute("LEAD_OBJ") LeadEntityDTO leadRecorderObj, BindingResult leadBindingresult, HttpSession session, final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser();

        if(leadFHQuotationEntityDTO.getLfhqid()==null || leadFHQuotationEntityDTO.getLfhqid()==0){
            return add_new_lead_fh_quotation(leadFHQuotationEntityDTO,result,leadRecorderObj, leadBindingresult,  session,redirectAttrib);
        }
        else{
            LeadFreeHandQuotationEntity existingleadFHQuotationEntity = leadQuotationService.findLeadFreeHandQuotationByID(leadFHQuotationEntityDTO.getLfhqid());
            LeadFreeHandQuotationEntity newLeadFHQuotationEntity = new LeadFreeHandQuotationEntity();
            String sessionKey = "QUOTATION_OBJ_" + userObj.getUserId();
            LeadFreeHandQuotationEntityDTO sessionQuotation = (LeadFreeHandQuotationEntityDTO) session.getAttribute(sessionKey);

            ClientEntity clientEntity = clientService.findClientById(leadFHQuotationEntityDTO.getClientEntity().getClientId());
            leadFHQuotationEntityDTO.setClientEntity(clientEntity);
            newLeadFHQuotationEntity.setClientEntity(clientEntity);

            leadRecorderObj.setLeadId(leadFHQuotationEntityDTO.getLeadEntity().getLeadId());
            LeadEntity leadEntity = leadService.findLeadById(leadRecorderObj.getLeadId());
            leadFHQuotationEntityDTO.setLeadEntity(leadEntity);

            sessionQuotation.setGuestName(leadFHQuotationEntityDTO.getClientEntity().getClientName());
            sessionQuotation.setDiscount(leadFHQuotationEntityDTO.getDiscount());
            sessionQuotation.setMobile(String.valueOf(leadFHQuotationEntityDTO.getClientEntity().getMobile()));
            sessionQuotation.setEmail(leadFHQuotationEntityDTO.getClientEntity().getEmailId());

            if (sessionQuotation != null) {
                leadFHQuotationEntityDTO = sessionQuotation;
            }
            newLeadFHQuotationEntity.updateEntityfromVO(leadFHQuotationEntityDTO);
            newLeadFHQuotationEntity.setLfhqid(leadFHQuotationEntityDTO.getLfhqid());

            List<LeadFreeHandQuotationRoomDetailsEntity> roomEntities = new ArrayList<>();
            if (leadFHQuotationEntityDTO.getRoomDetailsDTO() != null) {
                for (LeadFreeHandQuotationRoomDetailsEntityDTO roomDetail : leadFHQuotationEntityDTO.getRoomDetailsDTO()) {
                    LeadFreeHandQuotationRoomDetailsEntity roomEntity = new LeadFreeHandQuotationRoomDetailsEntity();
                    roomEntity.updateEntityFromVO(roomDetail);
                    roomEntity.setLfqrd(roomDetail.getLfqrd());
                    roomEntity.setLeadFreeHandQuotationEntity(newLeadFHQuotationEntity); // set parent reference
                    roomEntities.add(roomEntity); // collect to parent list
                }
            }
            newLeadFHQuotationEntity.setRoomDetails(roomEntities);

            /*
            System.out.println("Existing Entity is " + existingleadSystemQuotationEntity);
            System.out.println("****************************************************************");
            System.out.println("New Entity is " + newLeadSystemQuotationEntity);
            */
            //System.out.println("Before Updating LSQID is " + existingEntity.getLsqid());
            existingleadFHQuotationEntity.getRoomDetails().clear();
            leadQuotationService.deleteFHRoomDetails(existingleadFHQuotationEntity.getRoomDetails());
            leadQuotationService.createFHQuotationWithRooms(newLeadFHQuotationEntity);

            redirectAttrib.addFlashAttribute("Success", "Quotation updated successfully.");
            redirectAttrib.addFlashAttribute("LEAD_FH_QUOTATION_OBJ", leadFHQuotationEntityDTO);
            redirectAttrib.addFlashAttribute("LEAD_OBJ", leadRecorderObj);
            return new ModelAndView("redirect:view_fh_leads_quotes?leadId="+leadRecorderObj.getLeadId());

        }
    }

    public ModelAndView add_new_lead_fh_quotation(@ModelAttribute("LEAD_FH_QUOTATION_OBJ") LeadFreeHandQuotationEntityDTO quotationEntityDTO,
                                                      BindingResult result,@ModelAttribute("LEAD_OBJ") LeadEntityDTO leadRecorderObj, BindingResult leadBindingresult, HttpSession session, final RedirectAttributes redirectAttrib) {
        //ModelAndView modelView = review_process_create_quotation(quotationEntityDTO,result,sessionredirectAttrib) {
        ModelAndView modelView = new ModelAndView();
        UserDetailsObj userObj = getLoggedInUser();
        String sessionKey = "QUOTATION_OBJ_" + userObj.getUserId();
        LeadFreeHandQuotationEntityDTO sessionQuotation = (LeadFreeHandQuotationEntityDTO) session.getAttribute(sessionKey);

        ClientEntity clientEntity = clientService.findClientById(quotationEntityDTO.getClientEntity().getClientId());
        quotationEntityDTO.setClientEntity(clientEntity);

        leadRecorderObj.setLeadId(quotationEntityDTO.getLeadEntity().getLeadId());
        LeadEntity leadEntity = leadService.findLeadById(leadRecorderObj.getLeadId());
        quotationEntityDTO.setLeadEntity(leadEntity);

        sessionQuotation.setGuestName(quotationEntityDTO.getClientEntity().getClientName());
        sessionQuotation.setDiscount(quotationEntityDTO.getDiscount());
        sessionQuotation.setMobile(String.valueOf(quotationEntityDTO.getClientEntity().getMobile()));
        sessionQuotation.setEmail(quotationEntityDTO.getClientEntity().getEmailId());

        if (sessionQuotation != null) {
            quotationEntityDTO = sessionQuotation;
        }
        modelView.setViewName("redirect:view_fh_leads_quotes?leadId="+leadRecorderObj.getLeadId());
        redirectAttrib.addFlashAttribute("LEAD_FH_QUOTATION_OBJ", quotationEntityDTO);
        redirectAttrib.addFlashAttribute("LEAD_OBJ", leadRecorderObj);
        LeadFreeHandQuotationEntity leadFreeHandQuotationEntity = new LeadFreeHandQuotationEntity();
        leadFreeHandQuotationEntity.updateEntityfromVO(quotationEntityDTO);
        Integer maxVersionId = leadQuotationService.findMaxVersionIdOfFHQuotationByLeadId(leadRecorderObj.getLeadId());
        leadFreeHandQuotationEntity.setVersionId((maxVersionId != null ? maxVersionId : 0) + 1);
        List<LeadFreeHandQuotationRoomDetailsEntity> roomEntities = new ArrayList<>();
        if (quotationEntityDTO.getRoomDetailsDTO() != null) {
            for (LeadFreeHandQuotationRoomDetailsEntityDTO roomDetail : quotationEntityDTO.getRoomDetailsDTO()) {
                LeadFreeHandQuotationRoomDetailsEntity roomEntity = new LeadFreeHandQuotationRoomDetailsEntity();
                roomEntity.updateEntityFromVO(roomDetail);
                roomEntity.setLeadFreeHandQuotationEntity(leadFreeHandQuotationEntity); // set parent reference
                roomEntities.add(roomEntity); // collect to parent list
            }
        }
        leadFreeHandQuotationEntity.setRoomDetails(roomEntities); // ensure this setter exists
        leadQuotationService.createLeadFHQuotationWithRooms(leadFreeHandQuotationEntity);
        redirectAttrib.addFlashAttribute("Success", "Quotation is saved successfully. ");
        return modelView;
    }

    @RequestMapping(value = "view_review_fh_quotation", method = RequestMethod.GET)
    public ModelAndView viewReviewFHQuotation(@ModelAttribute("LEAD_FH_QUOTATION_OBJ") LeadFreeHandQuotationEntityDTO quotationEntityDTO,BindingResult result,@ModelAttribute("LEAD_OBJ") LeadEntityDTO leadRecorderObj, BindingResult leadBindingresult, HttpSession session,final RedirectAttributes redirectAttrib) {
        ModelAndView modelView = new ModelAndView("quotation/loadFreeHandQuotation");
        UserDetailsObj userObj = getLoggedInUser();
        LeadFreeHandQuotationEntity leadFreeHandQuotationEntity = leadQuotationService.findLeadFreeHandQuotationByID(quotationEntityDTO.getLfhqid()); // your actual method here
        quotationEntityDTO.updateDTOFromEntity(leadFreeHandQuotationEntity); // or use a mapper/service
        leadRecorderObj.setLeadId(quotationEntityDTO.getLeadEntity().getLeadId());
        session.setAttribute("QUOTATION_OBJ_" + userObj.getUserId(), quotationEntityDTO);

        List<LeadFreeHandQuotationRoomDetailsEntityDTO> quotationRoomsDTO = new ArrayList<LeadFreeHandQuotationRoomDetailsEntityDTO>();

        List<LeadFreeHandQuotationRoomDetailsEntity> quotationRooms = leadFreeHandQuotationEntity.getRoomDetails();
        for (LeadFreeHandQuotationRoomDetailsEntity quotationRoomDetailsEntity : quotationRooms) {
            LeadFreeHandQuotationRoomDetailsEntityDTO quotationRoomDTO = new LeadFreeHandQuotationRoomDetailsEntityDTO();
            quotationRoomDTO.updateLeadRoomDetailsDTOFromLeadRoomEntity(quotationRoomDetailsEntity);
            quotationRoomDTO.setFormattedCheckInDate(quotationRoomDTO.getCheckInDate().format(OUTPUT_FORMAT));
            quotationRoomDTO.setFormattedCheckOutDate(quotationRoomDTO.getCheckOutDate().format(OUTPUT_FORMAT));
            //quotationRoomDTO.setRoomCategoryName(salesService.findRoomCategoryById(quotationRoomDTO.getRoomCategoryId()).getRoomCategoryName());
            quotationRoomDTO.setMealPlanName(VistaluxConstants.MEAL_PLANS_MAP.get(quotationRoomDTO.getMealPlanId()));
            quotationRoomsDTO.add(quotationRoomDTO);
        }
        quotationEntityDTO.setRoomDetailsDTO(quotationRoomsDTO);

        LeadEntity leadEntity = leadService.findLeadById(leadFreeHandQuotationEntity.getLeadEntity().getLeadId());
        leadRecorderObj.updateLeadVoFromEntity(leadEntity);
        leadRecorderObj.setLeadOwnerName(userDetailsService.findUserByID(leadRecorderObj.getLeadOwner()).getUsername());
        leadRecorderObj.setStatusName(commonService.findWorkLoadStatusById(leadRecorderObj.getLeadStatus()).getWorkloadStatusName());
        leadRecorderObj.setFormattedCheckInDate(formatter.format(leadEntity.getCheckInDate()));
        leadRecorderObj.setFormattedCheckOutDate(formatter.format(leadEntity.getCheckOutDate()));
        return modelView;
    }

}