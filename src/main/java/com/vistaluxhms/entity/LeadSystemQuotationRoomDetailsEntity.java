package com.vistaluxhms.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.vistaluxhms.model.LeadEntityDTO;
import com.vistaluxhms.model.LeadSystemQuotationRoomDetailsEntityDTO;
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
    protected long lsqrd;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "lsqid", nullable = false)
    protected LeadSystemQuotationEntity leadSystemQuotationEntity;

    protected int roomCategoryId;

    @Column(name = "mealPlanId")
    protected int mealPlanId;

    @Column(name = "adults", nullable = false)
    protected int adults = 0;

    @Column(name = "CWB", nullable = false)
    protected int cwb = 0;

    @Column(name = "CNB", nullable = false)
    protected int cnb = 0;

    @Column(name = "extraBed", nullable = false)
    protected int extraBed = 0;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    protected LocalDate checkInDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    protected LocalDate checkOutDate;

    @Column(name = "adultsTotalPrice", nullable = false)
    protected int adultsTotalPrice = 0;

    @Column(name = "cwbTotalPrice", nullable = false)
    protected int cwbTotalPrice = 0;

    @Column(name = "cnbTotalPrice", nullable = false)
    protected int cnbTotalPrice = 0;

    @Column(name = "extraBedTotalPrice", nullable = false)
    protected int extraBedTotalPrice = 0;

    @Column(name = "totalPrice", nullable = false)
    protected int totalPrice = 0;


    public void setTotalPrice(Integer totalPrice) {
        this.totalPrice = totalPrice;
    }

    public LeadSystemQuotationRoomDetailsEntity() {
    }


    public long getLsqrd() {
        return lsqrd;
    }

    public void setLsqrd(long lsqrd) {
        this.lsqrd = lsqrd;
    }

    public LeadSystemQuotationEntity getLeadSystemQuotationEntity() {
        return leadSystemQuotationEntity;
    }

    public void setLeadSystemQuotationEntity(LeadSystemQuotationEntity leadSystemQuotationEntity) {
        this.leadSystemQuotationEntity = leadSystemQuotationEntity;
    }

    public int getRoomCategoryId() {
        return roomCategoryId;
    }

    public void setRoomCategoryId(int roomCategoryId) {
        this.roomCategoryId = roomCategoryId;
    }

    public int getMealPlanId() {
        return mealPlanId;
    }

    public void setMealPlanId(int mealPlanId) {
        this.mealPlanId = mealPlanId;
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

    public int getExtraBed() {
        return extraBed;
    }

    public void setExtraBed(int extraBed) {
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

    public int getAdultsTotalPrice() {
        return adultsTotalPrice;
    }

    public void setAdultsTotalPrice(int adultsTotalPrice) {
        this.adultsTotalPrice = adultsTotalPrice;
    }

    public int getCwbTotalPrice() {
        return cwbTotalPrice;
    }

    public void setCwbTotalPrice(int cwbTotalPrice) {
        this.cwbTotalPrice = cwbTotalPrice;
    }

    public int getCnbTotalPrice() {
        return cnbTotalPrice;
    }

    public void setCnbTotalPrice(int cnbTotalPrice) {
        this.cnbTotalPrice = cnbTotalPrice;
    }

    public int getExtraBedTotalPrice() {
        return extraBedTotalPrice;
    }

    public void setExtraBedTotalPrice(int extraBedTotalPrice) {
        this.extraBedTotalPrice = extraBedTotalPrice;
    }

    public int getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(int totalPrice) {
        this.totalPrice = totalPrice;
    }

    public void updateEntityFromVO(LeadSystemQuotationRoomDetailsEntityDTO leadSystemQuotationRoomDetailsEntityDTO){
        this.leadSystemQuotationEntity = leadSystemQuotationRoomDetailsEntityDTO.getLeadSystemQuotationEntity();
        this.roomCategoryId = leadSystemQuotationRoomDetailsEntityDTO.getRoomCategoryId();
        this.mealPlanId = leadSystemQuotationRoomDetailsEntityDTO.getMealPlanId();
        this.adults = leadSystemQuotationRoomDetailsEntityDTO.getAdults();
        this.cwb = leadSystemQuotationRoomDetailsEntityDTO.getCwb();
        this.cnb = leadSystemQuotationRoomDetailsEntityDTO.getCnb();
        this.extraBed = leadSystemQuotationRoomDetailsEntityDTO.getExtraBed();
        this.checkInDate = leadSystemQuotationRoomDetailsEntityDTO.getCheckInDate();
        this.checkOutDate = leadSystemQuotationRoomDetailsEntityDTO.getCheckOutDate();
        this.adultsTotalPrice = leadSystemQuotationRoomDetailsEntityDTO.getAdultPrice();
        this.cwbTotalPrice = leadSystemQuotationRoomDetailsEntityDTO.getChildWithBedPrice();
        this.cnbTotalPrice = leadSystemQuotationRoomDetailsEntityDTO.getChildNoBedPrice();
        this.extraBedTotalPrice = leadSystemQuotationRoomDetailsEntityDTO.getExtraBedPrice();
        this.totalPrice = leadSystemQuotationRoomDetailsEntityDTO.getTotalPrice();
    }

    @Override
    public String toString() {
        return "LeadSystemQuotationRoomDetailsEntity{" +
                "lsqrd=" + lsqrd +
                ", roomCategoryId=" + roomCategoryId +
                ", mealPlanId=" + mealPlanId +
                ", adults=" + adults +
                ", cwb=" + cwb +
                ", cnb=" + cnb +
                ", extraBed=" + extraBed +
                ", checkInDate=" + checkInDate +
                ", checkOutDate=" + checkOutDate +
                ", adultsTotalPrice=" + adultsTotalPrice +
                ", cwbTotalPrice=" + cwbTotalPrice +
                ", cnbTotalPrice=" + cnbTotalPrice +
                ", extraBedTotalPrice=" + extraBedTotalPrice +
                ", totalPrice=" + totalPrice +
                '}';
    }
}