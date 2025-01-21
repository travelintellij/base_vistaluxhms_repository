package com.vistaluxhms.repository;

import com.vistaluxhms.entity.LeadEntity;
import com.vistaluxhms.entity.Workload_Status_Entity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface LeadEntityRepository extends JpaRepository<LeadEntity, Long>, JpaSpecificationExecutor<LeadEntity> {
    @Query("FROM Workload_Status_Entity a where a.workloadStatusObj=?1 order by a.workloadStatusId")
    List<Workload_Status_Entity> find_All_Status_Workload_Obj(String workloadObj);
}