package com.vistaluxhms.controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.SortedMap;
import java.util.stream.Collectors;

import javax.validation.Valid;

import com.vistaluxhms.entity.City_Entity;
import com.vistaluxhms.model.City_Obj;
import com.vistaluxhms.model.UserDetailsObj;
import com.vistaluxhms.services.UserDetailsServiceImpl;
import com.vistaluxhms.services.VlxCommonServicesImpl;
import com.vistaluxhms.validator.CityManagementValidator;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;





@Controller
public class OthersController {


	@Autowired
	UserDetailsServiceImpl userDetailsService;

	@Autowired
	VlxCommonServicesImpl commonService;

	@Autowired
	CityManagementValidator cityMgmtValidator;

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

	@RequestMapping("view_add_city_form")
	public ModelAndView view_add_city_form(@ModelAttribute("CITY_OBJ") City_Obj cityObj, BindingResult result ) {
		UserDetailsObj userObj = getLoggedInUser();
		ModelAndView modelView = new ModelAndView("others/Admin_Add_City");
		List<City_Entity> activeDistinctDestinationList= commonService.findDistinctActiveDestinationList();
		modelView.addObject("ACTIVE_CTRYCODE_CTRYNAME_LIST", activeDistinctDestinationList);
		return modelView;
	}

	@RequestMapping("view_search_city_form")
	public ModelAndView view_search_city_form(@RequestParam(defaultValue = "0") int page,@RequestParam(defaultValue = "200") int pageSize, @RequestParam(defaultValue = "cityName") String sortBy,@ModelAttribute("SEARCH_CITY") City_Obj searchCityObj, BindingResult result ) {
		//pageSize = UdanChooConstants.DEFAULT_PAGE_SIZE;
		UserDetailsObj userObj = getLoggedInUser();
		ModelAndView modelView = new ModelAndView("others/viewCityListing");
		modelView.addObject("userName", userObj.getUsername());
		modelView.addObject("Id", userObj.getUserId());
		//modelView.addObject("userRole", userObj.getRoles());
		UserDetailsObj user = getLoggedInUser();
		//TODO Check if some one changes the url manually then it should lead to an error page. not to a server error.
		List<City_Entity> activeDistinctDestinationList= commonService.findDistinctActiveDestinationList();
		modelView.addObject("ACTIVE_CTRYCODE_CTRYNAME_LIST", activeDistinctDestinationList);

		//System.out.println("Search Obj is " + searchCityObj);

		Page<City_Entity> pageCitiesList = commonService.filterCities(page, pageSize, sortBy, searchCityObj);
		List<City_Obj> cityObjList = generateCityObj(pageCitiesList);
		modelView.addObject("CITY_LIST", cityObjList);
		modelView.addObject("maxPages", pageCitiesList.getTotalPages());
		modelView.addObject("page", page);
		modelView.addObject("sortBy", sortBy);
		modelView.addObject("countryName", searchCityObj.getCountryName());
		modelView.addObject("countryCode", searchCityObj.getCountryCode());
		modelView.addObject("destinationId", searchCityObj.getDestinationId());
		modelView.addObject("cityName", searchCityObj.getCityName());

		return modelView;
	}

