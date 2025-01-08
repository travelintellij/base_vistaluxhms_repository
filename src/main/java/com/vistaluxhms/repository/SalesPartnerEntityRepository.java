package com.vistaluxhms.repository;

import com.vistaluxhms.entity.SalesPartnerEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface SalesPartnerEntityRepository extends JpaRepository<SalesPartnerEntity, Long>, JpaSpecificationExecutor<SalesPartnerEntity> {
    List<SalesPartnerEntity> findByActive(boolean active);
}