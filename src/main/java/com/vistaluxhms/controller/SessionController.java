package com.vistaluxhms.controller;

import com.vistaluxhms.entity.City_Entity;
import com.vistaluxhms.entity.SessionDetailsEntity;
import com.vistaluxhms.model.City_Obj;
import com.vistaluxhms.model.UserDetailsObj;
import com.vistaluxhms.services.SalesRelatesServicesImpl;
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


@Controller
public class SessionController {


	@Autowired
	UserDetailsServiceImpl userDetailsService;

	@Autowired
	VlxCommonServicesImpl commonService;

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

	@RequestMapping("view_add_session_form")
	public ModelAndView view_add_session_form(@ModelAttribute("SESSION_OBJ") SessionDetailsEntity sessionObj, BindingResult result ) {
		UserDetailsObj userObj = getLoggedInUser();
		List ACTIVE_ROOM_LIST = salesRelatedServices.findActiveRoomsList();
		ModelAndView modelView = new ModelAndView("session/Admin_Add_Session");
		modelView.addObject("ACTIVE_ROOM_LIST",ACTIVE_ROOM_LIST);

		return modelView;
	}


    
}
