package com.vistaluxevent.entity;

import javax.persistence.*;

@Entity
@Table(name = "event_package_service")
public class EventPackageServiceEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "package_id")
    private EventPackageEntity eventPackage;

    private String serviceName;

    @ManyToOne
    @JoinColumn(name = "type", nullable = false)
    private EventServiceCostTypeEntity eventServiceCostTypeEntity;

    private int costPerUnit;
    private Integer quantity;
    private int totalCost;
    private Boolean isCustom;

    // Getters & Setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public EventPackageEntity getEventPackage() {
        return eventPackage;
    }

    public void setEventPackage(EventPackageEntity eventPackage) {
        this.eventPackage = eventPackage;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public EventServiceCostTypeEntity getEventServiceCostTypeEntity() {
        return eventServiceCostTypeEntity;
    }

    public void setEventServiceCostTypeEntity(EventServiceCostTypeEntity eventServiceCostTypeEntity) {
        this.eventServiceCostTypeEntity = eventServiceCostTypeEntity;
    }

    public int getCostPerUnit() {
        return costPerUnit;
    }

    public void setCostPerUnit(int costPerUnit) {
        this.costPerUnit = costPerUnit;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public int getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(int totalCost) {
        this.totalCost = totalCost;
    }

    public Boolean getCustom() {
        return isCustom;
    }

    public void setCustom(Boolean custom) {
        isCustom = custom;
    }
}

