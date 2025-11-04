package com.vistaluxhms.model;

import com.vistaluxhms.entity.Category;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;

public class AssetDTO {

    private int assetId;
    private String assetName;

    private LocalDate creationDate;
    private BigDecimal assetCost;
    private Category category;
    private boolean active;
    private Integer assetOwnerId;
    private String assetOwnerName;
    private String assetCode;
    private Date allocatedDate;
    private Integer categoryId;
    private String description;


    public AssetDTO() {
        this.creationDate = LocalDate.now();
    }


    public AssetDTO(int assetId, String assetName, LocalDate creationDate, BigDecimal assetCost,
                   Category category, boolean isActive, Integer assetOwnerId, String assetOwnerName) {
        this.assetId = assetId;
        this.assetName = assetName;
        this.creationDate = creationDate;
        this.assetCost = assetCost;
        this.category = category;
        this.active = isActive;
        this.assetOwnerId = assetOwnerId;
        this.assetOwnerName = assetOwnerName;
    }


    public int getAssetId() { return assetId; }
    public void setAssetId(int assetId) { this.assetId = assetId; }

    public String getAssetName() { return assetName; }
    public void setAssetName(String assetName) { this.assetName = assetName; }

    public LocalDate getCreationDate() { return creationDate; }
    public void setCreationDate(LocalDate creationDate) { this.creationDate = creationDate; }

    public BigDecimal getAssetCost() { return assetCost; }
    public void setAssetCost(BigDecimal assetCost) { this.assetCost = assetCost; }

    public Category getCategory() { return category; }
    public void setCategory(Category category) { this.category = category; }

    public boolean isActive() {
        return active;}

        public void setActive(boolean isActive) {
            this.active = isActive;

    }

    public Integer getAssetOwnerId() { return assetOwnerId; }
    public void setAssetOwnerId(Integer assetOwnerId) { this.assetOwnerId = assetOwnerId; }

    public String getAssetOwnerName() { return assetOwnerName; }
    public void setAssetOwnerName(String assetOwnerName) { this.assetOwnerName = assetOwnerName; }

    public String getAssetCode() { return assetCode; }
    public void setAssetCode(String assetCode) { this.assetCode = assetCode; }

    public Date getAllocatedDate() {
        return allocatedDate;
    }

    public void setAllocatedDate(Date allocatedDate) {
        this.allocatedDate = allocatedDate;
    }


    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}

