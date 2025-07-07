package com.vistaluxhms.model;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Date;


public class MyTravelClaimsDTO {

    private Long travelClaimId;
    private String source;
    private String destination;
    private Date expenseStartDate;
    private Date expenseEndDate;
    private String claimDetails;
    private Integer travelMode;
    private Integer kms;
    private Integer travelExpense;
    private Integer foodExpense;
    private Integer parkingExpense;
    private Integer otherExpense1;
    private Integer otherExpense2;
    private Integer otherExpense3;
    private String otherExpensesDetails;
    private Integer claimentId;
    private Integer approverId;
    private String approverRemarks;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Long getTravelClaimId() {
        return travelClaimId;
    }

    public void setTravelClaimId(Long travelClaimId) {
        this.travelClaimId = travelClaimId;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public Date getExpenseStartDate() {
        return expenseStartDate;
    }

    public void setExpenseStartDate(Date expenseStartDate) {
        this.expenseStartDate = expenseStartDate;
    }

    public Date getExpenseEndDate() {
        return expenseEndDate;
    }

    public void setExpenseEndDate(Date expenseEndDate) {
        this.expenseEndDate = expenseEndDate;
    }

    public String getClaimDetails() {
        return claimDetails;
    }

    public void setClaimDetails(String claimDetails) {
        this.claimDetails = claimDetails;
    }

    public Integer getTravelMode() {
        return travelMode;
    }

    public void setTravelMode(Integer travelMode) {
        this.travelMode = travelMode;
    }

    public Integer getKms() {
        return kms;
    }

    public void setKms(Integer kms) {
        this.kms = kms;
    }

    public Integer getTravelExpense() {
        return travelExpense;
    }

    public void setTravelExpense(Integer travelExpense) {
        this.travelExpense = travelExpense;
    }

    public Integer getFoodExpense() {
        return foodExpense;
    }

    public void setFoodExpense(Integer foodExpense) {
        this.foodExpense = foodExpense;
    }

    public Integer getParkingExpense() {
        return parkingExpense;
    }

    public void setParkingExpense(Integer parkingExpense) {
        this.parkingExpense = parkingExpense;
    }

    public Integer getOtherExpense1() {
        return otherExpense1;
    }

    public void setOtherExpense1(Integer otherExpense1) {
        this.otherExpense1 = otherExpense1;
    }

    public Integer getOtherExpense2() {
        return otherExpense2;
    }

    public void setOtherExpense2(Integer otherExpense2) {
        this.otherExpense2 = otherExpense2;
    }

    public Integer getOtherExpense3() {
        return otherExpense3;
    }

    public void setOtherExpense3(Integer otherExpense3) {
        this.otherExpense3 = otherExpense3;
    }

    public String getOtherExpensesDetails() {
        return otherExpensesDetails;
    }

    public void setOtherExpensesDetails(String otherExpensesDetails) {
        this.otherExpensesDetails = otherExpensesDetails;
    }

    public Integer getClaimentId() {
        return claimentId;
    }

    public void setClaimentId(Integer claimentId) {
        this.claimentId = claimentId;
    }

    public Integer getApproverId() {
        return approverId;
    }

    public void setApproverId(Integer approverId) {
        this.approverId = approverId;
    }

    public String getApproverRemarks() {
        return approverRemarks;
    }

    public void setApproverRemarks(String approverRemarks) {
        this.approverRemarks = approverRemarks;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
}

