package com.vistaluxhms.model;


import com.vistaluxhms.entity.LeadEntity;
import com.vistaluxhms.entity.Leads_Followup_Entity;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;


public class Leads_Followup_VO extends Leads_Followup_Entity {
	
	private DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm");
	private String userName;
	private int page;
	private String sortBy="followuptime";
	private String formattedFollowUpTime;
	private String formattedNextFollowUpTime;
	private String sortOrder="ASC";
	
	public String getUserName() {
		return userName;
	}
	
	public void setUserName(String userName) {
		this.userName = userName;
	}


	public void setFollowuptime(String followuptime) {
		this.followuptime =  LocalDateTime.parse(followuptime,formatter);
	}	


	public void setNextfollowuptime(String nextfollowuptime) {
		this.nextfollowuptime = LocalDateTime.parse(nextfollowuptime,formatter);
	}

	
	
	
	@Override
	public String toString() {
		return "TI_Leads_Followup_VO [userName=" + userName + ", page=" + page + ", sortBy=" + sortBy + ", sortOrder="
				+ sortOrder + "]";
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public String getSortBy() {
		return sortBy;
	}

	public void setSortBy(String sortBy) {
		this.sortBy = sortBy;
	}

	public String getFormattedFollowUpTime() {
		return formattedFollowUpTime;
	}

	public void setFormattedFollowUpTime(String formattedFollowUpTime) {
		this.formattedFollowUpTime = formattedFollowUpTime;
	}

	public String getFormattedNextFollowUpTime() {
		return formattedNextFollowUpTime;
	}

	public void setFormattedNextFollowUpTime(String formattedNextFollowUpTime) {
		this.formattedNextFollowUpTime = formattedNextFollowUpTime;
	}

	public String getSortOrder() {
		return sortOrder;
	}

	public void setSortOrder(String sortOrder) {
		this.sortOrder = sortOrder;
	}

	


}