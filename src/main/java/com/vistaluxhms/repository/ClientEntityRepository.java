package com.vistaluxhms.repository;

import com.vistaluxhms.entity.City_Entity;
import com.vistaluxhms.entity.ClientEntity;
import com.vistaluxhms.entity.SalesPartnerEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface ClientEntityRepository extends JpaRepository<ClientEntity, Long>, JpaSpecificationExecutor<ClientEntity> {
    @Query("FROM ClientEntity a WHERE a.active=true")
    List<ClientEntity> findAllActiveClients();

    boolean existsByclientIdAndClientName(long clientId, String clientName);

    ClientEntity findFirstBySalesPartner_salesPartnerIdAndSalesPartnerFlag(Long salesPartnerId, Boolean salesPartnerFlag);
}