package com.vistaluxhms.services;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;
import javax.validation.Valid;

import com.vistaluxhms.entity.AshokaTeam;
import com.vistaluxhms.entity.RoleEntity;
import com.vistaluxhms.exception.RecordNotFoundException;
import com.vistaluxhms.model.SearchUserObj;
import com.vistaluxhms.model.UserDetailsObj;
import com.vistaluxhms.repository.RoleRepository;
import com.vistaluxhms.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;




@Service
public class UserDetailsServiceImpl implements UserDetailsService{

	@Autowired
	UserRepository userRepository;
	
	@Autowired
	RoleRepository roleRepository;
	

	@Override
	public UserDetailsObj loadUserByUsername(String userName) throws UsernameNotFoundException {
	    
		Optional<AshokaTeam> optionalUsers = userRepository.findByUsernameAndActiveAndDeletedAndAccountLockedAndAccountExpiredAndCredentialsExpired(userName,true,false,false,false,false);

        optionalUsers
                .orElseThrow(() -> new UsernameNotFoundException("Username not found"));
        return optionalUsers
                .map(UserDetailsObj::new).get();
		/*
		Optional<UdnTeam> optionalUser = userRepository.findByUsernameAndActive(userName,true);
        
		
		if(optionalUser.isPresent()) {
        	UdnTeam users = optionalUser.get();
        
        UserDetails user = User.builder()
                	.username(users.getUsername())
                	//change here to store encoded password in db
                	//.password( bCryptPasswordEncoder.encode(users.getPassword()) )
                	.password(users.getPassword())
                	.disabled(!users.isActive())
                	.accountExpired(users.isAccountExpired())
                	.accountLocked(users.isAccountLocked())
                	.credentialsExpired(users.isCredentialsExpired())
                	.roles(roleList.toArray(new String[0]))
                	.build();
                	 
        	//UserDetailsObj userObj =optionalUser.map(UserDetailsObj::new).get(); 
        	
            return userObj;
        } else {
        	throw new UsernameNotFoundException("User Name is not Found");
        }   
        */
	}
	
	public List<UserDetailsObj> findAllUsers(){
		List<AshokaTeam> listUdnTeam= userRepository.findAll(Sort.by(Sort.Order.desc("active")));
		List<UserDetailsObj> listUdnObj = new ArrayList<UserDetailsObj>();
		Iterator<AshokaTeam>  itr = listUdnTeam.iterator();
		while(itr.hasNext()) {
			UserDetailsObj userObj = new UserDetailsObj(itr.next());
			listUdnObj.add(userObj);
		}
		return listUdnObj;
	}
	
	
	public List<UserDetailsObj> findAllActiveUsers(){
		//List<UdnTeam> listUdnTeam= userRepository.findAllActiveUsers();
		List<AshokaTeam> listUdnTeam= userRepository.findByActiveAndAccountExpired(true,false);
		
		List<UserDetailsObj> listUdnObj = new ArrayList<UserDetailsObj>();
		Iterator<AshokaTeam>  itr = listUdnTeam.iterator();
		while(itr.hasNext()) {
			UserDetailsObj userObj = new UserDetailsObj(itr.next());
			listUdnObj.add(userObj);
		}
		return listUdnObj;
	}
	
	
	public AshokaTeam createOrUpdateUser(AshokaTeam entity) throws RecordNotFoundException
    {
	   entity = userRepository.save(entity);
	   return entity;
	   //Optional<UdnIncentiveEntity> incentive = incentiveRepository.findById((long) entity.getIncentiveId());
	   //if(incentive.isPresent()) 
            //entity = incentiveRepository.save(entity);
    } 
	
