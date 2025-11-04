package com.vistaluxevent.controller;

import com.lowagie.text.DocumentException;
import com.vistaluxevent.entity.*;
import com.vistaluxevent.model.EventDetailsConfigDTO;
import com.vistaluxevent.model.EventMasterServiceDTO;
import com.vistaluxevent.model.EventPackageEntityDTO;
import com.vistaluxevent.model.FilterEventObj;
import com.vistaluxevent.services.EventConfigServicesImpl;
import com.vistaluxevent.services.EventServicesImpl;
import com.vistaluxhms.entity.AshokaTeam;
import com.vistaluxhms.entity.ClientEntity;
import com.vistaluxhms.model.Mail;
import com.vistaluxhms.model.UserDetailsObj;
import com.vistaluxhms.services.ClientServicesImpl;
import com.vistaluxhms.services.EmailServiceImpl;
import com.vistaluxhms.services.UserDetailsServiceImpl;
import com.vistaluxhms.services.VlxCommonServicesImpl;
import com.vistaluxhms.util.VistaluxConstants;
import freemarker.core.Configurable;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;


@Controller
public class EventConfigController {
	private final EventConfigServicesImpl eventService;

	public EventConfigController(EventConfigServicesImpl eventService) {
		this.eventService = eventService;
	}

	// Get data for form populate (returns base64 data URLs for banner + gallery slots)
	@GetMapping("/{eventType}")
	public ResponseEntity<EventDetailsConfigDTO> getEvent(@PathVariable String eventType) {
		EventDetailsConfigDTO dto = eventService.getEventDtoByType(eventType);
		return ResponseEntity.ok(dto);
	}

	@RequestMapping("view_form_manage_event_forms")
	public ModelAndView view_form_manage_event_forms(@ModelAttribute("USER_OBJ") UserDetailsObj userDetailsObj,@ModelAttribute("eventForm") EventDetailsConfigDTO eventConfig, BindingResult result) {
		/*ModelAndView modelView = new ModelAndView("admin/settings/view_event_manage_forms");
		return modelView;

		 */
		String eventType = eventConfig.getEventType();
		EventDetailsConfigDTO dto = eventService.getEventDetails(eventType);
		ModelAndView mv = new ModelAndView("admin/settings/view_event_manage_forms"); // your JSP
		mv.addObject("eventForm", dto);
		mv.addObject("eventType", eventType); // needed for form action
		return mv;

	}

	// Save/update (multipart/form-data). Only non-empty files replace existing images.
	//@PostMapping(value = "view_form_save_event_config_forms", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
	//public ResponseEntity<String> saveEvent(
	@PostMapping(value = "view_form_save_event_config_forms", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
	/*public ModelAndView saveEvent(
			@RequestParam(value = "eventType", required = true) String eventType ,
			@RequestParam(value = "bannerImage", required = false) MultipartFile bannerImage,
			@RequestParam(value = "image1", required = false) MultipartFile image1,
			@RequestParam(value = "image2", required = false) MultipartFile image2,
			@RequestParam(value = "image3", required = false) MultipartFile image3,
			@RequestParam(value = "image4", required = false) MultipartFile image4,
			@RequestParam(value = "image5", required = false) MultipartFile image5,
			@RequestParam(value = "image6", required = false) MultipartFile image6,
			@RequestParam(value = "resortInfo", required = false) String resortInfo,
			@RequestParam(value = "celebrationHighlight", required = false) String celebrationHighlight,
			@RequestParam(value = "testimonial", required = false) String testimonial,
			@RequestParam(value = "termsConditions", required = false) String termsConditions, final RedirectAttributes redirectAttrib
	) throws Exception {*/
	public ModelAndView saveEvent(EventDetailsConfigDTO eventDetailsConfigDTO,final RedirectAttributes redirectAttrib)throws Exception
	{
		ModelAndView modelView = new ModelAndView();
		EventDetailsConfigDTO form = new EventDetailsConfigDTO();
		//form.setBannerImage(bannerImage);
		//form.setImage1(image1); form.setImage2(image2); form.setImage3(image3);
		//form.setImage4(image4); form.setImage5(image5); form.setImage6(image6);
		//form.setResortInfo(resortInfo);
		//form.setCelebrationHighlight(celebrationHighlight);
		//form.setTestimonial(testimonial);
		//form.setTermsConditions(termsConditions);
		//eventService.saveOrUpdateEvent(eventType, form);
		form.setBannerImage(eventDetailsConfigDTO.getBannerImage());
		form.setImage1(eventDetailsConfigDTO.getImage1());
		form.setImage2(eventDetailsConfigDTO.getImage2());
		form.setImage3(eventDetailsConfigDTO.getImage3());
		form.setImage4(eventDetailsConfigDTO.getImage4());
		form.setImage5(eventDetailsConfigDTO.getImage5());
		form.setImage6(eventDetailsConfigDTO.getImage6());
		form.setResortInfo(eventDetailsConfigDTO.getResortInfo());
		form.setCelebrationHighlight(eventDetailsConfigDTO.getCelebrationHighlight());
		form.setTestimonial(eventDetailsConfigDTO.getTestimonial());
		form.setTermsConditions(eventDetailsConfigDTO.getTermsConditions());
		form.setImageUrl1(eventDetailsConfigDTO.getImageUrl1());
		form.setImageUrl2(eventDetailsConfigDTO.getImageUrl2());
		form.setImageUrl3(eventDetailsConfigDTO.getImageUrl3());
		form.setImageUrl4(eventDetailsConfigDTO.getImageUrl4());
		form.setImageUrl5(eventDetailsConfigDTO.getImageUrl5());
		form.setImageUrl6(eventDetailsConfigDTO.getImageUrl6());
		eventService.saveOrUpdateEvent(eventDetailsConfigDTO.getEventType(), form);
		redirectAttrib.addFlashAttribute("Success", "Record is updated successfully !! ");
		modelView.setViewName("redirect:view_form_manage_event_forms?eventType="+eventDetailsConfigDTO.getEventType());
		return modelView;
		//return ResponseEntity.ok("Saved");
	}


}
