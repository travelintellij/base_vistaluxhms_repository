package com.vistaluxhms.entity;

import com.vistaluxhms.model.RateType_Obj;

import javax.persistence.*;

@Entity
@Table(name = "RateType")
public class RateTypeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    protected Long rateTypeId;

    @Column(name = "rateTypeName", nullable = false, length = 50)
    protected String rateTypeName;

    @Column(name = "description", columnDefinition = "TEXT")
    protected String description;

    protected boolean active = true;
    public RateTypeEntity() {
    }

    // Getters and Setters
    public Long getRateTypeId() {
        return rateTypeId;
    }

    public void setRateTypeId(Long rateTypeId) {
        this.rateTypeId = rateTypeId;
    }

    public String getRateTypeName() {
        return rateTypeName;
    }

    public void setRateTypeName(String rateTypeName) {
        this.rateTypeName = rateTypeName;
    }

    public String getDescription() {
        return description;
    }

    public RateTypeEntity(RateType_Obj rateTypeObj) {
        this.rateTypeId = rateTypeObj.getRateTypeId();
        this.rateTypeName = rateTypeObj.getRateTypeName();
        this.description = rateTypeObj.getDescription();
        this.active=rateTypeObj.isActive();
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }
}

