package com.vistaluxhms.model;

public class WhatsAppMessageDTO {
    String recipientMobile;
    String recipientName;
    String queryId;
    String queryOwnerName;
    String queryOwnerMobile;
    String queryOwnerEmail;
    String guestDetails;
    String roomType;
    String mealPlan;
    String checkInDate;
    String checkOutDate;
    int finalPrice;





    public String getRecipientMobile() {
        return recipientMobile;
    }

    public void setRecipientMobile(String recipientMobile) {
        this.recipientMobile = recipientMobile;
    }

    public String getRecipientName() {
        return recipientName;
    }

    public void setRecipientName(String recipientName) {
        this.recipientName = recipientName;
    }

    public String getQueryId() {
        return queryId;
    }

    public void setQueryId(String queryId) {
        this.queryId = queryId;
    }

    public String getQueryOwnerName() {
        return queryOwnerName;
    }

    public void setQueryOwnerName(String queryOwnerName) {
        this.queryOwnerName = queryOwnerName;
    }

    public String getQueryOwnerMobile() {
        return queryOwnerMobile;
    }

    public void setQueryOwnerMobile(String queryOwnerMobile) {
        this.queryOwnerMobile = queryOwnerMobile;
    }

    public String getQueryOwnerEmail() {
        return queryOwnerEmail;
    }

    public void setQueryOwnerEmail(String queryOwnerEmail) {
        this.queryOwnerEmail = queryOwnerEmail;
    }

    public String getGuestDetails() {
        return guestDetails;
    }

    public void setGuestDetails(String guestDetails) {
        this.guestDetails = guestDetails;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public String getMealPlan() {
        return mealPlan;
    }

    public void setMealPlan(String mealPlan) {
        this.mealPlan = mealPlan;
    }

    public String getCheckInDate() {
        return checkInDate;
    }

    public void setCheckInDate(String checkInDate) {
        this.checkInDate = checkInDate;
    }

    public String getCheckOutDate() {
        return checkOutDate;
    }

    public void setCheckOutDate(String checkOutDate) {
        this.checkOutDate = checkOutDate;
    }

    public int getFinalPrice() {
        return finalPrice;
    }

    public void setFinalPrice(int finalPrice) {
        this.finalPrice = finalPrice;
    }

    @Override
    public String toString() {
        return "WhatsAppMessageDTO{" +
                "recipientMobile='" + recipientMobile + '\'' +
                ", recipientName='" + recipientName + '\'' +
                ", queryId='" + queryId + '\'' +
                ", queryOwnerName='" + queryOwnerName + '\'' +
                ", queryOwnerMobile='" + queryOwnerMobile + '\'' +
                ", queryOwnerEmail='" + queryOwnerEmail + '\'' +
                ", guestDetails='" + guestDetails + '\'' +
                ", roomType='" + roomType + '\'' +
                ", mealPlan='" + mealPlan + '\'' +
                ", checkInDate='" + checkInDate + '\'' +
                ", checkOutDate='" + checkOutDate + '\'' +
                ", finalPrice=" + finalPrice +
                '}';
    }
}
