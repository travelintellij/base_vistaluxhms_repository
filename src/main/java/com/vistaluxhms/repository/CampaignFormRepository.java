package com.vistaluxhms.repository;

import com.vistaluxhms.entity.CampaignFormEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CampaignFormRepository extends JpaRepository<CampaignFormEntity, Long> {

    @Query("FROM CampaignFormEntity c WHERE c.formType = ?1 AND c.active = true")
    List<CampaignFormEntity> findActiveByFormType(String formType);

    @Query("FROM CampaignFormEntity c WHERE c.active = true ORDER BY c.createdAt DESC")
    List<CampaignFormEntity> findAllActive();

    List<CampaignFormEntity> findAllByOrderByCreatedAtDesc();
}
