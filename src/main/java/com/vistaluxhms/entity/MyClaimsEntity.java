package com.vistaluxhms.entity;



import com.vistaluxhms.model.RateType_Obj;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "my_claims")
public class MyClaimsEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    protected Long claimId;

    protected int claimtype;
    protected String claimdetails;
    protected int claimamount;
    protected int approvedamount;
    protected Date claimdate;
    protected Date claimdecisiondate;
    protected int claimstatus;
    protected Date expensestartdate;
    protected Date expenseenddate;
    protected String managementremarks;
    protected int claimentId;
    protected int decisionmakerid;

    public Long getClaimId() {
        return claimId;
    }

    public void setClaimId(Long claimId) {
        this.claimId = claimId;
    }

    public String getClaimdetails() {
        return claimdetails;
    }

    public void setClaimdetails(String claimdetails) {
        this.claimdetails = claimdetails;
    }

    public int getClaimamount() {
        return claimamount;
    }

    public void setClaimamount(int claimamount) {
        this.claimamount = claimamount;
    }

    public int getApprovedamount() {
        return approvedamount;
    }

    public void setApprovedamount(int approvedamount) {
        this.approvedamount = approvedamount;
    }

    public Date getClaimdate() {
        return claimdate;
    }

    public void setClaimdate(Date claimdate) {
        this.claimdate = claimdate;
    }

    public Date getClaimdecisiondate() {
        return claimdecisiondate;
    }

    public void setClaimdecisiondate(Date claimdecisiondate) {
        this.claimdecisiondate = claimdecisiondate;
    }

    public int getClaimstatus() {
        return claimstatus;
    }

    public void setClaimstatus(int claimstatus) {
        this.claimstatus = claimstatus;
    }

    public Date getExpensestartdate() {
        return expensestartdate;
    }

    public void setExpensestartdate(Date expensestartdate) {
        this.expensestartdate = expensestartdate;
    }

    public Date getExpenseenddate() {
        return expenseenddate;
    }

    public void setExpenseenddate(Date expenseenddate) {
        this.expenseenddate = expenseenddate;
    }

    public String getManagementremarks() {
        return managementremarks;
    }

    public void setManagementremarks(String managementremarks) {
        this.managementremarks = managementremarks;
    }

    public int getClaimentId() {
        return claimentId;
    }

    public void setClaimentId(int claimentId) {
        this.claimentId = claimentId;
    }

    public int getDecisionmakerid() {
        return decisionmakerid;
    }

    public void setDecisionmakerid(int decisionmakerid) {
        this.decisionmakerid = decisionmakerid;
    }

    public int getClaimtype() {
        return claimtype;
    }

    public void setClaimtype(int claimtype) {
        this.claimtype = claimtype;
    }
}

