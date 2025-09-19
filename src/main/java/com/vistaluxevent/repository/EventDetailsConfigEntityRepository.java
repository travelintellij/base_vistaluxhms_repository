package com.vistaluxevent.repository;

import com.vistaluxevent.entity.EventDetailsConfigEntity;
import com.vistaluxevent.entity.EventImageConfigEntity;
import com.vistaluxhms.util.EventType;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface EventDetailsConfigEntityRepository extends JpaRepository<EventDetailsConfigEntity, Long> {
    Optional<EventDetailsConfigEntity> findByEventType(EventType eventType);
    List<EventImageConfigEntity> findByEventDetailsConfigEntityOrderByImageIndex(EventDetailsConfigEntity eventDetails);

}