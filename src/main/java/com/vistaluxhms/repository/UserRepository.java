package com.vistaluxhms.repository;

import java.util.List;
import java.util.Optional;

import javax.persistence.OrderBy;

import com.vistaluxhms.entity.AshokaTeam;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<AshokaTeam,Integer>,JpaSpecificationExecutor{
		//UdnTeam findByUserNameAndActive(String userName,boolean active);
		Optional<AshokaTeam> findByUsernameAndActive(String userName,boolean active);
		
		Optional<AshokaTeam> findByUsernameAndActiveAndDeletedAndAccountLockedAndAccountExpiredAndCredentialsExpired(String userName,boolean active,boolean deleted,boolean locked, boolean accountExpired, boolean credentialsExpired);
		
		Optional<AshokaTeam> findByUsername(String userName);
		
		@Query("FROM AshokaTeam a WHERE a.active=true")
		List <AshokaTeam>findAllActiveUsers();
		
/*
		@Query("FROM Udn_Services_Master_Entity a WHERE a.active=true")
		List <Udn_Services_Master_Entity>findAllActiveUdnServices();
		
		@Query("FROM Udn_Services_Master_Entity a WHERE a.id=?1 AND a.active=true")
		Udn_Services_Master_Entity findUserById(int id);


 */
		List<AshokaTeam> findByActiveAndAccountExpired(boolean active,boolean isExpired);
		
}