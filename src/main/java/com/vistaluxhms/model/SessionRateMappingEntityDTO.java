package com.vistaluxhms.model;

import com.vistaluxhms.entity.SessionRateMappingEntity;

public class SessionRateMappingEntityDTO extends SessionRateMappingEntity {
    public int rateTypeId;
    public int sessionId;
    public String sessionName;
    public String rateTypeName;

    public int getRateTypeId() {
        return rateTypeId;
    }

    public void setRateTypeId(int rateTypeId) {
        this.rateTypeId = rateTypeId;
    }

    public int getSessionId() {
        return sessionId;
    }

    public void setSessionId(int sessionId) {
        this.sessionId = sessionId;
    }


    public String getSessionName() {
        return sessionName;
    }

    public void setSessionName(String sessionName) {
        this.sessionName = sessionName;
    }

    public String getRateTypeName() {
        return rateTypeName;
    }

    public void setRateTypeName(String rateTypeName) {
        this.rateTypeName = rateTypeName;
    }

    public void updateVoFromEntity(SessionRateMappingEntity sessionRateMappingEntity){
        this.sessionRateTypeId=sessionRateMappingEntity.getSessionRateTypeId();
        this.sessionEntity = sessionRateMappingEntity.getSessionEntity();
        this.rateTypeEntity = sessionRateMappingEntity.getRateTypeEntity();
        this.startDate = sessionRateMappingEntity.getStartDate();
        this.endDate = sessionRateMappingEntity.getEndDate();
        this.active=sessionRateMappingEntity.isActive();
    }
    @Override
    public String toString() {
        return "SessionRateMappingEntityDTO{" +
                "rateTypeId=" + rateTypeId +
                ", sessionId=" + sessionId +
                ", sessionRateTypeId=" + sessionRateTypeId +
                ", sessionEntity=" + sessionEntity +
                ", rateTypeEntity=" + rateTypeEntity +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}
