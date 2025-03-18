package com.vistaluxhms.model;

import javax.validation.constraints.Email;
import java.util.ArrayList;
import java.util.List;

public class QuotationEntityDTO {
    private int rateTypeId;
    private int roomCategoryId;
    private int mealPlanId;
    private int quotationAudienceType;
    private String contactMethod;
    private int mobile;
    private String email;
    private List<QuotationRoomDetailsDTO> roomDetails;

    public int getRateTypeId() {
        return rateTypeId;
    }

    public void setRateTypeId(int rateTypeId) {
        this.rateTypeId = rateTypeId;
    }

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

    public int getQuotationAudienceType() {
        return quotationAudienceType;
    }

    public void setQuotationAudienceType(int quotationAudienceType) {
        this.quotationAudienceType = quotationAudienceType;
    }

    public String getContactMethod() {
        return contactMethod;
    }

    public void setContactMethod(String contactMethod) {
        this.contactMethod = contactMethod;
    }

    public int getMobile() {
        return mobile;
    }

    public void setMobile(int mobile) {
        this.mobile = mobile;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public List<QuotationRoomDetailsDTO> getRoomDetails() {
        return roomDetails;
    }

    public void setRoomDetails(List<QuotationRoomDetailsDTO> roomDetails) {
        this.roomDetails = roomDetails;
    }
}
