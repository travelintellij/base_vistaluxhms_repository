package com.vistaluxhms.services;

import com.vistaluxhms.entity.CentralConfigEntity;
import com.vistaluxhms.entity.EmailConfigEntity;
import com.vistaluxhms.entity.WhatsAppConfigEntity;
import com.vistaluxhms.model.CentralConfigEntityDTO;
import com.vistaluxhms.model.EmailConfigEntityDTO;
import com.vistaluxhms.model.WhatsAppConfigEntityDTO;
import com.vistaluxhms.repository.CentralConfigEntityRepository;
import com.vistaluxhms.repository.EmailConfigRepository;
import com.vistaluxhms.repository.WhatsAppConfigRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class SettingsAndOtherServicesImpl {

	@Autowired
	private CentralConfigEntityRepository centralConfigRepository;

	@Autowired
	private EmailConfigRepository emailConfigRepository;

	@Autowired
	private WhatsAppConfigRepository whatsAppConfigRepository;

	// =============== CENTRAL CONFIG ===============

	public CentralConfigEntityDTO getCentralConfig() {
		return Optional.ofNullable(centralConfigRepository.findTopByOrderByIdAsc())
				.map(this::convertEntityToDTO)
				.orElse(new CentralConfigEntityDTO());
	}

	public void saveOrUpdateCentralConfig(CentralConfigEntityDTO dto) {
		CentralConfigEntity entity;
		Optional<CentralConfigEntity> existingOpt = centralConfigRepository.findAll()
				.stream()
				.findFirst();

		if (existingOpt.isPresent()) {
			entity = existingOpt.get(); // Update existing record
		} else {
			entity = new CentralConfigEntity(); // Create new record
		}

		entity.setHotelName(dto.getHotelName());
		entity.setHotelAddress(dto.getHotelAddress());
		entity.setCentralNumber(dto.getCentralNumber());
		entity.setBankName(dto.getBankName());
		entity.setAccountNumber(dto.getAccountNumber());
		entity.setIfscCode(dto.getIfscCode());
		entity.setBranch(dto.getBranch());
		entity.setGlobalWatcherEmails(dto.getGlobalWatcherEmails());
		entity.setGlobalWatcherEnabled(dto.isGlobalWatcherEnabled());
		entity.setCentralizedEmail(dto.getCentralizedEmail());
		entity.setGstNumber(dto.getGstNumber());
		entity.setFacebookLink(dto.getFacebookLink());
		entity.setInstagramLink(dto.getInstagramLink());
		entity.setLinkedinLink(dto.getLinkedinLink());
		entity.setYoutubeLink(dto.getYoutubeLink());
		entity.setxLink(dto.getxLink());
		entity.setLogoPath(dto.getLogoPath());
		entity.setBaseUrl(dto.getBaseUrl());
		entity.setEscalationEmail(dto.getEscalationEmail());
		entity.setEscalationPhone(dto.getEscalationPhone());
		entity.setWebsite(dto.getWebsite());
		entity.setAccountName(dto.getAccountName());
		entity.setCompanyName(dto.getCompanyName());
		entity.setTnc(dto.getTnc());
		entity.setQuotationTopCover(dto.getQuotationTopCover());
		entity.setInclusions(dto.getInclusions());
		entity.setUsp(dto.getUsp());
		entity.setHotelInfo(dto.getHotelInfo());

		centralConfigRepository.save(entity);
	}

	private CentralConfigEntityDTO convertEntityToDTO(CentralConfigEntity entity) {
		CentralConfigEntityDTO dto = new CentralConfigEntityDTO();
		dto.setHotelName(entity.getHotelName());
		dto.setHotelAddress(entity.getHotelAddress());
		dto.setCentralNumber(entity.getCentralNumber());
		dto.setBankName(entity.getBankName());
		dto.setAccountNumber(entity.getAccountNumber());
		dto.setIfscCode(entity.getIfscCode());
		dto.setBranch(entity.getBranch());
		dto.setGlobalWatcherEmails(entity.getGlobalWatcherEmails());
		dto.setGlobalWatcherEnabled(entity.isGlobalWatcherEnabled());
		dto.setCentralizedEmail(entity.getCentralizedEmail());
		dto.setGstNumber(entity.getGstNumber());
		dto.setFacebookLink(entity.getFacebookLink());
		dto.setInstagramLink(entity.getInstagramLink());
		dto.setLinkedinLink(entity.getLinkedinLink());
		dto.setYoutubeLink(entity.getYoutubeLink());
		dto.setxLink(entity.getxLink());
		dto.setBaseUrl(entity.getBaseUrl());
		dto.setEscalationEmail(entity.getEscalationEmail());
		dto.setEscalationPhone(entity.getEscalationPhone());
		dto.setWebsite(entity.getWebsite());
		dto.setLogoPath(entity.getLogoPath());
		dto.setAccountName(entity.getAccountName());
		dto.setCompanyName(entity.getCompanyName());
		dto.setTnc(entity.getTnc());
		dto.setQuotationTopCover(entity.getQuotationTopCover());
		dto.setInclusions(entity.getInclusions());
		dto.setUsp(entity.getUsp());
		dto.setHotelInfo(entity.getHotelInfo());
		return dto;
	}

	// =============== EMAIL CONFIG ===============

	public EmailConfigEntityDTO getEmailConfig() {
		return Optional.ofNullable(emailConfigRepository.findTopByOrderByIdAsc())
				.map(this::convertEmailEntityToDTO)
				.orElse(new EmailConfigEntityDTO());
	}

	public void saveOrUpdateEmailConfig(EmailConfigEntityDTO dto) {
		EmailConfigEntity entity = Optional.ofNullable(emailConfigRepository.findTopByOrderByIdAsc())
				.orElse(new EmailConfigEntity());

		entity.setEmailSmtpHost(dto.getEmailSmtpHost());
		entity.setEmailSmtpPort(dto.getEmailSmtpPort());
		entity.setEmailSmtpUsername(dto.getEmailSmtpUsername());
		entity.setEmailSmtpPassword(dto.getEmailSmtpPassword());
		entity.setEmailFromAddress(dto.getEmailFromAddress());
		entity.setEmailReplyTo(dto.getEmailReplyTo());
		entity.setEmailDefaultCc(dto.getEmailDefaultCc());
		entity.setEmailNotifyTo(dto.getEmailNotifyTo());
		entity.setEmailClientActive(dto.getEmailClientActive());
		entity.setEmailInternalActive(dto.getEmailInternalActive());

		emailConfigRepository.save(entity);
	}

	private EmailConfigEntityDTO convertEmailEntityToDTO(EmailConfigEntity entity) {
		EmailConfigEntityDTO dto = new EmailConfigEntityDTO();
		dto.setEmailSmtpHost(entity.getEmailSmtpHost());
		dto.setEmailSmtpPort(entity.getEmailSmtpPort());
		dto.setEmailSmtpUsername(entity.getEmailSmtpUsername());
		dto.setEmailSmtpPassword(entity.getEmailSmtpPassword());
		dto.setEmailFromAddress(entity.getEmailFromAddress());
		dto.setEmailReplyTo(entity.getEmailReplyTo());
		dto.setEmailDefaultCc(entity.getEmailDefaultCc());
		dto.setEmailNotifyTo(entity.getEmailNotifyTo());
		dto.setEmailClientActive(entity.getEmailClientActive());
		dto.setEmailInternalActive(entity.getEmailInternalActive());
		return dto;
	}

	// =============== WHATSAPP CONFIG ===============

	public WhatsAppConfigEntityDTO getWhatsAppConfig() {
		return Optional.ofNullable(whatsAppConfigRepository.findTopByOrderByIdAsc())
				.map(this::convertWhatsAppEntityToDTO)
				.orElse(new WhatsAppConfigEntityDTO());
	}

	public void saveOrUpdateWhatsAppConfig(WhatsAppConfigEntityDTO dto) {
		WhatsAppConfigEntity entity = Optional.ofNullable(whatsAppConfigRepository.findTopByOrderByIdAsc())
				.orElse(new WhatsAppConfigEntity());

		entity.setWhatsAppApiUrl(dto.getWhatsAppApiUrl());
		entity.setWhatsAppApiKey(dto.getWhatsAppApiKey());
		entity.setWhatsAppRegistrationTemplateId(dto.getWhatsAppRegistrationTemplateId());
		entity.setWhatsAppStayQuotationTemplateId(dto.getWhatsAppStayQuotationTemplateId());
		entity.setWhatsAppGuestQuotationTemplateId(dto.getWhatsAppGuestQuotationTemplateId());

		whatsAppConfigRepository.save(entity);
	}

	private WhatsAppConfigEntityDTO convertWhatsAppEntityToDTO(WhatsAppConfigEntity entity) {
		WhatsAppConfigEntityDTO dto = new WhatsAppConfigEntityDTO();
		dto.setWhatsAppApiUrl(entity.getWhatsAppApiUrl());
		dto.setWhatsAppApiKey(entity.getWhatsAppApiKey());
		dto.setWhatsAppRegistrationTemplateId(entity.getWhatsAppRegistrationTemplateId());
		dto.setWhatsAppStayQuotationTemplateId(entity.getWhatsAppStayQuotationTemplateId());
		dto.setWhatsAppGuestQuotationTemplateId(entity.getWhatsAppGuestQuotationTemplateId());
		return dto;
	}

}
