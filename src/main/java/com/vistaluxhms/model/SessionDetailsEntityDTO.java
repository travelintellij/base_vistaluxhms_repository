package com.vistaluxhms.model;

import com.vistaluxhms.entity.SessionDetailsEntity;
import com.vistaluxhms.entity.SessionEntity;

import java.time.LocalDate;

public class SessionDetailsEntityDTO extends SessionDetailsEntity {
    private boolean exists;
    private int roomCategoryId;
    protected int mealPlanId;

    //Following fields are temporarily added in the system for sharing the pricing with the sales partners.
    private String tempRateTypeName;
    private String sessionStartDate;
    private String sessionEndDate;
    //**********************************

    public boolean isExists() {
        return exists;
    }

    public void setExists(boolean exists) {
        this.exists = exists;
    }

    public void updateVOFromEntity(SessionDetailsEntity sessionDetailsEntity) {
        this.sessionDetailId = sessionDetailsEntity.getSessionDetailId();
        this.session = sessionDetailsEntity.getSession();
        this.person1 = sessionDetailsEntity.getPerson1();
        this.person2 = sessionDetailsEntity.getPerson2();
        this.person3 = sessionDetailsEntity.getPerson3();
        this.person4 = sessionDetailsEntity.getPerson4();
        this.person5 = sessionDetailsEntity.getPerson5();
        this.person6 = sessionDetailsEntity.getPerson6();
        this.maxOccupancy = sessionDetailsEntity.getMaxOccupancy();
        this.remarks = sessionDetailsEntity.getRemarks();
        this.active = sessionDetailsEntity.getActive();
    }

    public int getRoomCategoryId() {
        return roomCategoryId;
    }

    public void setRoomCategoryId(int roomCategoryId) {
        this.roomCategoryId = roomCategoryId;
    }


    public int getMealPlanId() {
        return mealPlanId;
    }

    public void setMealPlanId(int mealPlanId) {
        this.mealPlanId = mealPlanId;
    }

    @Override
    public String toString() {
        return "SessionDetailsEntityDTO{" +
                ", mealPlanId=" + mealPlanId +
                ", sessionDetailId=" + sessionDetailId +
                ", person1=" + person1 +
                ", person2=" + person2 +
                ", person3=" + person3 +
                ", person4=" + person4 +
                ", person5=" + person5 +
                ", person6=" + person6 +
                ", rateTypename=" + tempRateTypeName +
                ", startDate=" + sessionStartDate +
                ", EndDate=" + sessionEndDate +
                '}';
    }

    public String getTempRateTypeName() {
        return tempRateTypeName;
    }

    public void setTempRateTypeName(String tempRateTypeName) {
        this.tempRateTypeName = tempRateTypeName;
    }

    public String getSessionStartDate() {
        return sessionStartDate;
    }

    public void setSessionStartDate(String sessionStartDate) {
        this.sessionStartDate = sessionStartDate;
    }

    public String getSessionEndDate() {
        return sessionEndDate;
    }

    public void setSessionEndDate(String sessionEndDate) {
        this.sessionEndDate = sessionEndDate;
    }
}
