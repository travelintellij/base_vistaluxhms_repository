package com.vistaluxhms.repository;

import java.util.List;

import com.vistaluxhms.entity.RoleEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;


@Repository
public interface RoleRepository extends JpaRepository<RoleEntity,Integer>{

	@Query("select distinct roleTarget FROM RoleEntity a")
	List<String> find_All_Roles_Distinct_by_Target();

	List<RoleEntity> findByRoleTarget(String roleTarget);
} 