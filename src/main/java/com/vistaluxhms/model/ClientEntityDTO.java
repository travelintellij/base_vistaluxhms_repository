package com.vistaluxhms.model;

import com.vistaluxhms.entity.ClientEntity;
import com.vistaluxhms.entity.SalesPartnerEntity;

/**
 * A DTO for the {@link SalesPartnerEntity} entity
 */
public class ClientEntityDTO extends ClientEntity {


    public String cityName;
    public String salesPartnerName;

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

    @Override
    public String toString() {
        return "ClientEntityDTO{" +
                "clientId=" + clientId +
                ", clientName='" + clientName + '\'' +
                ", city=" + city +
                ", mobile=" + mobile +
                ", emailId='" + emailId + '\'' +
                ", reference='" + reference + '\'' +
                ", salesPartner=" + salesPartner +
                ", remarks='" + remarks + '\'' +
                ", active=" + active +
                ", b2b=" + b2b +
                ", cityName='" + cityName + '\'' +
                '}';
    }

    public String getSalesPartnerName() {
        return salesPartnerName;
    }

    public void setSalesPartnerName(String salesPartnerName) {
        this.salesPartnerName = salesPartnerName;
    }
}