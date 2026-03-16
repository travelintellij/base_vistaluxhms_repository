package com.vistaluxhms.validator;

import com.vistaluxhms.entity.AshokaTeam;
import com.vistaluxhms.model.UserDetailsObj;
import com.vistaluxhms.services.UserDetailsServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;


@Component
public class PasswordValidator implements Validator {
    @Autowired
    private UserDetailsServiceImpl userService;
    
    @Autowired
	private PasswordEncoder passwordEncoder;

    @Override
    public boolean supports(Class<?> aClass) {
        return com.vistaluxhms.model.UserDetailsObj.class.equals(aClass);
    }

    @Override
    public void validate(Object o, Errors errors) {
    	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
      	String username;
      	if (principal instanceof UserDetails) {
      	   username = ((UserDetails)principal).getUsername();
      	} else {
      	   username = principal.toString();
      	}
    	AshokaTeam orgObj = userService.findUserByUserName(username).get();
    	UserDetailsObj user = (UserDetailsObj) o;

    	// ===== AI MODIFICATION START =====
    	// Change: Added specific, descriptive error messages for each validation failure
    	// Reason: Users need clear feedback on what went wrong during password change
    	// Scope: PasswordValidator — validate() method

    	// Validate current password is correct
    	if (user.getCurrentPassword() == null || user.getCurrentPassword().trim().isEmpty()) {
    		errors.rejectValue("currentPassword", "valid.currentPasswordEmpty", "Current Password is required.");
    	} else if (!passwordEncoder.matches(user.getCurrentPassword().trim(), orgObj.getPassword())) {
    		// errors.rejectValue("currentPassword", "valid.currentPasswordInvalid","Invalid Current Password");
    		errors.rejectValue("currentPassword", "valid.currentPasswordInvalid", "Current Password is incorrect. Please enter your correct current password.");
    	}

    	// Validate new password is not empty and meets minimum length
    	if (user.getChangedPassword() == null || user.getChangedPassword().trim().isEmpty()) {
    		errors.rejectValue("changedPassword", "valid.newPasswordEmpty", "New Password is required.");
    	} else if (user.getChangedPassword().trim().length() < 8) {
    		errors.rejectValue("changedPassword", "valid.newPasswordTooShort", "New Password must be at least 8 characters long.");
    	}

    	// Validate confirm password matches new password
    	if (user.getPasswordConfirm() == null || user.getPasswordConfirm().trim().isEmpty()) {
    		errors.rejectValue("changedPassword", "valid.confirmPasswordEmpty", "Confirm Password is required.");
    	// } else if (!user.getChangedPassword().equals(user.getPasswordConfirm())) {
    	} else if (user.getChangedPassword() != null && !user.getChangedPassword().equals(user.getPasswordConfirm())) {
    		// errors.rejectValue("changedPassword", "valid.passwordConfDiff","Invalid Changed Password");
    		errors.rejectValue("changedPassword", "valid.passwordConfDiff", "Confirm Password does not match New Password.");
    	}

    	// Validate new password is not same as current password
    	if (user.getChangedPassword() != null && !user.getChangedPassword().trim().isEmpty()
    		&& user.getCurrentPassword() != null && !user.getCurrentPassword().trim().isEmpty()
    		&& user.getChangedPassword().trim().equals(user.getCurrentPassword().trim())) {
    		errors.rejectValue("changedPassword", "valid.newPasswordSameAsCurrent", "New Password cannot be the same as Current Password.");
    	}
    	// ===== AI MODIFICATION END =====

    }
    
  
}