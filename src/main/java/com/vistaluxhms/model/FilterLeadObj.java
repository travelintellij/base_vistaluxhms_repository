package com.vistaluxhms.model;

import com.vistaluxhms.util.VistaluxConstants;

import java.sql.Date;


public class FilterLeadObj  {
    
    private long leadId;
    private long clientId;
    private String clientName;
	private Long salesPartnerId;
	private int leadStatus= VistaluxConstants.VIEW_ALL_OPEN_LEADS_WL_STATUS;
    private String startDate;
    private String endDate;
    private int dateCriteria;
    private int leadSource;
    private int leadOwner;
    private boolean qualified;
    private boolean flagged;
    private String sourceName;
    private int source;
    private boolean onlyLeadOwner;
	private Boolean b2b;
    
	public long getLeadId() {
		return leadId;
	}



	public void setLeadId(long leadId) {
		this.leadId = leadId;
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



	public void setContactName(String clientName) {
		this.clientName = clientName;
	}



	public int getLeadStatus() {
		return leadStatus;
	}



	public void setLeadStatus(int leadStatus) {
		this.leadStatus = leadStatus;
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


	public int getLeadSource() {
		return leadSource;
	}



	public void setLeadSource(int leadSource) {
		this.leadSource = leadSource;
	}



	public int getLeadOwner() {
		return leadOwner;
	}



	public void setLeadOwner(int leadOwner) {
		this.leadOwner = leadOwner;
	}



	public boolean isQualified() {
		return qualified;
	}

	public void setQualified(boolean qualified) {
		this.qualified = qualified;
	}

	public boolean isFlagged() {
		return flagged;
	}

	public void setFlagged(boolean flagged) {
		this.flagged = flagged;
	}

	public String getSourceName() {
		return sourceName;
	}

	public void setSourceName(String sourceName) {
		this.sourceName = sourceName;
	}

	public int getSource() {
		return source;
	}


	public void setSource(int source) {
		this.source = source;
	}


	public boolean isOnlyLeadOwner() {
		return onlyLeadOwner;
	}

	public void setOnlyLeadOwner(boolean onlyLeadOwner) {
		this.onlyLeadOwner = onlyLeadOwner;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public Long getSalesPartnerId() {
		return salesPartnerId;
	}

	public void setSalesPartnerId(Long salesPartnerId) {
		this.salesPartnerId = salesPartnerId;
	}

	public Boolean getB2b() {
		return b2b;
	}

	public void setB2b(Boolean b2b) {
		this.b2b = b2b;
	}
}
