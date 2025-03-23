package com.vistaluxhms.services;


import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.vistaluxhms.model.EmailMessageVO;
import com.vistaluxhms.model.Mail;
import com.vistaluxhms.util.EmailConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.util.ResourceUtils;


import freemarker.cache.WebappTemplateLoader;
import freemarker.core.Configurable;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.springframework.validation.Errors;


@Service
public class EmailServiceImpl {

	
	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	private EmailConfig emailConfig;

	
	/*@Autowired
    private SimpleMailMessage preConfiguredMessage;
	*/
	

	@Value("${email.client.from}")
	private String systemEmailFrom;
	
	@Value("${email.notify.communication.email}")
	private String emailNotifyBcc;
	
	@Autowired
	 private Configuration freemarkerConfig;
	 
	 @Value("${all.email.notify.communication.active}")
	private boolean emailNotifyActive;

	@Value("${email.internal.valid}")
	private boolean internalEmailNotifyActive;



	/**
     * This method will send compose and send the message 
     * */
    public void sendMail(String to, String subject, String body) 
    {
    	if(emailNotifyActive) {
    		SimpleMailMessage message = new SimpleMailMessage();
    		message.setFrom(systemEmailFrom);
    		message.setTo(to);
    		message.setSubject(subject);
    		message.setText(body);
    		mailSender.send(message);
    	}
    }
	  
    /**
     * This method will send compose and send the message 
     * */
    public void sendMail(String to, String from, String subject, String body) 
    {
    	if(emailNotifyActive) {
    		SimpleMailMessage message = new SimpleMailMessage();
    		message.setFrom(from);
    		message.setTo(to);
    		message.setSubject(subject);
    		message.setText(body);
    		mailSender.send(message);
    	}
    }

    
    
    /**
	     * This method will send a pre-configured message
	     * 
	    public void sendPreConfiguredMail(String message) 
	    {
	        SimpleMailMessage mailMessage = new SimpleMailMessage(preConfiguredMessage);
	        mailMessage.setText(message);
	        mailSender.send(mailMessage);
	    }
	 */
	    
