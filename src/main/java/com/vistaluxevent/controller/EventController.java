package com.vistaluxevent.controller;

import com.vistaluxevent.entity.*;
import com.vistaluxevent.model.EventMasterServiceDTO;
import com.vistaluxevent.model.EventPackageEntityDTO;
import com.vistaluxevent.services.EventServicesImpl;
import com.vistaluxhms.entity.ClientEntity;
import com.vistaluxhms.model.UserDetailsObj;
import com.vistaluxhms.services.ClientServicesImpl;
import com.vistaluxhms.services.UserDetailsServiceImpl;
import com.vistaluxhms.services.VlxCommonServicesImpl;
import com.vistaluxhms.util.VistaluxConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;


@Controller
public class EventController {


	@Autowired
	UserDetailsServiceImpl userDetailsService;

	@Autowired
	VlxCommonServicesImpl commonService;

	@Autowired
	EventServicesImpl eventServices;

	@Autowired
	ClientServicesImpl clientService;


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
	public ModelAndView view_event_quotation_form_wiz1(@ModelAttribute("EVENT_PACKAGE") EventPackageEntityDTO eventPackageEntityDTO, BindingResult result ) {
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

	@PostMapping("create_event_quoration_wiz_2")
	public ModelAndView create_event_quoration_wiz_2(@ModelAttribute("EVENT_PACKAGE") EventPackageEntityDTO eventPackageEntityDTO, BindingResult result) {
		UserDetailsObj userObj = getLoggedInUser();
		ModelAndView modelView = new ModelAndView("event/quotation/createEventQuotationWiz2");
		validateClient(eventPackageEntityDTO,result);
		isValidEventDates(eventPackageEntityDTO.getEventStartDate(), eventPackageEntityDTO.getEventEndDate(),result);
		if (result.hasErrors()) {
			return view_event_quotation_form_wiz1(eventPackageEntityDTO, result);
		} else {
			if (eventPackageEntityDTO.getQuotationAudienceType() == 1) {
				ClientEntity clientEntity = clientService.findClientById(eventPackageEntityDTO.getGuestId());
				eventPackageEntityDTO.setMobile(clientEntity.getMobile().toString());
				eventPackageEntityDTO.setEmail(clientEntity.getEmailId());
				System.out.println("All Value set for mobile and email");
				System.out.println(eventPackageEntityDTO);
			}
			List <EventMasterServiceEntity> eventMasterServiceDTOList = eventServices.findActiveEventMasterServiceList(true);
			List < EventPackageServiceEntity> eventPackageServicesEntityList = new ArrayList<EventPackageServiceEntity>();
			List<EventServiceCostTypeEntity> listServiceCostType = eventServices.findActiveEventServiceCostType(true);
			eventPackageServicesEntityList = updateEventServicesList(eventPackageEntityDTO,eventMasterServiceDTOList,eventPackageServicesEntityList,listServiceCostType,eventPackageEntityDTO.getBaseGuestCount());
			eventPackageEntityDTO.setServices(eventPackageServicesEntityList);
			modelView.addObject("LIST_SERVICE_COST_TYPE", listServiceCostType);
			modelView.addObject("eventPackageEntityDTO", eventPackageEntityDTO);

		}
		return modelView;
	}

	private List < EventPackageServiceEntity>  updateEventServicesList(EventPackageEntityDTO eventPackageEntityDTO,List <EventMasterServiceEntity> eventMasterServiceDTOList,List < EventPackageServiceEntity>  eventPackageServicesEntityList,List<EventServiceCostTypeEntity> listServiceCostType,int baseGuestCount){
		for (EventMasterServiceEntity masterService : eventMasterServiceDTOList) {
			EventPackageServiceEntity packageService = new EventPackageServiceEntity();
			packageService.setServiceName(masterService.getName());
			packageService.setEventServiceCostTypeEntity(masterService.getEventServiceCostTypeEntity());
			int totalNights = (int)getNumberOfNights(eventPackageEntityDTO.getEventStartDate(),eventPackageEntityDTO.getEventEndDate());
			int totalDays=totalNights+1;

			for (EventServiceCostTypeEntity serviceCostType : listServiceCostType) {
				//String costTypeName = serviceCostType.getEventServiceCostTypeName(); // Assuming the getter method is `getEventServiceCostTypeName()`
				String costTypeName =masterService.getEventServiceCostTypeEntity().getEventServiceCostTypeName();
				int totalCost=0;
				switch (costTypeName) {
					case VistaluxConstants.PER_GUEST_PER_NIGHT:
						packageService.setQuantity(baseGuestCount);
						packageService.setCostPerUnit(masterService.getBaseCost());
						totalCost = packageService.getQuantity()*packageService.getCostPerUnit() * totalNights;
						packageService.setTotalCost(totalCost);
						break;

					case VistaluxConstants.PER_GUEST_ONE_TIME:
						// Perform action for TypeB
						packageService.setQuantity(baseGuestCount);
						packageService.setCostPerUnit(masterService.getBaseCost());
						totalCost = packageService.getQuantity()*packageService.getCostPerUnit() * 1;
						packageService.setTotalCost(totalCost);
						break;

					case VistaluxConstants.PER_GUEST_PER_DAY:
						// Perform action for TypeC
						packageService.setQuantity(baseGuestCount);
						packageService.setCostPerUnit(masterService.getBaseCost());
						totalCost = packageService.getQuantity()*packageService.getCostPerUnit() * totalDays;
						packageService.setTotalCost(totalCost);
						break;

					case VistaluxConstants.PER_ROOM_ONE_TIME:
						packageService.setQuantity(eventPackageEntityDTO.getNumberOfRooms());
						packageService.setCostPerUnit(masterService.getBaseCost());
						totalCost = packageService.getQuantity()*packageService.getCostPerUnit() * 1;
						packageService.setTotalCost(totalCost);
						break;

					case VistaluxConstants.PER_ROOM_PER_NIGHT:
						packageService.setQuantity(eventPackageEntityDTO.getNumberOfRooms());
						packageService.setCostPerUnit(masterService.getBaseCost());
						totalCost = packageService.getQuantity()*packageService.getCostPerUnit() * totalNights;
						packageService.setTotalCost(totalCost);
						break;

					case VistaluxConstants.PER_DAY:
						packageService.setQuantity(1);
						packageService.setCostPerUnit(masterService.getBaseCost());
						totalCost = packageService.getQuantity()*packageService.getCostPerUnit() * totalDays;
						packageService.setTotalCost(totalCost);
						break;

					case VistaluxConstants.PER_NIGHT:
						packageService.setQuantity(totalNights);
						packageService.setCostPerUnit(masterService.getBaseCost());
						totalCost = packageService.getQuantity()*packageService.getCostPerUnit() * totalNights;
						packageService.setTotalCost(totalCost);
						break;

					case VistaluxConstants.ONE_TIME:
						packageService.setQuantity(1);
						packageService.setCostPerUnit(masterService.getBaseCost());
						totalCost = packageService.getQuantity()*packageService.getCostPerUnit() * 1;
						packageService.setTotalCost(totalCost);
						break;

					// Add more cases as needed
					default:
						// Handle the default case if the eventServiceCostTypeName doesn't match any case
						System.out.println("Unknown cost type: " + costTypeName);
						break;
				}
			}
			eventPackageServicesEntityList.add(packageService);

		}
		return eventPackageServicesEntityList;
	}

	public static long getNumberOfNights(LocalDate startEventDate, LocalDate endEventDate) {
		if (startEventDate == null || endEventDate == null) {
			throw new IllegalArgumentException("Dates must not be null");
		}

		long nights = ChronoUnit.DAYS.between(startEventDate, endEventDate);

		if (nights < 0) {
			throw new IllegalArgumentException("End date must be after start date");
		}

		return nights;
	}

	private boolean validateClient(EventPackageEntityDTO eventPackageEntityDTO, Errors errors) {
		if (eventPackageEntityDTO.getQuotationAudienceType() == 1) {
			if (eventPackageEntityDTO.getGuestId() == 0) {
				errors.rejectValue("guestName", "contact.error");
				return false;
			} else {
				ClientEntity clientEntity = clientService.findClientById(eventPackageEntityDTO.getGuestId());
				if (!clientEntity.getClientName().trim().equalsIgnoreCase(eventPackageEntityDTO.getGuestName().trim())) {
					System.out.println("Client Name is " + clientEntity.getClientName() + "--" + "Guest Name is " + eventPackageEntityDTO.getGuestName());
					errors.rejectValue("guestName", "contact.error");
					return false;
				}
			}
		}
		return true;
	}

	public boolean isValidEventDates(LocalDate eventStartDate, LocalDate eventEndDate,Errors errors) {
		LocalDate today = LocalDate.now();

		// Check if start date is today or in the future
		if (eventStartDate.isBefore(today)) {
			errors.rejectValue("eventStartDate", "error.eventStartDate", "Start date should be today or a future date.");
			return false;
		}
		// Check if end date is not before start date
		if (eventEndDate.isBefore(eventStartDate)) {
			System.out.println("");
			errors.rejectValue("eventEndDate", "error.eventEndDate", "End date cannot be before the start date.");
			return false;
		}
		return true;
	}


}
