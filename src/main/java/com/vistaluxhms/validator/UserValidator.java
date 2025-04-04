package com.vistaluxhms.validator;

import com.vistaluxhms.model.City_Obj;
import com.vistaluxhms.model.UserDetailsObj;
import com.vistaluxhms.services.VlxCommonServicesImpl;
import com.vistaluxhms.util.VistaluxConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

@Component
public class UserValidator implements Validator {
	 
	@Autowired
	VlxCommonServicesImpl commonService;
	
	@Override
	public boolean supports(Class<?> clazz) {
		return City_Obj.class.equals(clazz);	}

	//following code validates if the country code (String) matches with the country name.
	@Override
	public void validate(Object target, Errors errors) {
		UserDetailsObj userDTO = (UserDetailsObj)target;
		if(!userDTO.getPassword().trim().equals(userDTO.getPasswordConfirm().trim()) ) {
			errors.rejectValue("passwordConfirm", "password.mismatch.error");
		}

/*
		if(destinationVO.getCityName()==null || destinationVO.getCityName().trim().length()==0) {
			errors.rejectValue("cityName", "city.error");
		}
		if(destinationVO.getCountryCode().trim().equalsIgnoreCase(VistaluxConstants.DESTINATION_ALL_CTRY_CODE)) {
			errors.rejectValue("countryCode", "country.error");
		}
		if(commonService.existsByCityNameAndCountryCode(destinationVO.getCityName(),destinationVO.getCountryCode())) {
			errors.rejectValue("cityName", "city.error");
		}
*/
	}

}