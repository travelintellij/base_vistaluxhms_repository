package com.vistaluxhms.entity;

import com.vistaluxhms.model.RoleObj;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.Valid;


@Entity
@Table(name = "role")
public class RoleEntity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int roleId;

	private String roleName;
	
	private String roleTarget;
	
	public RoleEntity() {
		
	}
	
	public RoleEntity(@Valid RoleObj roleObj) {
		this.roleId = roleObj.getRoleId();
		this.roleName=roleObj.getRoleName();
	}

	
	public String toString() {
		String attrib = "Role Entity Details " ;
		attrib = attrib + " Role Id -> " + roleId +"\n";
		attrib = attrib + " Role Name -> " + roleName + "\n";
		attrib = attrib + " Role Target -> " + roleTarget + "\n";
		return attrib ;
	}


	public int getRoleId() {
		return roleId;
	}


	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}


	public String getRoleName() {
		return roleName;
	}


	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getRoleTarget() {
		return roleTarget;
	}

	public void setRoleTarget(String roleTarget) {
		this.roleTarget = roleTarget;
	}

	
			
}

