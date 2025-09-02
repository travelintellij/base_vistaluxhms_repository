package com.vistaluxhms.controller;

import com.lowagie.text.DocumentException;
import com.twilio.type.Client;
import com.vistaluxhms.entity.*;
import com.vistaluxhms.model.*;
import com.vistaluxhms.model.ratecard.MealPlanRate;
import com.vistaluxhms.model.ratecard.RateCard;
import com.vistaluxhms.model.ratecard.RoomCategory;
import com.vistaluxhms.model.ratecard.SessionRateMapHelperDTO;
import com.vistaluxhms.repository.Vlx_City_Master_Repository;
import com.vistaluxhms.services.*;
import com.vistaluxhms.util.VistaluxConstants;
import com.vistaluxhms.validator.CityManagementValidator;
import freemarker.core.Configurable;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.springframework.beans.factory.annotation.Autowired;
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
import javax.persistence.criteria.CriteriaBuilder;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
public class SalesServiceController {

    @Autowired
    UserDetailsServiceImpl userDetailsService;

    @Autowired
    SalesRelatesServicesImpl salesService;

    @Autowired
    Vlx_City_Master_Repository cityRepository;

    @Autowired
    VlxCommonServicesImpl commonService;

    @Autowired
    ClientServicesImpl clientService;

    @Autowired
    SessionServiceImpl sessionService;

    @Autowired
    SalesRelatesServicesImpl salesRelatedServices;

    @Autowired
    EmailServiceImpl emailService;

    @Autowired
    private Configuration freemarkerConfig;

