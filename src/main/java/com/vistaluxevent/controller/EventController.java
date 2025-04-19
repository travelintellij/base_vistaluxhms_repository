package com.vistaluxevent.controller;

import com.vistaluxevent.entity.EventMasterServiceEntity;
import com.vistaluxevent.entity.EventPackageEntity;
import com.vistaluxevent.entity.EventServiceCostTypeEntity;
import com.vistaluxevent.entity.EventTypeEntity;
import com.vistaluxevent.model.EventMasterServiceDTO;
import com.vistaluxevent.repository.EventTypeRepository;
import com.vistaluxevent.services.EventServicesImpl;
import com.vistaluxhms.entity.City_Entity;
import com.vistaluxhms.entity.MasterRoomDetailsEntity;
import com.vistaluxhms.model.City_Obj;
import com.vistaluxhms.model.SessionRateMappingEntityDTO;
import com.vistaluxhms.model.UserDetailsObj;
import com.vistaluxhms.services.UserDetailsServiceImpl;
import com.vistaluxhms.services.VlxCommonServicesImpl;
import com.vistaluxhms.util.VistaluxConstants;
import com.vistaluxhms.validator.CityManagementValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
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
public class EventController {


	@Autowired
	UserDetailsServiceImpl userDetailsService;

	@Autowired
	VlxCommonServicesImpl commonService;

	@Autowired
	EventServicesImpl eventServices;


	//@Autowired
	//EmailServiceImpl emailService;


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

	@RequestMapping(value="view_add_master_service_form",method= {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView view_add_master_service_form(@ModelAttribute("EVENT_MASTER_SERVICE") EventMasterServiceDTO eventMasterServiceDTO, BindingResult result ) {
		UserDetailsObj userObj = getLoggedInUser();
		ModelAndView modelView = new ModelAndView("event/createMasterService");
		//modelView.addObject("eventService", new EventMasterService());
		List<EventTypeEntity> listEventType = eventServices.findAllEventType();
		modelView.addObject("EVENT_TYPES", listEventType);
		List<EventServiceCostTypeEntity> eventServiceCostTypeEntities = eventServices.findActiveEventServiceCostType(true);
		modelView.addObject("SERVICE_TYPE", eventServiceCostTypeEntities);
		//modelView.addObject("ACTIVE_CTRYCODE_CTRYNAME_LIST", activeDistinctDestinationList);
		return modelView;
	}

	@PostMapping(value="create_edit_master_service")
	public ModelAndView create_edit_master_service(@ModelAttribute("EVENT_MASTER_SERVICE") EventMasterServiceDTO eventMasterServiceDTO, BindingResult result, final RedirectAttributes redirectAttrib) {
		ModelAndView modelView = new ModelAndView();
		EventMasterServiceEntity eventMasterServiceEntity = new EventMasterServiceEntity();
		eventMasterServiceEntity.updateEntityFromDTO(eventMasterServiceDTO);
		eventServices.saveEventMasterService(eventMasterServiceEntity);
		redirectAttrib.addFlashAttribute("Success","Event Master Service Record is created successfully. ");
		modelView.setViewName("redirect:view_master_service_list");
		return modelView;
	}

	@RequestMapping("view_master_service_list")
	public ModelAndView view_rooms_list() {
		ModelAndView modelView = new ModelAndView("event/viewEventMasterServiceListing");
		// Adding user details to the model
		// Filtering sales partners based on the search criteria
		List<EventMasterServiceEntity> listEventMasterServiceEntity = eventServices.findEventMasterServiceList();
		List<EventMasterServiceEntity> listEventMasterServiceDTO = new ArrayList<>();
		for (EventMasterServiceEntity entity : listEventMasterServiceEntity) {
			EventMasterServiceDTO eventMasterServiceDTO = new EventMasterServiceDTO();
			eventMasterServiceDTO.updateDTOFromEntity(entity);
			eventMasterServiceDTO.setEventTypeName(eventServices.findEventTypeById(entity.getEventTypeId()).getEventTypeName());
			listEventMasterServiceDTO.add(eventMasterServiceDTO);

		}
		modelView.addObject("ACTIVE_MASTER_SERVICE_LIST", listEventMasterServiceDTO);
		return modelView;
	}

	@PostMapping("view_master_service_details")
	public ModelAndView view_master_service_details(@ModelAttribute("EVENT_MASTER_SERVICE") EventMasterServiceDTO eventMasterServiceDTO, BindingResult result) {
		UserDetailsObj userObj = getLoggedInUser();
		ModelAndView modelView = new ModelAndView("event/View_Event_Master_Service");
		// Adding user details to the model
		// Filtering sales partners based on the search criteria
		EventMasterServiceEntity eventMasterServiceEntity= eventServices.findEventMasterServiceById(eventMasterServiceDTO.getId());
		EventTypeEntity eventTypeEntity = eventServices.findEventTypeById(eventMasterServiceEntity.getEventTypeId());
		eventMasterServiceDTO.setEventTypeName(eventTypeEntity.getEventTypeName());
		eventMasterServiceDTO.updateDTOFromEntity(eventMasterServiceEntity);
		modelView.addObject("EVENT_MASTER_SERVICE", eventMasterServiceDTO);
		return modelView;
	}

	@PostMapping("view_edit_master_service_form")
	public ModelAndView view_edit_master_service_form(@ModelAttribute("EVENT_MASTER_SERVICE") EventMasterServiceDTO eventMasterServiceDTO, BindingResult result) {
		UserDetailsObj userObj = getLoggedInUser();
		ModelAndView modelView = new ModelAndView("event/editMasterService");
		EventMasterServiceEntity eventMasterServiceEntity= eventServices.findEventMasterServiceById(eventMasterServiceDTO.getId());
		eventMasterServiceDTO.updateDTOFromEntity(eventMasterServiceEntity);
		modelView.addObject("EVENT_MASTER_SERVICE", eventMasterServiceDTO);
		List<EventTypeEntity> listEventType = eventServices.findAllEventType();
		modelView.addObject("EVENT_TYPES", listEventType);
		List<EventServiceCostTypeEntity> eventServiceCostTypeEntities = eventServices.findActiveEventServiceCostType(true);
		modelView.addObject("SERVICE_TYPE", eventServiceCostTypeEntities);
		return modelView;
	}


	@RequestMapping(value="view_event_quotation_form_wiz1",method= {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView view_event_quotation_form_wiz1(@ModelAttribute("EVENT_PACKAGE") EventPackageEntity eventPackageEntity, BindingResult result ) {
		UserDetailsObj userObj = getLoggedInUser();
		ModelAndView modelView = new ModelAndView("event/quotation/createEventQuotationWiz1");
		//modelView.addObject("eventService", new EventMasterService());
		List<EventTypeEntity> listEventType = eventServices.findAllEventType();
		modelView.addObject("EVENT_TYPES", listEventType);
		List<EventServiceCostTypeEntity> eventServiceCostTypeEntities = eventServices.findActiveEventServiceCostType(true);
		modelView.addObject("SERVICE_TYPE", eventServiceCostTypeEntities);
		//modelView.addObject("ACTIVE_CTRYCODE_CTRYNAME_LIST", activeDistinctDestinationList);
		return modelView;
	}



}
