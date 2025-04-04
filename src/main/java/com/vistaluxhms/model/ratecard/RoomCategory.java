package com.vistaluxhms.model.ratecard;

import java.util.List;

public class RoomCategory {
    private Integer roomCategoryId;
    private String name;
    private int maxOccupancy;
    private int standardOccupancy;
    private int extraBed;
    private List<MealPlanRate> mealPlans;

    // Getters and Setters

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getMaxOccupancy() {
        return maxOccupancy;
    }

    public void setMaxOccupancy(int maxOccupancy) {
        this.maxOccupancy = maxOccupancy;
    }

    public int getExtraBed() {
        return extraBed;
    }

    public void setExtraBed(int extraBed) {
        this.extraBed = extraBed;
    }

    public List<MealPlanRate> getMealPlans() {
        return mealPlans;
    }

    public void setMealPlans(List<MealPlanRate> mealPlans) {
        this.mealPlans = mealPlans;
    }

    public int getRoomCategoryId() {
        return roomCategoryId;
    }

    public void setRoomCategoryId(int roomCategoryId) {
        this.roomCategoryId = roomCategoryId;
    }

    public void setRoomCategoryId(Integer roomCategoryId) {
        this.roomCategoryId = roomCategoryId;
    }

    public int getStandardOccupancy() {
        return standardOccupancy;
    }

    public void setStandardOccupancy(int standardOccupancy) {
        this.standardOccupancy = standardOccupancy;
    }
}

