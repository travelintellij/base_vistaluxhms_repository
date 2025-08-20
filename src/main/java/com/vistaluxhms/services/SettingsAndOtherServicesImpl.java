package com.vistaluxhms.services;

import com.vistaluxhms.entity.CentralConfigEntity;
import com.vistaluxhms.entity.StatusEntity;
import com.vistaluxhms.model.CentralConfigEntityDTO;
import com.vistaluxhms.repository.CentralConfigEntityRepository;
import com.vistaluxhms.repository.StatusRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class SettingsAndOtherServicesImpl {

	@Autowired
	private CentralConfigEntityRepository centralConfigRepository;

	/**
	 * Fetch the existing central config (only 1 record is expected)
	 */
	public CentralConfigEntityDTO getCentralConfig() {
		return Optional.ofNullable(centralConfigRepository.findTopByOrderByIdAsc())
				.map(this::convertEntityToDTO)
				.orElse(new CentralConfigEntityDTO());
	}

	/**
	 * Save or update central configuration (overrides existing record)
	 */
	public void saveOrUpdateCentralConfig(CentralConfigEntityDTO dto) {
		CentralConfigEntity entity;

		// Check if record exists (only one is allowed)
		Optional<CentralConfigEntity> existingOpt = centralConfigRepository.findAll()
				.stream()
				.findFirst();

		if (existingOpt.isPresent()) {
			entity = existingOpt.get(); // Update existing record
		} else {
			entity = new CentralConfigEntity(); // Create new record
		}

		// Convert DTO -> Entity
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
		entity.setLogoPath(dto.getLogoPath());
		entity.setAccountName(dto.getAccountName());
		entity.setCompanyName(dto.getCompanyName());
		entity.setTnc(dto.getTnc());
		entity.setQuotationTopCover(dto.getQuotationTopCover());
		entity.setInclusions(dto.getInclusions());
		centralConfigRepository.save(entity);
	}

	/**
	 * Convert Entity -> DTO
	 */
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
		//dto.setLogoFile(entity.getLogoFile());
		return dto;
	}


}
