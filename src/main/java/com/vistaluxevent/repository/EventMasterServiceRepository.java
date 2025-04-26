package com.vistaluxevent.repository;


import com.vistaluxevent.entity.EventMasterServiceEntity;
import com.vistaluxhms.entity.RateTypeEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface EventMasterServiceRepository extends JpaRepository<EventMasterServiceEntity, Integer> {
    List<EventMasterServiceEntity> findByActive(boolean active);
    List<EventMasterServiceEntity> findByEventTypeIdAndActive(Integer eventTypeId,boolean active);
}
