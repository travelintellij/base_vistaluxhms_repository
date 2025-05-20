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
    private String mobile;
    private String email;
    private List<QuotationRoomDetailsDTO> roomDetails;
    private String guestName = "Guest";
    private int grandTotal;
    private int discount;
    private boolean showCostBreakup;
    private String remarks;
    private long guestId;
    private long leadId;


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

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String  mobile) {
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

    public String getGuestName() {
        return guestName;
    }

    public void setGuestName(String guestName) {
        this.guestName = guestName;
    }

    public int getGrandTotal() {
        return grandTotal;
    }

    public void setGrandTotal(int grandTotal) {
        this.grandTotal = grandTotal;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public boolean isShowCostBreakup() {
        return showCostBreakup;
    }

    public void setShowCostBreakup(boolean showCostBreakup) {
        this.showCostBreakup = showCostBreakup;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public long getGuestId() {
        return guestId;
    }

    public void setGuestId(long guestId) {
        this.guestId = guestId;
    }

    public long getLeadId() {
        return leadId;
    }

    public void setLeadId(long leadId) {
        this.leadId = leadId;
    }
}
