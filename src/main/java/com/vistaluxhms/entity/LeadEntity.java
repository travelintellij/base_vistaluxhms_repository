package com.vistaluxhms.entity;

import com.vistaluxhms.model.LeadEntityDTO;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;


import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "lead_master")
public class LeadEntity extends AuditModel{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "leadId")
    protected Long leadId;

    @ManyToOne
    @JoinColumn(name = "clientId", nullable = false)
    protected ClientEntity client;


    @ManyToMany(targetEntity = AshokaTeam.class,fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinTable(name = "leads_team_map",
            joinColumns = {@JoinColumn(name="leadId")},
            inverseJoinColumns = {@JoinColumn(name="userId")})
    protected Set<AshokaTeam> team = new HashSet<AshokaTeam>();

    @Column(name = "adults", nullable = false)
    protected int adults;

    @Column(name = "CWB")
    protected int cwb; // Children with Bed

    @Column(name = "CNB")
    protected int cnb; // Children No Bed

    @Column(name = "compChild")
    protected int compChild;


    @Column(name = "clientRemarks")
    protected String clientRemarks;

    @Column(name = "internalRemarks")
    protected String internalRemarks;

    @Temporal(TemporalType.DATE)
    @Column(name = "checkInDate")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    protected Date checkInDate;

    @Temporal(TemporalType.DATE)
    @Column(name = "checkOutDate")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    protected Date checkOutDate;

    @Column(name = "leadStatus", nullable = false)
    protected int leadStatus;

    @Column(name = "resultReason")
    protected Integer resultReason;

    @Column(name = "qualified")
    protected boolean qualified;

    @Column(name = "flagged")
    protected boolean flagged;

    @Column(name = "FIT")
    protected boolean fit=true;

    @Column(name = "groupEvent")
    protected boolean groupEvent;

    @Column(name = "Marriage")
    protected boolean marriage;


    @Column(name = "Others")
    protected boolean others;

    @Column(name = "leadCreationClientInformed")
    protected boolean leadCreationClientInformed=true;


    @Column(name = "leadOwner", nullable = false)
    protected int leadOwner;



    public LeadEntity() {
    }

    public LeadEntity(LeadEntityDTO leadRecorderObj) {
        //this.client = leadRecorderObj.getClient();
        //this.team = leadRecorderObj.getTeam();
        this.adults = leadRecorderObj.getAdults();
        this.cwb = leadRecorderObj.getCwb();
        this.cnb = leadRecorderObj.getCnb();
        this.compChild = leadRecorderObj.getCompChild();
        this.clientRemarks = leadRecorderObj.getClientRemarks();
        this.internalRemarks = leadRecorderObj.getInternalRemarks();
        this.checkInDate = leadRecorderObj.getCheckInDate();
        this.checkOutDate = leadRecorderObj.getCheckOutDate();
        this.leadStatus = leadRecorderObj.getLeadStatus();
        this.resultReason = leadRecorderObj.getResultReason();
        this.qualified = leadRecorderObj.isQualified();
        this.flagged = leadRecorderObj.isFlagged();
        this.fit = leadRecorderObj.isFit();
        this.groupEvent = leadRecorderObj.isGroupEvent();
        this.marriage = leadRecorderObj.isMarriage();
        this.others = leadRecorderObj.isOthers();
        this.leadCreationClientInformed = leadRecorderObj.isLeadCreationClientInformed();
        this.leadOwner = leadRecorderObj.getLeadOwner();
    }


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




    public Set<AshokaTeam> getTeam() {
        return team;
    }

    public void setTeam(Set<AshokaTeam> team) {
        this.team = team;
    }

    public int getLeadOwner() {
        return leadOwner;
    }

    public void setLeadOwner(int leadOwner) {
        this.leadOwner = leadOwner;
    }
}
