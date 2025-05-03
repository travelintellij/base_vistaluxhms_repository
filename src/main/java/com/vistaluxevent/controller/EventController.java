package com.vistaluxevent.controller;

import com.lowagie.text.DocumentException;
import com.vistaluxevent.entity.*;
import com.vistaluxevent.model.EventMasterServiceDTO;
import com.vistaluxevent.model.EventPackageEntityDTO;
import com.vistaluxevent.model.FilterEventObj;
import com.vistaluxevent.services.EventServicesImpl;
import com.vistaluxhms.entity.ClientEntity;
import com.vistaluxhms.entity.LeadEntity;
import com.vistaluxhms.model.*;
import com.vistaluxhms.services.ClientServicesImpl;
import com.vistaluxhms.services.UserDetailsServiceImpl;
import com.vistaluxhms.services.VlxCommonServicesImpl;
import com.vistaluxhms.util.VistaluxConstants;
import freemarker.core.Configurable;
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

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;


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

	@PostMapping("create_event_quotation_wiz_2")
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
			List <EventMasterServiceEntity> eventMasterServiceDTOList = eventServices.findByEventTypeIdAndActiveEventMasterServiceList(eventPackageEntityDTO.getEventType().getEventTypeId(),true);

			List<EventServiceCostTypeEntity> listServiceCostType = eventServices.findActiveEventServiceCostType(true);
			List < EventPackageServiceEntity> eventPackageServicesEntityList = updateEventServicesList(eventPackageEntityDTO,eventMasterServiceDTOList,listServiceCostType,eventPackageEntityDTO.getBaseGuestCount());
			int grandTotal = 0;

			for (EventPackageServiceEntity service : eventPackageServicesEntityList) {
					grandTotal += service.getTotalCost();
			}
			eventPackageEntityDTO.setGrand_total_cost(grandTotal);
			eventPackageEntityDTO.setServices(eventPackageServicesEntityList);
			modelView.addObject("LIST_SERVICE_COST_TYPE", listServiceCostType);
			modelView.addObject("eventPackageEntityDTO", eventPackageEntityDTO);

		}
		return modelView;
	}

	private List < EventPackageServiceEntity>  updateEventServicesList(EventPackageEntityDTO eventPackageEntityDTO,List <EventMasterServiceEntity> eventMasterServiceDTOList,List<EventServiceCostTypeEntity> listServiceCostType,int baseGuestCount){
		List < EventPackageServiceEntity>  eventPackageServicesEntityList = new ArrayList<EventPackageServiceEntity>();
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

	@RequestMapping(value = "create_create_event_quotation", params = "recalculate", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView handleRecalculate(@ModelAttribute("EVENT_PACKAGE") EventPackageEntityDTO eventPackageEntityDTO,
											 BindingResult result, final RedirectAttributes redirectAttrib) {
		//ModelAndView modelView = new ModelAndView("forward:create_event_quotation_wiz_2");
		ModelAndView modelView = new ModelAndView();
		if(!eventPackageEntityDTO.isUpdate())
			modelView.setViewName("event/quotation/createEventQuotationWiz2");
		else
			modelView.setViewName("event/quotation/updateEventQuotation");

		System.out.println("Update Value is " + eventPackageEntityDTO.isUpdate());
		UserDetailsObj userObj = getLoggedInUser();
		isValidEventDates(eventPackageEntityDTO.getEventStartDate(), eventPackageEntityDTO.getEventEndDate(),result);
		List<EventServiceCostTypeEntity> listServiceCostType = eventServices.findActiveEventServiceCostType(true);;
		if (result.hasErrors()) {
			modelView.addObject("org.springframework.validation.BindingResult.EVENT_PACKAGE", result); // Very important
			modelView.addObject("LIST_SERVICE_COST_TYPE", listServiceCostType);
			modelView.addObject("eventPackageEntityDTO", eventPackageEntityDTO);
			modelView.addObject("EVENT_PACKAGE", eventPackageEntityDTO);
			return modelView;
		} else {

			List < EventPackageServiceEntity> eventPackageServicesEntityList = recalcualateEventServicesList(eventPackageEntityDTO,listServiceCostType);

			int grandTotal = 0;
			for (EventPackageServiceEntity service : eventPackageServicesEntityList) {
				grandTotal += service.getTotalCost();
			}
			eventPackageEntityDTO.setGrand_total_cost(grandTotal);
			//eventPackageEntityDTO.setServices(eventPackageServicesEntityList);
			eventPackageEntityDTO.setServices(
					eventPackageServicesEntityList.stream()
							.filter(service -> service.getServiceName() != null && !service.getServiceName().trim().isEmpty())
							.collect(Collectors.toList())
			);

		}
		modelView.addObject("LIST_SERVICE_COST_TYPE", listServiceCostType);
		modelView.addObject("eventPackageEntityDTO", eventPackageEntityDTO);
		modelView.addObject("EVENT_PACKAGE", eventPackageEntityDTO);
		return modelView;
	}

	private List < EventPackageServiceEntity>  recalcualateEventServicesList(EventPackageEntityDTO eventPackageEntityDTO,List<EventServiceCostTypeEntity> listServiceCostType ){
		List < EventPackageServiceEntity>  eventPackageServicesEntityList = new ArrayList<EventPackageServiceEntity>();
		for (EventPackageServiceEntity packageService : eventPackageEntityDTO.getServices()) {
			int totalNights = (int)getNumberOfNights(eventPackageEntityDTO.getEventStartDate(),eventPackageEntityDTO.getEventEndDate());
			int totalDays=totalNights+1;

			for (EventServiceCostTypeEntity serviceCostType : listServiceCostType) {
				//String costTypeName = serviceCostType.getEventServiceCostTypeName(); // Assuming the getter method is `getEventServiceCostTypeName()`
				if(packageService.getEventServiceCostTypeEntity()!=null){
				Integer serviceCostTypeId = packageService.getEventServiceCostTypeEntity().getEventServiceCostTypeId();
				EventServiceCostTypeEntity costTypeEntity = eventServices.findEventServiceCostTypeByID(serviceCostTypeId);
				packageService.setEventServiceCostTypeEntity(costTypeEntity);

				String costTypeName = packageService.getEventServiceCostTypeEntity().getEventServiceCostTypeName();
				int totalCost = 0;
				switch (costTypeName) {
					case VistaluxConstants.PER_GUEST_PER_NIGHT:
						totalCost = packageService.getQuantity() * packageService.getCostPerUnit() * totalNights;
						packageService.setTotalCost(totalCost);
						break;

					case VistaluxConstants.PER_GUEST_ONE_TIME:
						// Perform action for TypeB
						totalCost = packageService.getQuantity() * packageService.getCostPerUnit() * 1;
						packageService.setTotalCost(totalCost);
						break;

					case VistaluxConstants.PER_GUEST_PER_DAY:
						// Perform action for TypeC
						totalCost = packageService.getQuantity() * packageService.getCostPerUnit() * totalDays;
						packageService.setTotalCost(totalCost);
						break;

					case VistaluxConstants.PER_ROOM_ONE_TIME:
						totalCost = packageService.getQuantity() * packageService.getCostPerUnit() * 1;
						packageService.setTotalCost(totalCost);
						break;

					case VistaluxConstants.PER_ROOM_PER_NIGHT:
						totalCost = packageService.getQuantity() * packageService.getCostPerUnit() * totalNights;
						packageService.setTotalCost(totalCost);
						break;

					case VistaluxConstants.PER_DAY:
						totalCost = packageService.getQuantity() * packageService.getCostPerUnit() * totalDays;
						packageService.setTotalCost(totalCost);
						break;

					case VistaluxConstants.PER_NIGHT:
						totalCost = packageService.getQuantity() * packageService.getCostPerUnit() * totalNights;
						packageService.setTotalCost(totalCost);
						break;

					case VistaluxConstants.ONE_TIME:
						totalCost = packageService.getQuantity() * packageService.getCostPerUnit() * 1;
						packageService.setTotalCost(totalCost);
						break;

					// Add more cases as needed
					default:
						// Handle the default case if the eventServiceCostTypeName doesn't match any case
						System.out.println("Unknown cost type: " + costTypeName);
						break;
				}
			}
			}
			if(packageService.getServiceName()!=null && (!packageService.getServiceName().isEmpty()))
				eventPackageServicesEntityList.add(packageService);
		}
		return eventPackageServicesEntityList;
	}


	@RequestMapping(value = "create_create_event_quotation", params = "saveQuotation", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView saveQuotation(@ModelAttribute("EVENT_PACKAGE") EventPackageEntityDTO eventPackageEntityDTO,
										  BindingResult result, final RedirectAttributes redirectAttrib) {
		//ModelAndView modelView = new ModelAndView("forward:create_event_quotation_wiz_2");
		ModelAndView modelView = new ModelAndView();
		UserDetailsObj userObj = getLoggedInUser();
		isValidEventDates(eventPackageEntityDTO.getEventStartDate(), eventPackageEntityDTO.getEventEndDate(),result);
		List<EventServiceCostTypeEntity> listServiceCostType = eventServices.findActiveEventServiceCostType(true);
		if (result.hasErrors()) {
			modelView.setViewName("event/quotation/createEventQuotationWiz2");
			modelView.addObject("LIST_SERVICE_COST_TYPE", listServiceCostType);
			modelView.addObject("eventPackageEntityDTO", eventPackageEntityDTO);
			modelView.addObject("EVENT_PACKAGE", eventPackageEntityDTO);
			modelView.addObject("org.springframework.validation.BindingResult.EVENT_PACKAGE", result); // Very important
			return modelView;
		} else {
			EventPackageEntity eventPackageEntity = new EventPackageEntity();
			eventPackageEntity.setPackageName(eventPackageEntityDTO.getPackageName());
			eventPackageEntity.setDescription(eventPackageEntityDTO.getDescription());
			eventPackageEntity.setBaseGuestCount(eventPackageEntityDTO.getBaseGuestCount());
			eventPackageEntity.setCreatedBy(userObj.getUserId());
			eventPackageEntity.setGrand_total_cost(eventPackageEntityDTO.getGrand_total_cost());
			eventPackageEntity.setDiscount(eventPackageEntityDTO.getDiscount());
			eventPackageEntity.setGstIncluded(eventPackageEntityDTO.isGstIncluded());
			eventPackageEntity.setShowBreakup(eventPackageEntityDTO.isShowBreakup());
			eventPackageEntity.setEventStartDate(eventPackageEntityDTO.getEventStartDate());
			eventPackageEntity.setEventEndDate(eventPackageEntityDTO.getEventEndDate());
			eventPackageEntity.setNumberOfRooms(eventPackageEntityDTO.getNumberOfRooms());
			eventPackageEntity.setEventType(eventPackageEntityDTO.getEventType());
			eventPackageEntity.setGuestId(eventPackageEntityDTO.getGuestId());
			eventPackageEntity.setGuestName(eventPackageEntityDTO.getGuestName());
			eventPackageEntity.setQuotationAudienceType(eventPackageEntityDTO.getQuotationAudienceType());
			eventPackageEntity.setContactMethod(eventPackageEntityDTO.getContactMethod());
			eventPackageEntity.setMobile(eventPackageEntityDTO.getMobile());
			eventPackageEntity.setEmail(eventPackageEntityDTO.getEmail());

			// For services list you can also map if needed here
			// Handle services list
			if (eventPackageEntityDTO.getServices() != null && !eventPackageEntityDTO.getServices().isEmpty()) {
				for (EventPackageServiceEntity serviceEntity : eventPackageEntityDTO.getServices()) {
					serviceEntity.setEventPackage(eventPackageEntity); // Set the parent for each service
				}
				eventPackageEntity.setServices(eventPackageEntityDTO.getServices()); // Set list into entity
			}
			if (eventPackageEntityDTO.getEventType() != null && eventPackageEntityDTO.getEventType().getEventTypeId() != 0) {
				EventTypeEntity eventTypeEntity = eventServices.findEventTypeById(eventPackageEntityDTO.getEventType().getEventTypeId());
				eventPackageEntity.setEventType(eventTypeEntity);
			}

			// Save the Entity (not DTO)
			eventServices.saveEventPackage(eventPackageEntity);
			redirectAttrib.addFlashAttribute("Success", "Event Package Record is saved successfully.");
		}
		//modelView.addObject("LIST_SERVICE_COST_TYPE", listServiceCostType);
		modelView.setViewName("redirect:view_filter_events?id=" + eventPackageEntityDTO.getId() );
		return modelView;
	}


	@RequestMapping(value="view_filter_events",method= {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView view_filter_events(@RequestParam(defaultValue = "0") String page, @RequestParam(defaultValue = VistaluxConstants.DEFAULT_PAGE_SIZE) Integer pageSize, @RequestParam(defaultValue = "id") String sortBy, @ModelAttribute("FILTER_EVENT_OBJ") FilterEventObj filterObj, BindingResult result) {

		ModelAndView modelView = new ModelAndView("event/viewEventListing");
		//System.out.println(filterObj);

		/*List<WorkLoadStatusVO> lead_wl_statusList = commonService.find_All_Active_Status_Workload_Obj(VistaluxConstants.WORKLOAD_LEAD_STATUS);
		// Create a LinkedHashMap to preserve the insertion order
		Map<Integer, String> leadStatusMap = new LinkedHashMap<>();
		// Manually put the constants first so they appear at the top
		leadStatusMap.put(VistaluxConstants.VIEW_ALL_OPEN_LEADS_WL_STATUS, "***All Open Leads***");
		leadStatusMap.put(VistaluxConstants.VIEW_ALL_LEADS_WL_STATUS, "***All Leads***");
		leadStatusMap.put(VistaluxConstants.VIEW_ALL_CLOSED_LEADS_WL_STATUS, "***All Closed Leads***");
		lead_wl_statusList.stream()
				.sorted(Comparator.comparing(WorkLoadStatusVO::getWorkloadStatusId)) // Optional: Sort by name if needed
				.forEach(status -> leadStatusMap.put(status.getWorkloadStatusId(), status.getWorkloadStatusName()));
		modelView.addObject("EVENT_STATUS_MAP", leadStatusMap);
		*/
		List<UserDetailsObj> activeUsersList = userDetailsService.findAllActiveUsers();
		Map<Integer, String> activeUsersMap = (Map<Integer, String>) activeUsersList.stream().collect(
				Collectors.toMap(UserDetailsObj::getUserId, UserDetailsObj::getUsername));
		modelView.addObject("ACTIVE_USERS_MAP", activeUsersMap);

		UserDetailsObj user = getLoggedInUser();
		//filterObj.setLeadOwner(user.getUserId());
		boolean isAdmin=false;
		if(user.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN") || a.getAuthority().equals("LEAD_MANAGER"))) {
			isAdmin=true;
		}
		if((!isAdmin) && filterObj.getLeadOwner()==0) {
			filterObj.setLeadOwner(user.getUserId());
		}

		int pageNum = Integer.parseInt(page);
		Page<EventPackageEntity> pageLeadsFilteredRecords = eventServices.filterEvents(pageNum, pageSize, filterObj.getLeadOwner(), sortBy, filterObj, isAdmin);
		List<EventPackageEntityDTO> filteredEventsVoList = generateFilteredEventsVo(pageLeadsFilteredRecords);
		modelView.addObject("FILTERED_EVENT_RECORDS",filteredEventsVoList);
		modelView.addObject("currentPage", page);
		modelView.addObject("totalPages", pageLeadsFilteredRecords.getTotalPages());
		modelView.addObject("totalLeads", pageLeadsFilteredRecords.getTotalElements());
		modelView.addObject("pageSize", pageSize);
		modelView.addObject("maxPages", pageLeadsFilteredRecords.getTotalPages());
		modelView.addObject("page", page);
		modelView.addObject("sortBy", sortBy);
		modelView.addObject("leadStatus", filterObj.getLeadStatus());

		return modelView;
	}

	private List<EventPackageEntityDTO> generateFilteredEventsVo(Page<EventPackageEntity> pagedResult) {
		List<EventPackageEntityDTO> filteredEventsVoList = new ArrayList<EventPackageEntityDTO>();
		List<EventPackageEntity> eventEntityList = pagedResult.getContent();
		Iterator filteredLeadsIterator = eventEntityList.iterator();
		while(filteredLeadsIterator.hasNext()) {
			EventPackageEntity eventPackageEntity = (EventPackageEntity) filteredLeadsIterator.next();
			EventPackageEntityDTO packageEntityDTO =new EventPackageEntityDTO();
			packageEntityDTO.updateDTOFromEntity(eventPackageEntity);

			filteredEventsVoList.add(packageEntityDTO);
		}
		return filteredEventsVoList;
	}

	@RequestMapping(value="load_event_quotation_wiz_2",method= {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView load_event_quotation_wiz_2(@ModelAttribute("EVENT_PACKAGE") EventPackageEntityDTO eventPackageEntityDTO, BindingResult result) {
		UserDetailsObj userObj = getLoggedInUser();
		ModelAndView modelView = new ModelAndView("event/quotation/updateEventQuotation");
		EventPackageEntity eventPackageEntity = eventServices.findEventPackageById(eventPackageEntityDTO.getId());
		eventPackageEntityDTO.updateDTOFromEntity(eventPackageEntity);
		List<EventServiceCostTypeEntity> listServiceCostType = eventServices.findActiveEventServiceCostType(true);
		modelView.addObject("LIST_SERVICE_COST_TYPE", listServiceCostType);
		modelView.addObject("eventPackageEntityDTO", eventPackageEntityDTO);


		return modelView;
	}


	@RequestMapping(value = "create_create_event_quotation", params = "updateQuotation", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView edit_edit_event_quotation(@ModelAttribute("EVENT_PACKAGE") EventPackageEntityDTO eventPackageEntityDTO,
									  BindingResult result, final RedirectAttributes redirectAttrib) {
		//ModelAndView modelView = new ModelAndView("forward:create_event_quotation_wiz_2");
		ModelAndView modelView = new ModelAndView();
		UserDetailsObj userObj = getLoggedInUser();
		isValidEventDates(eventPackageEntityDTO.getEventStartDate(), eventPackageEntityDTO.getEventEndDate(),result);
		List<EventServiceCostTypeEntity> listServiceCostType = eventServices.findActiveEventServiceCostType(true);

		if (result.hasErrors()) {
			modelView.setViewName("event/quotation/updateEventQuotation");
			modelView.addObject("LIST_SERVICE_COST_TYPE", listServiceCostType);
			modelView.addObject("eventPackageEntityDTO", eventPackageEntityDTO);
			modelView.addObject("EVENT_PACKAGE", eventPackageEntityDTO);
			modelView.addObject("org.springframework.validation.BindingResult.EVENT_PACKAGE", result); // Very important
			return modelView;
		} else {
			EventPackageEntity eventPackageEntity = new EventPackageEntity(eventPackageEntityDTO);
			if (eventPackageEntityDTO.getEventType() != null && eventPackageEntityDTO.getEventType().getEventTypeId() != 0) {
				EventTypeEntity eventTypeEntity = eventServices.findEventTypeById(eventPackageEntityDTO.getEventType().getEventTypeId());
				eventPackageEntity.setEventType(eventTypeEntity);
			}
			syncServiceList(eventPackageEntity, eventPackageEntityDTO.getServices());
			// Save the Entity (not DTO)
			eventServices.saveEventPackage(eventPackageEntity);
			redirectAttrib.addFlashAttribute("Success", "Event Package Record is saved successfully.");
		}
		modelView.setViewName("redirect:view_filter_events?id="+ eventPackageEntityDTO.getId());
		//modelView.addObject("LIST_SERVICE_COST_TYPE", listServiceCostType);
		//modelView.addObject("eventPackageEntityDTO", eventPackageEntityDTO);
		//modelView.addObject("EVENT_PACKAGE", eventPackageEntityDTO);
		return modelView;
	}

	private void syncServiceList(EventPackageEntity eventPackage, List<EventPackageServiceEntity> incomingServices) {
		List<EventPackageServiceEntity> existingServices = eventPackage.getServices();

		// Create a map of existing services for easy lookup
		Map<Long, EventPackageServiceEntity> existingMap = existingServices.stream()
				.filter(s -> s.getId() != null)
				.collect(Collectors.toMap(EventPackageServiceEntity::getId, Function.identity()));

		List<EventPackageServiceEntity> updatedList = new ArrayList<>();

		for (EventPackageServiceEntity incoming : incomingServices) {
			if (incoming.getId() != null && existingMap.containsKey(incoming.getId())) {
				// Modify existing
				EventPackageServiceEntity existing = existingMap.get(incoming.getId());
				existing.setServiceName(incoming.getServiceName());
				existing.setEventServiceCostTypeEntity(incoming.getEventServiceCostTypeEntity());
				existing.setCostPerUnit(incoming.getCostPerUnit());
				existing.setQuantity(incoming.getQuantity());
				existing.setTotalCost(incoming.getTotalCost());
				// ... other fields
				updatedList.add(existing);
			} else {
				// New service
				incoming.setEventPackage(eventPackage);
				updatedList.add(incoming);
			}
		}

		// Replace with updated list
		existingServices.clear();
		existingServices.addAll(updatedList);
	}




	@RequestMapping(value="delete_delete_package_service",method= {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView delete_delete_package_service(@ModelAttribute("EVENT_PACKAGE") EventPackageEntityDTO eventPackageEntityDTO,
												  BindingResult result, final RedirectAttributes redirectAttrib) {
		ModelAndView modelAndView = new ModelAndView();
		eventServices.deleteEventPackageService(Long.parseLong(eventPackageEntityDTO.getDeleteIndex()));
		modelAndView.setViewName("redirect:load_event_quotation_wiz_2?update=true&id="+eventPackageEntityDTO.getId());
		return modelAndView;

	}


	@RequestMapping(value = "create_create_event_quotation", params = "updateQuotation", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView edit_edit_event_quotation(@ModelAttribute("EVENT_PACKAGE") EventPackageEntityDTO eventPackageEntityDTO,
												  BindingResult result, final RedirectAttributes redirectAttrib) {


	@RequestMapping(value = "process_quotation", params = "Download", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public void downloadQuotationPdf(@ModelAttribute("QUOTATION_OBJ") QuotationEntityDTO quotationEntityDTO, HttpSession session, HttpServletResponse response) throws IOException, TemplateException, DocumentException {
		generateQuotationPDF(quotationEntityDTO, session, response,"PDFQuotation.ftl");
	}

	private void generateQuotationPDF(QuotationEntityDTO quotationEntityDTO, HttpSession session, HttpServletResponse response,String templateName) throws IOException, TemplateException, DocumentException{
		// Prepare data for the template
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



}
