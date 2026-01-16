package com.vistaluxhms.controller;

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


        AshokaTeam loggedUInUserEntity = userDetailsService.findUserByID(userObj.getUserId());
        Set<RoleEntity> loggedInrole = loggedUInUserEntity.getRoles();
        boolean isSuperAdmin = loggedInrole.stream()
                .anyMatch(role ->
                        "SUPERADMIN".equalsIgnoreCase(role.getRoleName())
                );
        if(isSuperAdmin){
            userObj.setSuperAdmin(true);
            modelView.addObject("LOGGED_IN_ROLE","SUPERADMIN");
        }
        else {
            for (RoleEntity role : loggedInrole) {
                if ("PRIV".equals(role.getRoleTarget())) {
                    if ("USER".equals(role.getRoleName())) {
                        userObj.setRoleName("USER");
                        modelView.addObject("LOGGED_IN_ROLE",userObj.getRoleName());
                        break; // Exit the loop once the condition is met
                    } else if ("ADMIN".equals(role.getRoleName())) {
                        userObj.setRoleName("ADMIN");
                        modelView.addObject("LOGGED_IN_ROLE",userObj.getRoleName());
                        break; // Exit the loop once the condition is met
                    }
                }
            }

        }
        //System.out.println("Logged in User is " + userObj.getUserId() + " Role is " + userObj.getRoleName());
        modelView.addObject("LOGGED_IN_USER",userObj);
        return modelView;
    }
    @PostMapping(value="create_create_user")
    public ModelAndView create_create_user(@ModelAttribute("USER_OBJ") UserDetailsObj userDTO, BindingResult result, final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser(); // Retrieve logged-in user details
        ModelAndView modelView = new ModelAndView();
        //implement the validation rule here.
        userValidator.validate(userDTO,result);
        if (result.hasErrors()) {
            // If there are validation errors, return the form view with errors
            modelView = view_add_user_form(userDTO, result);
        } else {
            userDTO.setPassword(passwordEncoder.encode(userDTO.getPassword()));
            AshokaTeam ashokaTeamEntity = new AshokaTeam(userDTO);
            //AshokaTeam ashokaTeamEntity = new AshokaTeam(userDTO);
            try {
                userDetailsService.createOrUpdateUser(ashokaTeamEntity);
                userDTO.setUserId(ashokaTeamEntity.getUserId());
                //modelView.addObject("userobj",userDTO);
                modelView.addObject("message","Success");
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
    @PostMapping(value="edit_edit_user")
    public ModelAndView edit_edit_user(@ModelAttribute("USER_OBJ") UserDetailsObj userDTO, BindingResult result, final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser(); // Retrieve logged-in user details
        ModelAndView modelView = new ModelAndView();
        //implement the validation rule here.
        //System.out.println("Last Working Day is "  +userDTO.getLastWorkingDay());

        userValidator.validate(userDTO,result);
        //System.out.println("User Details are " + userDTO);

        if (result.hasErrors()) {
            System.out.println(result);
            // If there are validation errors, return the form view with errors
            modelView = view_edit_user_form(userDTO, result);
        } else {
            AshokaTeam orgUserEntity = userDetailsService.findUserByID(userDTO.getUserId());

            if(!userDTO.getPassword().equals(orgUserEntity.getPassword())) {
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

            Set<RoleEntity> roles = orgUserEntity.getRoles();
            boolean isSuperAdmin = roles.stream()
                    .anyMatch(role ->
                            "SUPERADMIN".equalsIgnoreCase(role.getRoleName())
                    );
            if(!isSuperAdmin) {
                Optional<RoleEntity> existingPrivRoleOpt = orgUserEntity.getRoles().stream().filter(role -> role.getRoleTarget().equalsIgnoreCase("PRIV"))
                        .findFirst();

                if (existingPrivRoleOpt.isPresent() && userDTO.getRoleName() != null && !userDTO.getRoleName().isEmpty()) {
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

            modelView.setViewName("redirect:view_view_user?userId="+userDTO.getUserId());
            redirectAttrib.addFlashAttribute("Success", "User record is updated successfully.");
        }

        return modelView;
    }

    @RequestMapping("view_users_list")
    public ModelAndView view_users_list(@ModelAttribute("USER_FILTERED_LIST") UserDetailsObj userDTO, BindingResult result ) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("admin/user/viewUserListing");
        modelView.addObject("LOGGED_IN_USER", userObj);

        AshokaTeam loggedUInUserEntity = userDetailsService.findUserByID(userObj.getUserId());
        Set<RoleEntity> roles = loggedUInUserEntity.getRoles();
        boolean isSuperAdmin = roles.stream()
                .anyMatch(role ->
                        "SUPERADMIN".equalsIgnoreCase(role.getRoleName())
                );
        if(isSuperAdmin){
            modelView.addObject("LOGGED_IN_ROLE","SUPERADMIN");
        }
        else {
            for (RoleEntity role : roles) {
                if ("PRIV".equals(role.getRoleTarget())) {
                    if ("USER".equals(role.getRoleName())) {
                        userObj.setRoleName("USER");
                        modelView.addObject("LOGGED_IN_ROLE",userObj.getRoleName());
                        break; // Exit the loop once the condition is met
                    } else if ("ADMIN".equals(role.getRoleName())) {
                        userObj.setRoleName("ADMIN");
                        modelView.addObject("LOGGED_IN_ROLE",userObj.getRoleName());
                        break; // Exit the loop once the condition is met
                    }
                }
            }

        }

        //modelView.addObject("LOGGED_IN_PERMISSIONS", loggedInUser.getPermissions());

        List<UserDetailsObj> listUserDTO= userDetailsService.findAllUsers();
        modelView.addObject("USER_FILTERED_LIST", listUserDTO);
        return modelView;
    }


}
