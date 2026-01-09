package com.vistaluxhms.controller;

import com.lowagie.text.DocumentException;
import com.vistaluxhms.entity.*;
import com.vistaluxhms.model.*;
import com.vistaluxhms.repository.Vlx_City_Master_Repository;
import com.vistaluxhms.services.*;
import com.vistaluxhms.util.VistaluxConstants;
import com.vistaluxhms.validator.LeadValidator;
import com.vistaluxhms.validator.QuotationValidator;
import freemarker.core.Configurable;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.bouncycastle.math.raw.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
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
    QuotationValidator quotationValidator;

    @Autowired
    SessionServiceImpl sessionService;

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

    @RequestMapping("view_add_quotation_form")
    public ModelAndView view_add_quotation_form(@ModelAttribute("QUOTATION_OBJ") QuotationEntityDTO quotationEntityDTO, HttpSession session, BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        session.removeAttribute("QUOTATION_OBJ");
        session.removeAttribute("QUOTATION_OBJ_" + userObj.getUserId());

        if (quotationEntityDTO.getRoomDetails() == null || quotationEntityDTO.getRoomDetails().isEmpty()) {
            quotationEntityDTO.setRoomDetails(new ArrayList<>()); // Only initialize if it's empty
        }


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

        return modelView;
    }


    //@PostMapping(value = "review_process_create_quotation")
    @RequestMapping(value = "review_process_create_quotation", method = {RequestMethod.GET, RequestMethod.POST})
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
            return view_add_quotation_form(quotationEntityDTO, session, result);
        } else {
            System.out.println("Audient Type  selected is " + quotationEntityDTO.getQuotationAudienceType());
            System.out.println(quotationEntityDTO.getGuestId() + "---" + quotationEntityDTO.getGuestName());
            if (quotationEntityDTO.getQuotationAudienceType() == 1) {
                ClientEntity clientEntity = clientService.findClientById(quotationEntityDTO.getGuestId());
                quotationEntityDTO.setMobile(clientEntity.getMobile().toString());
                quotationEntityDTO.setEmail(clientEntity.getEmailId());
                quotationEntityDTO.setRateTypeId(clientEntity.getSalesPartner().getRateTypeEntity().getRateTypeId());
            }

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
        formatRoomDates(quotationEntityDTO);
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


    @RequestMapping(value = "process_quotation", params = "whatsapp", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView process_quotation_whatsapp(@ModelAttribute("QUOTATION_OBJ") QuotationEntityDTO quotationEntityDTO,
                                                   BindingResult result, HttpSession session, final RedirectAttributes redirectAttrib) {
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
        //List<String> recipientEmails = validateAndExtractEmails(quotationEntityDTO.getEmail(), result);
        if (result.hasErrors()) {
            modelView = review_process_create_quotation(quotationEntityDTO, result, session, redirectAttrib);
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

    private void notifyQuotationReceiverByWhatsapp(QuotationEntityDTO quotationEntityDTO) {
        UserDetailsObj user = getLoggedInUser();
        System.out.println("Sharing Quotation via Whats app");
        try {
            WhatsAppMessageDTO whatsAppMessageDTO = new WhatsAppMessageDTO();
            whatsAppMessageDTO.setRecipientMobile("91" + quotationEntityDTO.getMobile());
            whatsAppMessageDTO.setRecipientName(quotationEntityDTO.getGuestName());
            String guestDetails = generateGuestDetails(quotationEntityDTO.getRoomDetails());
            whatsAppMessageDTO.setGuestDetails(guestDetails);
            String roomType = getRoomCategoryName(quotationEntityDTO.getRoomDetails());
            whatsAppMessageDTO.setRoomType(roomType);
            String mealPlan = getMealPlanName(quotationEntityDTO.getRoomDetails());
            whatsAppMessageDTO.setMealPlan(mealPlan);
            String checkInDate = getFormattedDate(quotationEntityDTO.getRoomDetails(), true);
            whatsAppMessageDTO.setCheckInDate(checkInDate);
            String checkOutDate = getFormattedDate(quotationEntityDTO.getRoomDetails(), false);
            whatsAppMessageDTO.setCheckOutDate(checkOutDate);
            whatsAppMessageDTO.setQueryOwnerName(user.getUsername());
            whatsAppMessageDTO.setQueryOwnerMobile(String.valueOf(user.getMobile()));
            whatsAppMessageDTO.setQueryOwnerEmail(user.getEmail());
            int nettPrice = quotationEntityDTO.getGrandTotal() - quotationEntityDTO.getDiscount();
            whatsAppMessageDTO.setFinalPrice(nettPrice);
            whatsAppMessageDTO.setNoOfRooms(quotationEntityDTO.getRoomDetails().size());
            whatsAppService.sendStayQuotationMessage(whatsAppMessageDTO);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    private String generateGuestDetails(List<QuotationRoomDetailsDTO> roomDetailsList) {
        int totalAdults = 0;
        int totalChildren = 0;

        for (QuotationRoomDetailsDTO room : roomDetailsList) {
            totalAdults += room.getAdults();
            totalChildren += room.getChildWithBed() + room.getChildNoBed() + room.getNoOfChild();
        }
        return totalAdults + " Adults and " + totalChildren + " Children";
    }

    private String getRoomCategoryName(List<QuotationRoomDetailsDTO> roomDetailsList) {
        if (roomDetailsList.isEmpty()) {
            return "No Rooms"; // Handle empty list case
        }

        String firstRoomCategoryName = roomDetailsList.get(0).getRoomCategoryName();
        int firstRoomCategoryId = roomDetailsList.get(0).getRoomCategoryId();

        for (QuotationRoomDetailsDTO room : roomDetailsList) {
            if (room.getRoomCategoryId() != firstRoomCategoryId) {
                return "Multiple"; // Different room categories found
            }
        }

        return firstRoomCategoryName; // All rooms have the same category
    }

    public String getMealPlanName(List<QuotationRoomDetailsDTO> roomDetailsList) {
        if (roomDetailsList.isEmpty()) {
            return "No Meal Plan"; // Handle empty list case
        }

        String firstMealPlanName = roomDetailsList.get(0).getMealPlanName();
        int firstMealPlanId = roomDetailsList.get(0).getMealPlanId();

        for (QuotationRoomDetailsDTO room : roomDetailsList) {
            if (room.getMealPlanId() != firstMealPlanId) {
                return "Multiple"; // Different meal plans found
            }
        }

        return firstMealPlanName; // All rooms have the same meal plan
    }

    public String getFormattedDate(List<QuotationRoomDetailsDTO> roomDetailsList, boolean isCheckInDate) {
        if (roomDetailsList.isEmpty()) {
            return "No Date"; // Handle empty list case
        }

        // Extract the first date based on the parameter
        LocalDate firstDate = isCheckInDate ? roomDetailsList.get(0).getCheckInDate()
                : roomDetailsList.get(0).getCheckOutDate();

        for (QuotationRoomDetailsDTO room : roomDetailsList) {
            LocalDate currentDate = isCheckInDate ? room.getCheckInDate() : room.getCheckOutDate();
            if (!currentDate.equals(firstDate)) {
                return "Multiple"; // If dates are different, return "Multiple"
            }
        }

        // Convert the date to "DD MMM YYYY" format
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yyyy");
        return firstDate.format(formatter);
    }

    @RequestMapping(value = "process_quotation", params = "Email", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView process_quotation_email(@ModelAttribute("QUOTATION_OBJ") QuotationEntityDTO quotationEntityDTO,
                                                BindingResult result, HttpSession session, final RedirectAttributes redirectAttrib) {
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
            modelView = review_process_create_quotation(quotationEntityDTO, result, session, redirectAttrib);
            result.rejectValue("email", "error.email", "Invalid Email Format.");
            session.setAttribute("QUOTATION_OBJ_" + userObj.getUserId(), quotationEntityDTO);
            modelView.addObject("QUOTATION_OBJ", quotationEntityDTO);
            modelView.setViewName("quotation/reviewQuotation");
            modelView.addObject("Error", "Invalid Email Provided.");
            return modelView;
        }
        formatRoomDates(quotationEntityDTO);
        notifyQuotationReceiverByEmail(quotationEntityDTO, recipientEmails, "FITQuotation.ftl");
        System.out.println("Quotation Sent Successfully!! ");
        redirectAttrib.addFlashAttribute("Success", "Quotation is sent successfully !! ");
        //session.removeAttribute(sessionKey);
        return modelView;
    }

    @RequestMapping(value = "process_quotation", params = "Back", method = {RequestMethod.GET, RequestMethod.POST})
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


    private void notifyQuotationReceiverByEmail(QuotationEntityDTO quotationEntityDTO, List<String> recipientEmails, String templateName) {
        if (emailNotifyActive) {
            Mail mail = new Mail();
            //String leadReferenceNumber = "ATT-" + leadRecorderObj.getLeadId();
            String emailSubject = "Quotation: Morni Hills Resort | " + quotationEntityDTO.getGuestName() ;
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
                model.put("contactName", quotationEntityDTO.getGuestName());
                model.put("remarks", quotationEntityDTO.getRemarks());
                model.put("roomDetails", quotationEntityDTO.getRoomDetails());
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


    @RequestMapping(value = "process_quotation", params = "Download", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public void downloadQuotationPdf(@ModelAttribute("QUOTATION_OBJ") QuotationEntityDTO quotationEntityDTO, HttpSession session, HttpServletResponse response) throws IOException, TemplateException, DocumentException {
        generateQuotationPDF(quotationEntityDTO, session, response,"PDFQuotation.ftl");
    }

    private void generateQuotationPDF(QuotationEntityDTO quotationEntityDTO, HttpSession session, HttpServletResponse response,String templateName) throws IOException, TemplateException, DocumentException{
        // Prepare data for the template
        CentralConfigEntityDTO centralConfigEntity = settingService.getCentralConfig();
        Map<String, Object> model = new HashMap<>();
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

        if (sessionQuotation != null) {
            quotationEntityDTO = sessionQuotation;
        }

        model.put("contactName", quotationEntityDTO.getGuestName());
        formatRoomDates(quotationEntityDTO);
        model.put("roomDetails", quotationEntityDTO.getRoomDetails()); // Fetch dynamically as per your application
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

    public void formatRoomDates(QuotationEntityDTO quotation) {
        if (quotation != null && quotation.getRoomDetails() != null) {
            for (QuotationRoomDetailsDTO room : quotation.getRoomDetails()) {
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

    @RequestMapping(value = "process_quotation", params = "EmailAndWhatsApp", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView process_quotation_email_and_whatsapp(@ModelAttribute("QUOTATION_OBJ") QuotationEntityDTO quotationEntityDTO,
                                                             BindingResult result, HttpSession session, final RedirectAttributes redirectAttrib) {
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
            modelView = review_process_create_quotation(quotationEntityDTO, result, session, redirectAttrib);
            result.rejectValue("email", "error.email", "Invalid Email Format.");
            session.setAttribute("QUOTATION_OBJ_" + userObj.getUserId(), quotationEntityDTO);
            modelView.addObject("QUOTATION_OBJ", quotationEntityDTO);
            modelView.setViewName("quotation/reviewQuotation");
            modelView.addObject("Error", "Invalid Email Provided.");
            return modelView;
        }

        // Sending email
        notifyQuotationReceiverByEmail(quotationEntityDTO, recipientEmails, "FITQuotation.ftl");

        // Sending WhatsApp message
        notifyQuotationReceiverByWhatsapp(quotationEntityDTO);

        System.out.println("Quotation Sent Successfully via Email and WhatsApp!!");
        redirectAttrib.addFlashAttribute("Success", "Quotation is sent successfully via Email and WhatsApp!!");

        return modelView;
    }

    @RequestMapping("view_add_free_hand_quotation_form")
    public ModelAndView view_add_free_hand_quotation_form(@ModelAttribute("QUOTATION_OBJ") QuotationEntityDTO quotationEntityDTO, HttpSession session, BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        session.removeAttribute("QUOTATION_OBJ");
        session.removeAttribute("QUOTATION_OBJ_" + userObj.getUserId());

        if (quotationEntityDTO.getRoomDetails() == null || quotationEntityDTO.getRoomDetails().isEmpty()) {
            quotationEntityDTO.setRoomDetails(new ArrayList<>()); // Only initialize if it's empty
        }

        ModelAndView modelView = new ModelAndView("quotation/createFreeHandQuotation");
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

        return modelView;
    }

    @RequestMapping(value = "review_process_create_fh_quotation", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView review_process_create_fh_quotation(@ModelAttribute("QUOTATION_OBJ") QuotationEntityDTO quotationEntityDTO, BindingResult result, HttpSession session, final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("forward:view_add_quotation_form");

        if (quotationEntityDTO.getRoomDetails() == null) {
            quotationEntityDTO = (QuotationEntityDTO) session.getAttribute("QUOTATION_OBJ_" + userObj.getUserId());
            if (quotationEntityDTO.getRoomDetails() == null) {
                quotationEntityDTO.setRoomDetails(new ArrayList<>());
            }
        }
        List<QuotationRoomDetailsDTO> validRooms = quotationEntityDTO.getRoomDetails().stream()
                .filter(room -> room.getRoomCategoryName() != null && !room.getRoomCategoryName().trim().isEmpty()
                        && room.getMealPlanId() > 0)
                .collect(Collectors.toList());

        quotationEntityDTO.setRoomDetails(validRooms);
        isValidRoomDetails(validRooms, result);
        validateClient(quotationEntityDTO, result);
        if (result.hasErrors()) {
            return view_add_free_hand_quotation_form(quotationEntityDTO, session, result);
        } else {
            System.out.println("Audient Type  selected is " + quotationEntityDTO.getQuotationAudienceType());
            System.out.println(quotationEntityDTO.getGuestId() + "---" + quotationEntityDTO.getGuestName());
            if (quotationEntityDTO.getQuotationAudienceType() == 1) {
                ClientEntity clientEntity = clientService.findClientById(quotationEntityDTO.getGuestId());
                quotationEntityDTO.setMobile(clientEntity.getMobile().toString());
                quotationEntityDTO.setEmail(clientEntity.getEmailId());
                quotationEntityDTO.setRateTypeId(clientEntity.getSalesPartner().getRateTypeEntity().getRateTypeId());
            }

            int grandTotalSum = 0;
            List<SessionRateMappingEntity> sessionRateMappingEntities = sessionService.getMappingsByRateTypeId(quotationEntityDTO.getRateTypeId());
            for (QuotationRoomDetailsDTO quotationRoomDTO : validRooms) {
                //quotationRoomDTO.setRoomCategoryName(salesService.findRoomCategoryById(quotationRoomDTO.getRoomCategoryId()).getRoomCategoryName());
                quotationRoomDTO.setMealPlanName(VistaluxConstants.MEAL_PLANS_MAP.get(quotationRoomDTO.getMealPlanId()));
                grandTotalSum += quotationRoomDTO.getTotalPrice();
            }
            quotationEntityDTO.setGrandTotal(grandTotalSum);
        }
        formatRoomDates(quotationEntityDTO);
        //session.
        //session.setAttribute("QUOTATION_OBJ", quotationEntityDTO);
        //session.removeAttribute("QUOTATION_OBJ_" + userObj.getUserId());
        session.setAttribute("QUOTATION_OBJ_" + userObj.getUserId(), quotationEntityDTO);

        modelView.addObject("QUOTATION_OBJ", quotationEntityDTO);
        modelView.setViewName("quotation/reviewFHQuotation");
        return modelView;
    }

    private boolean validateClient(QuotationEntityDTO quotationEntityDTO, Errors errors) {
        if (quotationEntityDTO.getQuotationAudienceType() == 1) {
            if (quotationEntityDTO.getGuestId() == 0) {
                errors.rejectValue("guestName", "contact.error");
                return false;
            } else {
                ClientEntity clientEntity = clientService.findClientById(quotationEntityDTO.getGuestId());
                if (!clientEntity.getClientName().trim().equalsIgnoreCase(quotationEntityDTO.getGuestName().trim())) {
                    System.out.println("Client Name is " + clientEntity.getClientName() + "--" + "Guest Name is " + quotationEntityDTO.getGuestName());
                    errors.rejectValue("guestName", "contact.error");
                    return false;
                }
            }
        }
        return true;
    }

    private boolean isValidRoomDetails(List<QuotationRoomDetailsDTO> roomDetails, Errors errors) {
        boolean isValid = true;
        LocalDate today = LocalDate.now();

        if (roomDetails != null) {
            for (int i = 0; i < roomDetails.size(); i++) {
                QuotationRoomDetailsDTO room = roomDetails.get(i);

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

    @RequestMapping(value = "process_fh_quotation", params = "Back", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView process_fh_quotation(@ModelAttribute("QUOTATION_OBJ") QuotationEntityDTO quotationEntityDTO,
                                             BindingResult result, HttpSession session, final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("quotation/createFreeHandQuotation");
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

    @RequestMapping(value = "process_fh_quotation", params = "Download", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public void downloadFHQuotationPdf(@ModelAttribute("QUOTATION_OBJ") QuotationEntityDTO quotationEntityDTO, HttpSession session, HttpServletResponse response) throws IOException, TemplateException, DocumentException {
        generateQuotationPDF(quotationEntityDTO, session, response,"PDFFreeHandQuotation.ftl");
    }


    @RequestMapping(value = "process_fh_quotation", params = "whatsapp", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView process_fh_quotation_whatsapp(@ModelAttribute("QUOTATION_OBJ") QuotationEntityDTO quotationEntityDTO,
                                                   BindingResult result, HttpSession session, final RedirectAttributes redirectAttrib) {
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
        modelView.setViewName("redirect:review_process_create_fh_quotation");
        //List<String> recipientEmails = validateAndExtractEmails(quotationEntityDTO.getEmail(), result);
        if (result.hasErrors()) {
            modelView = review_process_create_fh_quotation(quotationEntityDTO, result, session, redirectAttrib);
            result.rejectValue("email", "error.email", "Invalid Email Format.");
            session.setAttribute("QUOTATION_OBJ_" + userObj.getUserId(), quotationEntityDTO);
            modelView.addObject("QUOTATION_OBJ", quotationEntityDTO);
            modelView.setViewName("quotation/reviewFHQuotation");
            modelView.addObject("Error", "Invalid Data Provided.");
            return modelView;
        }

        notifyFreeHandQuotationReceiverByWhatsapp(quotationEntityDTO);
        System.out.println("Quotation Sent Successfully!! ");
        redirectAttrib.addFlashAttribute("Success", "Quotation is sent successfully !! ");
        //session.removeAttribute(sessionKey);
        return modelView;
    }

    private void notifyFreeHandQuotationReceiverByWhatsapp(QuotationEntityDTO quotationEntityDTO) {
        UserDetailsObj user = getLoggedInUser();
        System.out.println("Sharing Quotation via Whats app");
        try {
            WhatsAppMessageDTO whatsAppMessageDTO = new WhatsAppMessageDTO();
            whatsAppMessageDTO.setRecipientMobile("91" + quotationEntityDTO.getMobile());
            whatsAppMessageDTO.setRecipientName(quotationEntityDTO.getGuestName());
            String guestDetails = generateGuestDetails(quotationEntityDTO.getRoomDetails());
            whatsAppMessageDTO.setGuestDetails(guestDetails);
            String roomType = getFHRoomCategoryName(quotationEntityDTO.getRoomDetails());
            whatsAppMessageDTO.setRoomType(roomType);
            String mealPlan = getMealPlanName(quotationEntityDTO.getRoomDetails());
            whatsAppMessageDTO.setMealPlan(mealPlan);
            String checkInDate = getFormattedDate(quotationEntityDTO.getRoomDetails(), true);
            whatsAppMessageDTO.setCheckInDate(checkInDate);
            String checkOutDate = getFormattedDate(quotationEntityDTO.getRoomDetails(), false);
            whatsAppMessageDTO.setCheckOutDate(checkOutDate);
            whatsAppMessageDTO.setQueryOwnerName(user.getUsername());
            whatsAppMessageDTO.setQueryOwnerMobile(String.valueOf(user.getMobile()));
            whatsAppMessageDTO.setQueryOwnerEmail(user.getEmail());
            int nettPrice = quotationEntityDTO.getGrandTotal() - quotationEntityDTO.getDiscount();
            whatsAppMessageDTO.setFinalPrice(nettPrice);
            int totalRooms = 0;
            for (QuotationRoomDetailsDTO roomDetail : quotationEntityDTO.getRoomDetails()) {
                totalRooms += roomDetail.getNoOfRooms();
            }
            whatsAppMessageDTO.setNoOfRooms(totalRooms);
            whatsAppService.sendStayQuotationMessage(whatsAppMessageDTO);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    private String getFHRoomCategoryName(List<QuotationRoomDetailsDTO> roomDetailsList) {
        if (roomDetailsList.isEmpty()) {
            return "No Rooms"; // Handle empty list case
        }

        String firstRoomCategoryName = roomDetailsList.get(0).getRoomCategoryName();
        for (QuotationRoomDetailsDTO room : roomDetailsList) {
            if (!(room.getRoomCategoryName().equalsIgnoreCase(firstRoomCategoryName))) {
                return "Multiple"; // Different room categories found
            }
        }

        return firstRoomCategoryName; // All rooms have the same category
    }

    @RequestMapping(value = "process_fh_quotation", params = "Email", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView process_fh_quotation_email(@ModelAttribute("QUOTATION_OBJ") QuotationEntityDTO quotationEntityDTO,
                                                BindingResult result, HttpSession session, final RedirectAttributes redirectAttrib) {
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
        modelView.setViewName("redirect:review_process_create_fh_quotation");
        List<String> recipientEmails = validateAndExtractEmails(quotationEntityDTO.getEmail(), result);
        if (result.hasErrors()) {
            modelView = review_process_create_fh_quotation(quotationEntityDTO, result, session, redirectAttrib);
            result.rejectValue("email", "error.email", "Invalid Email Format.");
            session.setAttribute("QUOTATION_OBJ_" + userObj.getUserId(), quotationEntityDTO);
            modelView.addObject("QUOTATION_OBJ", quotationEntityDTO);
            modelView.setViewName("quotation/reviewFHQuotation");
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





}