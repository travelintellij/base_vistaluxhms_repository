package com.vistaluxhms.exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import javax.servlet.http.HttpServletRequest;

@ControllerAdvice
public class GlobalExceptionHandler {

    private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    @ExceptionHandler(Exception.class)
    public String handleAllExceptions(Exception ex, Model model, HttpServletRequest request) {

        logger.error("=== UNHANDLED EXCEPTION ===");
        logger.error("URL: {} {}", request.getMethod(), request.getRequestURL());
        logger.error("Query: {}", request.getQueryString());
        logger.error("User: {}", request.getRemoteUser());
        logger.error("Exception: ", ex);

        model.addAttribute("errorMessage",
                "Something went wrong. Please contact the administrator.");

        return "error/error";
    }
}