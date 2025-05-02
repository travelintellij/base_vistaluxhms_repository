package com.vistaluxevent.repository;

import com.vistaluxevent.entity.EventPackageEntity;
import com.vistaluxevent.entity.EventPackageServiceEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface EventPackageServiceRepository extends JpaRepository<EventPackageServiceEntity, Long>, JpaSpecificationExecutor<EventPackageServiceEntity> {
}
