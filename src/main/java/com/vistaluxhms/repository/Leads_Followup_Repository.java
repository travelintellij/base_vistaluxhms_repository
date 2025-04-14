package com.vistaluxhms.repository;
import com.vistaluxhms.entity.Leads_Followup_Entity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface Leads_Followup_Repository extends JpaRepository<Leads_Followup_Entity,Long>,JpaSpecificationExecutor{
	List<Leads_Followup_Entity> findByLeadEntity_leadIdOrderByNextfollowuptimeDesc(Long leadId);
	
} 