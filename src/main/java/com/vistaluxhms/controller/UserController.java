package com.vistaluxhms.controller;

import com.vistaluxhms.entity.*;
import com.vistaluxhms.model.ClientEntityDTO;
import com.vistaluxhms.model.SalesPartnerEntityDto;
import com.vistaluxhms.model.UserDetailsObj;
import com.vistaluxhms.repository.Vlx_City_Master_Repository;
import com.vistaluxhms.services.ClientServicesImpl;
import com.vistaluxhms.services.SalesRelatesServicesImpl;
import com.vistaluxhms.services.UserDetailsServiceImpl;
import com.vistaluxhms.services.VlxCommonServicesImpl;
import com.vistaluxhms.util.VistaluxConstants;
import com.vistaluxhms.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.beans.PropertyEditorSupport;
import java.util.*;

@Controller
public class UserController {

    @Autowired
    UserDetailsServiceImpl userDetailsService;

    @Autowired
    UserValidator userValidator;

    @Autowired
    private PasswordEncoder passwordEncoder;

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


    @RequestMapping("view_view_user")
    public ModelAndView view_view_User(@RequestParam("userId") int userId) {
        ModelAndView mapview = new ModelAndView();
        //mapview.addObject("userRole", userObj.getRoles());
        UserDetailsObj userDetailsDTO = new UserDetailsObj();

        AshokaTeam userEntity = userDetailsService.findUserByID(userId);
        userDetailsDTO.updateUserVoFromEntity(userEntity);
        mapview.addObject("USER_OBJ", userDetailsDTO);
        //System.out.println("Entity REtreived is " + userEntity);
        //UserDetailsObj userDetailsObj = new UserDetailsObj(userEntity);
        //mapview.addObject("userobj",userDetailsObj);
        mapview.setViewName("admin/user/Admin_View_User");
        return mapview;
    }

    @RequestMapping("view_add_user_form")
    public ModelAndView view_add_user_form(@ModelAttribute("USER_OBJ") UserDetailsObj userDetailsDTO, BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("admin/user/Admin_Add_User");
        return modelView;
    }

    @RequestMapping("view_edit_user_form")
    public ModelAndView view_edit_user_form(@ModelAttribute("USER_OBJ") UserDetailsObj userDetailsDTO, BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("admin/user/Admin_Edit_User");
        AshokaTeam userEntity = userDetailsService.findUserByID(userDetailsDTO.getUserId());
        userDetailsDTO.updateUserVoFromEntity(userEntity);
        Set<RoleEntity> roles = userDetailsDTO.getRoles(); // Assuming this returns a List<Role>

        // Iterate through the roles and set roleName based on conditions
        for (RoleEntity role : roles) {
            if ("PRIV".equals(role.getRoleTarget())) {
                if ("USER".equals(role.getRoleName())) {
                    userDetailsDTO.setRoleName("USER");
                    break; // Exit the loop once the condition is met
                } else if ("ADMIN".equals(role.getRoleName())) {
                    userDetailsDTO.setRoleName("ADMIN");
                    break; // Exit the loop once the condition is met
                }
            }
        }
        userDetailsDTO.setPasswordConfirm(userEntity.getPassword());
        return modelView;
    }
    @PostMapping(value="create_create_user")
    public ModelAndView create_create_user(@ModelAttribute("USER_OBJ") UserDetailsObj userDTO, BindingResult result, final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser(); // Retrieve logged-in user details
        ModelAndView modelView = new ModelAndView();
        //implement the validation rule here.

        userValidator.validate(userDTO,result);
        System.out.println("User Details are " + userDTO);

        if (result.hasErrors()) {
            // If there are validation errors, return the form view with errors
            modelView = view_add_user_form(userDTO, result);
        } else {
            userDTO.setPassword(passwordEncoder.encode(userDTO.getPassword()));
            AshokaTeam ashokaTeamEntity = new AshokaTeam(userDTO);
            try {
                userDetailsService.createOrUpdateUser(ashokaTeamEntity);
                userDTO.setUserId(ashokaTeamEntity.getUserId());
                modelView.addObject("userobj",userDTO);
                modelView.addObject("message","Success");
                modelView.setViewName("redirect:view_view_Admin_User?userId="+userDTO.getUserId());
                redirectAttrib.addFlashAttribute("Success", "User record is updated successfully.");
            } catch (Exception e) {
                modelView.addObject("Error", "Error: Adding New User. Please contact Administrator !!! " );
                modelView.setViewName("redirect:view_view_user?userId="+userDTO.getUserId());
                e.printStackTrace();
            }
        }

        return modelView;
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(java.sql.Date.class, new PropertyEditorSupport() {
            @Override
            public void setAsText(String text) throws IllegalArgumentException {
                if (text == null || text.trim().isEmpty()) {
                    setValue(null); // Convert empty strings to null
                } else {
                    try {
                        setValue(java.sql.Date.valueOf(text)); // Convert valid input to java.sql.Date
                    } catch (IllegalArgumentException e) {
                        throw new IllegalArgumentException("Invalid date format. Expected format: yyyy-MM-dd");
                    }
                }
            }
        });
    }

