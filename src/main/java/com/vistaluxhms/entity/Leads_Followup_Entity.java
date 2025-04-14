package com.vistaluxhms.entity;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.vistaluxhms.model.Leads_Followup_VO;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "leads_followup")
public class Leads_Followup_Entity  {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	protected long leadFollowupId;

	@ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="leadId", nullable=false)
	@JsonManagedReference
	protected LeadEntity leadEntity;

	protected LocalDateTime followuptime;
	protected String response;
	protected LocalDateTime nextfollowuptime;
	protected String nextactionplan;
	protected int updatedBy;

	public Leads_Followup_Entity() {

	}

	public Leads_Followup_Entity(Leads_Followup_VO leadFollowupVo) {
		this.leadFollowupId=leadFollowupVo.getLeadFollowupId();
		this.followuptime=leadFollowupVo.getFollowuptime();
		this.response=leadFollowupVo.getResponse();
		this.nextfollowuptime=leadFollowupVo.getNextfollowuptime();
		this.nextactionplan=leadFollowupVo.getNextactionplan();
		this.updatedBy= leadFollowupVo.getUpdatedBy();
	}
	
	public long getLeadFollowupId() {
		return leadFollowupId;
	}
	public void setLeadFollowupId(long leadFollowupId) {
		this.leadFollowupId = leadFollowupId;
	}
	public LeadEntity getLeadEntity() {
		return leadEntity;
	}
	public void setLeadEntity(LeadEntity leadEntity) {
		this.leadEntity = leadEntity;
	}
	public LocalDateTime getFollowuptime() {
		return followuptime;
	}
	

	
	public String getResponse() {
		return response;
	}
	public void setResponse(String response) {
		this.response = response;
	}
	
	
	public LocalDateTime getNextfollowuptime() {
		return nextfollowuptime;
	}
	
	/*
	public void setNextfollowuptime(LocalDateTime nextfollowuptime) {
		this.nextfollowuptime = nextfollowuptime;
	}
	*/
	public String getNextactionplan() {
		return nextactionplan;
	}
	public void setNextactionplan(String nextactionplan) {
		this.nextactionplan = nextactionplan;
	}
	
	
	
	

	@Override
	public String toString() {
		return "TI_Leads_Followup_Entity [leadFollowupId=" + leadFollowupId + ", leadEntity=" + leadEntity
				+ ", followuptime=" + followuptime + ", response=" + response + ", nextfollowuptime=" + nextfollowuptime
				+ ", nextactionplan=" + nextactionplan + ", updatedBy=" + updatedBy + "]";
	}

	public int getUpdatedBy() {
		return updatedBy;
	}

	public void setUpdatedBy(int updatedBy) {
		this.updatedBy = updatedBy;
	}
	
	
	
}