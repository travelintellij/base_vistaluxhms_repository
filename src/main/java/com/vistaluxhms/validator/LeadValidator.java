package com.vistaluxhms.validator;

import com.vistaluxhms.model.LeadEntityDTO;
import com.vistaluxhms.services.ClientServicesImpl;
import com.vistaluxhms.services.VlxCommonServicesImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

@Component
public class LeadValidator implements Validator {

	@Autowired
	VlxCommonServicesImpl commonService;

	@Autowired
	ClientServicesImpl clientService;
	
	@Override
	public boolean supports(Class<?> clazz) {
		return LeadEntityDTO.class.equals(clazz);	}

	//following code validates if the country code (String) matches with the country name.
	@Override
	public void validate(Object target, Errors errors) {
		LeadEntityDTO leadRecorderVO = (LeadEntityDTO)target;

		if((leadRecorderVO.getClient()==null) || (leadRecorderVO.getClient().getClientId() ==null) ||(!clientService.existsByClientIdAndClientName(leadRecorderVO.getClient().getClientId(), leadRecorderVO.getClientName()))) {
			errors.rejectValue("clientName", "contact.error");
		}
		if(leadRecorderVO.getAdults()==0) {
			errors.rejectValue("adults", "min.guest.error");
		}
		if(!(leadRecorderVO.isFit() || leadRecorderVO.isGroupEvent()|| leadRecorderVO.isMarriage() ||
				leadRecorderVO.isOthers() )) {
			errors.rejectValue("minOneserviceError", "min.one.service.error");
		}
		
		if(leadRecorderVO.getCheckOutDate().compareTo(leadRecorderVO.getCheckInDate()) <0) {
			errors.rejectValue("checkOutDate", "stay.start.end.error");
		}
		
	}
 
}