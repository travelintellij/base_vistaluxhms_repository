package com.vistaluxevent.repository;


import com.vistaluxevent.entity.EventMasterServiceEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface EventMasterServiceRepository extends JpaRepository<EventMasterServiceEntity, Integer> {
}
