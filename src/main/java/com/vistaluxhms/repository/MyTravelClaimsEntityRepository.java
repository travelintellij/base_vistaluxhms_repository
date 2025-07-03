package com.vistaluxhms.repository;

import com.vistaluxhms.entity.ClientEntity;
import com.vistaluxhms.entity.MyClaimsEntity;
import com.vistaluxhms.entity.MyTravelClaimsEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface MyTravelClaimsEntityRepository extends JpaRepository<MyTravelClaimsEntity, Long>, JpaSpecificationExecutor<MyTravelClaimsEntity> {

}