package com.vistaluxevent.repository;

import com.vistaluxevent.entity.EventServiceCostTypeEntity;
import com.vistaluxevent.entity.EventTypeEntity;
import com.vistaluxhms.entity.RateTypeEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EventServiceCostTypeRepository extends JpaRepository<EventServiceCostTypeEntity, Integer> {
    List<EventServiceCostTypeEntity> findByActive(boolean active);
}