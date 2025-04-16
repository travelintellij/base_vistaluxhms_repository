package com.vistaluxevent.entity;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "event_package")
public class EventPackageEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String packageName;
    private String description;
    private Integer baseGuestCount;
    private String createdBy;


    @OneToMany(mappedBy = "eventPackage", cascade = CascadeType.ALL)
    private List<EventPackageServiceEntity> services = new ArrayList<>();

    // Getters & Setters
}
