package com.vistaluxhms.repository;

import com.vistaluxhms.entity.LeadEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface LeadEntityRepository extends JpaRepository<LeadEntity, Long>, JpaSpecificationExecutor<LeadEntity> {
}