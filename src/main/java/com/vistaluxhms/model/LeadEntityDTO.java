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
}