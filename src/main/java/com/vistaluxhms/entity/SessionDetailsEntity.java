package com.vistaluxhms.entity;

import javax.persistence.*;

@Entity
@Table(name = "sessiondetail")
public class SessionDetailsEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "sessionDetailId")
    private int sessionDetailId;


    @ManyToOne
    @JoinColumn(name = "sessionId", referencedColumnName = "sessionId")
    private SessionEntity session;

    @Column(name = "roomCategoryId", length = 255)
    private int roomCategoryId;

    @Column(name = "mealPlanId", length = 255)
    private int mealPlanId;

    @Column(name = "person1")
    private int person1;

    @Column(name = "person2")
    private int person2;

    @Column(name = "person3")
    private int person3;

    @Column(name = "person4")
    private int person4;

    @Column(name = "person5")
    private int person5;

    @Column(name = "person6")
    private int person6;

    @Column(name = "maxOccupancy", nullable = false)
    private int maxOccupancy;

    @Column(name = "remarks", length = 500)
    private String remarks;

    @Column(name = "activeFlag")
    private Boolean activeFlag = true;

    public int getSessionDetailId() {
        return sessionDetailId;
    }

    public void setSessionDetailId(int sessionDetailId) {
        this.sessionDetailId = sessionDetailId;
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

    public int getPerson1() {
        return person1;
    }

    public void setPerson1(int person1) {
        this.person1 = person1;
    }

    public int getPerson2() {
        return person2;
    }

    public void setPerson2(int person2) {
        this.person2 = person2;
    }

    public int getPerson3() {
        return person3;
    }

    public void setPerson3(int person3) {
        this.person3 = person3;
    }

    public int getPerson4() {
        return person4;
    }

    public void setPerson4(int person4) {
        this.person4 = person4;
    }

    public int getPerson5() {
        return person5;
    }

    public void setPerson5(int person5) {
        this.person5 = person5;
    }

    public int getPerson6() {
        return person6;
    }

    public void setPerson6(int person6) {
        this.person6 = person6;
    }

    public int getMaxOccupancy() {
        return maxOccupancy;
    }

    public void setMaxOccupancy(int maxOccupancy) {
        this.maxOccupancy = maxOccupancy;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public Boolean getActiveFlag() {
        return activeFlag;
    }

    public void setActiveFlag(Boolean activeFlag) {
        this.activeFlag = activeFlag;
    }

    @Override
    public String toString() {
        return "SessionDetailsEntity{" +
                "sessionDetailId=" + sessionDetailId +
                ", roomCategoryId=" + roomCategoryId +
                ", mealPlanId=" + mealPlanId +
                ", person1=" + person1 +
                ", person2=" + person2 +
                ", person3=" + person3 +
                ", person4=" + person4 +
                ", person5=" + person5 +
                ", person6=" + person6 +
                ", maxOccupancy=" + maxOccupancy +
                ", remarks='" + remarks + '\'' +
                ", activeFlag=" + activeFlag +
                '}';
    }
}