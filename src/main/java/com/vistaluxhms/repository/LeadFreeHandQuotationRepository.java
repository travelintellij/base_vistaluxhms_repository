package com.vistaluxhms.repository;


import com.vistaluxhms.entity.LeadFreeHandQuotationEntity;
import com.vistaluxhms.entity.LeadSystemQuotationEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface LeadFreeHandQuotationRepository extends JpaRepository<LeadFreeHandQuotationEntity, Long> {

    List<LeadFreeHandQuotationEntity> findByLeadEntity_LeadIdOrderByVersionIdDesc(Long leadId);

    @Query("SELECT MAX(l.versionId) FROM LeadFreeHandQuotationEntity l WHERE l.leadEntity.leadId = :leadId")
    Integer findMaxVersionIdOfQuotationByLeadId(Long leadId);


}

