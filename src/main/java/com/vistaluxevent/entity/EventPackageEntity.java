package com.vistaluxevent.entity;

import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "event_package")
public class EventPackageEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    protected Long id;

    protected String packageName;
    protected String description;
    protected Integer baseGuestCount;
    protected String createdBy;
    protected int grand_total_cost;
    protected int discount;
    protected boolean gstIncluded=true;
    protected boolean showBreakup=true;


    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    protected LocalDate eventStartDate;

    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    protected LocalDate eventEndDate;

    protected int numberOfRooms;

    @OneToMany(mappedBy = "eventPackage", cascade = CascadeType.ALL)
    private List<EventPackageServiceEntity> services = new ArrayList<>();

    @ManyToOne
    @JoinColumn(name = "package_type", nullable = false)  // Maps to column 'package_type' which holds foreign key
    private EventTypeEntity eventType;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getBaseGuestCount() {
        return baseGuestCount;
    }

    public void setBaseGuestCount(Integer baseGuestCount) {
        this.baseGuestCount = baseGuestCount;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public List<EventPackageServiceEntity> getServices() {
        return services;
    }

    public void setServices(List<EventPackageServiceEntity> services) {
        this.services = services;
    }

    public EventTypeEntity getEventType() {
        return eventType;
    }

    public void setEventType(EventTypeEntity eventType) {
        this.eventType = eventType;
    }

    public int getGrand_total_cost() {
        return grand_total_cost;
    }

    public void setGrand_total_cost(int grand_total_cost) {
        this.grand_total_cost = grand_total_cost;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public LocalDate getEventStartDate() {
        return eventStartDate;
    }

    public void setEventStartDate(LocalDate eventStartDate) {
        this.eventStartDate = eventStartDate;
    }

    public LocalDate getEventEndDate() {
        return eventEndDate;
    }

    public void setEventEndDate(LocalDate eventEndDate) {
        this.eventEndDate = eventEndDate;
    }

    public int getNumberOfRooms() {
        return numberOfRooms;
    }

    public void setNumberOfRooms(int numberOfRooms) {
        this.numberOfRooms = numberOfRooms;
    }

    public boolean isGstIncluded() {
        return gstIncluded;
    }

    public void setGstIncluded(boolean gstIncluded) {
        this.gstIncluded = gstIncluded;
    }

    public boolean isShowBreakup() {
        return showBreakup;
    }

    public void setShowBreakup(boolean showBreakup) {
        this.showBreakup = showBreakup;
    }


}
