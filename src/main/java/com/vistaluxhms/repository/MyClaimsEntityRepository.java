package com.vistaluxhms.repository;

import com.vistaluxhms.entity.ClientEntity;
import com.vistaluxhms.entity.MyClaimsEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface MyClaimsEntityRepository extends JpaRepository<MyClaimsEntity, Long>, JpaSpecificationExecutor<ClientEntity> {

}