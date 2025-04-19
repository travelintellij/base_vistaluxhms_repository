package com.vistaluxevent.entity;

import com.vistaluxevent.model.EventMasterServiceDTO;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "event_master_service")
public class EventMasterServiceEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    protected Integer id;

    protected String name;
    protected String description;

    @ManyToOne
    @JoinColumn(name = "eventServiceCostTypeId", nullable = false)
    private EventServiceCostTypeEntity eventServiceCostTypeEntity;

    protected int baseCost;
    protected Boolean active;


    protected int eventTypeId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public EventServiceCostTypeEntity getEventServiceCostTypeEntity() {
        return eventServiceCostTypeEntity;
    }

    public void setEventServiceCostTypeEntity(EventServiceCostTypeEntity eventServiceCostTypeEntity) {
        this.eventServiceCostTypeEntity = eventServiceCostTypeEntity;
    }

    public int getBaseCost() {
        return baseCost;
    }

    public void setBaseCost(int baseCost) {
        this.baseCost = baseCost;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    

    public void updateEntityFromDTO(EventMasterServiceDTO eventMasterServiceDTO) {
        this.id = eventMasterServiceDTO.getId();
        this.name = eventMasterServiceDTO.getName();
        this.description = eventMasterServiceDTO.getDescription();
        this.eventServiceCostTypeEntity = eventMasterServiceDTO.getEventServiceCostTypeEntity();
        this.baseCost = eventMasterServiceDTO.getBaseCost();
        this.eventTypeId = eventMasterServiceDTO.getEventTypeId();
        this.active = eventMasterServiceDTO.getActive();
    }

    public int getEventTypeId() {
        return eventTypeId;
    }

    public void setEventTypeId(int eventTypeId) {
        this.eventTypeId = eventTypeId;
    }
}
