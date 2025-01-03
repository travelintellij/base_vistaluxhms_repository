package com.vistaluxhms.model;

import com.vistaluxhms.entity.RateTypeEntity;

public class RateType_Obj extends RateTypeEntity {

    public RateType_Obj(RateTypeEntity rateTypeEntity) {
        this.rateTypeId=rateTypeEntity.getRateTypeId();
        this.rateTypeName=rateTypeEntity.getRateTypeName();
        this.description=rateTypeEntity.getDescription();
        this.active=rateTypeEntity.isActive();
    }
    public RateType_Obj(){

    }

    public void updateRateTypeVOFromEntity(RateTypeEntity rateTypeEntity) {
        this.rateTypeId=rateTypeEntity.getRateTypeId();
        this.rateTypeName=rateTypeEntity.getRateTypeName();
        this.description=rateTypeEntity.getDescription();
        this.active=rateTypeEntity.isActive();
    }
}

