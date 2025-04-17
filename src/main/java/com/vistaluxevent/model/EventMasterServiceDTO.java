package com.vistaluxevent.model;

import com.vistaluxevent.entity.EventMasterServiceEntity;

public class EventMasterServiceDTO extends EventMasterServiceEntity {
    public String eventTypeName;


    public void updateDTOFromEntity(EventMasterServiceEntity eventMasterServiceEntity){
        this.id = eventMasterServiceEntity.getId();
        this.name = eventMasterServiceEntity.getName();
        this.description = eventMasterServiceEntity.getDescription();
        this.setEventServiceCostTypeEntity(eventMasterServiceEntity.getEventServiceCostTypeEntity());
        this.baseCost = eventMasterServiceEntity.getBaseCost();
        this.eventTypeId = eventMasterServiceEntity.getEventTypeId();
        this.active = eventMasterServiceEntity.getActive();
    }

    public String getEventTypeName() {
        return eventTypeName;
    }

    public void setEventTypeName(String eventTypeName) {
        this.eventTypeName = eventTypeName;
    }
}
