package com.vistaluxhms.repository;

import com.vistaluxhms.entity.SessionEntity;
import com.vistaluxhms.entity.StatusEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface StatusRepository extends JpaRepository<StatusEntity, Integer>, JpaSpecificationExecutor<StatusEntity> {

    List<StatusEntity> findByStatusObjAndActive(String statusObj,boolean active);
    List<StatusEntity> findByActiveTrue();
}