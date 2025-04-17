package com.vistaluxevent.entity;

import javax.persistence.*;

@Entity
@Table(name = "event_service_cost_type")
public class EventServiceCostTypeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "eventServiceCostTypeId")
    private Integer eventServiceCostTypeId;

    @Column(name = "eventServiceCostTypeName", nullable = false, length = 100)
    private String eventServiceCostTypeName;

    @Column(name = "active")
    private Boolean active;

    public Integer getEventServiceCostTypeId() {
        return eventServiceCostTypeId;
    }

    public void setEventServiceCostTypeId(Integer eventServiceCostTypeId) {
        this.eventServiceCostTypeId = eventServiceCostTypeId;
    }

    public String getEventServiceCostTypeName() {
        return eventServiceCostTypeName;
    }

    public void setEventServiceCostTypeName(String eventServiceCostTypeName) {
        this.eventServiceCostTypeName = eventServiceCostTypeName;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }
}
