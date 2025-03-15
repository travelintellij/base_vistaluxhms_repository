package com.vistaluxhms.repository;

import com.vistaluxhms.entity.RateTypeEntity;
import com.vistaluxhms.entity.RoleEntity;
import com.vistaluxhms.entity.SalesPartnerEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RateTypeRepository extends JpaRepository<RateTypeEntity,Integer> {

    List<RateTypeEntity> findByActive(boolean active);
}
