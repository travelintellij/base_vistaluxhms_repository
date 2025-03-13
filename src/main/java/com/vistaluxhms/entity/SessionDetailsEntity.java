package com.vistaluxhms.entity;

import com.vistaluxhms.model.SessionDetailsEntityDTO;

import javax.persistence.*;

@Entity
@Table(name = "sessiondetail")
public class SessionDetailsEntity {

    @EmbeddedId
    protected SessionDetailId sessionDetailId;


    @ManyToOne
    @MapsId("sessionId")  // Mapping sessionId in composite key
    @JoinColumn(name = "sessionId", referencedColumnName = "sessionId")
    protected SessionEntity session;




    @Column(name = "person1")
    protected int person1;

    @Column(name = "person2")
    protected int person2;

    @Column(name = "person3")
    protected int person3;

    @Column(name = "person4")
    protected int person4;

    @Column(name = "person5")
    protected int person5;

    @Column(name = "person6")
    protected int person6;

    @Column(name = "maxOccupancy", nullable = false)
    protected int maxOccupancy;

    @Column(name = "remarks", length = 500)
    protected String remarks;

    @Column(name = "active")
    protected Boolean active = true;


    public SessionDetailsEntity() {
    }

    public SessionDetailsEntity(SessionDetailsEntityDTO sessionDetailsEntityDTO){
        this.sessionDetailId = sessionDetailsEntityDTO.getSessionDetailId();
        this.session = sessionDetailsEntityDTO.getSession();
        this.person1 = sessionDetailsEntityDTO.getPerson1();
        this.person2 = sessionDetailsEntityDTO.getPerson2();
        this.person3 = sessionDetailsEntityDTO.getPerson3();
        this.person4 = sessionDetailsEntityDTO.getPerson4();
        this.person5 = sessionDetailsEntityDTO.getPerson5();
        this.person6 = sessionDetailsEntityDTO.getPerson6();
        this.maxOccupancy = sessionDetailsEntityDTO.getMaxOccupancy();
        this.remarks = sessionDetailsEntityDTO.getRemarks();
        this.active = sessionDetailsEntityDTO.getActive();
}



    public int getPerson1() {
        return person1;
    }

    public void setPerson1(int person1) {
        this.person1 = person1;
    }

    public int getPerson2() {
        return person2;
    }

    public void setPerson2(int person2) {
        this.person2 = person2;
    }

    public int getPerson3() {
        return person3;
    }

    public void setPerson3(int person3) {
        this.person3 = person3;
    }

    public int getPerson4() {
        return person4;
    }

    public void setPerson4(int person4) {
        this.person4 = person4;
    }

    public int getPerson5() {
        return person5;
    }

    public void setPerson5(int person5) {
        this.person5 = person5;
    }

    public int getPerson6() {
        return person6;
    }

    public void setPerson6(int person6) {
        this.person6 = person6;
    }

    public int getMaxOccupancy() {
        return maxOccupancy;
    }

    public void setMaxOccupancy(int maxOccupancy) {
        this.maxOccupancy = maxOccupancy;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    @Override
    public String toString() {
        return "SessionDetailsEntity{" +
                "sessionDetailId=" + sessionDetailId +
                ", person1=" + person1 +
                ", person2=" + person2 +
                ", person3=" + person3 +
                ", person4=" + person4 +
                ", person5=" + person5 +
                ", person6=" + person6 +
                ", maxOccupancy=" + maxOccupancy +
                ", remarks='" + remarks + '\'' +
                ", active=" + active +
                '}';
    }

    public SessionEntity getSession() {
        return session;
    }

    public void setSession(SessionEntity session) {
        this.session = session;
    }

    public SessionDetailId getSessionDetailId() {
        return sessionDetailId;
    }

    public void setSessionDetailId(SessionDetailId sessionDetailId) {
        this.sessionDetailId = sessionDetailId;
    }
}