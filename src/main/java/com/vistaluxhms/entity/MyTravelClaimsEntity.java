package com.vistaluxhms.entity;

import javax.persistence.*;
import java.time.LocalDateTime;
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
    private List<TravelClaimBillEntity> bills;


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
    private Integer travelMode;

    @Column(name = "kms")
    private Integer kms;

    @Column(name = "travelExpense")
    private Integer travelExpense;

    @Column(name = "foodExpense")
    private Integer foodExpense;

    @Column(name = "parkingExpense")
    private Integer parkingExpense;

    @Column(name = "otherExpense1")
    private Integer otherExpense1;

    @Column(name = "otherExpense2")
    private Integer otherExpense2;

    @Column(name = "otherExpense3")
    private Integer otherExpense3;

    @Column(name = "otherExpensesDetails", length = 500)
    private String otherExpensesDetails;

    private Integer claimentId;


    private Integer approverId;

    @Column(name = "approverRemarks", length = 500)
    private String approverRemarks;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
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

