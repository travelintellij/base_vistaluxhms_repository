package com.vistaluxhms.model;

import com.vistaluxhms.entity.LeadFreeHandQuotationRoomDetailsEntity;
import com.vistaluxhms.entity.LeadSystemQuotationRoomDetailsEntity;

public class LeadFreeHandQuotationRoomDetailsEntityDTO extends LeadFreeHandQuotationRoomDetailsEntity {
    private String formattedCheckInDate;
    private String formattedCheckOutDate;

    private String mealPlanName;

    public void updateLeadRoomDetailsDTOFromLeadRoomEntity(LeadFreeHandQuotationRoomDetailsEntity leadRoomDetailsEntity) {
        this.lfqrd = leadRoomDetailsEntity.getLfqrd();
        this.leadFreeHandQuotationEntity = leadRoomDetailsEntity.getLeadFreeHandQuotationEntity();
        this.roomCategoryName = leadRoomDetailsEntity.getRoomCategoryName();
        this.mealPlanId = leadRoomDetailsEntity.getMealPlanId();
        this.adults = leadRoomDetailsEntity.getAdults();
        this.noOfChild = leadRoomDetailsEntity.getNoOfChild();
        this.checkInDate = leadRoomDetailsEntity.getCheckInDate();
        this.checkOutDate = leadRoomDetailsEntity.getCheckOutDate();
        this.totalPrice = leadRoomDetailsEntity.getTotalPrice();
        this.noOfRooms= leadRoomDetailsEntity.getNoOfRooms();
    }


    public String getFormattedCheckInDate() {
        return formattedCheckInDate;
    }

    public void setFormattedCheckInDate(String formattedCheckInDate) {
        this.formattedCheckInDate = formattedCheckInDate;
    }

    public String getFormattedCheckOutDate() {
        return formattedCheckOutDate;
    }

    public void setFormattedCheckOutDate(String formattedCheckOutDate) {
        this.formattedCheckOutDate = formattedCheckOutDate;
    }


    public String getMealPlanName() {
        return mealPlanName;
    }

    public void setMealPlanName(String mealPlanName) {
        this.mealPlanName = mealPlanName;
    }

}
