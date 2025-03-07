package com.vistaluxhms.repository;

import com.vistaluxhms.entity.SessionDetailsEntity;
import com.vistaluxhms.entity.SessionEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface SessionRepository extends JpaRepository<SessionEntity, Long>, JpaSpecificationExecutor<SessionEntity> {

}