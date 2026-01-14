package com.vistaluxhms.entity;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.validation.Valid;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.vistaluxhms.model.UserDetailsObj;

@Entity
@Table(name = "ashokateam")
public class AshokaTeam {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	protected int userId;

	@Column(nullable = false,name="username", unique = true)
	protected String username;

	@Column(nullable = false,name="password", unique = false)
	protected String password;

	/*@Column(nullable = false,name="roles", unique = false)
	private String roles;

	 */

	@Column(nullable = false,name="active", unique = false)
	protected boolean active=true;
	
	@Column(nullable = false,name="name", unique = false)
	protected String name;
	
	@Column(nullable = false,name="address", unique = false)
	protected String address;

	protected long mobile;
	
	@Column(nullable = false,name="type", unique = false)
	protected String type;
	
	
	@Column(nullable = false,name="shift", unique = false)
	protected String shift;
	
	@Column(nullable = false,name="fixedincentive", unique = false)
	protected long fixedIncentive;
	
	@Column(nullable = false,name="dob", unique = false)
	protected Date dob;
	
	@Column(nullable = false,name="doj", unique = false)
	protected Date doj;
	
	@Column(nullable = false,name="designation", unique = false)
	protected String designation;
	
	
	@Column(nullable = true,name="Email", unique = false)
	protected String email;
	
	@Column(nullable = true,name="lastWorkingDay", unique = false)
	protected Date lastWorkingDay;
	
	protected String personalEmail;
	protected long personalMobile;
	protected String panCard;
	protected String aadharCard;
	protected String gender;
	protected String maritalStatus;
	protected String remarks;
	
	protected boolean accountExpired;
	protected boolean accountLocked ;
	protected boolean credentialsExpired;
	protected boolean deleted;
	
	@ManyToMany(fetch = FetchType.EAGER)
	@JoinTable(name = "ashokateam_role",
		joinColumns = @JoinColumn(name = "userId"), 
		inverseJoinColumns = @JoinColumn(name = "roleId"))
	protected Set<RoleEntity> roles = new HashSet<RoleEntity>();

	/*
	@ManyToMany(targetEntity = Tg_Leads_Recorder_Entity.class,fetch = FetchType.LAZY)
    Set<Tg_Leads_Recorder_Entity> leads = new HashSet<>();
    
    @ManyToMany(targetEntity = Udn_Deals_Recorder_Entity.class,fetch = FetchType.LAZY)
    Set<Udn_Deals_Recorder_Entity> deals = new HashSet<>();


	 */
	public Date getLastWorkingDay() {
		return lastWorkingDay;
	}

	public void setLastWorkingDay(Date lastWorkingDay) {
		this.lastWorkingDay = lastWorkingDay;
	}

	public String getEmail() {
		return email;
	}
	

	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getDesignation() {
		return designation;
	}

