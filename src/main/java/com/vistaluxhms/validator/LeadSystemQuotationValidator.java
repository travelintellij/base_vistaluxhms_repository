package com.vistaluxhms.validator;

import com.vistaluxhms.entity.ClientEntity;
import com.vistaluxhms.entity.LeadSystemQuotationEntity;
import com.vistaluxhms.entity.LeadSystemQuotationRoomDetailsEntity;
import com.vistaluxhms.entity.MasterRoomDetailsEntity;
import com.vistaluxhms.model.QuotationEntityDTO;
import com.vistaluxhms.model.QuotationRoomDetailsDTO;
import com.vistaluxhms.services.ClientServicesImpl;
import com.vistaluxhms.services.SalesRelatesServicesImpl;
import com.vistaluxhms.services.VlxCommonServicesImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Component
public class LeadSystemQuotationValidator implements Validator {

	@Autowired
	VlxCommonServicesImpl commonService;

	@Autowired
	SalesRelatesServicesImpl salesService;


	@Autowired
	ClientServicesImpl clientService;


	@Value("${ANY_ROOM_CHILD_NO_BED_ALLOWED}")
	private int ANY_ROOM_CHILD_NO_BED_ALLOWED;
	
	@Override
	public boolean supports(Class<?> clazz) {
		return QuotationEntityDTO.class.equals(clazz);	}

	//following code validates if the country code (String) matches with the country name.
	@Override
	public void validate(Object target, Errors errors) {
		LeadSystemQuotationEntity leadSystemQuotationEntity = (LeadSystemQuotationEntity)target;
		isValidRoomDetails(leadSystemQuotationEntity.getRoomDetails(),errors);
		validateOccupancy(leadSystemQuotationEntity.getRoomDetails(),errors);
	}

	private void validateOccupancy(List<LeadSystemQuotationRoomDetailsEntity> roomDetailsList, Errors errors) {
		List<MasterRoomDetailsEntity> listRoomType = salesService.findActiveRoomsList();

		for (int i = 0; i < roomDetailsList.size(); i++) {
			LeadSystemQuotationRoomDetailsEntity quotationRoomDetailsDTO = roomDetailsList.get(i);

			Optional<MasterRoomDetailsEntity> masterRoomEntity = listRoomType.stream()
					.filter(room -> room.getRoomCategoryId() == quotationRoomDetailsDTO.getRoomCategoryId())
					.findFirst();

			if (masterRoomEntity.isPresent()) {
				MasterRoomDetailsEntity masterRoomDetailsEntity = masterRoomEntity.get();
				if(quotationRoomDetailsDTO.getAdults()>masterRoomDetailsEntity.getStandardOccupancy()){
					errors.rejectValue("roomDetails[" + i + "].roomCategoryId", "error.roomDetails", "Standard Occupancy Exceeded.");
				}
				int quotationOccupancy = quotationRoomDetailsDTO.getAdults() + quotationRoomDetailsDTO.getExtraBed() + quotationRoomDetailsDTO.getCwb();
				int childNoBed = quotationRoomDetailsDTO.getCnb();
				if(quotationOccupancy>masterRoomDetailsEntity.getMaxOccupancy()){
					errors.rejectValue("roomDetails[" + i + "].roomCategoryId", "error.roomDetails", "Max Occupancy Exceeded.");
				}
				if(childNoBed>ANY_ROOM_CHILD_NO_BED_ALLOWED){
					errors.rejectValue("roomDetails[" + i + "].childNoBed", "error.roomDetails", "Child No Bed Exceeded.");
				}

				// Use the found room entity
			} else {
				errors.rejectValue("roomDetails[" + i + "].roomCategoryId", "error.roomDetails", "Room Category Not Found.");
			}
		}

	}


	private boolean isValidRoomDetails(List<LeadSystemQuotationRoomDetailsEntity> roomDetails, Errors errors) {
		boolean isValid = true;
		LocalDate today = LocalDate.now();

		if (roomDetails != null) {
			for (int i = 0; i < roomDetails.size(); i++) {
				LeadSystemQuotationRoomDetailsEntity room = roomDetails.get(i);

				// Validate Adults count
				if (room.getAdults() < 1) {
					errors.rejectValue("roomDetails[" + i + "].adults", "error.roomDetails", "Adults must be greater than zero.");
					isValid = false;
				}

				// Validate Check-in and Check-out dates
				LocalDate checkIn = room.getCheckInDate();
				LocalDate checkOut = room.getCheckOutDate();

				if (checkIn == null || checkOut == null) {
					errors.rejectValue("roomDetails[" + i + "].checkInDate", "error.roomDetails", "Check-in and Check-out dates are required.");
					isValid = false;
				} else {
					if (checkIn.isBefore(today)) {
						errors.rejectValue("roomDetails[" + i + "].checkInDate", "error.roomDetails", "Check-in date cannot be in the past.");
						isValid = false;
					}

					if (checkOut.isBefore(today)) {
						errors.rejectValue("roomDetails[" + i + "].checkOutDate", "error.roomDetails", "Check-out date cannot be in the past.");
						isValid = false;
					}

					if (checkOut.isBefore(checkIn)) {
						errors.rejectValue("roomDetails[" + i + "].checkOutDate", "error.roomDetails", "Check-out date must be the same or after Check-in date.");
						isValid = false;
					}
				}
			}
		}
		return isValid;
	}




}