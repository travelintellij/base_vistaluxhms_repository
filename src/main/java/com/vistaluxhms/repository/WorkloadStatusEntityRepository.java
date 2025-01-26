package com.vistaluxhms.repository;

import com.vistaluxhms.entity.LeadEntity;
import com.vistaluxhms.entity.Workload_Status_Entity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface WorkloadStatusEntityRepository extends JpaRepository<Workload_Status_Entity, Integer>, JpaSpecificationExecutor<Workload_Status_Entity> {
    Optional<Workload_Status_Entity> findByWorkloadStatusId(int status);
}