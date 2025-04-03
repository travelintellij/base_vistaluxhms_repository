package com.vistaluxhms.controller;

import com.twilio.type.Client;
import com.vistaluxhms.entity.*;
import com.vistaluxhms.model.*;
import com.vistaluxhms.repository.Vlx_City_Master_Repository;
import com.vistaluxhms.services.*;
import com.vistaluxhms.util.VistaluxConstants;
import com.vistaluxhms.validator.CityManagementValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.transaction.Transactional;
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

    @PostMapping("view_share_season_sales_partner_form")
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
        System.out.println("Rate Type size is " + rateSessionMappingList.size());
        modelView.addObject("RATE_SESSION_MAPPING_LIST", rateSessionMappingList);
        return modelView;
    }

    @PostMapping("review_sales_partner_rate_share_form")
    public ModelAndView review_sales_partner_rate_share_form(@RequestParam(value = "selectedSessions", required = false) List<Integer> selectedSessions,final RedirectAttributes redirectAttrib) {
        ModelAndView modelAndView = new ModelAndView("admin/salespartner/reviewShareRateSessionForm"); // Change this to your JSP page
        if (selectedSessions != null && !selectedSessions.isEmpty()) {
            // Process the selected session IDs
            System.out.println("Selected Session ID is : " + selectedSessions);

            List<Map<String, Object>> sessionDetailsList = new ArrayList<>();
            for (Integer sessionRateMappingId : selectedSessions) {
                SessionRateMappingEntity sessionRateMappingEntity = sessionService.findSessionRateMappingEntityById(sessionRateMappingId);
                Map<String, Object> sessionDetail = getSessionDetailMap(sessionRateMappingEntity);
                if (sessionDetail != null) {
                    sessionDetailsList.add(sessionDetail);
                }
            }
            modelAndView.addObject("SESSION_SHARE_LIST",sessionDetailsList);
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
                newSessionDetailsEntityDTO.setSessionStartDate(sessionRateMappingEntity.getStartDate());
                newSessionDetailsEntityDTO.setSessionEndDate(sessionRateMappingEntity.getEndDate());
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

}
