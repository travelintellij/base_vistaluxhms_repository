package com.vistaluxhms.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.vistaluxhms.model.LeadEntityDTO;
import com.vistaluxhms.model.QuotationRoomDetailsDTO;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.List;


@Entity
@Table(name = "lead_system_quotation_room_details")
public class LeadSystemQuotationRoomDetailsEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long lsqrd;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "lsqid", nullable = false)
    private LeadSystemQuotationEntity leadSystemQuotationEntity;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "roomCategoryId", nullable = false)
    private MasterRoomDetailsEntity roomDetails;

    @Column(name = "mealPlanId")
    private Integer mealPlanId;

    @Column(name = "adults", nullable = false)
    private Integer adults = 0;

    @Column(name = "CWB", nullable = false)
    private Integer cwb = 0;

    @Column(name = "CNB", nullable = false)
    private Integer cnb = 0;

    @Column(name = "extraBed", nullable = false)
    private Integer extraBed = 0;

    @Column(name = "checkInDate", nullable = false)
    private LocalDate checkInDate;

    @Column(name = "checkOutDate", nullable = false)
    private LocalDate checkOutDate;

    @Column(name = "adultsTotalPrice", nullable = false)
    private Integer adultsTotalPrice = 0;

    @Column(name = "cwbTotalPrice", nullable = false)
    private Integer cwbTotalPrice = 0;

    @Column(name = "cnbTotalPrice", nullable = false)
    private Integer cnbTotalPrice = 0;

    @Column(name = "extraBedTotalPrice", nullable = false)
    private Integer extraBedTotalPrice = 0;

    @Column(name = "totalPrice", nullable = false)
    private Integer totalPrice = 0;


    public Long getLsqrd() {
        return lsqrd;
    }

    public void setLsqrd(Long lsqrd) {
        this.lsqrd = lsqrd;
    }

    public LeadSystemQuotationEntity getLeadSystemQuotationEntity() {
        return leadSystemQuotationEntity;
    }

    public void setLeadSystemQuotationEntity(LeadSystemQuotationEntity leadSystemQuotationEntity) {
        this.leadSystemQuotationEntity = leadSystemQuotationEntity;
    }

    public MasterRoomDetailsEntity getRoomDetails() {
        return roomDetails;
    }

    public void setRoomDetails(MasterRoomDetailsEntity roomDetails) {
        this.roomDetails = roomDetails;
    }

    public Integer getMealPlanId() {
        return mealPlanId;
    }

    public void setMealPlanId(Integer mealPlanId) {
        this.mealPlanId = mealPlanId;
    }

    public Integer getAdults() {
        return adults;
    }

    public void setAdults(Integer adults) {
        this.adults = adults;
    }

    public Integer getCwb() {
        return cwb;
    }

    public void setCwb(Integer cwb) {
        this.cwb = cwb;
    }

    public Integer getCnb() {
        return cnb;
    }

    public void setCnb(Integer cnb) {
        this.cnb = cnb;
    }

    public Integer getExtraBed() {
        return extraBed;
    }

    public void setExtraBed(Integer extraBed) {
        this.extraBed = extraBed;
    }

    public LocalDate getCheckInDate() {
        return checkInDate;
    }

    public void setCheckInDate(LocalDate checkInDate) {
        this.checkInDate = checkInDate;
    }

    public LocalDate getCheckOutDate() {
        return checkOutDate;
    }

    public void setCheckOutDate(LocalDate checkOutDate) {
        this.checkOutDate = checkOutDate;
    }

    public Integer getAdultsTotalPrice() {
        return adultsTotalPrice;
    }

    public void setAdultsTotalPrice(Integer adultsTotalPrice) {
        this.adultsTotalPrice = adultsTotalPrice;
    }

    public Integer getCwbTotalPrice() {
        return cwbTotalPrice;
    }

    public void setCwbTotalPrice(Integer cwbTotalPrice) {
        this.cwbTotalPrice = cwbTotalPrice;
    }

    public Integer getCnbTotalPrice() {
        return cnbTotalPrice;
    }

    public void setCnbTotalPrice(Integer cnbTotalPrice) {
        this.cnbTotalPrice = cnbTotalPrice;
    }

    public Integer getExtraBedTotalPrice() {
        return extraBedTotalPrice;
    }

    public void setExtraBedTotalPrice(Integer extraBedTotalPrice) {
        this.extraBedTotalPrice = extraBedTotalPrice;
    }

    public Integer getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Integer totalPrice) {
        this.totalPrice = totalPrice;
    }
}