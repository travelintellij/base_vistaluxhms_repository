package com.vistaluxhms.model;

import com.vistaluxhms.entity.MyTravelClaimsEntity;
import com.vistaluxhms.entity.TravelClaimBillEntity;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public class MyTravelClaimsDTO {

    private Long travelClaimId;
    private String source;
    private String destination;
    private int dateSelOpt;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date expenseStartDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date expenseEndDate;

    private String formattedExpenseStartDate;
    private String formattedExpenseEndDate;
    private List<TravelClaimBillEntity> billsEntity = new ArrayList<>();

    private List<MultipartFile> bills = new ArrayList<>();

    public String emailId;

    public List<MultipartFile> getBills() {
        return bills;
    }

    public void setBills(List<MultipartFile> bills) {
        this.bills = bills;
    }


    private String claimDetails;
    private int travelMode;
    private int kms;
    private int travelExpense;
    private int foodExpense;
    private int parkingExpense;
    private int otherExpense1;
    private int otherExpense2;
    private int otherExpense3;
    private String otherExpensesDetails;
    private Integer claimentId;
    private Integer approverId;
    private String approverRemarks;

    private int claimStatus;
    private String statusName;
    private String travelModeName;
    private int totalClaimAmount;

    private String claimantName;

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

    public int getTravelMode() {
        return travelMode;
    }

    public void setTravelMode(int travelMode) {
        this.travelMode = travelMode;
    }

    public int getKms() {
        return kms;
    }

    public void setKms(int kms) {
        this.kms = kms;
    }

    public int getTravelExpense() {
        return travelExpense;
    }

    public void setTravelExpense(int travelExpense) {
        this.travelExpense = travelExpense;
    }

    public int getFoodExpense() {
        return foodExpense;
    }

    public void setFoodExpense(int foodExpense) {
        this.foodExpense = foodExpense;
    }

    public int getParkingExpense() {
        return parkingExpense;
    }

    public void setParkingExpense(int parkingExpense) {
        this.parkingExpense = parkingExpense;
    }

    public int getOtherExpense1() {
        return otherExpense1;
    }

    public void setOtherExpense1(int otherExpense1) {
        this.otherExpense1 = otherExpense1;
    }

    public int getOtherExpense2() {
        return otherExpense2;
    }

    public void setOtherExpense2(int otherExpense2) {
        this.otherExpense2 = otherExpense2;
    }

    public int getOtherExpense3() {
        return otherExpense3;
    }

    public void setOtherExpense3(int otherExpense3) {
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

    public MyTravelClaimsDTO(){

    }

    public MyTravelClaimsDTO(MyTravelClaimsEntity myTravelClaimsEntity) {
        this.travelClaimId = myTravelClaimsEntity.getTravelClaimId();
        this.source = myTravelClaimsEntity.getSource();
        this.destination = myTravelClaimsEntity.getDestination();
        this.expenseStartDate = myTravelClaimsEntity.getExpenseStartDate();
        this.expenseEndDate = myTravelClaimsEntity.getExpenseEndDate();
        //this.bills = myTravelClaimsEntity.getBills();
        this.claimDetails = myTravelClaimsEntity.getClaimDetails();
        this.travelMode = myTravelClaimsEntity.getTravelMode();
        this.kms = myTravelClaimsEntity.getKms();
        this.travelExpense = myTravelClaimsEntity.getTravelExpense();
        this.foodExpense = myTravelClaimsEntity.getFoodExpense();
        this.parkingExpense = myTravelClaimsEntity.getParkingExpense();
        this.otherExpense1 = myTravelClaimsEntity.getOtherExpense1();
        this.otherExpense2 = myTravelClaimsEntity.getOtherExpense2();
        this.otherExpense3 = myTravelClaimsEntity.getOtherExpense3();
        this.otherExpensesDetails = myTravelClaimsEntity.getOtherExpensesDetails();
        this.claimentId = myTravelClaimsEntity.getClaimentId();
        this.approverId = myTravelClaimsEntity.getApproverId();
        this.approverRemarks = myTravelClaimsEntity.getApproverRemarks();
        this.createdAt = myTravelClaimsEntity.getCreatedAt();
        this.updatedAt = myTravelClaimsEntity.getUpdatedAt();
    }

    public String getFormattedExpenseStartDate() {
        return formattedExpenseStartDate;
    }

    public void setFormattedExpenseStartDate(String formattedExpenseStartDate) {
        this.formattedExpenseStartDate = formattedExpenseStartDate;
    }

    public String getFormattedExpenseEndDate() {
        return formattedExpenseEndDate;
    }

    public void setFormattedExpenseEndDate(String formattedExpenseEndDate) {
        this.formattedExpenseEndDate = formattedExpenseEndDate;
    }

    public int getClaimStatus() {
        return claimStatus;
    }

    public void setClaimStatus(int claimStatus) {
        this.claimStatus = claimStatus;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public String getTravelModeName() {
        return travelModeName;
    }

    public void setTravelModeName(String travelModeName) {
        this.travelModeName = travelModeName;
    }

    public List<TravelClaimBillEntity> getBillsEntity() {
        return billsEntity;
    }

    public void setBillsEntity(List<TravelClaimBillEntity> billsEntity) {
        this.billsEntity = billsEntity;
    }

    public int getTotalClaimAmount() {
        return totalClaimAmount;
    }

    public void setTotalClaimAmount(int totalClaimAmount) {
        this.totalClaimAmount = totalClaimAmount;
    }

    public String getClaimantName() {
        return claimantName;
    }

    public void setClaimantName(String claimantName) {
        this.claimantName = claimantName;
    }

    public int getDateSelOpt() {
        return dateSelOpt;
    }

    public void setDateSelOpt(int dateSelOpt) {
        this.dateSelOpt = dateSelOpt;
    }

    public String getEmailId() {
        return emailId;
    }

    public void setEmailId(String emailId) {
        this.emailId = emailId;
    }
}

