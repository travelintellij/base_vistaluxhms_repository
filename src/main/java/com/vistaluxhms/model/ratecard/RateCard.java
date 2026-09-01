package com.vistaluxhms.model.ratecard;

import java.util.ArrayList;
import java.util.List;

public class RateCard {
    private Integer sessionId;
    private String seasonName;
    private String seasonStartDate;
    private String seasonEndDate;
    private List<String> applicableDates = new ArrayList<>();
    private List<RoomCategory> roomCategories = new ArrayList<>();

    // Getters and Setters

    public Integer getSessionId() {
        return sessionId;
    }

    public void setSessionId(Integer sessionId) {
        this.sessionId = sessionId;
    }

    public String getSeasonName() {
        return seasonName;
    }

    public void setSeasonName(String seasonName) {
        this.seasonName = seasonName;
    }

    public String getSeasonStartDate() {
        return seasonStartDate;
    }

    public void setSeasonStartDate(String seasonStartDate) {
        this.seasonStartDate = seasonStartDate;
    }

    public String getSeasonEndDate() {
        return seasonEndDate;
    }

    public void setSeasonEndDate(String seasonEndDate) {
        this.seasonEndDate = seasonEndDate;
    }

    public List<String> getApplicableDates() {
        return applicableDates;
    }

    public void setApplicableDates(List<String> applicableDates) {
        this.applicableDates = applicableDates;
    }

    public List<RoomCategory> getRoomCategories() {
        return roomCategories;
    }

    public void setRoomCategories(List<RoomCategory> roomCategories) {
        this.roomCategories = roomCategories;
    }
}
