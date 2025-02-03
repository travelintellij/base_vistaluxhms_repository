package com.vistaluxhms.entity;

import javax.persistence.*;

@Entity
@Table(name = "master_room_details")
public class MasterRoomDetailsEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "room_category", nullable = false)
    private String roomCategory;

    @Column(name = "description")
    private String description;

    @Column(name = "size")
    private String size;

    @Column(name = "standard_occupancy", nullable = false)
    private int standardOccupancy;

    @Column(name = "max_occupancy", nullable = false)
    private int maxOccupancy;

    @Column(name = "extra_bed", columnDefinition = "int default 0")
    private int extraBed;

    @Column(name = "child", columnDefinition = "int default 0")
    private int child;

    @Column(name = "comp_child", columnDefinition = "int default 0")
    private int compChild;

    @Column(name = "categorylevel", columnDefinition = "int default 0")
    private int categoryLevel;

    @Column(name = "active", columnDefinition = "boolean default true")
    private boolean active=true;

    // Constructors
    public MasterRoomDetailsEntity() {}

    public MasterRoomDetailsEntity(String roomCategory, String description, String size, int standardOccupancy,
                             int maxOccupancy, int extraBed, int child, int compChild, int categoryLevel, boolean active) {
        this.roomCategory = roomCategory;
        this.description = description;
        this.size = size;
        this.standardOccupancy = standardOccupancy;
        this.maxOccupancy = maxOccupancy;
        this.extraBed = extraBed;
        this.child = child;
        this.compChild = compChild;
        this.categoryLevel = categoryLevel;
        this.active = active;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRoomCategory() {
        return roomCategory;
    }

    public void setRoomCategory(String roomCategory) {
        this.roomCategory = roomCategory;
    }

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
}