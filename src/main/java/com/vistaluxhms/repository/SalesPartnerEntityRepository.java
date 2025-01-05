package com.vistaluxhms.repository;

import com.vistaluxhms.entity.SalesPartnerEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface SalesPartnerEntityRepository extends JpaRepository<SalesPartnerEntity, Long>, JpaSpecificationExecutor<SalesPartnerEntity> {
}