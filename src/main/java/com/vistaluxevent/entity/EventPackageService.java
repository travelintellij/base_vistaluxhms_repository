package com.vistaluxevent.entity;

import javax.persistence.*;

@Entity
@Table(name = "event_package_service")
public class EventPackageService {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "package_id")
    private EventPackage eventPackage;

    private String serviceName;

    @Enumerated(EnumType.STRING)
    private ServiceType serviceType;

    private int costPerUnit;
    private Integer quantity;
    private int totalCost;
    private Boolean isCustom;

    // Getters & Setters
}