	/*
	public List<Udn_Services_Master_Obj> findAllActiveUdnServices(){
		List<Udn_Services_Master_Entity> listUdnServicesEntity= userRepository.findAllActiveUdnServices();
		List<Udn_Services_Master_Obj> listUdnMasterServicesObj = new ArrayList<Udn_Services_Master_Obj>();
		Iterator<Udn_Services_Master_Entity>  itr = listUdnServicesEntity.iterator();
		while(itr.hasNext()) {
			Udn_Services_Master_Obj udnMastrSrvObj = new Udn_Services_Master_Obj(itr.next());
			listUdnMasterServicesObj.add(udnMastrSrvObj);
		}
		return listUdnMasterServicesObj; 
	}
	*/
	public AshokaTeam findUserByID(int userId) {
		return userRepository.findById(userId).get();
	}
	
	
	public List<AshokaTeam>  search_Filtered_Users(SearchUserObj filterUserList) {
		List<AshokaTeam> filteredUsersList = userRepository.findAll(new Specification<AshokaTeam>() {
			@Override
			public Predicate toPredicate(Root<AshokaTeam> userEntity, CriteriaQuery< ?> query, CriteriaBuilder criteriaBuilder) {
				//CriteriaQuery<Udn_Deals_Recorder_Entity> criteriaQueryDeal = criteriaBuilder.createQuery(Udn_Deals_Recorder_Entity.class);
				List<Predicate> predicates = new ArrayList<>();
				
				if(filterUserList.getUserId()!=0) {
					predicates.add(criteriaBuilder.equal(userEntity.get("userId"), filterUserList.getUserId()));
				}
				 
				if ((filterUserList.getUsername() != null) && (filterUserList.getUsername().trim().length()>0)) {
					predicates.add(criteriaBuilder.like(criteriaBuilder.lower(userEntity.get("username")),"%" + filterUserList.getUsername().toLowerCase() + "%"));
				}

				if ((filterUserList.getName() != null) && (filterUserList.getName().trim().length()>0)) {
					predicates.add(criteriaBuilder.like(criteriaBuilder.lower(userEntity.get("name")),"%" + filterUserList.getName().toLowerCase() + "%"));
				}

				return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
			}
		});
		
		return filteredUsersList;
	}
	
	public void deleteUser(int userId) {
		userRepository.deleteById(userId);
	}
	
	//This method returns the roleTarget as key and all role Entities as list having the key role target.
	public Map<String, List<RoleEntity>> find_All_Roles(){
		List<String> roleTargetList = roleRepository.find_All_Roles_Distinct_by_Target();
		Iterator<String> itrTargetList = roleTargetList.iterator();
		Map<String, List<RoleEntity>> roleMap = new HashMap<String, List<RoleEntity>>();
		while(itrTargetList.hasNext()) {
			String roleTarget =  (String) itrTargetList.next();
			List<RoleEntity> listRoleEntity = roleRepository.findByRoleTarget(roleTarget);
			roleMap.put(roleTarget, listRoleEntity);
		}
		return roleMap;
	}
	
	@Transactional
	public void updateUserPermissions(UserDetailsObj userDetailsObj) throws RecordNotFoundException {
		AshokaTeam orgUserRecord = findUserByID(userDetailsObj.getUserId());
		
		List<RoleEntity> existingTargetRoles = orgUserRecord.getRoles().stream().filter(role -> role.getRoleTarget().equalsIgnoreCase(userDetailsObj.getRoleName()))
                .collect(Collectors.toList());
		
		Set<RoleEntity> rolesToUpdate = userDetailsObj.getRoles();
		
		Iterator itrExistingRoles = existingTargetRoles.iterator();
		List rolesToDelete = new ArrayList();
		while(itrExistingRoles.hasNext()) {
			RoleEntity roleEntity = (RoleEntity) itrExistingRoles.next();
			if(!rolesToUpdate.contains(roleEntity)) {
				rolesToDelete.add(roleEntity);
			}
		}
		rolesToUpdate.removeAll(existingTargetRoles);
				
		orgUserRecord.getRoles().removeAll(rolesToDelete);
		orgUserRecord.getRoles().addAll(rolesToUpdate);
	
		createOrUpdateUser(orgUserRecord);
		
		
		
		//following code will reload the logged in user object so that security settings are not required to be refreshed by logout and then relogin.
		/*Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		List<GrantedAuthority> updatedAuthorities = new ArrayList<>(auth.getAuthorities());
		Authentication newAuth = new UsernamePasswordAuthenticationToken(auth.getPrincipal(), auth.getCredentials(), updatedAuthorities);
		SecurityContextHolder.getContext().setAuthentication(newAuth);
		request.getSession().setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY, SecurityContextHolder.getContext());
		*/
		/*
		System.out.println("*********************Existing Roles *********************************");
		System.out.println(existingTargetRoles);
		System.out.println("*********************New Roles ********************");
		System.out.println(rolesToUpdate);
		System.out.println("*********************Roles to Delete***************************");
		System.out.println(rolesToDelete);
		System.out.println("*********************Roles to Add ***************************");
		System.out.println(rolesToUpdate);
		*/
	}

	public RoleEntity findRoleById(int roleId) {
		return roleRepository.findById(roleId).get();
	}
	
	public Optional<AshokaTeam> findUserByUserName(String userName) {
		return userRepository.findByUsername(userName);
	}

}
