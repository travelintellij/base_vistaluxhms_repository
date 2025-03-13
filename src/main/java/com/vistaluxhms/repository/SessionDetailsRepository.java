package com.vistaluxhms.repository;

import com.vistaluxhms.entity.LeadEntity;
import com.vistaluxhms.entity.SessionDetailId;
import com.vistaluxhms.entity.SessionDetailsEntity;
import com.vistaluxhms.entity.Workload_Status_Entity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface SessionDetailsRepository extends JpaRepository<SessionDetailsEntity, SessionDetailId>, JpaSpecificationExecutor<SessionDetailsEntity> {
    Optional<SessionDetailsEntity> findById(SessionDetailId id);


}