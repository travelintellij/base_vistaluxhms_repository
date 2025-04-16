package com.vistaluxevent.entity;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "event_master_service")
public class EventMasterServiceEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String description;

    @Enumerated(EnumType.STRING)
    private ServiceType type;

    private int baseCost;
    private Boolean isActive;
    private LocalDateTime createdAt;

    // Getters & Setters
}
