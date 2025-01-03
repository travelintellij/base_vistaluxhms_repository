package com.vistaluxhms.model;

import com.vistaluxhms.entity.City_Entity;
import com.vistaluxhms.entity.SalesPartnerEntity;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Objects;

/**
 * A DTO for the {@link com.vistaluxhms.entity.SalesPartnerEntity} entity
 */
public class SalesPartnerEntityDto extends SalesPartnerEntity {


    public String cityName;
    public SalesPartnerEntityDto() {

    }

    public void updateSalesPartnerVoFromEntity(SalesPartnerEntity salesPartnerEntity) {
        this.salesPartnerId=salesPartnerEntity.getSalesPartnerId();
        this.salesPartnerShortName = salesPartnerEntity.getSalesPartnerShortName();
        this.salesPartnerName = salesPartnerEntity.getSalesPartnerName();
        this.cityId = salesPartnerEntity.getCityId(); // Assuming city is an object and will be mapped separately
        this.active = salesPartnerEntity.getActive();
        this.address = salesPartnerEntity.getAddress();
        this.reference = salesPartnerEntity.getReference();
        this.description = salesPartnerEntity.getDescription();
        this.createdAt = salesPartnerEntity.getCreatedAt();
        this.updatedAt = salesPartnerEntity.getUpdatedAt();
    }




    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }
}