package com.vistaluxhms.controller;

import com.vistaluxhms.entity.AshokaTeam;
import com.vistaluxhms.repository.UserRepository;
import com.vistaluxhms.services.EmailServiceImpl;
import com.vistaluxhms.services.SettingsAndOtherServicesImpl;
import com.vistaluxhms.model.EmailConfigEntityDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

@Controller
public class ForgotPasswordController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private EmailServiceImpl emailService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private SettingsAndOtherServicesImpl settingService;

    private static final int TOKEN_EXPIRY_MINUTES = 30;

    // ========== FORGOT PASSWORD PAGE ==========

    @GetMapping("/forgot-password")
    public ModelAndView showForgotPasswordPage() {
        return new ModelAndView("forgotPassword");
    }

    @PostMapping("/forgot-password")
    public ModelAndView processForgotPassword(@RequestParam("email") String email,
                                              HttpServletRequest request,
                                              RedirectAttributes redirectAttrib) {
        ModelAndView modelView = new ModelAndView("forgotPassword");

        // Always show the same message to prevent user enumeration
        String safeMessage = "If a valid account exists for this email, a password reset link has been sent.";

        try {
            Optional<AshokaTeam> userOpt = userRepository.findByEmailAndActive(email.trim(), true);

            if (userOpt.isPresent()) {
                AshokaTeam user = userOpt.get();

                // Generate a secure token
                String token = UUID.randomUUID().toString();
                user.setResetToken(token);
                user.setTokenExpiryDate(LocalDateTime.now().plusMinutes(TOKEN_EXPIRY_MINUTES));
                userRepository.save(user);

                // Build reset link
                String resetUrl = request.getScheme() + "://" + request.getServerName()
                        + ":" + request.getServerPort()
                        + request.getContextPath()
                        + "/reset-password?token=" + token;

                // Send email
                String subject = "Password Reset Request — AxisHMS Pro";
                String htmlBody = buildResetEmailBody(user.getName(), resetUrl);
                emailService.sendMailWithHtml(user.getEmail(), subject, htmlBody);
            }
            // If user not found, we still show the same message (no enumeration)

        } catch (Exception e) {
            e.printStackTrace();
            // Still show the safe message even if email sending fails
        }

        modelView.addObject("Success", safeMessage);
        return modelView;
    }

    // ========== RESET PASSWORD PAGE ==========

    @GetMapping("/reset-password")
    public ModelAndView showResetPasswordPage(@RequestParam("token") String token) {
        ModelAndView modelView = new ModelAndView("resetPassword");

        Optional<AshokaTeam> userOpt = userRepository.findByResetToken(token);

        if (!userOpt.isPresent()) {
            modelView.addObject("Error", "This password reset link is invalid.");
            modelView.addObject("invalidToken", true);
            return modelView;
        }

        AshokaTeam user = userOpt.get();
        if (user.getTokenExpiryDate() != null && user.getTokenExpiryDate().isBefore(LocalDateTime.now())) {
            modelView.addObject("Error", "This password reset link has expired. Please request a new one.");
            modelView.addObject("invalidToken", true);
            return modelView;
        }

        modelView.addObject("token", token);
        return modelView;
    }

    @PostMapping("/reset-password")
    public ModelAndView processResetPassword(@RequestParam("token") String token,
                                             @RequestParam("password") String password,
                                             @RequestParam("confirmPassword") String confirmPassword) {
        ModelAndView modelView = new ModelAndView("resetPassword");

        // Validate passwords match
        if (!password.equals(confirmPassword)) {
            modelView.addObject("Error", "Passwords do not match.");
            modelView.addObject("token", token);
            return modelView;
        }

        // Validate password length
        if (password.trim().length() < 6) {
            modelView.addObject("Error", "Password must be at least 6 characters long.");
            modelView.addObject("token", token);
            return modelView;
        }

        Optional<AshokaTeam> userOpt = userRepository.findByResetToken(token);

        if (!userOpt.isPresent()) {
            modelView.addObject("Error", "This password reset link is invalid.");
            modelView.addObject("invalidToken", true);
            return modelView;
        }

        AshokaTeam user = userOpt.get();

        if (user.getTokenExpiryDate() != null && user.getTokenExpiryDate().isBefore(LocalDateTime.now())) {
            modelView.addObject("Error", "This password reset link has expired. Please request a new one.");
            modelView.addObject("invalidToken", true);
            return modelView;
        }

        // Update password and clear token
        user.setPassword(passwordEncoder.encode(password.trim()));
        user.setResetToken(null);
        user.setTokenExpiryDate(null);
        userRepository.save(user);

        modelView.addObject("Success", "Your password has been reset successfully! You can now login with your new password.");
        modelView.addObject("resetComplete", true);
        return modelView;
    }

    // ========== EMAIL BODY BUILDER ==========

    private String buildResetEmailBody(String userName, String resetUrl) {
        StringBuilder sb = new StringBuilder();
        sb.append("<div style='font-family: DM Sans, Arial, sans-serif; max-width: 560px; margin: 0 auto; padding: 32px;'>");
        sb.append("<div style='text-align: center; margin-bottom: 24px;'>");
        sb.append("<h2 style='color: #1B2A3D; font-size: 22px; margin: 0;'>Password Reset Request</h2>");
        sb.append("<div style='width: 50px; height: 2px; background: #C9A84C; margin: 12px auto;'></div>");
        sb.append("</div>");

        sb.append("<p style='color: #2D3748; font-size: 15px; line-height: 1.6;'>Dear <strong>").append(userName).append("</strong>,</p>");
        sb.append("<p style='color: #2D3748; font-size: 15px; line-height: 1.6;'>We received a request to reset your password. Click the button below to set a new password:</p>");

        sb.append("<div style='text-align: center; margin: 28px 0;'>");
        sb.append("<a href='").append(resetUrl).append("' style='display: inline-block; padding: 14px 32px; background-color: #C9A84C; color: #1B2A3D; font-weight: 600; text-decoration: none; border-radius: 6px; font-size: 15px;'>Reset My Password</a>");
        sb.append("</div>");

        sb.append("<p style='color: #8C8A87; font-size: 13px; line-height: 1.6;'>This link will expire in <strong>30 minutes</strong>. If you did not request a password reset, please ignore this email — your password will remain unchanged.</p>");

        sb.append("<hr style='border: none; border-top: 1px solid #E8E4DE; margin: 24px 0;'>");
        sb.append("<p style='color: #8C8A87; font-size: 12px; text-align: center;'>If the button doesn't work, copy and paste this link into your browser:<br>");
        sb.append("<a href='").append(resetUrl).append("' style='color: #C9A84C; word-break: break-all;'>").append(resetUrl).append("</a></p>");

        sb.append("<p style='color: #8C8A87; font-size: 12px; text-align: center; margin-top: 16px;'>Regards,<br><strong>AxisHMS Pro</strong></p>");
        sb.append("</div>");

        return sb.toString();
    }
}
