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
		return UserDetailsObj.class.equals(clazz);
	}

	// following code validates if the country code (String) matches with the
	// country name.
	@Override
	public void validate(Object target, Errors errors) {
		UserDetailsObj userDTO = (UserDetailsObj) target;
		if (userDTO.getPassword() != null && userDTO.getPasswordConfirm() != null
				&& !userDTO.getPassword().trim().equals(userDTO.getPasswordConfirm().trim())) {
			errors.rejectValue("passwordConfirm", "password.mismatch.error", "Password and Confirm Password do not match.");
		}

		// Validate Company Email format
		if (userDTO.getEmail() == null || userDTO.getEmail().trim().isEmpty()) {
			errors.rejectValue("email", "email.required", "Company Email is required.");
		} else if (!userDTO.getEmail().contains("@") || !userDTO.getEmail().contains(".")) {
			errors.rejectValue("email", "email.invalid", "Please enter a valid email address.");
		}

		// Validate Company Mobile
		if (userDTO.getMobile() == 0) {
			errors.rejectValue("mobile", "mobile.required", "Company Mobile is required.");
		}

		// Validate Personal Phone
		if (userDTO.getPersonalMobile() == 0) {
			errors.rejectValue("personalMobile", "personalMobile.required", "Personal Phone is required.");
		}

		// Validate Address
		if (userDTO.getAddress() == null || userDTO.getAddress().trim().isEmpty()) {
			errors.rejectValue("address", "address.required", "Address is required.");
		}

		// Validate Date of Birth
		if (userDTO.getDob() == null) {
			errors.rejectValue("dob", "dob.required", "Date of Birth is required.");
		}

		// Validate Date of Joining
		if (userDTO.getDoj() == null) {
			errors.rejectValue("doj", "doj.required", "Date of Joining is required.");
		}

		// Validate User Type
		if (userDTO.getRoleName() == null || userDTO.getRoleName().trim().isEmpty()) {
			errors.rejectValue("roleName", "roleName.required", "Please select a User Type.");
		}
	}

}