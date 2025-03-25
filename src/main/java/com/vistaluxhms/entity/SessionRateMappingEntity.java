package com.vistaluxhms.entity;

import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "session_rate_mapping")
public class SessionRateMappingEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "sessionRateTypeId")
    protected Integer sessionRateTypeId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "sessionId", nullable = false, foreignKey = @ForeignKey(name = "fk_session"))
    protected SessionEntity sessionEntity;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "rateTypeId", nullable = false, foreignKey = @ForeignKey(name = "fk_rateType"))
    protected RateTypeEntity rateTypeEntity;

    @Column(name = "startDate", nullable = false)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    protected LocalDate startDate;

    @Column(name = "endDate", nullable = false)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    protected LocalDate endDate;

    @Column(name = "createdAt", updatable = false, insertable = false)
    protected Timestamp createdAt;

    @Column(name = "updatedAt", insertable = false, updatable = false)
    protected Timestamp updatedAt;

    protected boolean active = true;

    // Transient fields (not stored in the database)
    private transient String formattedStartDate;
    private transient String formattedEndDate;

    // Constructors
    public SessionRateMappingEntity() {}

    public SessionRateMappingEntity(SessionEntity sessionEntity, RateTypeEntity rateTypeEntity, LocalDate startDate, LocalDate endDate) {
        this.sessionEntity = sessionEntity;
        this.rateTypeEntity = rateTypeEntity;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    // Getters and Setters
    public Integer getSessionRateTypeId() {
        return sessionRateTypeId;
    }

    public void setSessionRateTypeId(Integer sessionRateTypeId) {
        this.sessionRateTypeId = sessionRateTypeId;
    }



    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public SessionEntity getSessionEntity() {
        return sessionEntity;
    }

    public void setSessionEntity(SessionEntity sessionEntity) {
        this.sessionEntity = sessionEntity;
    }

    public RateTypeEntity getRateTypeEntity() {
        return rateTypeEntity;
    }

    public void setRateTypeEntity(RateTypeEntity rateTypeEntity) {
        this.rateTypeEntity = rateTypeEntity;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public String getFormattedStartDate() {
        return formattedStartDate;
    }

    public void setFormattedStartDate(String formattedStartDate) {
        this.formattedStartDate = formattedStartDate;
    }

    public String getFormattedEndDate() {
        return formattedEndDate;
    }

    public void setFormattedEndDate(String formattedEndDate) {
        this.formattedEndDate = formattedEndDate;
    }
}
