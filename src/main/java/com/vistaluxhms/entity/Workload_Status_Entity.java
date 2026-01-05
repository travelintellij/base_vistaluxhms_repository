package com.vistaluxhms.entity;

import java.sql.Date;
import java.time.LocalDate;

import javax.persistence.*;
import javax.validation.Valid;
import com.vistaluxhms.model.WorkLoadStatusVO;


@Entity
@Table(name = "workload_status")
public class Workload_Status_Entity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	 @Column(columnDefinition = "DEFAULT 0")
	private int id;

	private int workloadStatusId;
	private String workloadStatusObj;
	private String workloadStatusObjType;

	private String workloadStatusName;

	private boolean active;

	private int workloadCategory;
	
	public Workload_Status_Entity() {
		
	}
	
	public Workload_Status_Entity(WorkLoadStatusVO statusVO) {
		//workloadStatusId = statusVO.getWorkloadStatusId();
		workloadStatusObj=statusVO.getWorkloadStatusObj();
		workloadStatusObjType=statusVO.getWorkloadStatusObjType();
		workloadStatusName=statusVO.getWorkloadStatusName();
		active=statusVO.isActive();
		workloadCategory=statusVO.getWorkloadCategory();
			
	}
	
	@PrePersist
    public void prePersist() {
        this.workloadStatusId = this.id;
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


	
	public String getWorkloadStatusObjType() {
		return workloadStatusObjType;
	}

	public void setWorkloadStatusObjType(String workloadStatusObjType) {
		this.workloadStatusObjType = workloadStatusObjType;
	}

	public String toString() {
		String attrib = " Id -> " + id + "\n";
		attrib = attrib + " workloadStatusId -> " + workloadStatusId + "\n";
		attrib = attrib + " workloadStatusObj -> " + workloadStatusObj + "\n";
		attrib = attrib + " workloadStatusObjType -> " + workloadStatusObjType + "\n";
		attrib = attrib + " workloadStatusName -> " + workloadStatusName + "\n";
		return attrib;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public int getWorkloadCategory() {
		return workloadCategory;
	}

	public void setWorkloadCategory(int workloadCategory) {
		this.workloadCategory = workloadCategory;
	}
}