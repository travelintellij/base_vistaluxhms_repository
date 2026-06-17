package com.vistaluxhms.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vistaluxhms.entity.AshokaTeam;
import com.vistaluxhms.entity.RoleEntity;
import com.vistaluxhms.model.UserDetailsObj;
import com.vistaluxhms.services.UserDetailsServiceImpl;
import com.vistaluxhms.util.VistaluxConstants;
import com.vistaluxhms.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.transaction.Transactional;
import java.beans.PropertyEditorSupport;
import java.util.List;
import java.util.Optional;
import java.util.Set;

@Controller
public class UserController {


    private static final Logger logger = LoggerFactory.getLogger(UserController.class);
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
            username = ((UserDetails) principal).getUsername();
        } else {
            username = principal.toString();
        }
        UserDetailsObj userObj = (UserDetailsObj) userDetailsService.loadUserByUsername(username);

        return userObj;
    }

    @RequestMapping("view_view_user")
    public ModelAndView view_view_User(@RequestParam("userId") int userId) {
        ModelAndView mapview = new ModelAndView();
        // mapview.addObject("userRole", userObj.getRoles());
        UserDetailsObj userDetailsDTO = new UserDetailsObj();

        AshokaTeam userEntity = userDetailsService.findUserByID(userId);
        userDetailsDTO.updateUserVoFromEntity(userEntity);
        mapview.addObject("USER_OBJ", userDetailsDTO);
        // logger.debug("Entity REtreived is " + userEntity);
        // UserDetailsObj userDetailsObj = new UserDetailsObj(userEntity);
        // mapview.addObject("userobj",userDetailsObj);
        mapview.setViewName("admin/user/Admin_View_User");
        return mapview;
    }

    @RequestMapping("view_add_user_form")
    public ModelAndView view_add_user_form(@ModelAttribute("USER_OBJ") UserDetailsObj userDetailsDTO,
            BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("admin/user/Admin_Add_User");
        modelView.addObject("LOGGED_IN_USER", userObj);
        return modelView;
    }

    @RequestMapping("view_edit_user_form")
    public ModelAndView view_edit_user_form(@ModelAttribute("USER_OBJ") UserDetailsObj userDetailsDTO,
            BindingResult result) {
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

        // FIX: Clear password fields so the hashed password is not shown in the UI
        userDetailsDTO.setPassword("");
        userDetailsDTO.setPasswordConfirm("");

        AshokaTeam loggedUInUserEntity = userDetailsService.findUserByID(userObj.getUserId());
        Set<RoleEntity> loggedInrole = loggedUInUserEntity.getRoles();
        boolean isSuperAdmin = loggedInrole.stream()
                .anyMatch(role -> "SUPERADMIN".equalsIgnoreCase(role.getRoleName()));
        if (isSuperAdmin) {
            userObj.setSuperAdmin(true);
            modelView.addObject("LOGGED_IN_ROLE", "SUPERADMIN");
        } else {
            for (RoleEntity role : loggedInrole) {
                if ("PRIV".equals(role.getRoleTarget())) {
                    if ("USER".equals(role.getRoleName())) {
                        userObj.setRoleName("USER");
                        modelView.addObject("LOGGED_IN_ROLE", userObj.getRoleName());
                        break; // Exit the loop once the condition is met
                    } else if ("ADMIN".equals(role.getRoleName())) {
                        userObj.setRoleName("ADMIN");
                        modelView.addObject("LOGGED_IN_ROLE", userObj.getRoleName());
                        break; // Exit the loop once the condition is met
                    }
                }
            }

        }
        // System.out.println("Logged in User is " + userObj.getUserId() + " Role is " +
        // userObj.getRoleName());
        modelView.addObject("LOGGED_IN_USER", userObj);
        return modelView;
    }

    @PostMapping(value = "create_create_user")
    public ModelAndView create_create_user(@ModelAttribute("USER_OBJ") UserDetailsObj userDTO, BindingResult result,
            final RedirectAttributes redirectAttrib) {

        // 1. Check if username already exists to provide a friendly error message
        if (userDetailsService.findUserByUserName(userDTO.getUsername()).isPresent()) {
            result.rejectValue("username", "error.user", "This username is already taken. Please choose another.");
        }

        userValidator.validate(userDTO, result);

        if (result.hasErrors()) {
            // Return to form - USER_OBJ and result are already in the model
            ModelAndView modelView = view_add_user_form(userDTO, result);
            modelView.addObject("USER_OBJ", userDTO);
            return modelView;
        }

        try {
            // FIX: DO NOT encode the password on the DTO directly.
            // If you do, and an error occurs later, the encoded string (60 chars)
            // is shown in the UI password field.
            String rawPassword = userDTO.getPassword();
            AshokaTeam ashokaTeamEntity = new AshokaTeam(userDTO);
            ashokaTeamEntity.setPassword(passwordEncoder.encode(rawPassword));

            // Ensure mandatory fields have values
            if (ashokaTeamEntity.getType() == null)
                ashokaTeamEntity.setType("GENERAL");
            if (ashokaTeamEntity.getShift() == null)
                ashokaTeamEntity.setShift("GENERAL");

            userDetailsService.createOrUpdateUser(ashokaTeamEntity);

            redirectAttrib.addFlashAttribute("Success", "User '" + userDTO.getName() + "' created successfully.");
            return new ModelAndView("redirect:view_users_list");

        } catch (Exception e) {
            // If DB save fails (e.g. unique constraint), return to form safely
            ModelAndView modelView = view_add_user_form(userDTO, result);
            modelView.addObject("USER_OBJ", userDTO);
            modelView.addObject("Error", "Error: " + e.getMessage());
            logger.error("Exception caught", e);
            return modelView;
        }
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

    @Transactional
    @PostMapping(value = "edit_edit_user")
    public ModelAndView edit_edit_user(@ModelAttribute("USER_OBJ") UserDetailsObj userDTO, BindingResult result,
            final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser(); // Retrieve logged-in user details
        ModelAndView modelView = new ModelAndView();
        // implement the validation rule here.
        // System.out.println("Last Working Day is " +userDTO.getLastWorkingDay());

        userValidator.validate(userDTO, result);
        // logger.debug("User Details are " + userDTO);

        if (result.hasErrors()) {
            logger.debug("Validation errors: {}", result);
            // If there are validation errors, return the form view with errors
            modelView = view_edit_user_form(userDTO, result);
        } else {
            AshokaTeam orgUserEntity = userDetailsService.findUserByID(userDTO.getUserId());

            // FIX: Only update password if a new one is provided.
            // If the field is empty, keep the existing one.
            if (userDTO.getPassword() != null && !userDTO.getPassword().trim().isEmpty()) {
                orgUserEntity.setPassword(passwordEncoder.encode(userDTO.getPassword().trim()));
            }

            orgUserEntity.setAddress(userDTO.getAddress());
            orgUserEntity.setDesignation(userDTO.getDesignation());
            orgUserEntity.setDob(userDTO.getDob());
            orgUserEntity.setDoj(userDTO.getDoj());
            orgUserEntity.setEmail(userDTO.getEmail());
            orgUserEntity.setName(userDTO.getName());
            orgUserEntity.setShift(userDTO.getShift());
            orgUserEntity.setType(userDTO.getType());
            orgUserEntity.setUsername(userDTO.getUsername());
            orgUserEntity.setMobile(userDTO.getMobile());
            orgUserEntity.setFixedIncentive(userDTO.getFixedIncentive());
            orgUserEntity.setPersonalEmail(userDTO.getPersonalEmail());
            orgUserEntity.setPersonalMobile(userDTO.getPersonalMobile());
            orgUserEntity.setPanCard(userDTO.getPanCard());
            orgUserEntity.setAadharCard(userDTO.getAadharCard());
            orgUserEntity.setGender(userDTO.getGender());
            orgUserEntity.setMaritalStatus(userDTO.getMaritalStatus());
            orgUserEntity.setRemarks(userDTO.getRemarks());
            orgUserEntity.setActive(userDTO.isActive());
            orgUserEntity.setAccountExpired(userDTO.isAccountExpired());
            orgUserEntity.setAccountLocked(userDTO.isAccountLocked());
            orgUserEntity.setCredentialsExpired(userDTO.isCredentialsExpired());
            orgUserEntity.setDeleted(userDTO.isDeleted());
            orgUserEntity.setLastWorkingDay(userDTO.getLastWorkingDay());

            // ===== AI MODIFICATION START =====
            // Change: Auto-lock account if lastWorkingDay has passed
            // Reason: If a user's last working day has passed, their account should be automatically locked
            //         Adjusted to allow login ON the last working day — only locks AFTER it.
            // Scope: UserController — edit_edit_user() method
            if (userDTO.getLastWorkingDay() != null) {
                java.time.LocalDate today = java.time.LocalDate.now();
                java.time.LocalDate lastDay = userDTO.getLastWorkingDay().toLocalDate();
                if (today.isAfter(lastDay)) {
                    // today is strictly after lastWorkingDay — lock the account immediately
                    orgUserEntity.setAccountLocked(true);
                }
            }
            // ===== AI MODIFICATION END =====

            Set<RoleEntity> roles = orgUserEntity.getRoles();
            boolean isSuperAdmin = roles.stream()
                    .anyMatch(role -> "SUPERADMIN".equalsIgnoreCase(role.getRoleName()));
            if (!isSuperAdmin) {
                Optional<RoleEntity> existingPrivRoleOpt = orgUserEntity.getRoles().stream()
                        .filter(role -> role.getRoleTarget().equalsIgnoreCase("PRIV"))
                        .findFirst();

                if (existingPrivRoleOpt.isPresent() && userDTO.getRoleName() != null
                        && !userDTO.getRoleName().isEmpty()) {
                    RoleEntity existingPrivRole = existingPrivRoleOpt.get();

                    if (userDTO.getRoleName().equals(VistaluxConstants.BASIC_PRIV_ADMIN)) {
                        userDTO.setRoleId(VistaluxConstants.BASIC_PRIV_ADMIN_CODE);
                    } else if (userDTO.getRoleName().equals(VistaluxConstants.BASIC_PRIV_USER)) {
                        userDTO.setRoleId(VistaluxConstants.BASIC_PRIV_USER_CODE);
                    }

                    if (existingPrivRole.getRoleId() != userDTO.getRoleId()) {
                        RoleEntity newPrivRole = userDetailsService.findRoleById(userDTO.getRoleId());
                        orgUserEntity.getRoles().remove(existingPrivRole);
                        orgUserEntity.getRoles().add(newPrivRole);
                    }
                }
            }

            modelView.setViewName("redirect:view_view_user?userId=" + userDTO.getUserId());
            redirectAttrib.addFlashAttribute("Success", "User record is updated successfully.");
        }

        return modelView;
    }

    @RequestMapping("view_users_list")
    public ModelAndView view_users_list(@ModelAttribute("USER_FILTERED_LIST") UserDetailsObj userDTO,
            BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("admin/user/viewUserListing");
        modelView.addObject("LOGGED_IN_USER", userObj);

        AshokaTeam loggedUInUserEntity = userDetailsService.findUserByID(userObj.getUserId());
        Set<RoleEntity> roles = loggedUInUserEntity.getRoles();
        boolean isSuperAdmin = roles.stream()
                .anyMatch(role -> "SUPERADMIN".equalsIgnoreCase(role.getRoleName()));
        if (isSuperAdmin) {
            modelView.addObject("LOGGED_IN_ROLE", "SUPERADMIN");
        } else {
            for (RoleEntity role : roles) {
                if ("PRIV".equals(role.getRoleTarget())) {
                    if ("USER".equals(role.getRoleName())) {
                        userObj.setRoleName("USER");
                        modelView.addObject("LOGGED_IN_ROLE", userObj.getRoleName());
                        break; // Exit the loop once the condition is met
                    } else if ("ADMIN".equals(role.getRoleName())) {
                        userObj.setRoleName("ADMIN");
                        modelView.addObject("LOGGED_IN_ROLE", userObj.getRoleName());
                        break; // Exit the loop once the condition is met
                    }
                }
            }

        }

        // modelView.addObject("LOGGED_IN_PERMISSIONS", loggedInUser.getPermissions());

        List<UserDetailsObj> listUserDTO = userDetailsService.findAllUsers();
        modelView.addObject("USER_FILTERED_LIST", listUserDTO);
        return modelView;
    }

}
