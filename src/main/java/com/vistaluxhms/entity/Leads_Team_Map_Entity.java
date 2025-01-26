package com.vistaluxhms.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;

@Entity
@Table(name = "leads_team_map")
@IdClass(Leads_User_Map_Id.class)
public class Leads_Team_Map_Entity implements Serializable {


	@Id
	private Long leadId;
  
	@Id
	private int userId;

	public Long getLeadId() {
		return leadId;
	}

	public void setLeadId(Long leadId) {
		this.leadId = leadId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}
  
  
  
}
