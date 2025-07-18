package com.vistaluxhms.entity;

import com.vistaluxhms.model.MyTravelClaimsDTO;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "my_travel_claims")
public class MyTravelClaimsEntity {

    @Id
    @Column(name = "travelClaimId")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long travelClaimId;


    @OneToMany(mappedBy = "claim", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<TravelClaimBillEntity> bills = new ArrayList<>();


    @Column(name = "source", length = 250)
    private String source;

    @Column(name = "destination", length = 250)
    private String destination;

    @Column(name = "expenseStartDate")
    private Date expenseStartDate;

    @Column(name = "expenseEndDate")
    private Date expenseEndDate;

    @Column(name = "claimDetails", length = 500)
    private String claimDetails;

    @Column(name = "travelMode")
    private int travelMode;

    @Column(name = "kms")
    private int kms;

    @Column(name = "travelExpense")
    private int travelExpense;

    @Column(name = "foodExpense")
    private int foodExpense;

    @Column(name = "parkingExpense")
    private int parkingExpense;

    @Column(name = "otherExpense1")
    private int otherExpense1;

    @Column(name = "otherExpense2")
    private int otherExpense2;

    @Column(name = "otherExpense3")
    private int otherExpense3;

    @Column(name = "otherExpensesDetails", length = 500)
    private String otherExpensesDetails;

    private Integer claimentId;


    private Integer approverId;

    @Column(name = "approverRemarks", length = 500)
    private String approverRemarks;


    @Column(name = "claimStatus", length = 500)
    private int claimStatus;



    @Column(name = "created_at", insertable = false, updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at", insertable = false, updatable = false)
    private LocalDateTime updatedAt;

    public MyTravelClaimsEntity() {

    }



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


    public int getClaimStatus() {
        return claimStatus;
    }

    public void setClaimStatus(int claimStatus) {
        this.claimStatus = claimStatus;
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


    // NEW: list of associated bills

    // getters and setters for all fields (omitted here for brevity — keep as you already wrote)

    public List<TravelClaimBillEntity> getBills() {
        return bills;
    }

    public void setBills(List<TravelClaimBillEntity> bills) {
        this.bills = bills;
    }

    public String getOtherExpensesDetails() {
        return otherExpensesDetails;
    }

    public void setOtherExpensesDetails(String otherExpensesDetails) {
        this.otherExpensesDetails = otherExpensesDetails;
    }

}

