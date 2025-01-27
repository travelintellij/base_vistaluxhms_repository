package com.vistaluxhms.model;


import com.vistaluxhms.entity.Workload_Status_Entity;

import java.sql.Date;
import java.time.LocalDate;

import javax.persistence.*;
import javax.validation.Valid;



public class WorkLoadStatusVO{
	private int id;

	private int workloadStatusId;
	private String workloadStatusObj;
	private String workloadStatusShortName;
	private String workloadStatusName;
	private String workloadStatusActionPending;
	private String workloadStatusObjType;

	private int workloadCategory;
	private boolean active=true;
	
	
	
	public WorkLoadStatusVO() {
		
	}
	
	
	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public int getWorkloadStatusId() {
		return workloadStatusId;
	}


	public void setWorkloadStatusId(int workloadStatusId) {
		this.workloadStatusId = workloadStatusId;
	}


	public String getWorkloadStatusObj() {
		return workloadStatusObj;
	}


	public void setWorkloadStatusObj(String workloadStatusObj) {
		this.workloadStatusObj = workloadStatusObj;
	}


	public String getWorkloadStatusName() {
		return workloadStatusName;
	}


	public void setWorkloadStatusName(String workloadStatusName) {
		this.workloadStatusName = workloadStatusName;
	}


	public String getWorkloadStatusActionPending() {
		return workloadStatusActionPending;
	}


	public void setWorkloadStatusActionPending(String workloadStatusActionPending) {
		this.workloadStatusActionPending = workloadStatusActionPending;
	}


	public String getWorkloadStatusShortName() {
		return workloadStatusShortName;
	}


	public void setWorkloadStatusShortName(String workloadStatusShortName) {
		this.workloadStatusShortName = workloadStatusShortName;
	}


	

	
	@Override
	public String toString() {
		return "UdnDealStatusVO [id=" + id + ", workloadStatusId=" + workloadStatusId + ", workloadStatusObj="
				+ workloadStatusObj + ", workloadStatusShortName=" + workloadStatusShortName + ", workloadStatusName="
				+ workloadStatusName + ", workloadStatusActionPending=" + workloadStatusActionPending
				+ ", workloadStatusObjType=" + workloadStatusObjType + ", active=" + active + "]";
	}


	public WorkLoadStatusVO(Workload_Status_Entity statusEntity) {
		this.id=statusEntity.getId();
		this.workloadStatusId=statusEntity.getWorkloadStatusId();
		this.workloadStatusName=statusEntity.getWorkloadStatusName();
		this.workloadStatusObj=statusEntity.getWorkloadStatusObj();
		this.active=statusEntity.isActive();
	}


	public boolean isActive() {
		return active;
	}


	public void setActive(boolean active) {
		this.active = active;
	}


	public String getWorkloadStatusObjType() {
		return workloadStatusObjType;
	}


	public void setWorkloadStatusObjType(String workloadStatusObjType) {
		this.workloadStatusObjType = workloadStatusObjType;
	}

	public int getWorkloadCategory() {
		return workloadCategory;
	}

	public void setWorkloadCategory(int workloadCategory) {
		this.workloadCategory = workloadCategory;
	}
}