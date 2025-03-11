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

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Optional;


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

		sessionService.saveSessionMaster(sessionEntity);
		modelView.setViewName("forward:view_add_session_form");

		return modelView;
	}

	@PostMapping(value="create_create_session_detail")
	public ModelAndView create_create_session_master(@ModelAttribute("SESSION_OBJ") SessionDetailsEntity sessionDetailsEntity, BindingResult result, final RedirectAttributes redirectAttrib) {
		UserDetailsObj userObj = getLoggedInUser(); // Retrieve logged-in user details
		System.out.println("Session Entity object is " + sessionDetailsEntity);

		ModelAndView modelView = new ModelAndView();
		modelView.setViewName("forward:view_add_session_form");

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
	public ModelAndView view_add_session_form(@ModelAttribute("SESSION_MASTER_OBJ") SessionEntity sessionEntity, @ModelAttribute("SESSION_DETAIL_OBJ") SessionDetailsEntity sessionObj, BindingResult result) {
		UserDetailsObj userObj = getLoggedInUser();
		List<MasterRoomDetailsEntity> ACTIVE_ROOM_LIST = salesRelatedServices.findActiveRoomsList();
		ModelAndView modelView = new ModelAndView("session/Admin_Edit_Session_Details");
		modelView.addObject("ACTIVE_ROOM_LIST",ACTIVE_ROOM_LIST);

		for (MasterRoomDetailsEntity activeRoomCategory : ACTIVE_ROOM_LIST) {
			List<SessionDetailsEntity> sessionDetailsEntityList = new ArrayList<>();

			for (Integer mealPlanKey : VistaluxConstants.MEAL_PLANS_MAP.keySet()) {
				Optional<SessionDetailsEntity> existingSessionDetailsEntity =sessionService.findSessionDetailsEntity(sessionEntity.getSessionId(),activeRoomCategory.getRoomCategoryId(),mealPlanKey);
				if(existingSessionDetailsEntity.isPresent()) {
					System.out.println("Room Category " + activeRoomCategory.getRoomCategoryName() + "   Key: " + mealPlanKey + ", Value: " + VistaluxConstants.MEAL_PLANS_MAP.get(mealPlanKey));
					sessionDetailsEntityList.add(existingSessionDetailsEntity.get());
				}
				else{
					System.out.println("Not Present");
					SessionDetailsEntity newSessionDetailsEntity = new SessionDetailsEntity();
					newSessionDetailsEntity.setRoomCategoryId(activeRoomCategory.getRoomCategoryId());
					SessionEntity session = new SessionEntity();
					session.setSessionId(sessionEntity.getSessionId());
					newSessionDetailsEntity.setSession(session);
					newSessionDetailsEntity.setMealPlanId(mealPlanKey);
					sessionDetailsEntityList.add(newSessionDetailsEntity);
				}
			}
		}


		return modelView;
	}

}
