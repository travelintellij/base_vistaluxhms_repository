package com.vistaluxhms.entity;

import com.vistaluxhms.model.SalesPartnerEntityDto;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "sales_partner_entity")
public class SalesPartnerEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "salesPartnerId")
    protected Long salesPartnerId; // Primary Key

    @Column(name = "salesPartnerShortName", nullable = false, length = 50)
    protected String salesPartnerShortName; // Short Name of Sales Partner

    @Column(name = "salesPartnerName", nullable = false, length = 100)
    protected String salesPartnerName; // Full Name of Sales Partner

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "cityId", referencedColumnName = "destinationId", foreignKey = @ForeignKey(name = "fk_city"))
    protected City_Entity city; // Foreign Key to Cities Table

    @Column(name = "active", nullable = false)
    protected Boolean active = true; // Active Status

    @Column(name = "address", length = 255)
    protected String address; // Address Field

    @Column(name = "reference", length = 255)
    protected String reference; // Reference Field

    @Column(name = "description", length = 255)
    protected String description; // Description Field

    @Column(name = "created_at", updatable = false)
    protected LocalDateTime createdAt; // Created At

    @Column(name = "updated_at")
    protected LocalDateTime updatedAt; // Updated At

    public SalesPartnerEntity(SalesPartnerEntityDto salesPartnerDto) {
        this.salesPartnerId = salesPartnerDto.getSalesPartnerId();
        this.salesPartnerShortName = salesPartnerDto.getSalesPartnerShortName();
        this.salesPartnerName = salesPartnerDto.getSalesPartnerName();
        this.city = salesPartnerDto.getCity(); // Assuming city is an object and will be mapped separately
        this.active = salesPartnerDto.getActive();
        this.address = salesPartnerDto.getAddress();
        this.reference = salesPartnerDto.getReference();
        this.description = salesPartnerDto.getDescription();
    }

    public SalesPartnerEntity() {
    }

    // Getters and Setters

    public Long getSalesPartnerId() {
        return salesPartnerId;
    }

    public void setSalesPartnerId(Long salesPartnerId) {
        this.salesPartnerId = salesPartnerId;
    }

    public String getSalesPartnerShortName() {
        return salesPartnerShortName;
    }

    public void setSalesPartnerShortName(String salesPartnerShortName) {
        this.salesPartnerShortName = salesPartnerShortName;
    }

    public String getSalesPartnerName() {
        return salesPartnerName;
    }

    public void setSalesPartnerName(String salesPartnerName) {
        this.salesPartnerName = salesPartnerName;
    }

    public City_Entity getCity() {
        return city;
    }

    public void setCity(City_Entity city) {
        this.city = city;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    // Lifecycle Callbacks
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
}