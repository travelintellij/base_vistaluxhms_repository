package com.vistaluxhms.model;

import java.sql.Date;
import java.util.Collection;
import java.util.stream.Collectors;

import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import com.vistaluxhms.entity.AshokaTeam;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class UserDetailsObj extends AshokaTeam implements UserDetails{


    private String currentPassword; // this is the password entered by user to match his current password.
	private String changedPassword; // this is the new password.
	private String passwordConfirm;//this is the new confirm password.
	private String roleName;
	private int roleId;
	private String formattedDOJ;
	private String formattedDOB;
	private String formattedDOL;
	
    @Override
    public String getPassword() {
        return super.getPassword();
    }

    @Override
    public String getUsername() {
        return super.getUsername();
    }


	public UserDetailsObj(AshokaTeam  user) {
    	super(user);
		/*
		 * this.username = user.getUserName();
    	this.password=user.getPassword();
    	this.active=user.getActive();
    	this.address = user.getAddress();
    	this.fixedIncentive=user.getFixedIncentive();
    	this.mobile=user.getMobile();
    	this.name=user.getName();
    	this.shift=user.getShift();
    	this.type=user.getType();
    	this.userId=user.getUserId();
    	this.doj = user.getDoj();
    	this.dob = user.getDob();
    	this.designation=user.getDesignation();
    	this.email=user.getEmail();
    	this.lastWorkingDay=user.getLastWorkingDay();
		this.personalEmail = user.getPersonalEmail();
		this.personalMobile= user.getPersonalMobile();
		this.panCard= user.getPanCard();
		this.aadharCard= user.getAadharCard();
		this.gender= user.getGender();
		this.maritalStatus= user.getMaritalStatus();
		this.remarks= user.getRemarks();
		
		this.accountExpired=user.isAccountExpired();
		this.accountLocked=user.isAccountLocked() ;
		this.credentialsExpired=user.isCredentialsExpired();
		//this.roles = user.getRoles();
		*/
    }
    public UserDetailsObj() {
    	
    }
    
    @Transient
    public String getPasswordConfirm() {
        return passwordConfirm;
    }

    public void setPasswordConfirm(String passwordConfirm) {
        this.passwordConfirm = passwordConfirm;
    }
	
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		 return getRoles()
	                .stream()
	                .map(role -> new SimpleGrantedAuthority("ROLE_" + role.getRoleName()))
	                .collect(Collectors.toList());
	}
	
    
	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return !isAccountExpired();
	}
	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return !isAccountLocked();
	}
	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return !isCredentialsExpired();
	}
	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return isActive();
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getChangedPassword() {
		return changedPassword;
	}

	public void setChangedPassword(String changedPassword) {
		this.changedPassword = changedPassword;
	}

	public String getCurrentPassword() {
		return currentPassword;
	}

	public void setCurrentPassword(String currentPassword) {
		this.currentPassword = currentPassword;
	}

	
	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	public void updateUserVoFromEntity(AshokaTeam userEntity) {
		this.username = userEntity.getUsername();
    	this.password=userEntity.getPassword();
    	this.active=userEntity.isActive();
    	this.address = userEntity.getAddress();
    	this.fixedIncentive=userEntity.getFixedIncentive();
    	this.mobile=userEntity.getMobile();
    	this.name=userEntity.getName();
    	this.shift=userEntity.getShift();
    	this.type=userEntity.getType();
    	this.userId=userEntity.getUserId();
    	this.doj = userEntity.getDoj();
    	this.dob = userEntity.getDob();
    	this.designation=userEntity.getDesignation();
    	this.email=userEntity.getEmail();
    	this.lastWorkingDay=userEntity.getLastWorkingDay();
		this.personalEmail = userEntity.getPersonalEmail();
		this.personalMobile= userEntity.getPersonalMobile();
		this.panCard= userEntity.getPanCard();
		this.aadharCard= userEntity.getAadharCard();
		this.gender= userEntity.getGender();
		this.maritalStatus= userEntity.getMaritalStatus();
		this.remarks= userEntity.getRemarks();
		
		this.accountExpired=userEntity.isAccountExpired();
		this.accountLocked=userEntity.isAccountLocked() ;
		this.credentialsExpired=userEntity.isCredentialsExpired();
		this.setRoles(userEntity.getRoles());
		this.deleted = userEntity.isDeleted();
		
	}

	@Override
	public String toString() {
		return "UserDetailsObj{" +
				"currentPassword='" + currentPassword + '\'' +
				", changedPassword='" + changedPassword + '\'' +
				", passwordConfirm='" + passwordConfirm + '\'' +
				", roleName='" + roleName + '\'' +
				", roleId=" + roleId +
				", userId=" + userId +
				", username='" + username + '\'' +
				", password='" + password + '\'' +
				", active=" + active +
				", name='" + name + '\'' +
				", address='" + address + '\'' +
				", mobile=" + mobile +
				", type='" + type + '\'' +
				", shift='" + shift + '\'' +
				", fixedIncentive=" + fixedIncentive +
				", dob=" + dob +
				", doj=" + doj +
				", designation='" + designation + '\'' +
				", email='" + email + '\'' +
				", lastWorkingDay=" + lastWorkingDay +
				", personalEmail='" + personalEmail + '\'' +
				", personalMobile=" + personalMobile +
				", panCard='" + panCard + '\'' +
				", aadharCard='" + aadharCard + '\'' +
				", gender='" + gender + '\'' +
				", maritalStatus='" + maritalStatus + '\'' +
				", remarks='" + remarks + '\'' +
				", accountExpired=" + accountExpired +
				", accountLocked=" + accountLocked +
				", credentialsExpired=" + credentialsExpired +
				", deleted=" + deleted +
				", roles=" + roles +
				'}';
	}

	public String getFormattedDOJ() {
		return formattedDOJ;
	}

	public void setFormattedDOJ(String formattedDOJ) {
		this.formattedDOJ = formattedDOJ;
	}

	public String getFormattedDOB() {
		return formattedDOB;
	}

	public void setFormattedDOB(String formattedDOB) {
		this.formattedDOB = formattedDOB;
	}

	public String getFormattedDOL() {
		return formattedDOL;
	}

	public void setFormattedDOL(String formattedDOL) {
		this.formattedDOL = formattedDOL;
	}
}