package com.vistaluxhms.model;

import com.vistaluxhms.entity.LeadFreeHandQuotationRoomDetailsEntity;
import com.vistaluxhms.entity.LeadSystemQuotationRoomDetailsEntity;

public class LeadFreeHandQuotationRoomDetailsEntityDTO extends LeadFreeHandQuotationRoomDetailsEntity {
    private int adultPrice;
    private int childWithBedPrice;
    private int childNoBedPrice;
    private int extraBedPrice;
    private String formattedCheckInDate;
    private String formattedCheckOutDate;
    private String roomCategoryName;
    private String mealPlanName;

    private int noOfRooms;
    private int noOfChild;

    public void updateLeadRoomDetailsDTOFromLeadRoomEntity(LeadFreeHandQuotationRoomDetailsEntity leadRoomDetailsEntity) {
        this.lfqrd = leadRoomDetailsEntity.getLfqrd();
        this.leadFreeHandQuotationEntity = leadRoomDetailsEntity.getLeadFreeHandQuotationEntity();
        this.roomCategoryName = leadRoomDetailsEntity.getRoomCategoryName();
        this.mealPlanId = leadRoomDetailsEntity.getMealPlanId();
        this.adults = leadRoomDetailsEntity.getAdults();
        this.cwb = leadRoomDetailsEntity.getCwb();
        this.cnb = leadRoomDetailsEntity.getCnb();
        this.extraBed = leadRoomDetailsEntity.getExtraBed();
        this.checkInDate = leadRoomDetailsEntity.getCheckInDate();
        this.checkOutDate = leadRoomDetailsEntity.getCheckOutDate();
        this.adultsTotalPrice = leadRoomDetailsEntity.getAdultsTotalPrice();
        this.cwbTotalPrice = leadRoomDetailsEntity.getCwbTotalPrice();
        this.cnbTotalPrice = leadRoomDetailsEntity.getCnbTotalPrice();
        this.extraBedTotalPrice = leadRoomDetailsEntity.getExtraBedTotalPrice();
        this.totalPrice = leadRoomDetailsEntity.getTotalPrice();
    }

    public int getAdultPrice() {
        return adultPrice;
    }

    public void setAdultPrice(int adultPrice) {
        this.adultPrice = adultPrice;
    }

    public int getChildWithBedPrice() {
        return childWithBedPrice;
    }

    public void setChildWithBedPrice(int childWithBedPrice) {
        this.childWithBedPrice = childWithBedPrice;
    }

    public int getChildNoBedPrice() {
        return childNoBedPrice;
    }

    public void setChildNoBedPrice(int childNoBedPrice) {
        this.childNoBedPrice = childNoBedPrice;
    }

    public int getExtraBedPrice() {
        return extraBedPrice;
    }

    public void setExtraBedPrice(int extraBedPrice) {
        this.extraBedPrice = extraBedPrice;
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

    public String getRoomCategoryName() {
        return roomCategoryName;
    }

    public void setRoomCategoryName(String roomCategoryName) {
        this.roomCategoryName = roomCategoryName;
    }

    public String getMealPlanName() {
        return mealPlanName;
    }

    public void setMealPlanName(String mealPlanName) {
        this.mealPlanName = mealPlanName;
    }

    public int getNoOfRooms() {
        return noOfRooms;
    }

    public void setNoOfRooms(int noOfRooms) {
        this.noOfRooms = noOfRooms;
    }

    public int getNoOfChild() {
        return noOfChild;
    }

    public void setNoOfChild(int noOfChild) {
        this.noOfChild = noOfChild;
    }
}
