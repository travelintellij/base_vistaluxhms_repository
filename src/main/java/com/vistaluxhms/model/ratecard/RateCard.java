package com.vistaluxhms.model.ratecard;

import java.util.List;

public class RateCard {
    private String seasonStartDate;
    private String seasonEndDate;
    private List<RoomCategory> roomCategories;

    // Getters and Setters

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

    public List<RoomCategory> getRoomCategories() {
        return roomCategories;
    }

    public void setRoomCategories(List<RoomCategory> roomCategories) {
        this.roomCategories = roomCategories;
    }
}
