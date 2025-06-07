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

    @Column(name = "noOfChild", nullable = false)
    protected int noOfChild = 0;

    @Column(name = "noOfRooms", nullable = false)
    protected int noOfRooms =0;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    protected LocalDate checkInDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    protected LocalDate checkOutDate;

    @Column(name = "totalPrice", nullable = false)
    protected int totalPrice = 0;

    public void setTotalPrice(Integer totalPrice) {
        this.totalPrice = totalPrice;
    }

    public LeadFreeHandQuotationRoomDetailsEntity() {
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

    public int getNoOfChild() {
        return noOfChild;
    }

    public void setNoOfChild(int noOfChild) {
        this.noOfChild = noOfChild;
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
        this.checkInDate = leadFreeHandQuotationRoomDetailsEntity.getCheckInDate();
        this.checkOutDate = leadFreeHandQuotationRoomDetailsEntity.getCheckOutDate();
        this.totalPrice = leadFreeHandQuotationRoomDetailsEntity.getTotalPrice();
        this.noOfChild=leadFreeHandQuotationRoomDetailsEntity.getNoOfChild();
        this.noOfRooms=leadFreeHandQuotationRoomDetailsEntity.getNoOfRooms();
    }

    public int getNoOfRooms() {
        return noOfRooms;
    }

    public void setNoOfRooms(int noOfRooms) {
        this.noOfRooms = noOfRooms;
    }
}