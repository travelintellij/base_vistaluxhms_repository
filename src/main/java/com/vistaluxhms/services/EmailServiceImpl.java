package com.vistaluxhms.services;


import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
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
import javax.servlet.ServletContext;

import com.vistaluxevent.model.EventDetailsConfigDTO;
import com.vistaluxevent.services.EventConfigServicesImpl;
import com.vistaluxhms.entity.CentralConfigEntity;
import com.vistaluxhms.model.CentralConfigEntityDTO;
import com.vistaluxhms.model.EmailMessageVO;
import com.vistaluxhms.model.Mail;
import com.vistaluxhms.util.EmailConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.core.io.ByteArrayResource;
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


import org.springframework.util.StreamUtils;
import java.io.InputStream;
import java.util.Base64;
import com.vistaluxhms.util.VistaluxConstants;

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

	@Autowired
	private ServletContext servletContext;
	/*@Autowired
    private SimpleMailMessage preConfiguredMessage;
	*/

	@Autowired
	private SettingsAndOtherServicesImpl settingService;


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

	@Autowired
	private EventConfigServicesImpl eventConfigService;

    @Value("${email.reply.to}")
    private String replyToEmail;



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
	    

	    @Async
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

			CentralConfigEntityDTO centralConfigEntity = settingService.getCentralConfig();
			byte[] logoBytes = null;
			if (mail.getModel().get("logoUrl") == null || mail.getModel().get("logoUrl").toString().trim().isEmpty() || mail.getModel().get("logoUrl").toString().startsWith("data:")) {
				logoBytes = getUploadedLogoBytes();
				if (logoBytes != null && logoBytes.length > 0) {
					mail.getModel().put("logoUrl", "cid:resortLogo");
				} else if (centralConfigEntity != null && centralConfigEntity.getLogoPath() != null && !centralConfigEntity.getLogoPath().trim().isEmpty()) {
					mail.getModel().put("logoUrl", centralConfigEntity.getLogoPath().trim());
				}
			}
			mail.getModel().put("escalationEmail", centralConfigEntity.getEscalationEmail());
			mail.getModel().put("escalationPhone", centralConfigEntity.getEscalationPhone());
			mail.getModel().put("centralNumber", centralConfigEntity.getCentralNumber());
			mail.getModel().put("website", centralConfigEntity.getWebsite());
			mail.getModel().put("facebook", centralConfigEntity.getFacebookLink());
			mail.getModel().put("instagram", centralConfigEntity.getInstagramLink());
			mail.getModel().put("linkedin", centralConfigEntity.getLinkedinLink());
			mail.getModel().put("youtube", centralConfigEntity.getYoutubeLink());
			mail.getModel().put("companyName", centralConfigEntity.getCompanyName());
			mail.getModel().put("logoCid", "ashokaLogo");

			Template template = freemarkerConfig.getTemplate(templateName);
	        String html = FreeMarkerTemplateUtils.processTemplateIntoString(template, mail.getModel());

	        helper.setTo(mail.getTo());
	        if(mail.getCc()!=null && isValidEmail(mail.getCc().trim())) {
	        	helper.setCc(mail.getCc().trim());
	        }
			if(emailNotifyBcc!=null && emailNotifyBcc.trim().length()>0) {
				List<String> emailListWaterBcc = validateAndExtractEmails(emailNotifyBcc);
				if (!emailListWaterBcc.isEmpty()) {
					List<InternetAddress> emailWatcherAddresses = new ArrayList<>();
					for (int i = 0; i < emailListWaterBcc.size(); i++) {
						try {
							emailWatcherAddresses.add(new InternetAddress(emailListWaterBcc.get(i).trim()));
						} catch (AddressException e) {
							throw new RuntimeException(e);
						}
					}
					if (!emailWatcherAddresses.isEmpty()) {
						helper.setBcc(emailWatcherAddresses.toArray(new InternetAddress[0]));
					}
				}
			}
	        helper.setText(html, true);
	        if (logoBytes != null && logoBytes.length > 0 && html.contains("cid:resortLogo")) {
				try {
					String mimeType = "image/png";
					if (VistaluxConstants.LOGO_FILE_NAME.toLowerCase().endsWith(".jpg") || VistaluxConstants.LOGO_FILE_NAME.toLowerCase().endsWith(".jpeg")) {
						mimeType = "image/jpeg";
					}
					helper.addInline("resortLogo", new ByteArrayResource(logoBytes), mimeType);
				} catch (Exception e) {
					e.printStackTrace();
				}
	        }
	        helper.setSubject(mail.getSubject());
	        helper.setFrom(mail.getFrom());
            helper.setReplyTo(replyToEmail);

	       try {
	           mailSender.send(message);
	           System.out.println("Email successfully dispatched to: " + mail.getTo());
	       } catch (Exception e) {
	           System.err.println("CRITICAL ERROR: Failed to send email via JavaMailSender: " + e.getMessage());
	           e.printStackTrace();
	           throw e;
	       }
	    }
	    
	    
	    @Async
		public void sendEmailMessageUsingTemplate_MultipleRecipients(Mail mail,String templateName) throws MessagingException, IOException, TemplateException {
			CentralConfigEntityDTO centralConfigEntity = settingService.getCentralConfig();
			String eventType;

            if(mail.getModel().get("eventType")!=null)
				eventType = mail.getModel().get("eventType").toString();
			else
				eventType = "wedding";

			EventDetailsConfigDTO eventDetailsConfigDTO = eventConfigService.getEventDetails(eventType);
			byte[] logoBytes = null;
			if (mail.getModel().get("logoUrl") == null || mail.getModel().get("logoUrl").toString().trim().isEmpty() || mail.getModel().get("logoUrl").toString().startsWith("data:")) {
				logoBytes = getUploadedLogoBytes();
				if (logoBytes != null && logoBytes.length > 0) {
					mail.getModel().put("logoUrl", "cid:resortLogo");
				} else if (centralConfigEntity != null && centralConfigEntity.getLogoPath() != null && !centralConfigEntity.getLogoPath().trim().isEmpty()) {
					mail.getModel().put("logoUrl", centralConfigEntity.getLogoPath().trim());
				}
			}
			mail.getModel().put("escalationEmail", centralConfigEntity.getEscalationEmail());
			mail.getModel().put("escalationPhone", centralConfigEntity.getEscalationPhone());
			mail.getModel().put("centralNumber", centralConfigEntity.getCentralNumber());
			mail.getModel().put("website", centralConfigEntity.getWebsite());
			mail.getModel().put("facebook", centralConfigEntity.getFacebookLink());
			mail.getModel().put("instagram", centralConfigEntity.getInstagramLink());
			mail.getModel().put("linkedin", centralConfigEntity.getLinkedinLink());
			mail.getModel().put("youtube", centralConfigEntity.getYoutubeLink());
			mail.getModel().put("hotelName", centralConfigEntity.getHotelName());

			mail.getModel().put("centralConfig", centralConfigEntity);
			mail.getModel().put("eventConfig", eventDetailsConfigDTO);
			if (mail.getModel().get("serviceAdvisorMobile") == null || mail.getModel().get("serviceAdvisorMobile").toString().trim().isEmpty()) {
				mail.getModel().put("serviceAdvisorMobile", centralConfigEntity.getCentralNumber());
			}

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
        
	        Template template = freemarkerConfig.getTemplate(templateName);
	        String html = FreeMarkerTemplateUtils.processTemplateIntoString(template, mail.getModel());

	        helper.setTo(mail.getToList());
	        if (mail.getCc() != null && isValidEmail(mail.getCc().trim())) {
				try {
					helper.setCc(mail.getCc().trim());
				} catch (Exception e) {
					e.printStackTrace();
				}
	        } else if (mail.getCcList() != null && mail.getCcList().length > 0) {
				try {
					helper.setCc(mail.getCcList());
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

	        if(emailNotifyBcc!=null && emailNotifyBcc.trim().length()>0) {
				List<String> emailListWaterBcc = validateAndExtractEmails(emailNotifyBcc);
				if (!emailListWaterBcc.isEmpty()) {
					List<InternetAddress> emailWatcherAddresses = new ArrayList<>();
					for (int i = 0; i < emailListWaterBcc.size(); i++) {
						try {
							emailWatcherAddresses.add(new InternetAddress(emailListWaterBcc.get(i).trim()));
						} catch (AddressException e) {
							throw new RuntimeException(e);
						}
					}
					if (!emailWatcherAddresses.isEmpty()) {
						helper.setBcc(emailWatcherAddresses.toArray(new InternetAddress[0]));
					}
				}
	        }
	        helper.setText(html, true);
	        if (logoBytes != null && logoBytes.length > 0 && html.contains("cid:resortLogo")) {
				try {
					String mimeType = "image/png";
					if (VistaluxConstants.LOGO_FILE_NAME.toLowerCase().endsWith(".jpg") || VistaluxConstants.LOGO_FILE_NAME.toLowerCase().endsWith(".jpeg")) {
						mimeType = "image/jpeg";
					}
					helper.addInline("resortLogo", new ByteArrayResource(logoBytes), mimeType);
				} catch (Exception e) {
					e.printStackTrace();
				}
	        }
	        helper.setSubject(mail.getSubject());
	        helper.setFrom(mail.getFrom());
            helper.setReplyTo(replyToEmail);

	       try {
	           mailSender.send(message);
	           System.out.println("Multiple-recipients email successfully dispatched to: " + (mail.getToList() != null ? Arrays.toString(mail.getToList()) : ""));
	       } catch (Exception e) {
	           System.err.println("CRITICAL ERROR: Failed to send multiple-recipients email via JavaMailSender: " + e.getMessage());
	           e.printStackTrace();
	           throw e;
	       }
	    }

	public byte[] getUploadedLogoBytes() {
		try {
			if (servletContext != null) {
				String path = VistaluxConstants.LOGO_PATH + "/" + VistaluxConstants.LOGO_FILE_NAME;
				InputStream is = servletContext.getResourceAsStream(path);
				if (is != null) {
					try {
						byte[] bytes = StreamUtils.copyToByteArray(is);
						if (bytes != null && bytes.length > 0) {
							return bytes;
						}
					} finally {
						is.close();
					}
				}

				String realPath = servletContext.getRealPath(VistaluxConstants.LOGO_PATH + File.separator + VistaluxConstants.LOGO_FILE_NAME);
				if (realPath != null) {
					File file = new File(realPath);
					if (file.exists() && file.isFile() && file.length() > 0) {
						return Files.readAllBytes(file.toPath());
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public String getUploadedLogo(CentralConfigEntityDTO centralConfig) {
		byte[] bytes = getUploadedLogoBytes();
		if (bytes != null && bytes.length > 0) {
			String mimeType = "image/png";
			if (VistaluxConstants.LOGO_FILE_NAME.toLowerCase().endsWith(".jpg") || VistaluxConstants.LOGO_FILE_NAME.toLowerCase().endsWith(".jpeg")) {
				mimeType = "image/jpeg";
			}
			return "data:" + mimeType + ";base64," + Base64.getEncoder().encodeToString(bytes);
		}
		if (centralConfig != null && centralConfig.getLogoPath() != null && !centralConfig.getLogoPath().trim().isEmpty()) {
			return centralConfig.getLogoPath().trim();
		}
		return "";
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

	public void sendEmailMessage_Notification1_MultipleRecipients_from_loggedInUser(Mail mail,String emailBody,String emailFrom) throws MessagingException, IOException, TemplateException {

		if(emailNotifyActive && internalEmailNotifyActive) {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message);
			message.setFrom(new InternetAddress(emailFrom));
			message.setRecipients(Message.RecipientType.TO, mail.getToList());
			if(emailNotifyBcc!=null && emailNotifyBcc.trim().length()>0) {
				message.setRecipients(Message.RecipientType.BCC, emailNotifyBcc);
			}
			message.setSubject(mail.getSubject());
			message.setText(emailBody);
			mailSender.send(message);
		}
	}

	/**
	 * Send mail to multiple recipients (comma or semicolon separated).
	 */
	public void sendMailToMultipleRecipients(String emailList, String subject, String body) {
		if (!emailNotifyActive) {
			System.out.println("Email notifications are disabled.");
			return;
		}

		// Validate and extract emails
		List<String> recipients = validateAndExtractEmails(emailList);
		if (recipients.isEmpty()) {
			System.out.println("No valid email addresses found.");
			return;
		}

		try {
			// Prepare message
			SimpleMailMessage message = new SimpleMailMessage();
			message.setFrom(systemEmailFrom);
			message.setTo(recipients.toArray(new String[0])); // Convert list to array
			message.setSubject(subject);
			message.setText(body);

			// Send mail
			mailSender.send(message);
			System.out.println("Email sent to: " + recipients);

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Failed to send email: " + e.getMessage());
		}
	}

	public void sendMailWithHtml(String to, String subject, String htmlBody) {
		if (emailNotifyActive) {
			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
				helper.setFrom(systemEmailFrom);
                helper.setReplyTo(replyToEmail);
				helper.setTo(to.split("[,;]")); // handles multiple emails separated by , or ;
				if(emailNotifyBcc!=null && emailNotifyBcc.trim().length()>0) {
					message.setRecipients(Message.RecipientType.BCC, emailNotifyBcc);
				}
				helper.setSubject(subject);
				helper.setText(htmlBody, true); // true = HTML content
				mailSender.send(message);
			} catch (MessagingException e) {
				e.printStackTrace();
			}
		}
	}






}
