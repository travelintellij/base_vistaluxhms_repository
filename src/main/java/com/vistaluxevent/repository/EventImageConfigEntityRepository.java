package com.vistaluxevent.repository;

import com.vistaluxevent.entity.EventDetailsConfigEntity;
import com.vistaluxevent.entity.EventImageConfigEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface EventImageConfigEntityRepository extends JpaRepository<EventImageConfigEntity, Long> {
    Optional<EventImageConfigEntity> findByEventDetailsAndImageIndex(EventDetailsConfigEntity details, int imageIndex);
    List<EventImageConfigEntity> findByEventDetailsOrderByImageIndex(EventDetailsConfigEntity details);
    List<EventImageConfigEntity> findByEventDetails(EventDetailsConfigEntity eventDetails);
    List<EventImageConfigEntity> findByEventDetails_IdOrderByImageIndex(Long id);
}