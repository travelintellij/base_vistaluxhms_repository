package com.vistaluxhms.repository;

import com.vistaluxhms.entity.CentralConfigEntity;
import com.vistaluxhms.entity.LeadEntity;
import com.vistaluxhms.entity.Workload_Status_Entity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CentralConfigEntityRepository extends JpaRepository<CentralConfigEntity, Integer>, JpaSpecificationExecutor<CentralConfigEntity> {

}