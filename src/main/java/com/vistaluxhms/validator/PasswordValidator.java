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
    	if (!passwordEncoder.matches(user.getCurrentPassword().trim(), orgObj.getPassword())) {
    		errors.rejectValue("currentPassword", "valid.currentPasswordInvalid","Invalid Current Password");
    	}
    	if (!user.getChangedPassword().equals(user.getPasswordConfirm())) {
    		errors.rejectValue("changedPassword", "valid.passwordConfDiff","Invalid Changed Password");
    	}

    }
    
  
}