    @Autowired
    private SettingsAndOtherServicesImpl settingService;


    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yyyy");
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
    @RequestMapping("view_add_rate_type_form")
    public ModelAndView view_add_rate_type_form(@ModelAttribute("RATE_TYPE_OBJ") RateType_Obj rateTypeObj, BindingResult result ) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("admin/Admin_Add_RateType");
        return modelView;
    }

    @PostMapping(value="create_edit_rate_type")
    public ModelAndView create_create_rate_type(@ModelAttribute("RATE_TYPE_OBJ") RateType_Obj rateTypeObj, BindingResult result,final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView();
        //cityMgmtValidator.validate(cityObj, result);
        if(result.hasErrors()) {
            modelView = view_add_rate_type_form(rateTypeObj,result );
        } else {
            RateTypeEntity rateTypeEntity = new RateTypeEntity(rateTypeObj);
            salesService.saveRateType(rateTypeEntity);
            redirectAttrib.addFlashAttribute("Success", "Rate Type Record is updated Successfully..");
            modelView.setViewName("redirect:view_rate_type_list");
        }
        return modelView;
    }

    @RequestMapping("view_rate_type_list")
    public ModelAndView view_rate_type_listing(@ModelAttribute("RATE_TYPE_LIST") RateType_Obj rateTypeObj, BindingResult result ) {
        //pageSize = UdanChooConstants.DEFAULT_PAGE_SIZE;
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("admin/viewRateTypeListing");
        //modelView.addObject("userRole", userObj.getRoles());
        UserDetailsObj user = getLoggedInUser();
        //TODO Check if some one changes the url manually then it should lead to an error page. not to a server error.
        List<RateTypeEntity> listRateType= salesService.findAllRateTypeList();
        List<RateType_Obj> rateTypeObjList = generateRateTypeObj(listRateType);
        modelView.addObject("RATE_TYPE_LIST", rateTypeObjList);
        return modelView;
    }
    private List<RateType_Obj> generateRateTypeObj(List<RateTypeEntity> listRateTypeEntity) {
        List<RateType_Obj> listRateTypeObj = new ArrayList<RateType_Obj>();
        Iterator<RateTypeEntity> itrRateTypeEntity = listRateTypeEntity.iterator();
        while(itrRateTypeEntity.hasNext()) {
            RateTypeEntity rateTypeEntity = (RateTypeEntity) itrRateTypeEntity.next();
            RateType_Obj rateTypeObj;
            try {
                rateTypeObj= new RateType_Obj(rateTypeEntity);
                listRateTypeObj.add(rateTypeObj);
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return listRateTypeObj;
    }

    @PostMapping("view_edit_rate_type_form")
    public ModelAndView view_edit_rate_type_form(@ModelAttribute("RATE_TYPE_OBJ") RateType_Obj rateTypeObj, BindingResult result ) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("admin/Admin_Edit_RateType");
        RateTypeEntity rateTypeEntity = salesService.findById(rateTypeObj.getRateTypeId());
        rateTypeObj.updateRateTypeVOFromEntity(rateTypeEntity);
        return modelView;
    }

    @Transactional
    @PostMapping(value="create_create_sales_partner")
    public ModelAndView createEditSalesPartner(@ModelAttribute("SALES_PARTNER_OBJ") SalesPartnerEntityDto salesPartnerDto,BindingResult result,final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser(); // Retrieve logged-in user details
        ModelAndView modelView = new ModelAndView();
        if(!commonService.existsByDestinationIdAndCityName(salesPartnerDto.getCityId(), salesPartnerDto.getCityName())) {
            result.rejectValue("cityName", "city.error");
        }
        if (result.hasErrors()) {
            // If there are validation errors, return the form view with errors
            modelView = view_add_sales_partner_form(salesPartnerDto, result);
        } else {
            SalesPartnerEntity salesPartnerEntity = new SalesPartnerEntity(salesPartnerDto);
            RateTypeEntity rateTypeEntity = salesService.findById(salesPartnerDto.getRateTypeId());
            salesPartnerEntity.setRateTypeEntity(rateTypeEntity);
            salesService.saveSalesPartner(salesPartnerEntity);

            ClientEntityDTO clientEntityDTO = new ClientEntityDTO();
            clientEntityDTO = getSalesPartnerMappedClientDTO(salesPartnerEntity,clientEntityDTO);
            ClientEntity clientEntity = new ClientEntity(clientEntityDTO);
            clientService.saveClient(clientEntity);
            redirectAttrib.addFlashAttribute("Success", "Sales Partner record updated successfully.");
            modelView.setViewName("redirect:view_sales_partner_list");
        }

        return modelView;
    }


    private ClientEntityDTO getSalesPartnerMappedClientDTO(SalesPartnerEntity salesPartnerEntity,ClientEntityDTO clientEntityDTO){
        City_Entity cityEntity = cityRepository.findDestinationById(salesPartnerEntity.getCityId());
        clientEntityDTO.setCity(cityEntity);
        clientEntityDTO.setSalesPartner(salesPartnerEntity);
        clientEntityDTO.setMobile(salesPartnerEntity.getMobile());
        clientEntityDTO.setClientName(salesPartnerEntity.getSalesPartnerName());
        clientEntityDTO.setSalesPartnerName(salesPartnerEntity.getSalesPartnerName());
        clientEntityDTO.setReference(salesPartnerEntity.getReference());
        clientEntityDTO.setEmailId(salesPartnerEntity.getEmailId());
        clientEntityDTO.setActive(salesPartnerEntity.getActive());
        clientEntityDTO.setB2b(true);
        clientEntityDTO.setSalesPartnerFlag(true);
        return clientEntityDTO;

    }

    @RequestMapping("view_add_sales_partner_form")
    public ModelAndView view_add_sales_partner_form(@ModelAttribute("SALES_PARTNER_OBJ") SalesPartnerEntityDto salesPartnerEntityDto, BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("admin/salespartner/Admin_Add_SalesPartner");
        List<RateTypeEntity> listRateType = salesService.findAllActiveRateTypes(true);
        modelView.addObject("ACTIVE_RATE_TYPES_LIST",listRateType );

        return modelView;
    }

    @RequestMapping("view_sales_partner_list")
    public ModelAndView view_sales_partner_list(@ModelAttribute("SALES_PARTNER_OBJ") SalesPartnerEntityDto searchSalesPartnerObj, BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("admin/salespartner/viewSalesPartnerListing");
        // Adding user details to the model
        modelView.addObject("userName", userObj.getUsername());
        modelView.addObject("Id", userObj.getUserId());
        // Filtering sales partners based on the search criteria
        List<SalesPartnerEntity> salesPartnerFilteredList = salesService.filterSalesPartners(searchSalesPartnerObj);
        List<SalesPartnerEntityDto> salesPartnerDTOFilteredList = generateSalesPartnerObj(salesPartnerFilteredList);
        modelView.addObject("SALES_PARTNER_FILTERED_LIST", salesPartnerDTOFilteredList);
        return modelView;
    }

    private List<SalesPartnerEntityDto> generateSalesPartnerObj(List<SalesPartnerEntity> listSalesPartner) {
        List<SalesPartnerEntityDto> salesPartnerVoList = new ArrayList<SalesPartnerEntityDto>();
        Iterator<SalesPartnerEntity> itrSalesPartnerEntity = listSalesPartner.iterator();
        while(itrSalesPartnerEntity.hasNext()) {
            SalesPartnerEntity salesPartnerEntity = (SalesPartnerEntity) itrSalesPartnerEntity.next();
            SalesPartnerEntityDto salesPartnerEntityDto;
            try {
                salesPartnerEntityDto= new SalesPartnerEntityDto();
                salesPartnerEntityDto.updateSalesPartnerVoFromEntity(salesPartnerEntity);
                salesPartnerEntityDto.setCityName(commonService.findDestinationById(salesPartnerEntity.getCityId()).getCityName());
                salesPartnerVoList.add(salesPartnerEntityDto);
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return salesPartnerVoList;
    }

    @PostMapping("view_sales_partner_details")
    public ModelAndView view_sales_partner_details(@ModelAttribute("SALES_PARTNER_OBJ") SalesPartnerEntityDto searchSalesPartnerObj, BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("admin/salespartner/Admin_View_SalesPartner");
        // Adding user details to the model
        modelView.addObject("userName", userObj.getUsername());
        modelView.addObject("Id", userObj.getUserId());
        // Filtering sales partners based on the search criteria
        SalesPartnerEntity salesPartnerEntity = salesService.findSalesPartnerById(searchSalesPartnerObj.getSalesPartnerId());
        searchSalesPartnerObj.updateSalesPartnerVoFromEntity(salesPartnerEntity);
        searchSalesPartnerObj.setCityName(commonService.findDestinationById(salesPartnerEntity.getCityId()).getCityName());
        searchSalesPartnerObj.setRateTypeName(salesPartnerEntity.getRateTypeEntity().getRateTypeName());
        return modelView;
    }

    @RequestMapping("view_edit_sales_partner_form")
    public ModelAndView view_edit_sales_partner_form(@ModelAttribute("SALES_PARTNER_OBJ") SalesPartnerEntityDto salesPartnerEntityDto, BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("admin/salespartner/Admin_Edit_SalesPartner");
        SalesPartnerEntity salesPartnerEntity = salesService.findSalesPartnerById(salesPartnerEntityDto.getSalesPartnerId());
        salesPartnerEntityDto.updateSalesPartnerVoFromEntity(salesPartnerEntity);
        salesPartnerEntityDto.setCityName(commonService.findDestinationById(salesPartnerEntity.getCityId()).getCityName());
        List<RateTypeEntity> listRateType = salesService.findAllActiveRateTypes(true);
        salesPartnerEntityDto.setRateTypeId(salesPartnerEntity.getRateTypeEntity().getRateTypeId());
        modelView.addObject("ACTIVE_RATE_TYPES_LIST",listRateType );
        return modelView;
    }

    @Transactional
    @PostMapping(value="edit_edit_sales_partner")
    public ModelAndView edit_edit_sales_partner(@ModelAttribute("SALES_PARTNER_OBJ") SalesPartnerEntityDto salesPartnerDto,BindingResult result,final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser(); // Retrieve logged-in user details
        ModelAndView modelView = new ModelAndView();
        if(!commonService.existsByDestinationIdAndCityName(salesPartnerDto.getCityId(), salesPartnerDto.getCityName())) {
            result.rejectValue("cityName", "city.error");
        }
        if (result.hasErrors()) {
            // If there are validation errors, return the form view with errors
            modelView = view_edit_sales_partner_form(salesPartnerDto, result);
        } else {
            SalesPartnerEntity salesPartnerEntity = new SalesPartnerEntity(salesPartnerDto);
            RateTypeEntity rateTypeEntity = salesService.findById(salesPartnerDto.getRateTypeId());
            salesPartnerEntity.setRateTypeEntity(rateTypeEntity);
            salesPartnerEntity.setSalesPartnerId(salesPartnerDto.getSalesPartnerId());
            salesService.saveSalesPartner(salesPartnerEntity);

            ClientEntity clientEntity = clientService.findClientEntityForSalesPartnerId(salesPartnerEntity.getSalesPartnerId());
            if(clientEntity==null){
                redirectAttrib.addFlashAttribute("E", "Sales Partner record updated successfully.");
                modelView = view_edit_sales_partner_form(salesPartnerDto, result);
            }else{
                ClientEntityDTO clientEntityDTO = new ClientEntityDTO(clientEntity);
                ClientEntityDTO updatedClientEntityDTO = getSalesPartnerMappedClientDTO(salesPartnerEntity,clientEntityDTO);
                clientEntity = new ClientEntity(updatedClientEntityDTO);
                clientService.saveClient(clientEntity);
            }
            redirectAttrib.addFlashAttribute("Success", "Sales Partner record updated successfully.");
            modelView.setViewName("redirect:view_sales_partner_list");
        }

        return modelView;
    }

    @RequestMapping("view_add_room_category_form")
    public ModelAndView view_add_room_category_form(@ModelAttribute("ROOM_OBJ") MasterRoomDetailsEntity roomEntity, BindingResult result) {
        ModelAndView modelView = new ModelAndView("admin/rooms/Admin_Add_Room");
        return modelView;
    }


    @PostMapping(value="create_create_room_category")
    public ModelAndView create_create_room_category(@ModelAttribute("ROOM_OBJ") MasterRoomDetailsEntity roomDetailsEntity,BindingResult result,final RedirectAttributes redirectAttrib) {
        ModelAndView modelView = new ModelAndView("admin/rooms/Admin_Add_Room");
        salesService.saveRoomDetails(roomDetailsEntity);
        redirectAttrib.addFlashAttribute("Success", "Room Details record updated successfully.");
        modelView.setViewName("redirect:view_rooms_list");
        return modelView;
    }

    @RequestMapping("view_rooms_list")
    public ModelAndView view_rooms_list() {
        ModelAndView modelView = new ModelAndView("admin/rooms/viewRoomsListing");
        // Adding user details to the model
        // Filtering sales partners based on the search criteria
        List<MasterRoomDetailsEntity> listActiveRooms = salesService.findRoomsList();
        modelView.addObject("ACTIVE_ROOMS_LIST", listActiveRooms);
        return modelView;
    }

    @PostMapping("view_room_category_details")
    public ModelAndView view_room_category_details(@ModelAttribute("ROOM_OBJ") MasterRoomDetailsEntity roomCategoryDTO, BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("admin/rooms/Admin_View_Room");
        // Adding user details to the model
        // Filtering sales partners based on the search criteria
        roomCategoryDTO= salesService.findRoomCategoryById(roomCategoryDTO.getRoomCategoryId());
        modelView.addObject("ROOM_OBJ", roomCategoryDTO);
        return modelView;
    }

    @PostMapping("view_edit_room_form")
    public ModelAndView view_edit_room_form(@ModelAttribute("ROOM_OBJ") MasterRoomDetailsEntity roomCategoryDTO, BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("admin/rooms/Admin_Edit_Room");
        roomCategoryDTO= salesService.findRoomCategoryById(roomCategoryDTO.getRoomCategoryId());
        modelView.addObject("ROOM_OBJ", roomCategoryDTO);
        return modelView;
    }

    @PostMapping(value="edit_edit_room")
    public ModelAndView edit_edit_room(@ModelAttribute("ROOM_OBJ") MasterRoomDetailsEntity roomCategoryDTO,BindingResult result,final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser(); // Retrieve logged-in user details
        ModelAndView modelView = new ModelAndView();
        salesService.saveRoomDetails(roomCategoryDTO);
        redirectAttrib.addFlashAttribute("Success", "Room record is updated successfully.");
        modelView.setViewName("redirect:view_rooms_list");
        return modelView;
    }

    @PostMapping("view_rate_type_sessionwise")
    public ModelAndView view_rate_type_sessionwise(@ModelAttribute("RATE_TYPE_OBJ") RateType_Obj rateTypeObj, BindingResult result ) {
        ModelAndView modelView = new ModelAndView("admin/viewRateSessionMappingList");
        // Adding user details to the model
        // Filtering sales partners based on the search criteria
        List<SessionRateMappingEntity> rateSessionMappingList = salesService.findByRateTypeEntityRateTypeIdOrderByStartDateDesc(rateTypeObj.getRateTypeId());
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yy");

        // Format startDate and endDate and store them as new attributes
        for (SessionRateMappingEntity entity : rateSessionMappingList) {
            entity.setFormattedStartDate(entity.getStartDate().format(formatter));
            entity.setFormattedEndDate(entity.getEndDate().format(formatter));
        }

        modelView.addObject("RATE_SESSION_MAPPING_LIST", rateSessionMappingList);
        return modelView;
    }

    //@PostMapping("view_share_season_sales_partner_form")
    @RequestMapping(value="view_share_season_sales_partner_form",method= {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView view_share_season_sales_partner_form(@ModelAttribute("SALES_PARTNER_OBJ") SalesPartnerEntityDto salesPartnerEntityDto, BindingResult result ) {
        ModelAndView modelView = new ModelAndView("admin/salespartner/viewShareRateSessionForm");
        // Adding user details to the model
        // Filtering sales partners based on the search criteria
        SalesPartnerEntity salesPartnerEntity = salesService.findSalesPartnerById(salesPartnerEntityDto.getSalesPartnerId());
        salesPartnerEntityDto.updateSalesPartnerVoFromEntity(salesPartnerEntity);
        List<SessionRateMappingEntity> rateSessionMappingList = salesService.findByRateTypeEntityRateTypeIdOrderByStartDateDesc(salesPartnerEntityDto.getRateTypeEntity().getRateTypeId());
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yy");

        // Format startDate and endDate and store them as new attributes
        for (SessionRateMappingEntity entity : rateSessionMappingList) {
            entity.setFormattedStartDate(entity.getStartDate().format(formatter));
            entity.setFormattedEndDate(entity.getEndDate().format(formatter));
        }
        //System.out.println("Rate Type size is " + rateSessionMappingList.size());
        modelView.addObject("RATE_SESSION_MAPPING_LIST", rateSessionMappingList);
        return modelView;
    }

    @PostMapping("review_sales_partner_rate_share_form")
    public ModelAndView review_sales_partner_rate_share_form(@RequestParam(value = "rateSessionMappingIds", required = true) List<Integer> rateSessionMappingIds,@ModelAttribute("SALES_PARTNER_OBJ") SalesPartnerEntityDto salesPartnerEntityDto, BindingResult result,final RedirectAttributes redirectAttrib) {
        SalesPartnerEntity salesPartnerEntity = salesRelatedServices.findSalesPartnerById(salesPartnerEntityDto.getSalesPartnerId());
        salesPartnerEntityDto.updateSalesPartnerVoFromEntity(salesPartnerEntity);
        salesPartnerEntityDto.setEmail(salesPartnerEntity.getEmailId());
        ModelAndView modelAndView = new ModelAndView("admin/salespartner/reviewShareRateSessionForm"); // Change this to your JSP page
        if (rateSessionMappingIds != null && !rateSessionMappingIds.isEmpty()) {
            // Process the selected session IDs
            //System.out.println("Selected Session ID is : " + rateSessionMappingIds);

            List<Map<String, Object>> sessionDetailsList = new ArrayList<>();
            for (Integer sessionRateMappingId : rateSessionMappingIds) {
                SessionRateMappingEntity sessionRateMappingEntity = sessionService.findSessionRateMappingEntityById(sessionRateMappingId);
                Map<String, Object> sessionDetail = getSessionDetailMap(sessionRateMappingEntity);
                if (sessionDetail != null) {
                    sessionDetailsList.add(sessionDetail);
                }
            }
            sessionDetailsList.sort(Comparator.comparing(map -> {
                Map<Integer, Map<Integer, SessionDetailsEntityDTO>> sessionDetailsMap =
                        (Map<Integer, Map<Integer, SessionDetailsEntityDTO>>) map.get("sessionDetailsMap");

                if (sessionDetailsMap != null && !sessionDetailsMap.isEmpty()) {
                    for (Map<Integer, SessionDetailsEntityDTO> mealPlanMap : sessionDetailsMap.values()) {
                        for (SessionDetailsEntityDTO dto : mealPlanMap.values()) {
                            if (dto != null && dto.getSessionStartDate() != null) {
                                return LocalDate.parse(dto.getSessionStartDate(), formatter);
                            }
                        }
                    }
                }
                return LocalDate.MAX; // If no valid date found, push it to the end
            }));
            modelAndView.addObject("SALES_PARTNER_OBJ",salesPartnerEntityDto);
            modelAndView.addObject("SESSION_SHARE_LIST",sessionDetailsList);
            modelAndView.addObject("RATE_TYPE_SESSION_MAPPING_ID_LIST", rateSessionMappingIds);
            redirectAttrib.addFlashAttribute("Success", "Selected Sessions processed successfully!");
        } else {
            redirectAttrib.addFlashAttribute("Error", "No sessions were selected!");
        }
        modelAndView.addObject("mealPlans", VistaluxConstants.MEAL_PLANS_MAP); // {1: "EPAI", 2: "CPAI", 3: "MAPAI", 4: "APAI"}
        return modelAndView;
    }


    private Map getSessionDetailMap(SessionRateMappingEntity sessionRateMappingEntity) {
        Map sessionShareData = new HashMap();
        SessionEntity sessionEntity = sessionRateMappingEntity.getSessionEntity();
        RateTypeEntity rateTypeEntity = sessionRateMappingEntity.getRateTypeEntity();
        List<MasterRoomDetailsEntity> ACTIVE_ROOM_LIST = salesRelatedServices.findActiveRoomsList();
        ModelAndView modelView = new ModelAndView("session/Admin_Edit_Session_Details");
        modelView.addObject("ACTIVE_ROOM_LIST",ACTIVE_ROOM_LIST);
        Map<Integer, Map<Integer, SessionDetailsEntityDTO>> sessionDetailsMap = new LinkedHashMap<>();
        Map<Integer,MasterRoomDetailsEntity> activeRoomCategoriesMap = new HashMap<Integer,MasterRoomDetailsEntity>();
        for (MasterRoomDetailsEntity activeRoomCategory : ACTIVE_ROOM_LIST) {
            int roomCategoryId = activeRoomCategory.getRoomCategoryId();
            String roomCategoryName = activeRoomCategory.getRoomCategoryName();
            activeRoomCategoriesMap.put(roomCategoryId,activeRoomCategory);

            // Create or retrieve inner map for this room category
            Map<Integer, SessionDetailsEntityDTO> mealPlanMap = sessionDetailsMap.getOrDefault(roomCategoryId, new LinkedHashMap<>());

            for (Integer mealPlanKey : VistaluxConstants.MEAL_PLANS_MAP.keySet()) {
                SessionDetailsEntityDTO newSessionDetailsEntityDTO = new SessionDetailsEntityDTO();

                Optional<SessionDetailsEntity> existingSessionDetailsEntity =
                        sessionService.findSessionDetailsEntity(sessionRateMappingEntity.getSessionEntity().getSessionId(), roomCategoryId, mealPlanKey);

                if (existingSessionDetailsEntity.isPresent()) {
                    newSessionDetailsEntityDTO.updateVOFromEntity(existingSessionDetailsEntity.get());
                    newSessionDetailsEntityDTO.setExists(true);
                } else {
                    newSessionDetailsEntityDTO.setRoomCategoryId(roomCategoryId);
                    newSessionDetailsEntityDTO.setMealPlanId(mealPlanKey);
                    newSessionDetailsEntityDTO.setSession(sessionEntity);
                    newSessionDetailsEntityDTO.setExists(false);
                }
                newSessionDetailsEntityDTO.setTempRateTypeName(rateTypeEntity.getRateTypeName());
                newSessionDetailsEntityDTO.setSessionStartDate(sessionRateMappingEntity.getStartDate().format(formatter));
                newSessionDetailsEntityDTO.setSessionEndDate(sessionRateMappingEntity.getEndDate().format(formatter));
                // Store the DTO in the inner map
                mealPlanMap.put(mealPlanKey, newSessionDetailsEntityDTO);
            }
            // Store the inner map in the outer map
            sessionDetailsMap.put(roomCategoryId, mealPlanMap);
        }
        sessionShareData.put("sessionDetailsMap", sessionDetailsMap);
        sessionShareData.put("roomCategoryNames", activeRoomCategoriesMap); // e.g., {1: "Deluxe", 2: "Premium"}


        return sessionShareData;
    }

    //@PostMapping("send_send_sales_partner_rate_share")
    @RequestMapping(value="send_send_sales_partner_rate_share",method= {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView send_send_sales_partner_rate_share(@RequestParam(value = "rateSessionMappingIds", required = false) List<Integer> rateSessionMappingIds,@ModelAttribute("SALES_PARTNER_OBJ") SalesPartnerEntityDto salesPartnerEntityDto, BindingResult result,final RedirectAttributes redirectAttrib) {
        ModelAndView modelView = new ModelAndView("redirect:view_sales_partner_list");
        UserDetailsObj userObj = getLoggedInUser();
        SalesPartnerEntity entity = salesService.findSalesPartnerById(salesPartnerEntityDto.getSalesPartnerId());
        salesPartnerEntityDto.updateSalesPartnerVoFromEntity(entity);
        List<String> recipientEmails = extractEmails(salesPartnerEntityDto.getEmail());
        List<Map<String, Object>> sessionDetailsList = getSessionDetailsList(rateSessionMappingIds);
        //SessionRateMapHelperDTO sessionRateMapHelperDTO = getSessionDetailsList(rateSessionMappingIds);
        //List<Map<String, Object>> sessionDetailsList = sessionRateMapHelperDTO.getSessionDetailsList();
        List<RateCard> listRateCard = new ArrayList<>();
        for (Map<String, Object> sessionDetails : sessionDetailsList) {
            Map roomCategoryMap = (Map) sessionDetails.get("roomCategoryNames");
            Map sessionDetailsMap = (Map) sessionDetails.get("sessionDetailsMap");
            RateCard rateCard = new RateCard();
            rateCard.setSeasonStartDate((String) sessionDetails.get("seasonStartDate"));
            rateCard.setSeasonEndDate((String) sessionDetails.get("seasonEndDate"));
            List<RoomCategory> roomCategories = new ArrayList<>();
            for (Object key : roomCategoryMap.keySet()) {
                MasterRoomDetailsEntity roomDetailsEntity = (MasterRoomDetailsEntity) roomCategoryMap.get(key);
                RoomCategory roomCategory = new RoomCategory();
                roomCategory.setRoomCategoryId(roomDetailsEntity.getRoomCategoryId());
                roomCategory.setStandardOccupancy(roomDetailsEntity.getStandardOccupancy());
                roomCategory.setMaxOccupancy(roomDetailsEntity.getMaxOccupancy());
                roomCategory.setName(roomDetailsEntity.getRoomCategoryName());
                roomCategory.setExtraBed(roomDetailsEntity.getExtraBed());
                //System.out.println("Key: " + key + ", Room Details Entity : " + roomDetailsEntity);
                List<MealPlanRate> mealPlans = new ArrayList<>();
                Map<Integer,SessionDetailsEntityDTO> mealwiseSessionDetail = (Map<Integer, SessionDetailsEntityDTO>) sessionDetailsMap.get(roomCategory.getRoomCategoryId());
                for (Integer mealId : VistaluxConstants.MEAL_PLANS_MAP.keySet()) {
                    MealPlanRate mealPlanRate = new MealPlanRate();
                    mealPlanRate.setMealPlanId(mealId);
                    SessionDetailsEntityDTO sessionDetailsEntityDTO = mealwiseSessionDetail.get(mealId);
                    Map<String,Integer> personWiseRate = new HashMap<>();
                    for(int i=1;i<roomCategory.getMaxOccupancy();i++){
                        if(i==1)
                            personWiseRate.put(String.valueOf(i),sessionDetailsEntityDTO.getPerson1());
                        else if(i==2)
                            personWiseRate.put(String.valueOf(i),sessionDetailsEntityDTO.getPerson2());
                        else if(i==3)
                            personWiseRate.put(String.valueOf(i),sessionDetailsEntityDTO.getPerson3());
                        else if(i==4)
                            personWiseRate.put(String.valueOf(i),sessionDetailsEntityDTO.getPerson4());
                        else if(i==5)
                            personWiseRate.put(String.valueOf(i),sessionDetailsEntityDTO.getPerson5());
                        else if(i==6)
                            personWiseRate.put(String.valueOf(i),sessionDetailsEntityDTO.getPerson6());
                    }
                    mealPlanRate.setPersonWiseRates(personWiseRate);
                    mealPlans.add(mealPlanRate);
                    //System.out.println(mealId + "-- " + personWiseRate);
                }
                roomCategory.setMealPlans(mealPlans);
                roomCategories.add(roomCategory);
            }
            rateCard.setRoomCategories(roomCategories);
            listRateCard.add(rateCard);
            System.out.println("***************************");
        }

        Map<String, Object> emailData = new HashMap<>();
        emailData.put("salesPartnerName", salesPartnerEntityDto.getSalesPartnerName());

//       printRateCards(listRateCard);

        emailData.put("rateCardList", listRateCard);

        Map<String, String> freemarkerFriendlyMealMap = new HashMap<>();
        for (Map.Entry<Integer, String> entry : VistaluxConstants.MEAL_PLANS_MAP.entrySet()) {
            freemarkerFriendlyMealMap.put(String.valueOf(entry.getKey()), entry.getValue());
        }
        emailData.put("mealPlanNames", freemarkerFriendlyMealMap);
        Mail mail = new Mail();
        String emailSubject = "Special B2B Seasonal Rates : Ashoka Tiger Trail | " + salesPartnerEntityDto.getSalesPartnerName() + " | Jim Corbett ";
        mail.setSubject(emailSubject);

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
        mail.setModel(emailData);
        try {
            emailService.sendEmailMessageUsingTemplate_MultipleRecipients(mail,"sales_partner_rate_share.ftl");
            redirectAttrib.addFlashAttribute("Success", "Sales Partner rates are sent successfully.");
        } catch (MessagingException e) {
            redirectAttrib.addFlashAttribute("Error", "Error While Sending Email. Please contact Admin");
            throw new RuntimeException(e);
        } catch (IOException e) {
            redirectAttrib.addFlashAttribute("Error", "Error While Sending Email. Please contact Admin");
            throw new RuntimeException(e);
        } catch (TemplateException e) {
            redirectAttrib.addFlashAttribute("Error", "Error While Sending Email. Please contact Admin");
            throw new RuntimeException(e);
        }
        return modelView;
    }


    private List<Map<String, Object>>  getSessionDetailsList(List<Integer> rateSessionMappingIds) {
        SessionRateMapHelperDTO sessionRateMapHelperDTO = new SessionRateMapHelperDTO();
        List<Map<String, Object>> sessionDetailsList = new ArrayList<>();

        if (rateSessionMappingIds != null && !rateSessionMappingIds.isEmpty()) {
            for (Integer sessionRateMappingId : rateSessionMappingIds) {
                SessionRateMappingEntity sessionRateMappingEntity = sessionService.findSessionRateMappingEntityById(sessionRateMappingId);

                Map<String, Object> sessionDetail = getSessionDetailMap(sessionRateMappingEntity);
                if (sessionDetail != null) {
                    // Add season dates to each session detail
                    sessionDetail.put("seasonStartDate", formatter.format(sessionRateMappingEntity.getStartDate()));
                    sessionDetail.put("seasonEndDate", formatter.format(sessionRateMappingEntity.getEndDate()));
                    sessionDetailsList.add(sessionDetail);
                }
            }

            sessionDetailsList.sort(Comparator.comparing(map -> {
                Map<Integer, Map<Integer, SessionDetailsEntityDTO>> sessionDetailsMap =
                        (Map<Integer, Map<Integer, SessionDetailsEntityDTO>>) map.get("sessionDetailsMap");
                if (sessionDetailsMap != null && !sessionDetailsMap.isEmpty()) {
                    for (Map<Integer, SessionDetailsEntityDTO> mealPlanMap : sessionDetailsMap.values()) {
                        for (SessionDetailsEntityDTO dto : mealPlanMap.values()) {
                            if (dto != null && dto.getSessionStartDate() != null) {
                                return LocalDate.parse(dto.getSessionStartDate(), formatter);
                            }
                        }
                    }
                }
                return LocalDate.MAX;
            }));
        }
        return sessionDetailsList;
    }

    private List<String> extractEmails(String emailInput) {
        List<String> emailList = new ArrayList<>();
        if (emailInput != null && !emailInput.trim().isEmpty()) {
            // Split input using comma ',' or semicolon ';' as delimiter
            String[] emails = emailInput.split("[,]");
            for (String email : emails) {
                email = email.trim(); // Remove spaces
                emailList.add(email);
            }
        }
        return emailList;
    }
/*
    private SessionRateMapHelperDTO getSessionDetailsList(List<Integer> rateSessionMappingIds) {
        SessionRateMapHelperDTO sessionRateMapHelperDTO = new SessionRateMapHelperDTO();
        RateCard rateCard = new RateCard();
        List<Map<String, Object>> sessionDetailsList = new ArrayList<>();
        if (rateSessionMappingIds != null && !rateSessionMappingIds.isEmpty()) {
            // Process the selected session IDs
            System.out.println("Selected Session ID is : " + rateSessionMappingIds);

            for (Integer sessionRateMappingId : rateSessionMappingIds) {
                SessionRateMappingEntity sessionRateMappingEntity = sessionService.findSessionRateMappingEntityById(sessionRateMappingId);
                rateCard.setSeasonStartDate(formatter.format(sessionRateMappingEntity.getStartDate()));
                rateCard.setSeasonEndDate(formatter.format(sessionRateMappingEntity.getEndDate()));

                Map<String, Object> sessionDetail = getSessionDetailMap(sessionRateMappingEntity);
                if (sessionDetail != null) {
                    sessionDetailsList.add(sessionDetail);
                }
            }
            sessionDetailsList.sort(Comparator.comparing(map -> {
                Map<Integer, Map<Integer, SessionDetailsEntityDTO>> sessionDetailsMap =
                        (Map<Integer, Map<Integer, SessionDetailsEntityDTO>>) map.get("sessionDetailsMap");

                if (sessionDetailsMap != null && !sessionDetailsMap.isEmpty()) {
                    for (Map<Integer, SessionDetailsEntityDTO> mealPlanMap : sessionDetailsMap.values()) {
                        for (SessionDetailsEntityDTO dto : mealPlanMap.values()) {
                            if (dto != null && dto.getSessionStartDate() != null) {
                                return LocalDate.parse(dto.getSessionStartDate(), formatter);
                            }
                        }
                    }
                }
                return LocalDate.MAX; // If no valid date found, push it to the end
            }));
        }
        sessionRateMapHelperDTO.setSessionDetailsList(sessionDetailsList);
        sessionRateMapHelperDTO.setRateCard(rateCard);
        return sessionRateMapHelperDTO;
        //return sessionDetailsList;
    }
*/

    /*
    private void printRateCards(List<RateCard> rateCards) {
        if (rateCards == null || rateCards.isEmpty()) {
            System.out.println("No rate cards available.");
            return;
        }

        for (RateCard rateCard : rateCards) {
            System.out.println("==========================================");
            System.out.println("Season: " + rateCard.getSeasonStartDate() + " to " + rateCard.getSeasonEndDate());

            List<RoomCategory> roomCategories = rateCard.getRoomCategories();
            if (roomCategories == null || roomCategories.isEmpty()) {
                System.out.println("  No room categories available.");
                continue;
            }

            for (RoomCategory roomCategory : roomCategories) {
                System.out.println("  ----------------------------------");
                System.out.println("  Room Category: " + roomCategory.getName());
                System.out.println("    Max Occupancy: " + roomCategory.getMaxOccupancy());
                System.out.println("    Extra Bed: " + roomCategory.getExtraBed());

                List<MealPlanRate> mealPlans = roomCategory.getMealPlans();
                if (mealPlans == null || mealPlans.isEmpty()) {
                    System.out.println("    No meal plans available.");
                    continue;
                }

                for (MealPlanRate mealPlan : mealPlans) {
                    System.out.println("    Meal Plan ID: " + mealPlan.getMealPlanId());

                    Map<String, Integer> personWiseRates = mealPlan.getPersonWiseRates();
                    if (personWiseRates == null || personWiseRates.isEmpty()) {
                        System.out.println("      No person-wise rates available.");
                    } else {
                        for (Map.Entry<String, Integer> entry : personWiseRates.entrySet()) {
                            System.out.println("      Person " + entry.getKey() + ": ₹" + entry.getValue());
                        }
                    }
                }
            }
        }
    }
     */


    @RequestMapping(value="send_send_sales_partner_rate_share",params = "download",method= {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public void download_salesparter_rate(@RequestParam(value = "rateSessionMappingIds", required = false) List<Integer> rateSessionMappingIds,@ModelAttribute("SALES_PARTNER_OBJ") SalesPartnerEntityDto salesPartnerEntityDto, HttpServletResponse response) throws TemplateException, IOException {

        UserDetailsObj userObj = getLoggedInUser();
        CentralConfigEntityDTO centralConfigEntity = settingService.getCentralConfig();

        SalesPartnerEntity entity = salesService.findSalesPartnerById(salesPartnerEntityDto.getSalesPartnerId());
        salesPartnerEntityDto.updateSalesPartnerVoFromEntity(entity);



        List<Map<String, Object>> sessionDetailsList = getSessionDetailsList(rateSessionMappingIds);
        //SessionRateMapHelperDTO sessionRateMapHelperDTO = getSessionDetailsList(rateSessionMappingIds);
        //List<Map<String, Object>> sessionDetailsList = sessionRateMapHelperDTO.getSessionDetailsList();
        List<RateCard> listRateCard = new ArrayList<>();
        for (Map<String, Object> sessionDetails : sessionDetailsList) {
            Map roomCategoryMap = (Map) sessionDetails.get("roomCategoryNames");
            Map sessionDetailsMap = (Map) sessionDetails.get("sessionDetailsMap");
            RateCard rateCard = new RateCard();
            rateCard.setSeasonStartDate((String) sessionDetails.get("seasonStartDate"));
            rateCard.setSeasonEndDate((String) sessionDetails.get("seasonEndDate"));
            List<RoomCategory> roomCategories = new ArrayList<>();
            for (Object key : roomCategoryMap.keySet()) {
                MasterRoomDetailsEntity roomDetailsEntity = (MasterRoomDetailsEntity) roomCategoryMap.get(key);
                RoomCategory roomCategory = new RoomCategory();
                roomCategory.setRoomCategoryId(roomDetailsEntity.getRoomCategoryId());
                roomCategory.setStandardOccupancy(roomDetailsEntity.getStandardOccupancy());
                roomCategory.setMaxOccupancy(roomDetailsEntity.getMaxOccupancy());
                roomCategory.setName(roomDetailsEntity.getRoomCategoryName());
                roomCategory.setExtraBed(roomDetailsEntity.getExtraBed());
                //System.out.println("Key: " + key + ", Room Details Entity : " + roomDetailsEntity);
                List<MealPlanRate> mealPlans = new ArrayList<>();
                Map<Integer,SessionDetailsEntityDTO> mealwiseSessionDetail = (Map<Integer, SessionDetailsEntityDTO>) sessionDetailsMap.get(roomCategory.getRoomCategoryId());
                for (Integer mealId : VistaluxConstants.MEAL_PLANS_MAP.keySet()) {
                    MealPlanRate mealPlanRate = new MealPlanRate();
                    mealPlanRate.setMealPlanId(mealId);
                    SessionDetailsEntityDTO sessionDetailsEntityDTO = mealwiseSessionDetail.get(mealId);
                    Map<String,Integer> personWiseRate = new HashMap<>();
                    for(int i=1;i<roomCategory.getMaxOccupancy();i++){
                        if(i==1)
                            personWiseRate.put(String.valueOf(i),sessionDetailsEntityDTO.getPerson1());
                        else if(i==2)
                            personWiseRate.put(String.valueOf(i),sessionDetailsEntityDTO.getPerson2());
                        else if(i==3)
                            personWiseRate.put(String.valueOf(i),sessionDetailsEntityDTO.getPerson3());
                        else if(i==4)
                            personWiseRate.put(String.valueOf(i),sessionDetailsEntityDTO.getPerson4());
                        else if(i==5)
                            personWiseRate.put(String.valueOf(i),sessionDetailsEntityDTO.getPerson5());
                        else if(i==6)
                            personWiseRate.put(String.valueOf(i),sessionDetailsEntityDTO.getPerson6());
                    }
                    mealPlanRate.setPersonWiseRates(personWiseRate);
                    mealPlans.add(mealPlanRate);
                    //System.out.println(mealId + "-- " + personWiseRate);
                }
                roomCategory.setMealPlans(mealPlans);
                roomCategories.add(roomCategory);
            }
            rateCard.setRoomCategories(roomCategories);
            listRateCard.add(rateCard);
            System.out.println("***************************");
        }

        Map<String, Object> model = new HashMap<>();
        model.put("salesPartnerName", salesPartnerEntityDto.getSalesPartnerName());
        model.put("rateCardList", listRateCard);

        Map<String, String> freemarkerFriendlyMealMap = new HashMap<>();
        for (Map.Entry<Integer, String> entry : VistaluxConstants.MEAL_PLANS_MAP.entrySet()) {
            freemarkerFriendlyMealMap.put(String.valueOf(entry.getKey()), entry.getValue());
        }
        model.put("mealPlanNames", freemarkerFriendlyMealMap);
        model.put("centralConfig", centralConfigEntity);

        // Load the Freemarker template
        freemarkerConfig.setClassForTemplateLoading(this.getClass(), "/templates");
        //freemarkerConfig.setDirectoryForTemplateLoading(new File(this.fileStorageLocation.get"));
        freemarkerConfig.setSetting(Configurable.NUMBER_FORMAT_KEY, "computer");
        freemarkerConfig.setAPIBuiltinEnabled(true);
        freemarkerConfig.setTemplateUpdateDelay(0);
        Template template = freemarkerConfig.getTemplate("sales_partner_rate_share.ftl");
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
        response.setHeader("Content-Disposition", "attachment; filename=ATTPricing.pdf");
        response.getOutputStream().write(pdfBytes);
        response.getOutputStream().flush();
    }


}
