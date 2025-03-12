package com.vistaluxhms.model;

import com.vistaluxhms.entity.SessionDetailsEntity;
import com.vistaluxhms.entity.SessionEntity;

public class SessionDetailsEntityDTO extends SessionDetailsEntity {
    private boolean exists;

    public boolean isExists() {
        return exists;
    }

    public void setExists(boolean exists) {
        this.exists = exists;
    }

    public void updateVOFromEntity(SessionDetailsEntity sessionDetailsEntity) {
        this.sessionDetailId = sessionDetailsEntity.getSessionDetailId();
        this.session = sessionDetailsEntity.getSession();
        this.roomCategoryId = sessionDetailsEntity.getRoomCategoryId();
        this.mealPlanId = sessionDetailsEntity.getMealPlanId();
        this.person1 = sessionDetailsEntity.getPerson1();
        this.person2 = sessionDetailsEntity.getPerson2();
        this.person3 = sessionDetailsEntity.getPerson3();
        this.person4 = sessionDetailsEntity.getPerson4();
        this.person5 = sessionDetailsEntity.getPerson5();
        this.person6 = sessionDetailsEntity.getPerson6();
        this.maxOccupancy = sessionDetailsEntity.getMaxOccupancy();
        this.remarks = sessionDetailsEntity.getRemarks();
        this.activeFlag = sessionDetailsEntity.getActiveFlag();
    }


}
