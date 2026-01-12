package com.vistaluxhms.validator;

import com.vistaluxhms.entity.ClientEntity;
import com.vistaluxhms.entity.MasterRoomDetailsEntity;
import com.vistaluxhms.model.LeadEntityDTO;
import com.vistaluxhms.model.QuotationEntityDTO;
import com.vistaluxhms.model.QuotationRoomDetailsDTO;
import com.vistaluxhms.services.ClientServicesImpl;
import com.vistaluxhms.services.SalesRelatesServicesImpl;
import com.vistaluxhms.services.VlxCommonServicesImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Component
public class QuotationValidator implements Validator {

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
		QuotationEntityDTO quotationEntityDTO = (QuotationEntityDTO)target;
		isValidRoomDetails(quotationEntityDTO.getRoomDetails(),errors);
		validateOccupancy(quotationEntityDTO.getRoomDetails(),errors);
		validateClient(quotationEntityDTO,errors);
		/*
		if((leadRecorderVO.getClient()==null) || (!clientService.existsByClientIdAndClientName(leadRecorderVO.getClient().getClientId(), leadRecorderVO.getClientName()))) {
			errors.rejectValue("clientName", "contact.error");
		}
		if(leadRecorderVO.getAdults()==0) {
			errors.rejectValue("adults", "min.guest.error");
		}
		if(!(leadRecorderVO.isFit() || leadRecorderVO.isGroupEvent()|| leadRecorderVO.isMarriage() ||
				leadRecorderVO.isOthers() )) {
			errors.rejectValue("minOneserviceError", "min.one.service.error");
		}
		
		if(leadRecorderVO.getCheckOutDate().compareTo(leadRecorderVO.getCheckInDate()) <0) {
			errors.rejectValue("checkOutDate", "stay.start.end.error");
		}

		 */
		
	}


	private void validateOccupancy(List<QuotationRoomDetailsDTO> roomDetailsList, Errors errors) {
		List<MasterRoomDetailsEntity> listRoomType = salesService.findActiveRoomsList();

		for (int i = 0; i < roomDetailsList.size(); i++) {
			QuotationRoomDetailsDTO quotationRoomDetailsDTO = roomDetailsList.get(i);

			Optional<MasterRoomDetailsEntity> masterRoomEntity = listRoomType.stream()
					.filter(room -> room.getRoomCategoryId() == quotationRoomDetailsDTO.getRoomCategoryId())
					.findFirst();

			if (masterRoomEntity.isPresent()) {
				MasterRoomDetailsEntity masterRoomDetailsEntity = masterRoomEntity.get();
				if(quotationRoomDetailsDTO.getAdults()>masterRoomDetailsEntity.getStandardOccupancy()){
					errors.rejectValue("roomDetails[" + i + "].roomCategoryId", "error.roomDetails", "Standard Occupancy Exceeded.");
				}
				int quotationOccupancy = quotationRoomDetailsDTO.getAdults() + quotationRoomDetailsDTO.getExtraBed() + quotationRoomDetailsDTO.getChildWithBed();
				int childNoBed = quotationRoomDetailsDTO.getChildNoBed();
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


	private boolean isValidRoomDetails(List<QuotationRoomDetailsDTO> roomDetails, Errors errors) {
		boolean isValid = true;
		LocalDate today = LocalDate.now();



        if (roomDetails != null) {
			for (int i = 0; i < roomDetails.size(); i++) {
				QuotationRoomDetailsDTO room = roomDetails.get(i);

                if (room.getRoomCategoryId() <= 0) {
                    errors.rejectValue(
                            "roomDetails[" + i + "].roomCategoryId",
                            "error.roomDetails",
                            "Room Category is required."
                    );
                    isValid = false;
                }


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

	private boolean validateClient(QuotationEntityDTO quotationEntityDTO,Errors errors){
		if(quotationEntityDTO.getQuotationAudienceType()==1){
			if(quotationEntityDTO.getGuestId()==0){
				errors.rejectValue("guestName", "contact.error");
				return false;
			}
			else {
				ClientEntity clientEntity = clientService.findClientById(quotationEntityDTO.getGuestId());
				if (!clientEntity.getClientName().trim().equalsIgnoreCase(quotationEntityDTO.getGuestName().trim())) {
					System.out.println("Client Name is " + clientEntity.getClientName() + "--" + "Guest Name is " + quotationEntityDTO.getGuestName() );
					errors.rejectValue("guestName", "contact.error");
					return false;
				}
			}
		}
		return true;
	}


}

