package com.vistaluxhms.model;

import com.vistaluxhms.entity.SalesPartnerEntity;

/**
 * A DTO for the {@link com.vistaluxhms.entity.SalesPartnerEntity} entity
 */
public class SalesPartnerEntityDto extends SalesPartnerEntity {

    public String cityName;
    public int rateTypeId;
    public String rateTypeName;
    private String email;

    public void updateSalesPartnerVoFromEntity(SalesPartnerEntity salesPartnerEntity) {
        this.salesPartnerId=salesPartnerEntity.getSalesPartnerId();
        this.salesPartnerShortName = salesPartnerEntity.getSalesPartnerShortName();
        this.salesPartnerName = salesPartnerEntity.getSalesPartnerName();
        this.mobile=salesPartnerEntity.getMobile();
        this.emailId=salesPartnerEntity.getEmailId();
        this.cityId = salesPartnerEntity.getCityId(); // Assuming city is an object and will be mapped separately
        this.active = salesPartnerEntity.getActive();
        this.address = salesPartnerEntity.getAddress();
        this.reference = salesPartnerEntity.getReference();
        this.description = salesPartnerEntity.getDescription();
        this.createdAt = salesPartnerEntity.getCreatedAt();
        this.updatedAt = salesPartnerEntity.getUpdatedAt();
        this.rateTypeEntity=salesPartnerEntity.getRateTypeEntity();
    }




    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }

    public int getRateTypeId() {
        return rateTypeId;
    }

    public void setRateTypeId(int rateTypeId) {
        this.rateTypeId = rateTypeId;
    }

    public String getRateTypeName() {
        return rateTypeName;
    }

    public void setRateTypeName(String rateTypeName) {
        this.rateTypeName = rateTypeName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
