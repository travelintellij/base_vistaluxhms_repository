package com.vistaluxevent.model;

import com.vistaluxhms.util.VistaluxConstants;


public class FilterEventObj {
    
    private long eventId;
    private long clientId;
    private String clientName;
	private String startDate;
    private String endDate;
    private int dateCriteria;
	private int leadOwner;
	private int leadStatus;

	public long getEventId() {
		return eventId;
	}

	public void setEventId(long eventId) {
		this.eventId = eventId;
	}

	public long getClientId() {
		return clientId;
	}

	public void setClientId(long clientId) {
		this.clientId = clientId;
	}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public int getDateCriteria() {
		return dateCriteria;
	}

	public void setDateCriteria(int dateCriteria) {
		this.dateCriteria = dateCriteria;
	}

	public int getLeadOwner() {
		return leadOwner;
	}

	public void setLeadOwner(int leadOwner) {
		this.leadOwner = leadOwner;
	}

	public int getLeadStatus() {
		return leadStatus;
	}

	public void setLeadStatus(int leadStatus) {
		this.leadStatus = leadStatus;
	}
}
