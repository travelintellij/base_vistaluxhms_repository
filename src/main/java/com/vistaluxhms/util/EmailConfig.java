package com.vistaluxhms.util;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
 
@Configuration
public class EmailConfig 
{
 
	@Value("${spring.mail.host}")
	private String emailHost;
    @Value("${spring.mail.port}")
    private int emailPort;

	@Value("${spring.mail.properties.mail.smtp.auth}")
	private String smtpAuth;
	
	@Value("${spring.mail.properties.mail.debug}")
	private String mailDebug;

}
