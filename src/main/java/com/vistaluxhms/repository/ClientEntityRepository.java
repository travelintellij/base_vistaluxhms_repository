package com.vistaluxhms.repository;

import com.vistaluxhms.entity.ClientEntity;
import com.vistaluxhms.entity.SalesPartnerEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface ClientEntityRepository extends JpaRepository<ClientEntity, Long>, JpaSpecificationExecutor<ClientEntity> {
}