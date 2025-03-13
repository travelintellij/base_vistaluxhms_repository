package com.vistaluxhms.controller;

import com.vistaluxhms.entity.*;
import com.vistaluxhms.model.*;
import com.vistaluxhms.services.SalesRelatesServicesImpl;
import com.vistaluxhms.services.SessionServiceImpl;
import com.vistaluxhms.services.UserDetailsServiceImpl;
import com.vistaluxhms.services.VlxCommonServicesImpl;
import com.vistaluxhms.util.VistaluxConstants;
import com.vistaluxhms.validator.CityManagementValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.*;


@Controller
public class SessionController {


	@Autowired
	UserDetailsServiceImpl userDetailsService;

	@Autowired
	SessionServiceImpl sessionService;

	@Autowired
	SalesRelatesServicesImpl salesRelatedServices;

	@Value("${HOTEL_MAX_STANDARD_OCCUPANCY}")  // Injects the property value
	private String HOTEL_MAX_STANDARD_OCCUPANCY_SUPPORTED;

	@Value("${HOTEL_MAX_EXTRA_BED}")  // Injects the property value
	private String HOTEL_MAX_EXTRA_BED_SUPPORTED;


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


	@PostMapping(value="create_create_session_master")
	public ModelAndView create_create_session_detail(@ModelAttribute("SESSION_MASTER_OBJ") SessionEntity sessionEntity,@ModelAttribute("SESSION_OBJ") SessionDetailsEntity sessionDetailsEntity,BindingResult result, final RedirectAttributes redirectAttrib) {
		UserDetailsObj userObj = getLoggedInUser(); // Retrieve logged-in user details
		ModelAndView modelView = new ModelAndView();
		sessionService.saveSessionDetails(sessionDetailsEntity);
		modelView.setViewName("redirect:view_session_list");

		return modelView;
	}

	@PostMapping(value="create_create_session_detail")
	public ModelAndView create_create_session_detail(@RequestParam("sessionId") Integer sessionId,@ModelAttribute("SESSION_OBJ") SessionDetailsEntity sessionDetailsEntity, BindingResult result, final RedirectAttributes redirectAttrib) {
		UserDetailsObj userObj = getLoggedInUser(); // Retrieve logged-in user details
		System.out.println("Session id is " + sessionId);
		System.out.println("Session Entity object is " + sessionDetailsEntity);
		SessionEntity sessionEntity = sessionService.findSessionById(sessionId);
		sessionDetailsEntity.setSession(sessionEntity);
		ModelAndView modelView = new ModelAndView();
		modelView.setViewName("redirect:view_edit_session_detail_form?sessionId="+sessionId);
		sessionService.saveSessionDetails(sessionDetailsEntity);
		redirectAttrib.addFlashAttribute("Success", "Session Details record updated successfully.");
		return modelView;
	}

	@RequestMapping("view_session_list")
	public ModelAndView view_session_list(@ModelAttribute("SESSION_FILTER_OBJ") SessionFilterDTO sessionFilterDTO, BindingResult result) {
		UserDetailsObj userObj = getLoggedInUser();
		ModelAndView modelView = new ModelAndView("session/viewSessionListing");
		// Adding user details to the model
		modelView.addObject("userName", userObj.getUsername());
		modelView.addObject("Id", userObj.getUserId());
		// Filtering sales partners based on the search criteria
		List<SessionEntity> sessionEntityList = sessionService.filterSession(sessionFilterDTO);
		modelView.addObject("SALES_PARTNER_FILTERED_LIST", sessionEntityList);
		return modelView;
	}

	@PostMapping("view_session_details")
	public ModelAndView viewSessionDetails(@RequestParam("sessionId") Integer sessionId) {
		UserDetailsObj userObj = getLoggedInUser();
		ModelAndView modelView = new ModelAndView("session/Admin_View_Session");

		// Adding user details to the model
		modelView.addObject("userName", userObj.getUsername());
		modelView.addObject("Id", userObj.getUserId());

		// Fetch session details from the database
		SessionEntity sessionEntity = sessionService.findSessionById(sessionId);
		modelView.addObject("SESSION_MASTER_OBJ", sessionEntity);

		return modelView;
	}

