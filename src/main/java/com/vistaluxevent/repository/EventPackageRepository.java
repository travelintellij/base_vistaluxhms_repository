package com.vistaluxevent.repository;

import com.vistaluxevent.entity.EventPackageEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EventPackageRepository extends JpaRepository<EventPackageEntity, Long> {
}
