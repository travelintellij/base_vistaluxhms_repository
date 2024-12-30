package com.vistaluxhms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController {

    @GetMapping("/hello")
    public String helloWorld() {
        return "helloWorld";  // This will map to /WEB-INF/jsp/helloWorld.jsp
    }
}