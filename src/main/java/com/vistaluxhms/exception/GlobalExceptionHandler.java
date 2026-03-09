package com.vistaluxhms.exception;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(Exception.class)
    public String handleAllExceptions(Exception ex, Model model) {

        ex.printStackTrace();  // you can replace with logger later

        model.addAttribute("errorMessage",
                "Something went wrong. Please contact the administrator.");

        return "error/error";   // ✅ THIS IS IMPORTANT
    }
}