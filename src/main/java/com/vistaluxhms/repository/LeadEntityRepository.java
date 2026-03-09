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

    // ===== AI MODIFICATION START =====
    // Change: Added dashboard analytics query methods
    // Reason: Dashboard needs lead counts by status for charts (admin = all, user =
    // own leads)
    // Scope: LeadEntityRepository — used by LoginController for dashboard data

    // Count all leads (for admin)
    long count();

    // Count leads by status (for admin)
    long countByLeadStatus(int leadStatus);

    // Count qualified leads (for admin)
    long countByQualifiedTrue();

    // Count flagged leads (for admin)
    long countByFlaggedTrue();

    // Count leads by owner (for normal user)
    long countByLeadOwner(int leadOwner);

    // Count leads by owner and status (for normal user)
    long countByLeadOwnerAndLeadStatus(int leadOwner, int leadStatus);

    // Count qualified leads by owner (for normal user)
    long countByLeadOwnerAndQualifiedTrue(int leadOwner);

    // Count flagged leads by owner (for normal user)
    long countByLeadOwnerAndFlaggedTrue(int leadOwner);

    // ===== AI MODIFICATION END =====
}