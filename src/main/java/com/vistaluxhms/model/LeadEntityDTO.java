package com.vistaluxhms.model;

import com.vistaluxhms.entity.ClientEntity;
import com.vistaluxhms.entity.LeadEntity;
import com.vistaluxhms.entity.SalesPartnerEntity;

/**
 * A DTO for the {@link SalesPartnerEntity} entity
 */
public class LeadEntityDTO extends LeadEntity {


    public String cityName;
    public String salesPartnerName;
    public String clientName;

    public boolean notifyEmail=true;
    public boolean notifySMS;
    public boolean notifyWhatsapp;

   public void updateLeadVoFromEntity(LeadEntity leadEntity) {

    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }


    public String getSalesPartnerName() {
        return salesPartnerName;
    }

    public void setSalesPartnerName(String salesPartnerName) {
        this.salesPartnerName = salesPartnerName;
    }

    public String getClientName() {
        return clientName;
    }

    public void setClientName(String clientName) {
        this.clientName = clientName;
    }

    public boolean isNotifyEmail() {
        return notifyEmail;
    }

    public void setNotifyEmail(boolean notifyEmail) {
        this.notifyEmail = notifyEmail;
    }

    public boolean isNotifySMS() {
        return notifySMS;
    }

    public void setNotifySMS(boolean notifySMS) {
        this.notifySMS = notifySMS;
    }

    public boolean isNotifyWhatsapp() {
        return notifyWhatsapp;
    }

    public void setNotifyWhatsapp(boolean notifyWhatsapp) {
        this.notifyWhatsapp = notifyWhatsapp;
    }
}