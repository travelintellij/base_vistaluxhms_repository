package com.vistaluxhms.validator;

import com.vistaluxhms.entity.MyTravelClaimsEntity;
import com.vistaluxhms.model.LeadEntityDTO;
import com.vistaluxhms.model.MyTravelClaimForm;
import com.vistaluxhms.model.MyTravelClaimsDTO;
import com.vistaluxhms.services.ClientServicesImpl;
import com.vistaluxhms.services.VlxCommonServicesImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;
import org.springframework.web.multipart.MultipartFile;

@Component
public class MyTravelClaimsalidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return MyTravelClaimForm.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		MyTravelClaimForm form = (MyTravelClaimForm) target;

		MyTravelClaimsDTO claim = form.getClaim();
		MultipartFile[] files = form.getBills();

		if (claim.getExpenseStartDate() != null && claim.getExpenseEndDate() != null &&
				claim.getExpenseStartDate().after(claim.getExpenseEndDate())) {
			errors.rejectValue("claim.expenseStartDate", "invalid.dates", "Start Date must be before End Date.");
		}

		int totalExpense =
				safe(claim.getTravelExpense()) +
						safe(claim.getFoodExpense()) +
						safe(claim.getParkingExpense()) +
						safe(claim.getOtherExpense1()) +
						safe(claim.getOtherExpense2()) +
						safe(claim.getOtherExpense3());
		if (totalExpense <= 0) {
			errors.reject("claim.expenses", "At least one expense must be greater than zero.");
		}

		if (files != null) {
			if (files.length > 5) {
				errors.reject("bills", "You can upload up to 5 files.");
			}
			for (MultipartFile file : files) {
				if (file.getSize() > (5 * 1024 * 1024)) {
					errors.reject("bills", "Each file must be ≤ 5 MB.");
				}
			}
		}
	}

	private int safe(Integer val) {
		return val != null ? val : 0;
	}
 
}