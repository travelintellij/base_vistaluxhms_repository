package com.vistaluxevent.entity;

import javax.persistence.*;
@Entity
@Table(name = "event_package")
public class EventPackage {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String packageName;
    private String description;
    private Integer baseGuestCount;
    private String createdBy;


    @OneToMany(mappedBy = "eventPackage", cascade = CascadeType.ALL)
    private List<EventPackageService> services = new ArrayList<>();

    // Getters & Setters
}
