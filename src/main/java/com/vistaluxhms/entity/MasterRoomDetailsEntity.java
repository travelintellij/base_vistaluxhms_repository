package com.vistaluxhms.entity;

import javax.persistence.*;

@Entity
@Table(name = "master_room_details")
public class MasterRoomDetailsEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int roomCategoryId;

    @Column(name = "roomCategoryName", nullable = false)
    private String roomCategoryName;

    @Column(name = "description")
    private String description;

    @Column(name = "size")
    private String size;

    @Column(name = "standardOccupancy", nullable = false)
    private int standardOccupancy;

    @Column(name = "maxOccupancy", nullable = false)
    private int maxOccupancy;

    @Column(name = "extraBed", columnDefinition = "int default 0")
    private int extraBed;

    @Column(name = "child", columnDefinition = "int default 0")
    private int child;

    @Column(name = "compChild", columnDefinition = "int default 0")
    private int compChild;

    @Column(name = "categorylevel", columnDefinition = "int default 0")
    private int categoryLevel;

    @Column(name = "active", columnDefinition = "boolean default true")
    private boolean active=true;

    @Column(name = "extraBedPercentage", columnDefinition = "int default 35")
    private int extraBedPercentage=35;

    @Column(name = "cnbPercentage", columnDefinition = "int default 20")
    private int cnbPercentage=20;


    // Constructors
    public MasterRoomDetailsEntity() {}

    public MasterRoomDetailsEntity(String roomCategoryName, String description, String size, int standardOccupancy,
                             int maxOccupancy, int extraBed, int child, int compChild, int categoryLevel, int extraBedPercentage,int cnbPercentage,boolean active) {
        this.roomCategoryName = roomCategoryName;
        this.description = description;
        this.size = size;
        this.standardOccupancy = standardOccupancy;
        this.maxOccupancy = maxOccupancy;
        this.extraBed = extraBed;
        this.child = child;
        this.compChild = compChild;
        this.categoryLevel = categoryLevel;
        this.active = active;
        this.extraBedPercentage= extraBedPercentage;
        this.cnbPercentage=cnbPercentage;
    }

    // Getters and Setters




    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public int getStandardOccupancy() {
        return standardOccupancy;
    }

    public void setStandardOccupancy(int standardOccupancy) {
        this.standardOccupancy = standardOccupancy;
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

    public int getChild() {
        return child;
    }

    public void setChild(int child) {
        this.child = child;
    }

    public int getCompChild() {
        return compChild;
    }

    public void setCompChild(int compChild) {
        this.compChild = compChild;
    }

    public int getCategoryLevel() {
        return categoryLevel;
    }

    public void setCategoryLevel(int categoryLevel) {
        this.categoryLevel = categoryLevel;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public int getRoomCategoryId() {
        return roomCategoryId;
    }

    public void setRoomCategoryId(int roomCategoryId) {
        this.roomCategoryId = roomCategoryId;
    }

    public String getRoomCategoryName() {
        return roomCategoryName;
    }

    public void setRoomCategoryName(String roomCategoryName) {
        this.roomCategoryName = roomCategoryName;
    }

    public int getExtraBedPercentage() {
        return extraBedPercentage;
    }

    public void setExtraBedPercentage(int extraBedPercentage) {
        this.extraBedPercentage = extraBedPercentage;
    }

    public int getCnbPercentage() {
        return cnbPercentage;
    }

    public void setCnbPercentage(int cnbPercentage) {
        this.cnbPercentage = cnbPercentage;
    }

    @Override
    public String toString() {
        return "MasterRoomDetailsEntity{" +
                "roomCategoryId=" + roomCategoryId +
                ", roomCategoryName='" + roomCategoryName + '\'' +
                ", description='" + description + '\'' +
                ", size='" + size + '\'' +
                ", standardOccupancy=" + standardOccupancy +
                ", maxOccupancy=" + maxOccupancy +
                ", extraBed=" + extraBed +
                ", child=" + child +
                ", compChild=" + compChild +
                ", categoryLevel=" + categoryLevel +
                ", active=" + active +
                ", extraBedPercentage=" + extraBedPercentage +
                ", cnbPercentage=" + cnbPercentage +
                '}';
    }
}