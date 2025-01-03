package com.vistaluxhms.repository;

import com.vistaluxhms.entity.RateTypeEntity;
import com.vistaluxhms.entity.RoleEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RateTypeRepository extends JpaRepository<RateTypeEntity,Long> {
}
