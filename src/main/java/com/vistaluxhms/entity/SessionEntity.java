package com.vistaluxhms.entity;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.List;

@Entity
@Table(name = "session")
public class SessionEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "sessionId")
    private Integer sessionId;

    @Column(name = "sessionName", nullable = false)
    private String sessionName;

    @Column(name = "remarks")
    private String remarks;


    @Column(name = "createdAt", updatable = false, insertable = false)
    private Timestamp createdAt;

    @Column(name = "updatedAt", insertable = false, updatable = false)
    private Timestamp updatedAt;


    @OneToMany(mappedBy = "session", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<SessionDetailsEntity > sessionDetailsEntity;

    @Column(name = "active")
    private Boolean active = true;

    public Integer getSessionId() {
        return sessionId;
    }

    public void setSessionId(Integer sessionId) {
        this.sessionId = sessionId;
    }

    public String getSessionName() {
        return sessionName;
    }

    public void setSessionName(String sessionName) {
        this.sessionName = sessionName;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public List<SessionDetailsEntity> getSessionDetailsEntity() {
        return sessionDetailsEntity;
    }

    public void setSessionDetailsEntity(List<SessionDetailsEntity> sessionDetailsEntity) {
        this.sessionDetailsEntity = sessionDetailsEntity;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    @Override
    public String toString() {
        return "Session{" +
                "sessionId=" + sessionId +
                ", sessionName='" + sessionName + '\'' +
                ", remarks='" + remarks + '\'' +
                ", sessionDetailsEntity=" + sessionDetailsEntity +
                '}';
    }
}
