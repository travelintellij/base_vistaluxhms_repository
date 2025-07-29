package com.vistaluxhms.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import com.vistaluxhms.model.UserDetailsObj;
import com.vistaluxhms.services.UserDetailsServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.security.Principal;


@Controller
public class LoginController {

    @Autowired
    UserDetailsServiceImpl userDetailsService;



    @RequestMapping("/welcome")
    public ModelAndView firstPage(@RequestHeader(value="Authorization") String authorizationHeader) {
        //System.out.println("Request Header is " + authorizationHeader);
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails)principal).getUsername();
        } else {
            username = principal.toString();
        }
        UserDetailsObj userObj = (UserDetailsObj) userDetailsService.loadUserByUsername(username);

        ModelAndView mapview = new ModelAndView("welcome");
        mapview.addObject("address", userObj.getAddress());
        mapview.addObject("fixedIncentive", userObj.getFixedIncentive());
        mapview.addObject("Id", userObj.getUserId());
        mapview.addObject("mobile", userObj.getMobile());
        mapview.addObject("name", userObj.getName());
        mapview.addObject("shift", userObj.getShift());
        mapview.addObject("type", userObj.getType());
        mapview.addObject("dob", userObj.getDob());
        mapview.addObject("doj", userObj.getDoj());
        mapview.addObject("designation", userObj.getDesignation());
        mapview.addObject("active", userObj.isActive());
        //mapview.addObject("userRole", userObj.getRoles());
        mapview.addObject("email", userObj.getEmail());
        mapview.addObject("userObj", userObj);
        //mapview.addObject(userObj);

        //System.out.println(userObj);
        return mapview;
    }

    @RequestMapping(value = "/hello", method = RequestMethod.POST)
    public String hello() {
        return "Hello World";
    }

    @RequestMapping("/user")
    public String user() {
        return "<H1> Welcome User </H1>";
    }

    @RequestMapping("/admin")
    public String admin() {
        return "<H1> Welcome Admin </H1>";
    }


    @RequestMapping(value="/login", method=RequestMethod.GET)
    public ModelAndView loginPage(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView modelView = new ModelAndView();
        modelView.setViewName("/login");
        //System.out.println("Login controller is invoked. ");

        return modelView;


    }

    @RequestMapping(value="/logout", method=RequestMethod.GET)
    public String logoutPage(HttpServletRequest request, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null){
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        return "redirect:/";
    }

    @GetMapping("/view_workloadhome")
    public String home(Model model, Principal principal) {
        //System.out.println("User Role is to find out"  );
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        boolean isAdmin = authentication.getAuthorities().stream()
                .anyMatch(auth -> auth.getAuthority().equals("ROLE_ADMIN"));

        String roleMessage = isAdmin ? "Admin" : "User";
        model.addAttribute("message", roleMessage);

        String username = principal.getName();  // Directly from Principal
        UserDetailsObj userObj = (UserDetailsObj) userDetailsService.loadUserByUsername(username);
        model.addAttribute("userName", userObj.getUsername());

        return "resortHomePage"; // Home JSP
    }



    @RequestMapping("AdminHome")
    public ModelAndView showAdminHome(@ModelAttribute("userobj") @Valid UserDetailsObj userDetailsObj, BindingResult result, ModelMap model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails)principal).getUsername();
        } else {
            username = principal.toString();
        }

        UserDetailsObj userObj = (UserDetailsObj) userDetailsService.loadUserByUsername(username);

        ModelAndView mapview = new ModelAndView();
        //mapview.addObject("userRole", userObj.getRoles());
        mapview.addObject("userName", userObj.getUsername());
        mapview.setViewName("admin/AdminHome");
        mapview.addObject("userName", userObj.getUsername());
        mapview.addObject("address", userObj.getAddress());
        mapview.addObject("fixedIncentive", userObj.getFixedIncentive());
        mapview.addObject("Id", userObj.getUserId());
        mapview.addObject("mobile", userObj.getMobile());
        mapview.addObject("name", userObj.getName());
        mapview.addObject("shift", userObj.getShift());
        mapview.addObject("type", userObj.getType());
        mapview.addObject("dob", userObj.getDob());
        mapview.addObject("doj", userObj.getDoj());
        mapview.addObject("designation", userObj.getDesignation());
        mapview.addObject("active", userObj.isActive());
        mapview.addObject("email", userObj.getEmail());
        mapview.addObject(userObj);
        return mapview;
    }





}
