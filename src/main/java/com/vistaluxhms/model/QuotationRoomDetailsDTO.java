package com.vistaluxhms.model;


import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;

public class QuotationRoomDetailsDTO {
    private int roomCategoryId;
    private int mealPlanId;
    private int adults;
    private int adultPrice;
    private int childWithBed;
    private int childNoBed;
    private int extraBed;
    private int totalPrice;
    private int discount;
    private int finalPrice;
    private boolean showBreakup;
    private int childWithBedPrice;
    private int childNoBedPrice;
    private int extraBedPrice;
    private String roomCategoryName;
    private String mealPlanName;

    //following attributes are added for Free Hand Quotations.
    private int noOfRooms;
    private int noOfChild;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate checkInDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate checkOutDate;

    private String formattedCheckInDate;
    private String formattedCheckOutDate;


    public int getRoomCategoryId() {
        return roomCategoryId;
    }

    public void setRoomCategoryId(int roomCategoryId) {
        this.roomCategoryId = roomCategoryId;
    }

    public int getMealPlanId() {
        return mealPlanId;
    }

    public void setMealPlanId(int mealPlanId) {
        this.mealPlanId = mealPlanId;
    }

    public int getAdults() {
        return adults;
    }

    public void setAdults(int adults) {
        this.adults = adults;
    }

    public int getChildWithBed() {
        return childWithBed;
    }

    public void setChildWithBed(int childWithBed) {
        this.childWithBed = childWithBed;
    }

    public int getChildNoBed() {
        return childNoBed;
    }

    public void setChildNoBed(int childNoBed) {
        this.childNoBed = childNoBed;
    }

    public int getExtraBed() {
        return extraBed;
    }

    public void setExtraBed(int extraBed) {
        this.extraBed = extraBed;
    }

    public LocalDate getCheckInDate() {
        return checkInDate;
    }

    public void setCheckInDate(LocalDate checkInDate) {
        this.checkInDate = checkInDate;
    }

    public LocalDate getCheckOutDate() {
        return checkOutDate;
    }

    public void setCheckOutDate(LocalDate checkOutDate) {
        this.checkOutDate = checkOutDate;
    }

    // Ensure valid inputs
    public boolean isValid() {
        return roomCategoryId > 0 && mealPlanId > 0;
    }

    @Override
    public String toString() {
        return "QuotationRoomDetailsDTO{" +
                "roomCategoryId=" + roomCategoryId +
                ", mealPlanId=" + mealPlanId +
                ", adults=" + adults +
                ", childWithBed=" + childWithBed +
                ", childNoBed=" + childNoBed +
                ", extraBed=" + extraBed +
                ", checkInDate=" + checkInDate +
                ", checkOutDate=" + checkOutDate +
                '}';
    }

    public int getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(int totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public int getFinalPrice() {
        return finalPrice;
    }

    public void setFinalPrice(int finalPrice) {
        this.finalPrice = finalPrice;
    }

    public boolean isShowBreakup() {
        return showBreakup;
    }

    public void setShowBreakup(boolean showBreakup) {
        this.showBreakup = showBreakup;
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

    public int getAdultPrice() {
        return adultPrice;
    }

    public void setAdultPrice(int adultPrice) {
        this.adultPrice = adultPrice;
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
