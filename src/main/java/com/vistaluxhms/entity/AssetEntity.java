package com.vistaluxhms.entity;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "assets")
public class AssetEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "asset_id")
    private Integer assetId;

    @Column(name = "asset_name", nullable = false)
    private String assetName;

    @Temporal(TemporalType.DATE)
    @Column(name = "creation_date", nullable = false)
    private Date creationDate;

    @Column(name = "asset_cost")
    private BigDecimal assetCost;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id", nullable = false)
    private Category category;

    @Column(name = "is_active")
    private Boolean isActive = true;

    @Column(name = "asset_code", unique = true)
    private String assetCode;

    @Column(name = "deleted")
    private Boolean deleted = false;

    @Column(name = "owner_id")
    private Integer ownerId;

    @OneToMany(mappedBy = "asset")
    private List<AssetAllocation> allocations;

    @Column(name = "description")
    private String description;


    public Integer getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(Integer ownerId) {
        this.ownerId = ownerId;
    }

    public Integer getAssetId() {
        return assetId;
    }

    public void setAssetId(Integer assetId) {
        this.assetId = assetId;
    }

    public String getAssetName() {
        return assetName;
    }

    public void setAssetName(String assetName) {
        this.assetName = assetName;
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public BigDecimal getAssetCost() {
        return assetCost;
    }

    public void setAssetCost(BigDecimal assetCost) {
        this.assetCost = assetCost;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public Boolean isActive() {
        return isActive;
    }

    public void setActive(Boolean active) {
        isActive = active;
    }

    public String getAssetCode() {
        return assetCode;
    }

    public void setAssetCode(String assetCode) {
        this.assetCode = assetCode;
    }

    public Boolean isDeleted() { return deleted;}

    public void setisDeleted(Boolean isDeleted){ this.deleted = isDeleted;}

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}

