package com.vistaluxhms.entity;

import javax.persistence.*;


import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Date;

@Entity
@Table(name = "lead_master")
public class LeadEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "leadId")
    private Long leadId;

    @ManyToOne
    @JoinColumn(name = "clientId", nullable = false)
    private ClientEntity client;

    @ManyToOne
    @JoinColumn(name = "leadSource", nullable = false)
    private SalesPartnerEntity leadSource;

    @Column(name = "adults", nullable = false)
    private int adults;

    @Column(name = "CWB")
    private int cwb; // Children with Bed

    @Column(name = "CNB")
    private int cnb; // Children No Bed

    @Column(name = "compChild")
    private int compChild;

    @Column(name = "ageInfoRemarks")
    private String ageInfoRemarks;

    @Column(name = "tentativeCost")
    private BigDecimal tentativeCost;

    @Column(name = "clientRemarks")
    private String clientRemarks;

    @Column(name = "internalRemarks")
    private String internalRemarks;

    @Temporal(TemporalType.DATE)
    @Column(name = "checkInDate")
    private Date checkInDate;

    @Temporal(TemporalType.DATE)
    @Column(name = "checkOutDate")
    private Date checkOutDate;

    @Column(name = "leadStatus", nullable = false)
    private int leadStatus;

    @Column(name = "resultReason")
    private Integer resultReason;

    @Column(name = "qualified")
    private boolean qualified;

    @Column(name = "flagged")
    private boolean flagged;

    @Column(name = "FIT")
    private boolean fit;

    @Column(name = "groupEvent")
    private boolean groupEvent;

    @Column(name = "Marriage")
    private boolean marriage;

    @Column(name = "CorporateEvent")
    private boolean corporateEvent;

    @Column(name = "Birthday")
    private boolean birthday;

    @Column(name = "Others")
    private boolean others;

    @Column(name = "leadCreationClientInformed")
    private boolean leadCreationClientInformed;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    // Getters and Setters
    public Long getLeadId() {
        return leadId;
    }

    public void setLeadId(Long leadId) {
        this.leadId = leadId;
    }

    public ClientEntity getClient() {
        return client;
    }

    public void setClient(ClientEntity client) {
        this.client = client;
    }

    public SalesPartnerEntity getLeadSource() {
        return leadSource;
    }

    public void setLeadSource(SalesPartnerEntity leadSource) {
        this.leadSource = leadSource;
    }

    public int getAdults() {
        return adults;
    }

    public void setAdults(int adults) {
        this.adults = adults;
    }

    public int getCwb() {
        return cwb;
    }

    public void setCwb(int cwb) {
        this.cwb = cwb;
    }

    public int getCnb() {
        return cnb;
    }

    public void setCnb(int cnb) {
        this.cnb = cnb;
    }

    public int getCompChild() {
        return compChild;
    }

    public void setCompChild(int compChild) {
        this.compChild = compChild;
    }

    public String getAgeInfoRemarks() {
        return ageInfoRemarks;
    }

    public void setAgeInfoRemarks(String ageInfoRemarks) {
        this.ageInfoRemarks = ageInfoRemarks;
    }

    public BigDecimal getTentativeCost() {
        return tentativeCost;
    }

    public void setTentativeCost(BigDecimal tentativeCost) {
        this.tentativeCost = tentativeCost;
    }

    public String getClientRemarks() {
        return clientRemarks;
    }

    public void setClientRemarks(String clientRemarks) {
        this.clientRemarks = clientRemarks;
    }

    public String getInternalRemarks() {
        return internalRemarks;
    }

    public void setInternalRemarks(String internalRemarks) {
        this.internalRemarks = internalRemarks;
    }

    public Date getCheckInDate() {
        return checkInDate;
    }

    public void setCheckInDate(Date checkInDate) {
        this.checkInDate = checkInDate;
    }

    public Date getCheckOutDate() {
        return checkOutDate;
    }

    public void setCheckOutDate(Date checkOutDate) {
        this.checkOutDate = checkOutDate;
    }

    public int getLeadStatus() {
        return leadStatus;
    }

    public void setLeadStatus(int leadStatus) {
        this.leadStatus = leadStatus;
    }

    public Integer getResultReason() {
        return resultReason;
    }

    public void setResultReason(Integer resultReason) {
        this.resultReason = resultReason;
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

    public boolean isFit() {
        return fit;
    }

    public void setFit(boolean fit) {
        this.fit = fit;
    }

    public boolean isGroupEvent() {
        return groupEvent;
    }

    public void setGroupEvent(boolean groupEvent) {
        this.groupEvent = groupEvent;
    }

    public boolean isMarriage() {
        return marriage;
    }

    public void setMarriage(boolean marriage) {
        this.marriage = marriage;
    }

    public boolean isCorporateEvent() {
        return corporateEvent;
    }

    public void setCorporateEvent(boolean corporateEvent) {
        this.corporateEvent = corporateEvent;
    }

    public boolean isBirthday() {
        return birthday;
    }

    public void setBirthday(boolean birthday) {
        this.birthday = birthday;
    }

    public boolean isOthers() {
        return others;
    }

    public void setOthers(boolean others) {
        this.others = others;
    }

    public boolean isLeadCreationClientInformed() {
        return leadCreationClientInformed;
    }

    public void setLeadCreationClientInformed(boolean leadCreationClientInformed) {
        this.leadCreationClientInformed = leadCreationClientInformed;
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