	public void setDesignation(String designation) {
		this.designation = designation;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public long getMobile() {
		return mobile;
	}

	public void setMobile(long mobile) {
		this.mobile = mobile;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getShift() {
		return shift;
	}

	public void setShift(String shift) {
		this.shift = shift;
	}

	public long getFixedIncentive() {
		return fixedIncentive;
	}

	public void setFixedIncentive(long fixedIncentive) {
		this.fixedIncentive = fixedIncentive;
	}

	public Date getDob() {
		return dob;
	}

	public void setDob(Date dob) {
		this.dob = dob;
	}

	public Date getDoj() {
		return doj;
	}

	public void setDoj(Date doj) {
		this.doj = doj;
	}


	public AshokaTeam() {}

	public void updateUserEntityFromVoExcludingRoles(UserDetailsObj userDetailsObj) {
		this.userId = userDetailsObj.getUserId();
		this.active=true;
		this.address=userDetailsObj.getAddress();
		this.designation=userDetailsObj.getDesignation();
		this.dob=userDetailsObj.getDob();
		this.doj=userDetailsObj.getDoj();
		this.email=userDetailsObj.getEmail();
		this.name=userDetailsObj.getName();
		this.password=userDetailsObj.getPassword();
		this.shift=userDetailsObj.getShift();
		this.type=userDetailsObj.getType();
		this.username=userDetailsObj.getUsername();
		this.mobile=userDetailsObj.getMobile();
		this.fixedIncentive=userDetailsObj.getFixedIncentive();
		this.personalEmail = userDetailsObj.getPersonalEmail();
		this.personalMobile= userDetailsObj.getPersonalMobile();
		this.panCard= userDetailsObj.getPanCard();
		this.aadharCard= userDetailsObj.getAadharCard();
		this.gender= userDetailsObj.getGender();
		this.maritalStatus= userDetailsObj.getMaritalStatus();
		this.remarks= userDetailsObj.getRemarks();
		this.active=userDetailsObj.isActive();
		this.accountExpired=userDetailsObj.isAccountExpired();
		this.accountLocked=userDetailsObj.isAccountLocked() ;
		this.credentialsExpired=userDetailsObj.isCredentialsExpired();
		this.deleted=userDetailsObj.isDeleted();
		this.lastWorkingDay=userDetailsObj.getLastWorkingDay();
		//this.roles = userDetailsObj.getRoles();

	}
	
	public AshokaTeam(AshokaTeam userDetailsObj) {
		this.userId = userDetailsObj.getUserId();
		this.active=true;
		this.address=userDetailsObj.getAddress();
		this.designation=userDetailsObj.getDesignation();
		this.dob=userDetailsObj.getDob();
		this.doj=userDetailsObj.getDoj();
		this.email=userDetailsObj.getEmail();
		this.name=userDetailsObj.getName();
		this.password=userDetailsObj.getPassword();
		this.shift=userDetailsObj.getShift();
		this.type=userDetailsObj.getType();
		this.username=userDetailsObj.getUsername();
		this.mobile=userDetailsObj.getMobile();
		this.fixedIncentive=userDetailsObj.getFixedIncentive();
		this.personalEmail = userDetailsObj.getPersonalEmail();
		this.personalMobile= userDetailsObj.getPersonalMobile();
		this.panCard= userDetailsObj.getPanCard();
		this.aadharCard= userDetailsObj.getAadharCard();
		this.gender= userDetailsObj.getGender();
		this.maritalStatus= userDetailsObj.getMaritalStatus();
		this.remarks= userDetailsObj.getRemarks();
		this.active=userDetailsObj.isActive();
		this.roles = userDetailsObj.getRoles();
		this.accountExpired=userDetailsObj.isAccountExpired();
		this.accountLocked=userDetailsObj.isAccountLocked() ;
		this.credentialsExpired=userDetailsObj.isCredentialsExpired();
		this.roles = userDetailsObj.getRoles();
		this.deleted=userDetailsObj.isDeleted();
		this.lastWorkingDay=userDetailsObj.getLastWorkingDay();
	}
	
	
	public AshokaTeam(@Valid UserDetailsObj userDetailsObj) {
		this.userId = userDetailsObj.getUserId();
		this.active=true;
		this.address=userDetailsObj.getAddress();
		this.designation=userDetailsObj.getDesignation();
		this.dob=userDetailsObj.getDob();
		this.doj=userDetailsObj.getDoj();
		this.email=userDetailsObj.getEmail();
		this.name=userDetailsObj.getName();
		this.password=userDetailsObj.getPassword();
		this.shift=userDetailsObj.getShift();
		this.type=userDetailsObj.getType();
		this.username=userDetailsObj.getUsername();
		this.mobile=userDetailsObj.getMobile();
		this.fixedIncentive=userDetailsObj.getFixedIncentive();
		this.personalEmail = userDetailsObj.getPersonalEmail();
		this.personalMobile= userDetailsObj.getPersonalMobile();
		this.panCard= userDetailsObj.getPanCard();
		this.aadharCard= userDetailsObj.getAadharCard();
		this.gender= userDetailsObj.getGender();
		this.maritalStatus= userDetailsObj.getMaritalStatus();
		this.remarks= userDetailsObj.getRemarks();
		this.active=userDetailsObj.isActive();
		this.lastWorkingDay=userDetailsObj.getLastWorkingDay();
		this.accountExpired=userDetailsObj.isAccountExpired();
		this.accountLocked=userDetailsObj.isAccountLocked() ;
		this.credentialsExpired=userDetailsObj.isCredentialsExpired();

		if(userDetailsObj.getRoleName()!=null && userDetailsObj.getRoleName().trim().length()>0) {
	  		this.roles = new HashSet<RoleEntity>();
			RoleEntity entity = new RoleEntity();
	  		if(userDetailsObj.getRoleName().equalsIgnoreCase("ADMIN")) {
	        		entity.setRoleId(1);
	        		this.getRoles().add(entity);
	        	}
	        	else {
	        		entity.setRoleId(2);
	        		this.getRoles().add(entity);
	        	}
	        }
	}

	public int getUserId() {
		return userId;
	}
	public void setUserId(int id) {
		this.userId = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}

	public String toString() {
		
		String attribValue = "";
		attribValue = attribValue + "0.  User ID -> " + userId + "\n";
		attribValue = attribValue + "1.  Login ID -> " + username + "\n";
		attribValue = attribValue + "2.  Password -> " + password + "\n";
		
		attribValue = attribValue + "3.  Full Name -> " + name + "\n";
		attribValue = attribValue + "4.  Address -> " + address + "\n";
		attribValue = attribValue + "5.  Email  -> " + email + "\n";
		attribValue = attribValue + "6.  Mobile -> " + mobile + "\n";
		attribValue = attribValue + "7.  Designation -> " + designation + "\n";
		attribValue = attribValue + "8.  Type -> " + type + "\n";
		attribValue = attribValue + "9.  Shift -> " + shift + "\n";
		attribValue = attribValue + "10.  Fixed Incentive -> " + fixedIncentive + "\n";
		attribValue = attribValue + "11.  Date of Birth -> " + dob + "\n";
		attribValue = attribValue + "12.  Date of Joining -> " + doj + "\n";
		
		attribValue = attribValue + "13.  Account Expired -> " + accountExpired + "\n";
		attribValue = attribValue + "14.  Account Locked -> " + accountLocked + "\n";
		attribValue = attribValue + "15.  Credentials Expired  -> " + credentialsExpired + "\n";
		
		
		attribValue = attribValue + "16.  Roles -> " + roles + "\n";
		return attribValue; 
	}

	public boolean isActive() {

		return active;
	}
	public void setActive(boolean active) {
		this.active = active;
	}

	public String getPersonalEmail() {
		return personalEmail;
	}

	public void setPersonalEmail(String personalEmail) {
		this.personalEmail = personalEmail;
	}

	public long getPersonalMobile() {
		return personalMobile;
	}

	public void setPersonalMobile(long personalMobile) {
		this.personalMobile = personalMobile;
	}

	public String getPanCard() {
		return panCard;
	}

	public void setPanCard(String panCard) {
		this.panCard = panCard;
	}

	public String getAadharCard() {
		return aadharCard;
	}

	public void setAadharCard(String aadharCard) {
		this.aadharCard = aadharCard;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getMaritalStatus() {
		return maritalStatus;
	}

	public void setMaritalStatus(String maritalStatus) {
		this.maritalStatus = maritalStatus;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public boolean isAccountExpired() {
		return accountExpired;
	}

	public void setAccountExpired(boolean accountExpired) {
		this.accountExpired = accountExpired;
	}

	public boolean isAccountLocked() {
		return accountLocked;
	}

	public void setAccountLocked(boolean accountLocked) {
		this.accountLocked = accountLocked;
	}

	public boolean isCredentialsExpired() {
		return credentialsExpired;
	}

	public void setCredentialsExpired(boolean credentialsExpired) {
		this.credentialsExpired = credentialsExpired;
	}

	public Set<RoleEntity> getRoles() {
		return roles;
	}

	public void setRoles(Set<RoleEntity> roles) {
		this.roles = roles;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public boolean isDeleted() {
		return deleted;
	}

	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}

	/*
	public Set<Tg_Leads_Recorder_Entity> getLeads() {
		return leads;
	}

	public void setLeads(Set<Tg_Leads_Recorder_Entity> leads) {
		this.leads = leads;
	}

	public Set<Udn_Deals_Recorder_Entity> getDeals() {
		return deals;
	}

	public void setDeals(Set<Udn_Deals_Recorder_Entity> deals) {
		this.deals = deals;
	}
	*/
	
	
			
}

