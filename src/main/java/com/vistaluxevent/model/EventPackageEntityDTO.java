package com.vistaluxevent.model;

import com.vistaluxevent.entity.EventPackageEntity;

public class EventPackageEntityDTO extends EventPackageEntity {
    private long guestId;
    private String guestName;
    private int quotationAudienceType;
    private int discount;
    private String contactMethod;
    private String mobile;
    private String email;


    public long getGuestId() {
        return guestId;
    }

    public void setGuestId(long guestId) {
        this.guestId = guestId;
    }

    public String getGuestName() {
        return guestName;
    }

    public void setGuestName(String guestName) {
        this.guestName = guestName;
    }

    public int getQuotationAudienceType() {
        return quotationAudienceType;
    }

    public void setQuotationAudienceType(int quotationAudienceType) {
        this.quotationAudienceType = quotationAudienceType;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
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

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
