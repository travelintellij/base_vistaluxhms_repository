package com.vistaluxhms.services;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.FileNotFoundException;
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


    private static final Logger logger = LoggerFactory.getLogger(EmailServiceImpl.class);
	// ===== AI MODIFICATION START =====
	// Change: Dynamic JavaMailSender based on DB config instead of static bean
	// Reason: Ensure SMTP properties are read from the frontend without
	// application.properties fallback
	// Scope: Email config
	private JavaMailSender getJavaMailSender() {
		com.vistaluxhms.model.EmailConfigEntityDTO centralConfig = settingService.getEmailConfig();
		if (centralConfig == null || centralConfig.getEmailSmtpHost() == null
				|| centralConfig.getEmailSmtpHost().trim().isEmpty()) {
			throw new org.springframework.mail.MailSendException(
					"Email SMTP configuration is missing. Please setup email in Settings > Communication Channels.");
		}

		JavaMailSenderImpl dynamicMailSender = new JavaMailSenderImpl();
		dynamicMailSender.setHost(centralConfig.getEmailSmtpHost().trim());
		try {
			if (centralConfig.getEmailSmtpPort() != null && !centralConfig.getEmailSmtpPort().trim().isEmpty()) {
				dynamicMailSender.setPort(Integer.parseInt(centralConfig.getEmailSmtpPort().trim()));
			} else {
				dynamicMailSender.setPort(587);
			}
		} catch (NumberFormatException e) {
			dynamicMailSender.setPort(587);
		}

		dynamicMailSender.setUsername(centralConfig.getEmailSmtpUsername());
		dynamicMailSender.setPassword(centralConfig.getEmailSmtpPassword());

		java.util.Properties props = dynamicMailSender.getJavaMailProperties();
		props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");

		try {
			dynamicMailSender.testConnection();
		} catch (Exception e) {
			throw new org.springframework.mail.MailSendException("SMTP connection test failed. Please check your credentials and host.", e);
		}

		return dynamicMailSender;
	}
	// ===== AI MODIFICATION END =====

	@Autowired
	private EmailConfig emailConfig;

	@Autowired
	private ServletContext servletContext;
	/*
	 * @Autowired
	 * private SimpleMailMessage preConfiguredMessage;
	 */

	@Autowired
	private SettingsAndOtherServicesImpl settingService;

	// ===== AI MODIFICATION START =====
	// Change: Email From, Notify BCC, and Reply-To now read from DB only (no
	// fallback)
	// Reason: User wants email configuration handled entirely via frontend
	// Scope: EmailServiceImpl - dynamic configuration from Communication Channels >
	// Email Config

	// COMMENTED OUT: application.properties @Value fields no longer used as
	// fallback
	// @Value("${email.client.from}")
	// private String systemEmailFrom;

	// @Value("${email.notify.communication.email}")
	// private String emailNotifyBcc;

	// @Value("${email.reply.to}")
	// private String replyToEmail;

	@Autowired
	private Configuration freemarkerConfig;

	private boolean isEmailNotifyActive() {
		com.vistaluxhms.model.EmailConfigEntityDTO config = settingService.getEmailConfig();
		return config != null && "true".equalsIgnoreCase(config.getEmailClientActive());
	}

	private boolean isInternalEmailNotifyActive() {
		com.vistaluxhms.model.EmailConfigEntityDTO config = settingService.getEmailConfig();
		return config != null && "true".equalsIgnoreCase(config.getEmailInternalActive());
	}

	@Autowired
	private EventConfigServicesImpl eventConfigService;

	// Helper methods to get email config values directly from DB (frontend config)
	private String getSystemEmailFrom() {
		com.vistaluxhms.model.EmailConfigEntityDTO config = settingService.getEmailConfig();
		String dbVal = config.getEmailFromAddress();
		return (dbVal != null) ? dbVal : "";
	}

	private String getEmailNotifyBcc() {
		com.vistaluxhms.model.EmailConfigEntityDTO config = settingService.getEmailConfig();
		String dbVal = config.getEmailNotifyTo();
		return (dbVal != null) ? dbVal : "";
	}

	private String getReplyToEmail() {
		com.vistaluxhms.model.EmailConfigEntityDTO config = settingService.getEmailConfig();
		String dbVal = config.getEmailReplyTo();
		return (dbVal != null) ? dbVal : "";
	}
	// ===== AI MODIFICATION END =====

	/**
	 * This method will send compose and send the message
	 */
    public void sendMail(String to, String subject, String body) {
        if (isEmailNotifyActive()) {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(getSystemEmailFrom());
            message.setTo(to);
            message.setSubject(subject);
            message.setText(body);

            List<String> bccList = getMergedBccEmailStrings();
            if (bccList != null && !bccList.isEmpty()) {
                message.setBcc(bccList.toArray(new String[0]));
            }

            getJavaMailSender().send(message);
        }
    }

	/**
	 * This method will send compose and send the message
	 */
    public void sendMail(String to, String from, String subject, String body) {
        if (isEmailNotifyActive()) {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(from);
            message.setTo(to);
            message.setSubject(subject);
            message.setText(body);

            List<String> bccList = getMergedBccEmailStrings();
            if (bccList != null && !bccList.isEmpty()) {
                message.setBcc(bccList.toArray(new String[0]));
            }

            getJavaMailSender().send(message);
        }
    }

	/**
	 * This method will send a pre-configured message
	 * 
	 * public void sendPreConfiguredMail(String message)
	 * {
	 * SimpleMailMessage mailMessage = new SimpleMailMessage(preConfiguredMessage);
	 * mailMessage.setText(message);
	 * getJavaMailSender().send(mailMessage);
	 * }
	 */

	public void sendMailWithAttachment(EmailMessageVO emailMessageVo, ArrayList filtToAttach) throws MailException {
		MimeMessagePreparator preparator = new MimeMessagePreparator() {
			public void prepare(MimeMessage mimeMessage) throws Exception {
				// mimeMessage.setRecipient(Message.RecipientType.TO, new
				// InternetAddress(emailMessageVo.getEmailToList()));

                InternetAddress[] mergedBcc = getMergedBccAddresses();
                if (mergedBcc != null && mergedBcc.length > 0) {
                    mimeMessage.setRecipients(Message.RecipientType.BCC, mergedBcc);
                }

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
                mimeMessage.setFrom(new InternetAddress(getSystemEmailFrom()));
				mimeMessage.setSubject(emailMessageVo.getEmailSubject());
				mimeMessage.setText(emailMessageVo.getEmailMessage());
				MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
				// attachFiles(filtToAttach,helper );

				for (Object aName : filtToAttach) {
					File file = new File((String) aName);
					FileSystemResource fr = new FileSystemResource(file);
					helper.addAttachment(file.getName(), fr);
				}
				helper.setText(emailMessageVo.getEmailMessage());
			}
		};
		getJavaMailSender().send(preparator);
	}

	private void attachFiles(ArrayList fileToAttach, MimeMessageHelper helper) {
		Iterator itrToFilesAttach = fileToAttach.iterator();
		while (itrToFilesAttach.hasNext()) {
			FileSystemResource file = new FileSystemResource(new File((String) itrToFilesAttach.next()));
			try {
				System.out.println("ATTACHING: " + file.getFile().getPath());
				helper.addAttachment(file.getFilename(), file);
			} catch (MessagingException e) {
				// TODO Auto-generated catch block
				logger.error("Exception caught", e);
			}
		}

		/*
		 * for(int i=0;i<UdanChooConstants.UDN_SRV_SUPP_NAME_LIST.size();i++) {
		 * if(UdanChooConstants.UDN_SRV_SUPP_NAME_LIST.get(i).toString().
		 * equalsIgnoreCase(UdanChooConstants.UDN_FLT_SRV_SUPP_NAME) &&
		 * (!fileUploaderListVo.getFlightFilesList().isEmpty())) {
		 * Iterator itr = fileUploaderListVo.getFlightFilesList().iterator();
		 * while(itr.hasNext()) {
		 * String fileName=(String) itr.next();
		 * logger.debug("File Name is " + fileName);
		 * Path directoryPath = Paths.get(fileStorageService.getFileStorageLocation() +
		 * "\\" + fileUploaderListVo.getDealConfirmationId() +"
		 * \\" + UdanChooConstants.UDN_FLT_SRV_SUPP_NAME + "\\" + fileName);
		 * logger.debug("Attaching File " + directoryPath);
		 * FileSystemResource file = new FileSystemResource(new
		 * File(directoryPath.toString()));
		 * helper.addAttachment(file.getFilename(),file);
		 * }
		 * }
		 * }
		 */
	}

	// ===== AI MODIFICATION START =====
	// Change: Removed @Async
	// Reason: Allow synchronous execution so caller can catch MailSendException if
	// config is invalid
	// Scope: Email quotation sending - error handling
	// @Async
	// ===== AI MODIFICATION END =====
	public void sendEmailMessageUsingTemplate(Mail mail, String templateName)
			throws MessagingException, IOException, TemplateException {
		freemarkerConfig.setClassForTemplateLoading(this.getClass(), "/templates");
		// freemarkerConfig.setDirectoryForTemplateLoading(new
		// File(this.fileStorageLocation.get"));
		freemarkerConfig.setSetting(Configurable.NUMBER_FORMAT_KEY, "computer");
		freemarkerConfig.setTemplateUpdateDelay(0);
		// mail.setFrom(systemEmailFrom); // COMMENTED: was hardcoded from
		// application.properties
		String systemEmailFrom = getSystemEmailFrom();
		
		try {
			InternetAddress[] addrs = InternetAddress.parse(systemEmailFrom, true); 
			for (InternetAddress addr : addrs) {
				String e = addr.getAddress();
				if (e == null || !e.contains("@") || !e.contains(".")) {
					throw new org.springframework.mail.MailSendException("Invalid Sender Email Format");
				}
			}
		} catch (Exception e) {
			throw new org.springframework.mail.MailSendException("Failed to send email: The 'From Address' is invalid or not correctly structured.");
		}


		mail.setFrom(systemEmailFrom); // Now reads from DB (frontend config)
		MimeMessage message = getJavaMailSender().createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message,
				MimeMessageHelper.MULTIPART_MODE_MIXED_RELATED,
				StandardCharsets.UTF_8.name());

		CentralConfigEntityDTO centralConfigEntity = settingService.getCentralConfig();
		// String logoUrl = centralConfigEntity.getBaseUrl() +
		// "/resources/images/ashoka_logo.jpg";