	    public void sendMailWithAttachment(EmailMessageVO emailMessageVo, ArrayList filtToAttach) throws MailException
	    {
	    	MimeMessagePreparator preparator = new MimeMessagePreparator() 
	        {
	            public void prepare(MimeMessage mimeMessage) throws Exception 
	            {
	                //mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(emailMessageVo.getEmailToList()));
	            	
	            	InternetAddress[] emailToList = new InternetAddress[emailMessageVo.getEmailToValidatedList().size()];
	            	for (int i = 0; i < emailMessageVo.getEmailToValidatedList().size(); i++) {
	            		emailToList[i] = new InternetAddress((String) emailMessageVo.getEmailToValidatedList().get(i));
	            	}
	            	mimeMessage.setRecipients(Message.RecipientType.TO, emailToList);
	            	InternetAddress[] emailCcList = new InternetAddress[emailMessageVo.getEmailCcValidatedList().size()];
	            	for (int i = 0; i < emailMessageVo.getEmailCcValidatedList().size(); i++) {
	            		emailCcList[i] = new InternetAddress((String) emailMessageVo.getEmailCcValidatedList().get(i));
	            	}
	            	mimeMessage.setRecipients(Message.RecipientType.CC, emailCcList);
	            	mimeMessage.setFrom(new InternetAddress("UdanChoo@travelintellij.com"));
	                mimeMessage.setSubject(emailMessageVo.getEmailSubject());
	                mimeMessage.setText(emailMessageVo.getEmailMessage());
	                MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
	                //attachFiles(filtToAttach,helper );
	                
	                for (Object aName : filtToAttach) {
	    				File file = new File((String)aName);
	                	FileSystemResource fr = new FileSystemResource(file);
	    				helper.addAttachment(file.getName(), fr);
	    			}
	                helper.setText(emailMessageVo.getEmailMessage());
	            }
	        };
            mailSender.send(preparator);
	    }
	    
	    
	   
	    
	    private void attachFiles(ArrayList fileToAttach,MimeMessageHelper helper ) {
			Iterator itrToFilesAttach = fileToAttach.iterator();
			while(itrToFilesAttach.hasNext()) {
				FileSystemResource file = new FileSystemResource(new File((String)itrToFilesAttach.next()));
				try {
					System.out.println("ATTACHING: " + file.getFile().getPath());
					helper.addAttachment(file.getFilename(),file);
				} catch (MessagingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
	    	
	    	/*
	    	for(int i=0;i<UdanChooConstants.UDN_SRV_SUPP_NAME_LIST.size();i++) {
	    		if(UdanChooConstants.UDN_SRV_SUPP_NAME_LIST.get(i).toString().equalsIgnoreCase(UdanChooConstants.UDN_FLT_SRV_SUPP_NAME) && (!fileUploaderListVo.getFlightFilesList().isEmpty())) {
	    			Iterator itr = fileUploaderListVo.getFlightFilesList().iterator();
	    			while(itr.hasNext()) {
	    				String fileName=(String) itr.next();
	    				System.out.println("File Name is " + fileName);
	    				Path directoryPath = Paths.get(fileStorageService.getFileStorageLocation() + "\\" + fileUploaderListVo.getDealConfirmationId() +"\\" + UdanChooConstants.UDN_FLT_SRV_SUPP_NAME + "\\" + fileName);
	    				System.out.println("Attaching File " + directoryPath);
	    				FileSystemResource file = new FileSystemResource(new File(directoryPath.toString()));
	    				helper.addAttachment(file.getFilename(),file);
	    			}
	    		}
	    	}
	    	*/
	    }
	    
	    
	    public void sendEmailMessageUsingTemplate(Mail mail, String templateName) throws MessagingException, IOException, TemplateException {
	    	freemarkerConfig.setClassForTemplateLoading(this.getClass(), "/templates");
	    	//freemarkerConfig.setDirectoryForTemplateLoading(new File(this.fileStorageLocation.get"));
	    	freemarkerConfig.setSetting(Configurable.NUMBER_FORMAT_KEY, "computer");
	    	freemarkerConfig.setTemplateUpdateDelay(0);
	    	mail.setFrom(systemEmailFrom);
	    	MimeMessage message = mailSender.createMimeMessage();
	        MimeMessageHelper helper = new MimeMessageHelper(message,
	                MimeMessageHelper.MULTIPART_MODE_MIXED_RELATED,
	                StandardCharsets.UTF_8.name());


	        //If you have any inline image then following code needs to be commented and add
	        // cid:udanchoo.png as placeholer in the ftl template. Dont forget that 
	        //image files location for ftl template is different. 
	        /*
	        File fileRes = ResourceUtils.getFile(ftlTemplateImagePath + File.separator + "tglogo.png");
	        //System.out.println("Path isss " + fileRes.getAbsolutePath());
	        helper.addAttachment("udanchoo.png", fileRes);
	         */
        
	        Template template = freemarkerConfig.getTemplate(templateName);
	        String html = FreeMarkerTemplateUtils.processTemplateIntoString(template, mail.getModel());

	        helper.setTo(mail.getTo());
	        if(mail.getCc()!=null && mail.getCc().trim().length()>0) {
	        	helper.setCc(mail.getCc());
	        }
	        if(emailNotifyBcc!=null && emailNotifyBcc.trim().length()>0) {
	        	helper.setBcc(emailNotifyBcc);
	        }
	        helper.setText(html, true);
	        helper.setSubject(mail.getSubject());
	        helper.setFrom(mail.getFrom());

	       mailSender.send(message);
	    }
	    
	    
	    public void sendEmailMessageUsingTemplate_MultipleRecipients(Mail mail,String templateName) throws MessagingException, IOException, TemplateException {
	    	freemarkerConfig.setClassForTemplateLoading(this.getClass(), "/templates");
	    	//freemarkerConfig.setDirectoryForTemplateLoading(new File(this.fileStorageLocation.get"));
	    	freemarkerConfig.setSetting(Configurable.NUMBER_FORMAT_KEY, "computer");
	    	freemarkerConfig.setAPIBuiltinEnabled(true);
	    	
	    	freemarkerConfig.setTemplateUpdateDelay(0);
	    	mail.setFrom(systemEmailFrom);
	    	MimeMessage message = mailSender.createMimeMessage();
	        MimeMessageHelper helper = new MimeMessageHelper(message,
	                MimeMessageHelper.MULTIPART_MODE_MIXED_RELATED,
	                StandardCharsets.UTF_8.name());
	        
	        //If you have any inline image then following code needs to be commented and add
	        // cid:udanchoo.png as placeholer in the ftl template. Dont forget that 
	        //image files location for ftl template is different. 
	        /*
	        File fileRes = ResourceUtils.getFile(ftlTemplateImagePath + File.separator + "tglogo.png");
	        //System.out.println("Path isss " + fileRes.getAbsolutePath());
	        helper.addAttachment("udanchoo.png", fileRes);
	         */
        
	        Template template = freemarkerConfig.getTemplate(templateName);
	        String html = FreeMarkerTemplateUtils.processTemplateIntoString(template, mail.getModel());

	        helper.setTo(mail.getToList());
	        /*helper.setCc(mail.getCcList());*/
	        if(emailNotifyBcc!=null && emailNotifyBcc.trim().length()>0) {
				List<String> emailListWaterBcc = validateAndExtractEmails(emailNotifyBcc);
				InternetAddress[] emailWatcherAddresses = new InternetAddress[emailListWaterBcc.size()];
				for (int i = 0; i < emailListWaterBcc.size(); i++) {
					try {
						emailWatcherAddresses[i] = new InternetAddress(emailListWaterBcc.get(i).trim());
					} catch (AddressException e) {
						throw new RuntimeException(e);
					}
				}
				helper.setBcc(emailWatcherAddresses);
	        }
	        helper.setText(html, true);
	        helper.setSubject(mail.getSubject());
	        helper.setFrom(mail.getFrom());
	       mailSender.send(message);
	    }

	private List<String> validateAndExtractEmails(String emailInput) {
		List<String> emailList = new ArrayList<>();
		if (emailInput != null && !emailInput.trim().isEmpty()) {
			// Split input using comma ',' or semicolon ';' as delimiter
			String[] emails = emailInput.split("[,;]");
			for (String email : emails) {
				email = email.trim(); // Remove spaces
				if (!isValidEmail(email)) {
					System.out.println("Invalid Email Formation Specified in Configuration File for watcher. ");
					//errors.rejectValue("email", "error.email", "Invalid email format: " + email);
				} else {
					emailList.add(email);
				}
			}
		}
		if (emailList.isEmpty()) {
			System.out.println("Watcher Not Defined in Configuration. ");
			//errors.rejectValue("email", "error.email", "At least one valid email is required.");
		}
		return emailList;
	}

	private boolean isValidEmail(String email) {
		String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
		return email.matches(emailRegex);
	}

	    /*
	    public void sendB2bEmailMessageUsingTemplate_MultipleRecipients(Mail mail,String templateName) throws MessagingException, IOException, TemplateException {
	    	freemarkerConfig.setClassForTemplateLoading(this.getClass(), "/templates");
	    	//freemarkerConfig.setDirectoryForTemplateLoading(new File(this.fileStorageLocation.get"));
	    	freemarkerConfig.setSetting(Configurable.NUMBER_FORMAT_KEY, "computer");
	    	freemarkerConfig.setAPIBuiltinEnabled(true);
	    	freemarkerConfig.setTemplateUpdateDelay(0);
	    	MimeMessage message = mailSender.createMimeMessage();
	        MimeMessageHelper helper = new MimeMessageHelper(message,MimeMessageHelper.MULTIPART_MODE_MIXED_RELATED,StandardCharsets.UTF_8.name());
	        Template template = freemarkerConfig.getTemplate(templateName);
	        String html = FreeMarkerTemplateUtils.processTemplateIntoString(template, mail.getModel());
	        helper.setTo(mail.getToList());
	        helper.setCc(mail.getCcList());
	        if(emailNotifyBcc!=null && emailNotifyBcc.trim().length()>0) {
	        	helper.setBcc(emailNotifyBcc);
	        }
	        helper.setText(html, true);
	        helper.setSubject(mail.getSubject());
	        helper.setFrom(b2BEmailFrom);
	        //mailSender.send(message);
	        emailConfig.getB2bJavaMailSender().send(message);
	    }
	    */

	    public void sendEmailMessageUsingTemplate_MultipleRecipients_from_loggedInUser(Mail mail,String templateName,String emailFrom) throws MessagingException, IOException, TemplateException {
	    	freemarkerConfig.setClassForTemplateLoading(this.getClass(), "/templates");
	    	//freemarkerConfig.setDirectoryForTemplateLoading(new File(this.fileStorageLocation.get"));
	    	freemarkerConfig.setSetting(Configurable.NUMBER_FORMAT_KEY, "computer");
	    	freemarkerConfig.setAPIBuiltinEnabled(true);
	    	
	    	freemarkerConfig.setTemplateUpdateDelay(0);
	    	mail.setFrom(emailFrom);
	    	MimeMessage message = mailSender.createMimeMessage();
	        MimeMessageHelper helper = new MimeMessageHelper(message,
	                MimeMessageHelper.MULTIPART_MODE_MIXED_RELATED,
	                StandardCharsets.UTF_8.name());
	        
	        //If you have any inline image then following code needs to be commented and add
	        // cid:udanchoo.png as placeholer in the ftl template. Dont forget that 
	        //image files location for ftl template is different. 
	        /*
	        File fileRes = ResourceUtils.getFile(ftlTemplateImagePath + File.separator + "tglogo.png");
	        //System.out.println("Path isss " + fileRes.getAbsolutePath());
	        helper.addAttachment("udanchoo.png", fileRes);
	         */
        
	        Template template = freemarkerConfig.getTemplate(templateName);
	        String html = FreeMarkerTemplateUtils.processTemplateIntoString(template, mail.getModel());

	        helper.setTo(mail.getToList());
	        helper.setCc(mail.getCcList());
	        
	        if(emailNotifyBcc!=null && emailNotifyBcc.trim().length()>0) {
	        	helper.setBcc(emailNotifyBcc);
	        }
	        helper.setText(html, true);
	        helper.setSubject(mail.getSubject());
	        helper.setFrom(mail.getFrom());

	       mailSender.send(message);
	    }
	    

	    /*
	    public void sendEmailMessage_Notification1_MultipleRecipients_from_loggedInUser(Mail mail,String emailBody,String emailFrom) throws MessagingException, IOException, TemplateException {
	    	
	    	if(emailNotifyActive && internalEmailNotifyActive) {
	    		Session session = emailConfig.getNotification1EmailSessionSender();
	    		MimeMessage message = new MimeMessage(session);
	    		message.setFrom(new InternetAddress(emailFrom));
	    		message.setRecipients(Message.RecipientType.TO, mail.getToList());
	    		if(emailNotifyBcc!=null && emailNotifyBcc.trim().length()>0) {
		    		message.setRecipients(Message.RecipientType.BCC, emailNotifyBcc);
	    		}
	    		message.setSubject(mail.getSubject());
	    		message.setText(emailBody);
            	Transport.send(message);
	    	}
	    }
	    */
	    
}
