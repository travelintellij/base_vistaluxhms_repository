package com.vistaluxhms.model;

import com.vistaluxhms.entity.ClientEntity;
import com.vistaluxhms.entity.LeadEntity;
import com.vistaluxhms.entity.SalesPartnerEntity;

/**
 * A DTO for the {@link LeadEntity} entity
 */
public class LeadEntityDTO extends LeadEntity {


    public String cityName;
    public String salesPartnerName;
    public String clientName;
    public String minOneserviceError;

    public boolean notifyEmail=true;
    public boolean notifySMS;
    public boolean notifyWhatsapp;

   public void updateLeadVoFromEntity(LeadEntity leadEntity) {
           //this.client = leadRecorderObj.getClient();
           //this.team = leadRecorderObj.getTeam();
           this.adults = leadEntity.getAdults();
           this.cwb = leadEntity.getCwb();
           this.cnb = leadEntity.getCnb();
           this.compChild = leadEntity.getCompChild();
           this.clientRemarks = leadEntity.getClientRemarks();
           this.internalRemarks = leadEntity.getInternalRemarks();
           this.checkInDate = leadEntity.getCheckInDate();
           this.checkOutDate = leadEntity.getCheckOutDate();
           this.leadStatus = leadEntity.getLeadStatus();
           this.resultReason = leadEntity.getResultReason();
           this.qualified = leadEntity.isQualified();
           this.flagged = leadEntity.isFlagged();
           this.fit = leadEntity.isFit();
           this.groupEvent = leadEntity.isGroupEvent();
           this.marriage = leadEntity.isMarriage();
           this.others = leadEntity.isOthers();
           this.leadCreationClientInformed = leadEntity.isLeadCreationClientInformed();
           this.leadOwner = leadEntity.getLeadOwner();
    }

    public LeadEntityDTO(){}
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

    public String getMinOneserviceError() {
        return minOneserviceError;
    }

    public void setMinOneserviceError(String minOneserviceError) {
        this.minOneserviceError = minOneserviceError;
    }

    @Override
    public String toString() {
        return "LeadEntityDTO{" +
                "cityName='" + cityName + '\'' +
                ", salesPartnerName='" + salesPartnerName + '\'' +
                ", clientName='" + clientName + '\'' +
                ", minOneserviceError='" + minOneserviceError + '\'' +
                ", notifyEmail=" + notifyEmail +
                ", notifySMS=" + notifySMS +
                ", notifyWhatsapp=" + notifyWhatsapp +
                ", leadId=" + leadId +
                ", client=" + client +
                ", team=" + team +
                ", adults=" + adults +
                ", cwb=" + cwb +
                ", cnb=" + cnb +
                ", compChild=" + compChild +
                ", clientRemarks='" + clientRemarks + '\'' +
                ", internalRemarks='" + internalRemarks + '\'' +
                ", checkInDate=" + checkInDate +
                ", checkOutDate=" + checkOutDate +
                ", leadStatus=" + leadStatus +
                ", resultReason=" + resultReason +
                ", qualified=" + qualified +
                ", flagged=" + flagged +
                ", fit=" + fit +
                ", groupEvent=" + groupEvent +
                ", marriage=" + marriage +
                ", others=" + others +
                ", leadCreationClientInformed=" + leadCreationClientInformed +
                ", leadOwner=" + leadOwner +
                '}';
    }
}