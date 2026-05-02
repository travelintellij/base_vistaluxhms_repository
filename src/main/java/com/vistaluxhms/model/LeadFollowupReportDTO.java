package com.vistaluxhms.model;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class LeadFollowupReportDTO {

    private String startDate;
    private String endDate;
    private int leadStatus;
    private int leadOwner;
    private String sortOrder;

    public String getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(String sortOrder) {
        this.sortOrder = sortOrder;
    }

    // Default constructor that sets today's date
    public LeadFollowupReportDTO() {
        String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        this.startDate = today;
        this.endDate = today;
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

    public int getLeadStatus() {
        return leadStatus;
    }

    public void setLeadStatus(int leadStatus) {
        this.leadStatus = leadStatus;
    }

    public int getLeadOwner() {
        return leadOwner;
    }

    public void setLeadOwner(int leadOwner) {
        this.leadOwner = leadOwner;
    }

    @Override
    public String toString() {
        return "LeadFollowupReportDTO [startDate=" + startDate + ", endDate=" + endDate + ", leadStatus=" + leadStatus
                + ", leadOwner=" + leadOwner + "]";
    }
}