	private List<City_Obj> generateCityObj(Page<City_Entity> pagedResult) {
		List<City_Obj> cityVoList = new ArrayList<City_Obj>();
		List<City_Entity> cityEntityList = pagedResult.getContent();

		Iterator<City_Entity> itrCityEntity = cityEntityList.iterator();
		while(itrCityEntity.hasNext()) {
			City_Entity cityEntity = (City_Entity) itrCityEntity.next();
			City_Obj cityObj;
			try {
				cityObj= new City_Obj(cityEntity);
				cityVoList.add(cityObj);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return cityVoList;
	}


	@PostMapping(value="create_create_city")
	public ModelAndView create_create_city(@ModelAttribute("CITY_OBJ") City_Obj cityObj, BindingResult result,final RedirectAttributes redirectAttrib) {
		System.out.println("Create city is finally invoked. debug man");
		UserDetailsObj userObj = getLoggedInUser();
		ModelAndView modelView = new ModelAndView();

		cityMgmtValidator.validate(cityObj, result);

		if(result.hasErrors()) {
			modelView = view_add_city_form(cityObj,result );
		} else {
			City_Entity cityEntity = new City_Entity(cityObj);
			commonService.saveCity(cityEntity);
			redirectAttrib.addFlashAttribute("Success", "City Record is updated Successfully..");
			modelView.setViewName("redirect:view_search_city_form?destinationId="+cityEntity.getDestinationId()+"&countryCode="+cityEntity.getCountryCode());
		}
		return modelView;
	}

	@PostMapping("view_edit_city_form")
	public ModelAndView view_edit_city_form(@ModelAttribute("CITY_OBJ") City_Obj cityObj, BindingResult result ) {
		UserDetailsObj userObj = getLoggedInUser();
		ModelAndView modelView = new ModelAndView("others/Admin_Edit_City");

		List<City_Entity> activeDistinctDestinationList= commonService.findDistinctActiveDestinationList();
		modelView.addObject("ACTIVE_CTRYCODE_CTRYNAME_LIST", activeDistinctDestinationList);

		City_Entity cityEntity = commonService.findDestinationById(cityObj.getDestinationId());
		cityObj.updateCityVOFromEntity(cityEntity);

		return modelView;
	}

	@PostMapping(value="edit_edit_city")
	public ModelAndView edit_edit_city(@ModelAttribute("CITY_OBJ") City_Obj cityObj, BindingResult result,final RedirectAttributes redirectAttrib) {
		UserDetailsObj userObj = getLoggedInUser();
		ModelAndView modelView = new ModelAndView();
		//cityMgmtValidator.validate(cityObj, result);
		if(result.hasErrors()) {
			modelView = view_edit_city_form(cityObj,result );
		}
		else {
			City_Entity cityEntity = new City_Entity(cityObj);
			cityEntity.setDestinationId(cityObj.getDestinationId());
			commonService.saveCity(cityEntity);
			redirectAttrib.addFlashAttribute("Success", "City Record is updated Successfully..");
			modelView.setViewName("redirect:view_search_city_form?destinationId="+cityEntity.getDestinationId()+"&countryCode="+cityEntity.getCountryCode());
		}
		return modelView;
	}

	@RequestMapping(value = "/getCityList", method= {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody
	List<City_Obj> getTags(@RequestParam String cityName) {
		List<City_Obj> result = new ArrayList<City_Obj>();
		List <City_Entity> entityList = commonService.listAllActiveDestinations();
		// iterate a list and filter by tagName
		for (City_Entity entity : entityList) {
			if (entity.getCityName().toLowerCase().contains(cityName.toLowerCase())) {
				City_Obj destinationObj = new City_Obj(entity);
				result.add(destinationObj);
			}
		}

		return result;
	}



   /*


    





    
    
    @RequestMapping("view_manage_multiple_status")
 	public ModelAndView view_manage_multiple_status(@ModelAttribute("TI_STATUS") UdnDealStatusVO dealStatusVO, BindingResult result ) {
     	//pageSize = UdanChooConstants.DEFAULT_PAGE_SIZE;
 		UserDetailsObj userObj = getLoggedInUser();
 		ModelAndView modelView = manage_ti_status(dealStatusVO, result);
 		modelView.addObject("userName", userObj.getUsername());
 		modelView.addObject("Id", userObj.getUserId());
 		//modelView.addObject("userRole", userObj.getRoles());
 		UserDetailsObj user = getLoggedInUser();
 		//TODO Check if some one changes the url manually then it should lead to an error page. not to a server error. 
 		return modelView;
 	}
    
    @PostMapping(value="manage_ti_status")
    public ModelAndView manage_ti_status(@ModelAttribute("TI_STATUS") UdnDealStatusVO dealStatusVO, BindingResult result) {
    	ModelAndView modelView = new ModelAndView("admin/others/manageStatus");
    	Map<String, List<Udn_Deal_Status_Entity>> mapStatusPerType =  commonService.findGroupOfStatusRecords();
    	LinkedHashMap<String, List<Udn_Deal_Status_Entity>> sortedMapStatusPerType = new LinkedHashMap<>();
    	mapStatusPerType.entrySet().stream().sorted(Map.Entry.comparingByKey()).forEachOrdered(x -> sortedMapStatusPerType.put(x.getKey(), x.getValue()));
    	modelView.addObject("STATUS_LIST_OF_MAP", sortedMapStatusPerType);	
    	return modelView;
    			
    }
    
    
    @PostMapping(value = "/manage_object_status", params = "Add Status")
    public ModelAndView add_object_status(@ModelAttribute("TI_STATUS") UdnDealStatusVO dealStatusVO, BindingResult result) {
    	ModelAndView modelView = new ModelAndView("redirect:view_manage_multiple_status");
    	Udn_Deal_Status_Entity statusEntity = new Udn_Deal_Status_Entity(dealStatusVO);
    	commonService.saveObjectStatus(statusEntity);
    	return modelView;
    }

    @PostMapping(value = "/manage_object_status", params = "Edit Status")
    public ModelAndView edit_object_status(@ModelAttribute("TI_STATUS") UdnDealStatusVO dealStatusVO, BindingResult result) {
    	ModelAndView modelView = manage_ti_status(dealStatusVO,result);
    	modelView.addObject("ST_ACTION", "EDIT");
    	//Udn_Deal_Status_Entity statusEntity = new Udn_Deal_Status_Entity(dealStatusVO);
    	//commonService.saveObjectStatus(statusEntity);
    	return modelView;
    }

    
    @PostMapping(value = "/manage_object_status", params = "De-Activate Status")
    public ModelAndView deactivateStatus(@ModelAttribute("TI_STATUS") UdnDealStatusVO dealStatusVO, BindingResult result,final RedirectAttributes redirectAttrib) {
    	ModelAndView modelView = new ModelAndView("redirect:view_manage_multiple_status");
    	Udn_Deal_Status_Entity statusEntity = commonService.findStatusById(dealStatusVO.getId());
    	statusEntity.setActive(false);
    	commonService.saveObjectStatus(statusEntity);
    	redirectAttrib.addFlashAttribute("Success", "Status Record is updated successfully!!");
    	return modelView;
    }
    
    @PostMapping(value = "/manage_object_status", params = "Activate Status")
    public ModelAndView activateStatus(@ModelAttribute("TI_STATUS") UdnDealStatusVO dealStatusVO, BindingResult result,final RedirectAttributes redirectAttrib) {
    	ModelAndView modelView = new ModelAndView("redirect:view_manage_multiple_status");
    	Udn_Deal_Status_Entity statusEntity = commonService.findStatusById(dealStatusVO.getId());
    	statusEntity.setActive(true);
    	commonService.saveObjectStatus(statusEntity);
    	redirectAttrib.addFlashAttribute("Success", "Status Record is updated successfully!!");
    	return modelView;
    }
    
    @PostMapping(value = "/manage_object_status", params = "UPDATE_UPDATE_STATUS")
    public ModelAndView update_update_status(@ModelAttribute("TI_STATUS") UdnDealStatusVO dealStatusVO, BindingResult result,final RedirectAttributes redirectAttrib) {
    	ModelAndView modelView = new ModelAndView("redirect:view_manage_multiple_status");
    	Udn_Deal_Status_Entity statusEntity = commonService.findStatusById(dealStatusVO.getId());
    	statusEntity.setWorkloadStatusName(dealStatusVO.getWorkloadStatusName());
    	statusEntity.setWorkloadStatusShortName(dealStatusVO.getWorkloadStatusName());
    	commonService.saveObjectStatus(statusEntity);
    	redirectAttrib.addFlashAttribute("Success", "Status Record is updated successfully!!");
    	return modelView;
    }
    
    
    @RequestMapping("view_check_email_working")
   	public ModelAndView view_check_email_working(@ModelAttribute("EMAIL_MSG_VO") EmailMessageVO emailMsgVO, BindingResult result ) {
    	UserDetailsObj userObj = getLoggedInUser();
    	ModelAndView modelView = new ModelAndView("admin/others/form_email_checker");
   	
    	return modelView;
    }

    @PostMapping("send_send_email_check")
    public ModelAndView send_send_email_check(@ModelAttribute("EMAIL_MSG_VO") EmailMessageVO emailMsgVO, BindingResult result,final RedirectAttributes redirectAttrib) {
    	ModelAndView modelView = new ModelAndView("redirect:view_check_email_working");
    	System.out.println("Email Data retrieved as : " + emailMsgVO);
    	emailService.sendMail(emailMsgVO.getEmailToList(),emailMsgVO.getEmailMessageFrom(), emailMsgVO.getEmailSubject(),emailMsgVO.getEmailMessage());
    	redirectAttrib.addFlashAttribute("Success", "Email is sent successfully!!");
    	return modelView;
    }

    */
    
}
