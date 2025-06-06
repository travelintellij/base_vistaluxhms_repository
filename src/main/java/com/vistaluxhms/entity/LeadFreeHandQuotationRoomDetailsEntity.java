package com.vistaluxhms.entity;

import com.vistaluxhms.model.LeadFreeHandQuotationRoomDetailsEntityDTO;
import com.vistaluxhms.model.LeadSystemQuotationRoomDetailsEntityDTO;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.time.LocalDate;


@Entity
@Table(name = "lead_fh_quotation_room_details")
public class LeadFreeHandQuotationRoomDetailsEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    protected long lfqrd;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "lfhqid", nullable = false)
    protected LeadFreeHandQuotationEntity leadFreeHandQuotationEntity;

    protected String roomCategoryName;

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

    public LeadFreeHandQuotationRoomDetailsEntity() {
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

    public void updateEntityFromVO(LeadFreeHandQuotationRoomDetailsEntityDTO leadFreeHandQuotationRoomDetailsEntity){
        this.leadFreeHandQuotationEntity = leadFreeHandQuotationRoomDetailsEntity.getLeadFreeHandQuotationEntity();
        this.roomCategoryName = leadFreeHandQuotationRoomDetailsEntity.getRoomCategoryName();
        this.mealPlanId = leadFreeHandQuotationRoomDetailsEntity.getMealPlanId();
        this.adults = leadFreeHandQuotationRoomDetailsEntity.getAdults();
        this.cwb = leadFreeHandQuotationRoomDetailsEntity.getCwb();
        this.cnb = leadFreeHandQuotationRoomDetailsEntity.getCnb();
        this.extraBed = leadFreeHandQuotationRoomDetailsEntity.getExtraBed();
        this.checkInDate = leadFreeHandQuotationRoomDetailsEntity.getCheckInDate();
        this.checkOutDate = leadFreeHandQuotationRoomDetailsEntity.getCheckOutDate();
        this.adultsTotalPrice = leadFreeHandQuotationRoomDetailsEntity.getAdultPrice();
        this.cwbTotalPrice = leadFreeHandQuotationRoomDetailsEntity.getChildWithBedPrice();
        this.cnbTotalPrice = leadFreeHandQuotationRoomDetailsEntity.getChildNoBedPrice();
        this.extraBedTotalPrice = leadFreeHandQuotationRoomDetailsEntity.getExtraBedPrice();
        this.totalPrice = leadFreeHandQuotationRoomDetailsEntity.getTotalPrice();
    }

    public long getLfqrd() {
        return lfqrd;
    }

    public void setLfqrd(long lfqrd) {
        this.lfqrd = lfqrd;
    }

    public LeadFreeHandQuotationEntity getLeadFreeHandQuotationEntity() {
        return leadFreeHandQuotationEntity;
    }

    public void setLeadFreeHandQuotationEntity(LeadFreeHandQuotationEntity leadFreeHandQuotationEntity) {
        this.leadFreeHandQuotationEntity = leadFreeHandQuotationEntity;
    }

    public String getRoomCategoryName() {
        return roomCategoryName;
    }

    public void setRoomCategoryName(String roomCategoryName) {
        this.roomCategoryName = roomCategoryName;
    }
}