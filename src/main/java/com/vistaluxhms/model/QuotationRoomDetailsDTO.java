package com.vistaluxhms.model;


import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;

public class QuotationRoomDetailsDTO {
    private int roomCategoryId;
    private int mealPlanId;
    private int adults;
    private int childWithBed;
    private int childNoBed;
    private int extraBed;
    private int totalPrice;
    private int discount;
    private int finalPrice;
    private boolean showBreakup;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate checkInDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate checkOutDate;


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
}
