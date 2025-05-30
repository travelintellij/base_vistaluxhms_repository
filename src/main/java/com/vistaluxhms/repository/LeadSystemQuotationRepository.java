package com.vistaluxhms.repository;


import com.vistaluxhms.entity.LeadSystemQuotationEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface LeadSystemQuotationRepository extends JpaRepository<LeadSystemQuotationEntity, Long> {

    List<LeadSystemQuotationEntity> findByLeadEntity_LeadIdOrderByVersionIdDesc(Long leadId);

    @Query("SELECT MAX(l.versionId) FROM LeadSystemQuotationEntity l WHERE l.leadEntity.leadId = :leadId")
    Integer findMaxVersionIdOfQuotationByLeadId(Long leadId);


}

