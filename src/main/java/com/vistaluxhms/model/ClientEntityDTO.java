package com.vistaluxhms.model;

import com.vistaluxhms.entity.ClientEntity;
import com.vistaluxhms.entity.SalesPartnerEntity;

/**
 * A DTO for the {@link SalesPartnerEntity} entity
 */
public class ClientEntityDTO extends ClientEntity {


    public String cityName;

    public void updateClientVoFromEntity(ClientEntity clientEntity) {
        this.city= clientEntity.getCity();
        this.clientId=clientEntity.getClientId();
        this.mobile=clientEntity.getMobile();
        this.clientName=clientEntity.getClientName();
        this.reference=clientEntity.getReference();
        this.emailId=clientEntity.getEmailId();
        this.remarks=clientEntity.getRemarks();
        this.salesPartner=clientEntity.getSalesPartner();
        this.active=clientEntity.getActive();
        this.b2b = clientEntity.getB2b();
    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }
}