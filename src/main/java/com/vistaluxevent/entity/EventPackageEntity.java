package com.vistaluxevent.entity;

import javax.persistence.*;
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

    // Getters & Setters
}