    @PostMapping(value="edit_edit_user")
    public ModelAndView edit_edit_user(@ModelAttribute("USER_OBJ") UserDetailsObj userDTO, BindingResult result, final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser(); // Retrieve logged-in user details
        ModelAndView modelView = new ModelAndView();
        //implement the validation rule here.

        System.out.println("Last Working Day is "  +userDTO.getLastWorkingDay());

        userValidator.validate(userDTO,result);
        //System.out.println("User Details are " + userDTO);

        if (result.hasErrors()) {
            System.out.println(result);
            // If there are validation errors, return the form view with errors
            modelView = view_edit_user_form(userDTO, result);
        } else {
            AshokaTeam orgUserEntity = userDetailsService.findUserByID(userDTO.getUserId());
            if(!userDTO.getPassword().equals(orgUserEntity.getPassword())) {
                userDTO.setPassword(passwordEncoder.encode(userDTO.getPassword().trim()));
            }

            AshokaTeam ashokaTeamEntity = new AshokaTeam(userDTO);
            ashokaTeamEntity.setUserId(userDTO.getUserId());
            Optional <RoleEntity> existingPrivRoleOpt = orgUserEntity.getRoles().stream().filter(role -> role.getRoleTarget().equalsIgnoreCase("PRIV"))
                    .findFirst();

            if(existingPrivRoleOpt.isPresent()) {
                RoleEntity existingPrivRole = existingPrivRoleOpt.get();
                System.out.println(existingPrivRole.getRoleId() + "-- " + userDTO.getRoleId());
                if(existingPrivRole.getRoleId()!=userDTO.getRoleId()) {
                    if(userDTO.getRoleName().equals(VistaluxConstants.BASIC_PRIV_ADMIN)){
                        userDTO.setRoleId(VistaluxConstants.BASIC_PRIV_ADMIN_CODE);
                    }
                    else if(userDTO.getRoleName().equals(VistaluxConstants.BASIC_PRIV_USER)){
                        userDTO.setRoleId(VistaluxConstants.BASIC_PRIV_USER_CODE);
                    }
                    RoleEntity newPrivRole = userDetailsService.findRoleById(userDTO.getRoleId());
                    System.out.println("New Role Entity is "  + newPrivRole);
                    orgUserEntity.getRoles().remove(existingPrivRole);
                    orgUserEntity.getRoles().add(newPrivRole);
                }
            }
            try {
                userDetailsService.createOrUpdateUser(ashokaTeamEntity);
                userDTO.setUserId(ashokaTeamEntity.getUserId());
                //modelView.addObject("userobj",userDTO);
                //modelView.addObject("message","Success");
                modelView.setViewName("redirect:view_view_user?userId="+userDTO.getUserId());
                redirectAttrib.addFlashAttribute("Success", "User record is updated successfully.");
            } catch (Exception e) {
                modelView.addObject("Error", "Error: Adding New User. Please contact Administrator !!! " );
                modelView.setViewName("redirect:view_view_user?userId="+userDTO.getUserId());
                e.printStackTrace();
            }
        }

        return modelView;
    }


}