// ===== AI MODIFICATION START =====
// Change: Build an absolute URL for the logo in emails if a relative image path is used
// Reason: Email clients require fully qualified URLs to render images properly
// Scope: Email generation context
		String logoPath = centralConfigEntity.getLogoPath();
		if (logoPath != null && logoPath.startsWith("/resources")) {
			String baseUrl = centralConfigEntity.getBaseUrl();
			if (baseUrl != null && baseUrl.endsWith("/")) {
				logoPath = baseUrl.substring(0, baseUrl.length() - 1) + logoPath;
			} else if (baseUrl != null) {
				logoPath = baseUrl + logoPath;
			}
		}
		mail.getModel().put("logoUrl", logoPath);
// ===== AI MODIFICATION END =====
		mail.getModel().put("escalationEmail", centralConfigEntity.getEscalationEmail());
		mail.getModel().put("escalationPhone", centralConfigEntity.getEscalationPhone());
		mail.getModel().put("centralNumber", centralConfigEntity.getCentralNumber());
		mail.getModel().put("website", centralConfigEntity.getWebsite());
		mail.getModel().put("facebook", centralConfigEntity.getFacebookLink());
		mail.getModel().put("instagram", centralConfigEntity.getInstagramLink());
		mail.getModel().put("linkedin", centralConfigEntity.getLinkedinLink());
		mail.getModel().put("youtube", centralConfigEntity.getYoutubeLink());
		mail.getModel().put("companyName", centralConfigEntity.getCompanyName());
		// If you have any inline image then following code needs to be commented and
		// add
		// cid:udanchoo.png as placeholer in the ftl template. Dont forget that
		// image files location for ftl template is different.
		/*
		 * File fileRes = ResourceUtils.getFile(ftlTemplateImagePath + File.separator +
		 * "tglogo.png");
		 * //System.out.println("Path isss " + fileRes.getAbsolutePath());
		 * helper.addAttachment("udanchoo.png", fileRes);
		 */
		mail.getModel().put("logoCid", "ashokaLogo");

		Template template = freemarkerConfig.getTemplate(templateName);
		String html = FreeMarkerTemplateUtils.processTemplateIntoString(template, mail.getModel());

		helper.setTo(mail.getTo());
		if (mail.getCc() != null && mail.getCc().trim().length() > 0) {
			helper.setCc(mail.getCc());
		}
		// COMMENTED: was using hardcoded emailNotifyBcc from application.properties
		// if (emailNotifyBcc != null && emailNotifyBcc.trim().length() > 0) {
		// List<String> emailListWaterBcc = validateAndExtractEmails(emailNotifyBcc);
        InternetAddress[] mergedBcc = getMergedBccAddresses();
        if (mergedBcc != null && mergedBcc.length > 0) {
            helper.setBcc(mergedBcc);
        }
		helper.setText(html, true);
		helper.setSubject(mail.getSubject());
		helper.setFrom(mail.getFrom());
		// helper.setReplyTo(replyToEmail); // COMMENTED: was hardcoded from
		// application.properties
		helper.setReplyTo(getReplyToEmail()); // Now reads from DB (frontend config)

		getJavaMailSender().send(message);
	}

	// ===== AI MODIFICATION START =====
	// Change: Removed @Async
	// Reason: Allow synchronous execution so caller can catch MailSendException if
	// config is invalid
	// Scope: Email quotation sending - error handling
	// @Async
	// ===== AI MODIFICATION END =====
	public void sendEmailMessageUsingTemplate_MultipleRecipients(Mail mail, String templateName)
			throws MessagingException, IOException, TemplateException {
		CentralConfigEntityDTO centralConfigEntity = settingService.getCentralConfig();
		String eventType;

		if (mail.getModel().get("eventType") != null)
			eventType = mail.getModel().get("eventType").toString();
		else
			eventType = "wedding";

		EventDetailsConfigDTO eventDetailsConfigDTO = eventConfigService.getEventDetails(eventType);
		// String logoUrl = centralConfigEntity.getBaseUrl() +
		// "/resources/images/ashoka_logo.jpg";
// ===== AI MODIFICATION START =====
// Change: Build an absolute URL for the logo in emails if a relative image path is used
// Reason: Email clients require fully qualified URLs to render images properly
// Scope: Email generation context
		String logoPath = centralConfigEntity.getLogoPath();
		if (logoPath != null && logoPath.startsWith("/resources")) {
			String baseUrl = centralConfigEntity.getBaseUrl();
			if (baseUrl != null && baseUrl.endsWith("/")) {
				logoPath = baseUrl.substring(0, baseUrl.length() - 1) + logoPath;
			} else if (baseUrl != null) {
				logoPath = baseUrl + logoPath;
			}
		}
		mail.getModel().put("logoUrl", logoPath);
// ===== AI MODIFICATION END =====
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
		mail.getModel().put("serviceAdvisorMobile", centralConfigEntity.getCentralNumber());

		/*
		 * mail.getModel().put("quotationTopCover",
		 * centralConfigEntity.getQuotationTopCover());
		 * mail.getModel().put("inclusions", centralConfigEntity.getInclusions());
		 * mail.getModel().put("tnc", centralConfigEntity.getTnc());
		 */

		freemarkerConfig.setClassForTemplateLoading(this.getClass(), "/templates");
		// freemarkerConfig.setDirectoryForTemplateLoading(new
		// File(this.fileStorageLocation.get"));
		freemarkerConfig.setSetting(Configurable.NUMBER_FORMAT_KEY, "computer");
		freemarkerConfig.setAPIBuiltinEnabled(true);

		freemarkerConfig.setTemplateUpdateDelay(0);
		String systemEmailFrom = getSystemEmailFrom();

		try {
			InternetAddress[] addrs = InternetAddress.parse(systemEmailFrom, true); 
			for (InternetAddress addr : addrs) {
				String e = addr.getAddress();
				if (e == null || !e.contains("@") || !e.contains(".")) {
					throw new org.springframework.mail.MailSendException("Invalid Sender Email Format");
				}
			}
		} catch (Exception e) {
			throw new org.springframework.mail.MailSendException("Failed to send email: The 'From Address' is invalid or not correctly structured.");
		}

		// mail.setFrom(systemEmailFrom); // COMMENTED: was hardcoded from
		// application.properties
		mail.setFrom(systemEmailFrom); // Now reads from DB (frontend config)
		MimeMessage message = getJavaMailSender().createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message,
				MimeMessageHelper.MULTIPART_MODE_MIXED_RELATED,
				StandardCharsets.UTF_8.name());

		// If you have any inline image then following code needs to be commented and
		// add
		// cid:udanchoo.png as placeholer in the ftl template. Dont forget that
		// image files location for ftl template is different.
		/*
		 * File fileRes = ResourceUtils.getFile(ftlTemplateImagePath + File.separator +
		 * "tglogo.png");
		 * //System.out.println("Path isss " + fileRes.getAbsolutePath());
		 * helper.addAttachment("udanchoo.png", fileRes);
		 */

		Template template = freemarkerConfig.getTemplate(templateName);
		String html = FreeMarkerTemplateUtils.processTemplateIntoString(template, mail.getModel());

		helper.setTo(mail.getToList());
		/* helper.setCc(mail.getCcList()); */
		// COMMENTED: was using hardcoded emailNotifyBcc from application.properties
		// if (emailNotifyBcc != null && emailNotifyBcc.trim().length() > 0) {
		// List<String> emailListWaterBcc = validateAndExtractEmails(emailNotifyBcc);
        InternetAddress[] mergedBcc = getMergedBccAddresses();
        if (mergedBcc != null && mergedBcc.length > 0) {
            helper.setBcc(mergedBcc);
        }
		helper.setText(html, true);
		helper.setSubject(mail.getSubject());
		helper.setFrom(mail.getFrom());
		// helper.setReplyTo(replyToEmail); // COMMENTED: was hardcoded from
		// application.properties
		helper.setReplyTo(getReplyToEmail()); // Now reads from DB (frontend config)
		getJavaMailSender().send(message);
	}

	private List<String> validateAndExtractEmails(String emailInput) {
		List<String> emailList = parseEmails(emailInput);

		if (emailList.isEmpty()) {
			logger.debug("Watcher Not Defined in Configuration. ");
		}

		return emailList;
	}

	private boolean isValidEmail(String email) {
		String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
		return email.matches(emailRegex);
	}

	/*
	 * public void sendB2bEmailMessageUsingTemplate_MultipleRecipients(Mail
	 * mail,String templateName) throws MessagingException, IOException,
	 * TemplateException {
	 * freemarkerConfig.setClassForTemplateLoading(this.getClass(), "/templates");
	 * //freemarkerConfig.setDirectoryForTemplateLoading(new
	 * File(this.fileStorageLocation.get"));
	 * freemarkerConfig.setSetting(Configurable.NUMBER_FORMAT_KEY, "computer");
	 * freemarkerConfig.setAPIBuiltinEnabled(true);
	 * freemarkerConfig.setTemplateUpdateDelay(0);
	 * MimeMessage message = getJavaMailSender().createMimeMessage();
	 * MimeMessageHelper helper = new
	 * MimeMessageHelper(message,MimeMessageHelper.MULTIPART_MODE_MIXED_RELATED,
	 * StandardCharsets.UTF_8.name());
	 * Template template = freemarkerConfig.getTemplate(templateName);
	 * String html = FreeMarkerTemplateUtils.processTemplateIntoString(template,
	 * mail.getModel());
	 * helper.setTo(mail.getToList());
	 * helper.setCc(mail.getCcList());
	 * if(emailNotifyBcc!=null && emailNotifyBcc.trim().length()>0) {
	 * helper.setBcc(emailNotifyBcc);
	 * }
	 * helper.setText(html, true);
	 * helper.setSubject(mail.getSubject());
	 * helper.setFrom(b2BEmailFrom);
	 * //getJavaMailSender().send(message);
	 * emailConfig.getB2bJavaMailSender().send(message);
	 * }
	 */

	public void sendEmailMessageUsingTemplate_MultipleRecipients_from_loggedInUser(Mail mail, String templateName,
			String emailFrom) throws MessagingException, IOException, TemplateException {
		freemarkerConfig.setClassForTemplateLoading(this.getClass(), "/templates");
		// freemarkerConfig.setDirectoryForTemplateLoading(new
		// File(this.fileStorageLocation.get"));
		freemarkerConfig.setSetting(Configurable.NUMBER_FORMAT_KEY, "computer");
		freemarkerConfig.setAPIBuiltinEnabled(true);

		freemarkerConfig.setTemplateUpdateDelay(0);
		mail.setFrom(emailFrom);
		MimeMessage message = getJavaMailSender().createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message,
				MimeMessageHelper.MULTIPART_MODE_MIXED_RELATED,
				StandardCharsets.UTF_8.name());

		// If you have any inline image then following code needs to be commented and
		// add
		// cid:udanchoo.png as placeholer in the ftl template. Dont forget that
		// image files location for ftl template is different.
		/*
		 * File fileRes = ResourceUtils.getFile(ftlTemplateImagePath + File.separator +
		 * "tglogo.png");
		 * //System.out.println("Path isss " + fileRes.getAbsolutePath());
		 * helper.addAttachment("udanchoo.png", fileRes);
		 */

		Template template = freemarkerConfig.getTemplate(templateName);
		String html = FreeMarkerTemplateUtils.processTemplateIntoString(template, mail.getModel());

		helper.setTo(mail.getToList());
		helper.setCc(mail.getCcList());

		// COMMENTED: was using hardcoded emailNotifyBcc from application.properties
		// if (emailNotifyBcc != null && emailNotifyBcc.trim().length() > 0) {
		// helper.setBcc(emailNotifyBcc);
        InternetAddress[] mergedBcc = getMergedBccAddresses();
        if (mergedBcc != null && mergedBcc.length > 0) {
            helper.setBcc(mergedBcc);
        }
		helper.setText(html, true);
		helper.setSubject(mail.getSubject());
		helper.setFrom(mail.getFrom());

		getJavaMailSender().send(message);
	}

	/*
	 * public void
	 * sendEmailMessage_Notification1_MultipleRecipients_from_loggedInUser(Mail
	 * mail,String emailBody,String emailFrom) throws MessagingException,
	 * IOException, TemplateException {
	 * 
	 * if(emailNotifyActive && internalEmailNotifyActive) {
	 * Session session = emailConfig.getNotification1EmailSessionSender();
	 * MimeMessage message = new MimeMessage(session);
	 * message.setFrom(new InternetAddress(emailFrom));
	 * message.setRecipients(Message.RecipientType.TO, mail.getToList());
	 * if(emailNotifyBcc!=null && emailNotifyBcc.trim().length()>0) {
	 * message.setRecipients(Message.RecipientType.BCC, emailNotifyBcc);
	 * }
	 * message.setSubject(mail.getSubject());
	 * message.setText(emailBody);
	 * Transport.send(message);
	 * }
	 * }
	 */

	public void sendEmailMessage_Notification1_MultipleRecipients_from_loggedInUser(Mail mail, String emailBody,
			String emailFrom) throws MessagingException, IOException, TemplateException {

		if (isEmailNotifyActive() && isInternalEmailNotifyActive()) {
			MimeMessage message = getJavaMailSender().createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message);
			message.setFrom(new InternetAddress(emailFrom));
			message.setRecipients(Message.RecipientType.TO, mail.getToList());
			// COMMENTED: was using hardcoded emailNotifyBcc from application.properties
			// if (emailNotifyBcc != null && emailNotifyBcc.trim().length() > 0) {
			// message.setRecipients(Message.RecipientType.BCC, emailNotifyBcc);
            InternetAddress[] mergedBcc = getMergedBccAddresses();
            if (mergedBcc != null && mergedBcc.length > 0) {
                message.setRecipients(Message.RecipientType.BCC, mergedBcc);
            }
			message.setSubject(mail.getSubject());
			message.setText(emailBody);
			getJavaMailSender().send(message);
		}
	}

	/**
	 * Send mail to multiple recipients (comma or semicolon separated).
	 */
	public void sendMailToMultipleRecipients(String emailList, String subject, String body) {
		if (!isEmailNotifyActive()) {
			logger.debug("Email notifications are disabled.");
			return;
		}

		List<String> recipients = validateAndExtractEmails(emailList);
		if (recipients.isEmpty()) {
			logger.debug("No valid email addresses found.");
			return;
		}

        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(getSystemEmailFrom());
            message.setTo(recipients.toArray(new String[0]));
            message.setSubject(subject);
            message.setText(body);

			List<String> bccList = getMergedBccEmailStrings();
			if (bccList != null && !bccList.isEmpty()) {
				message.setBcc(bccList.toArray(new String[0]));
			}

			getJavaMailSender().send(message);
			logger.debug("Email sent to: " + recipients);

		} catch (Exception e) {
			logger.error("Exception caught", e);
			logger.debug("Failed to send email: " + e.getMessage());
		}
	}

	public void sendMailWithHtml(String to, String subject, String htmlBody) {
		if (isEmailNotifyActive()) {
			try {
				MimeMessage message = getJavaMailSender().createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
				// helper.setFrom(systemEmailFrom); // COMMENTED: was hardcoded from
				// application.properties
				helper.setFrom(getSystemEmailFrom()); // Now reads from DB (frontend config)
				// helper.setReplyTo(replyToEmail); // COMMENTED: was hardcoded from
				// application.properties
				helper.setReplyTo(getReplyToEmail()); // Now reads from DB (frontend config)
				helper.setTo(to.split("[,;]")); // handles multiple emails separated by , or ;
				// COMMENTED: was using hardcoded emailNotifyBcc from application.properties
				// if (emailNotifyBcc != null && emailNotifyBcc.trim().length() > 0) {
				// message.setRecipients(Message.RecipientType.BCC, emailNotifyBcc);
                InternetAddress[] mergedBcc = getMergedBccAddresses();
                if (mergedBcc != null && mergedBcc.length > 0) {
                    message.setRecipients(Message.RecipientType.BCC, mergedBcc);
                }
				helper.setSubject(subject);
				helper.setText(htmlBody, true); // true = HTML content
				getJavaMailSender().send(message);
			} catch (MessagingException e) {
				logger.error("Exception caught", e);
			}
		}
	}

    private List<String> parseEmails(String emailInput) {
        List<String> emailList = new ArrayList<>();

        if (emailInput != null && !emailInput.trim().isEmpty()) {
            // Supports comma, semicolon, new line
            String[] emails = emailInput.split("[,;\\n\\r]+");
            for (String email : emails) {
                email = email.trim();
                if (!email.isEmpty() && isValidEmail(email)) {
                    emailList.add(email);
                } else if (!email.isEmpty()) {
                    System.out.println("Invalid email skipped: " + email);
                }
            }
        }

        return emailList;
    }

    private List<String> getCentralConfigWatcherEmails() {
        List<String> watcherEmails = new ArrayList<>();

        try {
            CentralConfigEntityDTO centralConfig = settingService.getCentralConfig();

            if (centralConfig != null
                    && centralConfig.isGlobalWatcherEnabled()
                    && centralConfig.getGlobalWatcherEmails() != null
                    && !centralConfig.getGlobalWatcherEmails().trim().isEmpty()) {

                watcherEmails.addAll(parseEmails(centralConfig.getGlobalWatcherEmails()));
            }
        } catch (Exception e) {
            System.out.println("Unable to load Central Config Global Watcher Emails: " + e.getMessage());
        }

        return watcherEmails;
    }

    private InternetAddress[] getMergedBccAddresses() {
        java.util.LinkedHashSet<String> mergedEmails = new java.util.LinkedHashSet<>();

        // 1. Email Config BCC / Notify To
        String emailConfigBcc = getEmailNotifyBcc();
        if (emailConfigBcc != null && !emailConfigBcc.trim().isEmpty()) {
            mergedEmails.addAll(parseEmails(emailConfigBcc));
        }

        // 2. Central Config Global Watcher Emails (if enabled)
        mergedEmails.addAll(getCentralConfigWatcherEmails());

        if (mergedEmails.isEmpty()) {
            return null;
        }

        List<InternetAddress> addresses = new ArrayList<>();
        for (String email : mergedEmails) {
            try {
                addresses.add(new InternetAddress(email));
            } catch (AddressException e) {
                System.out.println("Invalid BCC email skipped: " + email);
            }
        }

        if (addresses.isEmpty()) {
            return null;
        }

        return addresses.toArray(new InternetAddress[0]);
    }

    private List<String> getMergedBccEmailStrings() {
        java.util.LinkedHashSet<String> mergedEmails = new java.util.LinkedHashSet<>();

        // 1. Email Config BCC / Notify To
        String emailConfigBcc = getEmailNotifyBcc();
        if (emailConfigBcc != null && !emailConfigBcc.trim().isEmpty()) {
            mergedEmails.addAll(parseEmails(emailConfigBcc));
        }

        // 2. Central Config Global Watcher Emails (if enabled)
        mergedEmails.addAll(getCentralConfigWatcherEmails());

        return new ArrayList<>(mergedEmails);
    }

}
