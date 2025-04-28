package com.vistaluxevent.repository;

import com.vistaluxevent.entity.EventPackageEntity;
import com.vistaluxhms.entity.LeadEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface EventPackageRepository extends JpaRepository<EventPackageEntity, Long>, JpaSpecificationExecutor<EventPackageEntity> {
}