	@RequestMapping(value="view_add_session_form",method= {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView view_add_session_form(@ModelAttribute("SESSION_MASTER_OBJ") SessionEntity sessionEntity,BindingResult result,final RedirectAttributes redirectAttrib) {
		//ModelAndView modelView = view_add_lead_form(leadRecorderVO,result);
		ModelAndView modelView = new ModelAndView("session/Admin_Add_Session");
		return modelView;
	}



	@RequestMapping(value="view_edit_session_form",method= {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView view_edit_session_form(@RequestParam("sessionId") Integer sessionId) {
		//ModelAndView modelView = view_add_lead_form(leadRecorderVO,result);
		ModelAndView modelView = new ModelAndView("session/Admin_Edit_Session");
		SessionEntity sessionEntity = sessionService.findSessionById(sessionId);
		modelView.addObject("SESSION_MASTER_OBJ", sessionEntity);
		return modelView;
	}


	@PostMapping(value="edit_edit_session")
	public ModelAndView edit_edit_session(@ModelAttribute("SESSION_MASTER_OBJ") SessionEntity sessionEntity,BindingResult result,final RedirectAttributes redirectAttrib) {
		UserDetailsObj userObj = getLoggedInUser(); // Retrieve logged-in user details
		ModelAndView modelView = new ModelAndView();
		sessionService.saveSessionMaster(sessionEntity);
		redirectAttrib.addFlashAttribute("Success", "Session record updated successfully.");
		modelView.setViewName("redirect:view_session_list");
		return modelView;
	}

	@RequestMapping("view_edit_session_detail_form")
	public ModelAndView view_add_session_form(@RequestParam("sessionId") Integer sessionId, @ModelAttribute("SESSION_DETAIL_OBJ") SessionDetailsEntityDTO sessionObj, BindingResult result) {
		UserDetailsObj userObj = getLoggedInUser();
		SessionEntity sessionEntity = sessionService.findSessionById(sessionId);
		sessionObj.setSession(sessionEntity);
		List<MasterRoomDetailsEntity> ACTIVE_ROOM_LIST = salesRelatedServices.findActiveRoomsList();
		ModelAndView modelView = new ModelAndView("session/Admin_Edit_Session_Details");
		modelView.addObject("ACTIVE_ROOM_LIST",ACTIVE_ROOM_LIST);
		modelView.addObject("SESSION_MASTER_OBJ",sessionEntity);
		/*for (MasterRoomDetailsEntity activeRoomCategory : ACTIVE_ROOM_LIST) {
			List<SessionDetailsEntityDTO> sessionDetailsEntityList = new ArrayList<>();
			for (Integer mealPlanKey : VistaluxConstants.MEAL_PLANS_MAP.keySet()) {
				SessionDetailsEntityDTO newSessionDetailsEntityDTO = new SessionDetailsEntityDTO();
				Optional<SessionDetailsEntity> existingSessionDetailsEntity =sessionService.findSessionDetailsEntity(sessionEntity.getSessionId(),activeRoomCategory.getRoomCategoryId(),mealPlanKey);
				if(existingSessionDetailsEntity.isPresent()) {
					System.out.println("Room Category " + activeRoomCategory.getRoomCategoryName() + "   Key: " + mealPlanKey + ", Value: " + VistaluxConstants.MEAL_PLANS_MAP.get(mealPlanKey));
					newSessionDetailsEntityDTO.updateVOFromEntity(existingSessionDetailsEntity.get());
					newSessionDetailsEntityDTO.setExists(true);
					sessionDetailsEntityList.add(newSessionDetailsEntityDTO);
				}
				else{
					System.out.println("Not Present");
					newSessionDetailsEntityDTO.setRoomCategoryId(activeRoomCategory.getRoomCategoryId());
					SessionEntity session = new SessionEntity();
					session.setSessionId(sessionEntity.getSessionId());
					newSessionDetailsEntityDTO.setSession(session);
					newSessionDetailsEntityDTO.setMealPlanId(mealPlanKey);
					newSessionDetailsEntityDTO.setExists(false);
					sessionDetailsEntityList.add(newSessionDetailsEntityDTO);
				}
			}
		}*/
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
						sessionService.findSessionDetailsEntity(sessionEntity.getSessionId(), roomCategoryId, mealPlanKey);

				if (existingSessionDetailsEntity.isPresent()) {
					newSessionDetailsEntityDTO.updateVOFromEntity(existingSessionDetailsEntity.get());
					newSessionDetailsEntityDTO.setExists(true);
				} else {
					newSessionDetailsEntityDTO.setRoomCategoryId(roomCategoryId);
					newSessionDetailsEntityDTO.setMealPlanId(mealPlanKey);
					newSessionDetailsEntityDTO.setSession(sessionEntity);
					newSessionDetailsEntityDTO.setExists(false);
				}

				// Store the DTO in the inner map
				mealPlanMap.put(mealPlanKey, newSessionDetailsEntityDTO);
			}

			// Store the inner map in the outer map
			sessionDetailsMap.put(roomCategoryId, mealPlanMap);
		}

// Add to model for JSP
		modelView.addObject("sessionDetailsMap", sessionDetailsMap);
		modelView.addObject("roomCategoryNames", activeRoomCategoriesMap); // e.g., {1: "Deluxe", 2: "Premium"}
		modelView.addObject("mealPlans", VistaluxConstants.MEAL_PLANS_MAP); // {1: "EPAI", 2: "CPAI", 3: "MAPAI", 4: "APAI"}

		return modelView;
	}



}
