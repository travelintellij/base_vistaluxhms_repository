package com.vistaluxhms.repository;

import com.vistaluxhms.entity.SalesPartnerEntity;
import com.vistaluxhms.entity.TravelClaimBillEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface TravelClaimBillRepository extends JpaRepository<TravelClaimBillEntity, Long>, JpaSpecificationExecutor<TravelClaimBillEntity> {
}
