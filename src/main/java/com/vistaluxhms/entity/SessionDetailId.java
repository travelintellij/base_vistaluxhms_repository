package com.vistaluxhms.entity;

import java.io.Serializable;
import java.util.Objects;
import javax.persistence.*;

@Embeddable
public class SessionDetailId implements Serializable {

    @Column(name = "sessionId")
    private int sessionId;

    @Column(name = "roomCategoryId")
    private int roomCategoryId;

    @Column(name = "mealPlanId")
    private int mealPlanId;

    public SessionDetailId() {}

    public SessionDetailId(int sessionId, int roomCategoryId, int mealPlanId) {
        this.sessionId = sessionId;
        this.roomCategoryId = roomCategoryId;
        this.mealPlanId = mealPlanId;
    }

    public int getSessionId() {
        return sessionId;
    }

    public void setSessionId(int sessionId) {
        this.sessionId = sessionId;
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
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        SessionDetailId that = (SessionDetailId) o;
        return sessionId == that.sessionId && roomCategoryId == that.roomCategoryId && mealPlanId == that.mealPlanId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(sessionId, roomCategoryId, mealPlanId);
    }
}
