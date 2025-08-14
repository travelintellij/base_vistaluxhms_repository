package com.vistaluxhms.controller;

import com.vistaluxhms.entity.*;
import com.vistaluxhms.exception.RecordNotFoundException;
import com.vistaluxhms.model.*;
import com.vistaluxhms.repository.CentralConfigEntityRepository;
import com.vistaluxhms.repository.Vlx_City_Master_Repository;
import com.vistaluxhms.services.*;
import com.vistaluxhms.util.VistaluxConstants;
import com.vistaluxhms.validator.LeadValidator;
import com.vistaluxhms.validator.PasswordValidator;
import freemarker.template.TemplateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;
import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Controller
public class SettingsController {

    @Autowired
    UserDetailsServiceImpl userDetailsService;

    @Autowired
    private PasswordValidator validator;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    SettingsAndOtherServicesImpl configService;


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

    @RequestMapping("view_form_my_profile")
    public ModelAndView view_form_my_profile() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails)principal).getUsername();
        } else {
            username = principal.toString();
        }
        UserDetailsObj userObj = (UserDetailsObj) userDetailsService.loadUserByUsername(username);
        ModelAndView modelView = new ModelAndView("admin/settings/view_myprofile");
        modelView.addObject("USER_OBJ",userObj);
        return modelView;
    }

    @RequestMapping("settings_my_profile")
    public ModelAndView showMyProfile(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails)principal).getUsername();
        } else {
            username = principal.toString();
        }
        UserDetailsObj userObj = (UserDetailsObj) userDetailsService.loadUserByUsername(username);
        ModelAndView modelView = new ModelAndView("admin/settings/my_profile");
        modelView.addObject("USER_OBJ",userObj);
        return modelView; // resolves to /WEB-INF/views/my_profile.jsp
    }

    @RequestMapping("view_form_change_password")
    public ModelAndView view_form_change_password(@ModelAttribute("USER_OBJ") UserDetailsObj userDetailsObj) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails)principal).getUsername();
        } else {
            username = principal.toString();
        }
        UserDetailsObj userObj = (UserDetailsObj) userDetailsService.loadUserByUsername(username);
        ModelAndView modelView = new ModelAndView("admin/settings/view_changepassword");
        modelView.addObject("USER_OBJ",userObj);
        return modelView;
    }

    @RequestMapping("update_update_password")
    public ModelAndView update_update_password(@ModelAttribute("USER_OBJ") UserDetailsObj userDetailsObj, BindingResult result, ModelMap model) {
        ModelAndView modelView = new ModelAndView("admin/settings/view_changepassword");
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails)principal).getUsername();
        } else {
            username = principal.toString();
        }
        validator.validate(userDetailsObj, result);
        try {
            if(result.hasErrors()) {
                modelView.addObject("Error","Error: While updating password. ");
            }else {
                AshokaTeam userEntity = userDetailsService.findUserByID(getLoggedInUser().getUserId());
                //userEntity.setPassword(userDetailsObj.getPasswordConfirm());
                userEntity.setPassword(passwordEncoder.encode(userDetailsObj.getChangedPassword().trim()));
                userDetailsService.createOrUpdateUser(userEntity);
                modelView.addObject("Success","Your password is updated Successfully!!");
            }
        }
        catch(RecordNotFoundException rnfe) {
            rnfe.printStackTrace();
        }
        //UserDetailsObj userObj = (UserDetailsObj) userDetailsService.loadUserByUsername(username);
        return modelView;
    }

    @RequestMapping("view_form_manage_permissions")
    public ModelAndView view_form_manage_permissions(@ModelAttribute("USER_OBJ") UserDetailsObj userDetailsObj, BindingResult result) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails)principal).getUsername();
        } else {
            username = principal.toString();
        }
        UserDetailsObj userObj = (UserDetailsObj) userDetailsService.loadUserByUsername(username);
        ModelAndView modelView = new ModelAndView("admin/settings/view_user_permissions");

        Map<String, List<RoleEntity>> roleEntityMap= userDetailsService.find_All_Roles();
        List<UserDetailsObj> userList = userDetailsService.findAllActiveUsers();

        modelView.addObject("ROLE_OBJ",roleEntityMap);
        System.out.println("Active Users List is " + userList);
        modelView.addObject("ACTIVE_USERS_LIST",userList);

        return modelView;
    }


    @RequestMapping("update_update_user_permissions")
    public ModelAndView update_update_user_permissions(@ModelAttribute("USER_OBJ") UserDetailsObj userDetailsObj, BindingResult result) {
        ModelAndView modelView = view_form_manage_permissions(userDetailsObj,result);
        try {
            userDetailsService.updateUserPermissions(userDetailsObj);
            modelView.addObject("Success", "Permission Records are updated successfully.");
        } catch (RecordNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            modelView.addObject("Error", "Error: while updating permissions. Please contact support.");
        }
        return modelView;
    }

    @RequestMapping("access-denied")
    public ModelAndView access(@ModelAttribute("USER_OBJ") UserDetailsObj userDetailsObj, BindingResult result) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("error/403");
        return modelAndView;
    }

    @RequestMapping("view_form_manage_central_config")
    public ModelAndView view_form_manage_central_config(@ModelAttribute("CENTRAL_CONFIG_OBJ") CentralConfigEntityDTO centralConfigDTO, BindingResult result) {
        ModelAndView modelAndView = new ModelAndView("admin/settings/view_centralConfig");

        centralConfigDTO = configService.getCentralConfig();
        if (centralConfigDTO == null) {
            centralConfigDTO = new CentralConfigEntityDTO(); // Empty DTO for first time
        }
        modelAndView.addObject("CENTRAL_CONFIG_OBJ", centralConfigDTO);
        return modelAndView;

    }





    @PostMapping("create_edit_central_config")
    public String create_edit_central_config(@ModelAttribute("CENTRAL_CONFIG_OBJ") CentralConfigEntityDTO centralConfigDTO,
                             @RequestParam("logoFile") MultipartFile logoFile,
                             HttpServletRequest request,final RedirectAttributes redirectAttrib) {

        try {
            if (!logoFile.isEmpty()) {
                String uploadDir = request.getServletContext().getRealPath(VistaluxConstants.LOGO_PATH);
                File dir = new File(uploadDir);
                if (!dir.exists()) dir.mkdirs();
                Path filePath = Paths.get(uploadDir, VistaluxConstants.LOGO_FILE_NAME);
                logoFile.transferTo(filePath.toFile());
            }
            //centralConfigDTO.setLogoPath(VistaluxConstants.LOGO_PATH + File.separator + VistaluxConstants.LOGO_FILE_NAME);
            configService.saveOrUpdateCentralConfig(centralConfigDTO);
            redirectAttrib.addFlashAttribute("Success","Configuration is updated Successfully!!. ");
        } catch (Exception e) {
            redirectAttrib.addFlashAttribute("Error","Configuration updation Failed. !!. ");
            e.printStackTrace();
        }
        return "redirect:view_form_manage_central_config";
    }


}
