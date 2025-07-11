package com.vistaluxhms.model;

import com.vistaluxhms.entity.LeadSystemQuotationEntity;

import java.util.List;

public class LeadSystemQuotationEntityDTO extends LeadSystemQuotationEntity {
    private List<LeadSystemQuotationRoomDetailsEntityDTO> roomDetailsDTO;
    private String guestName;
    private String mobile;
    private String email;

    public List<LeadSystemQuotationRoomDetailsEntityDTO> getRoomDetailsDTO() {
        return roomDetailsDTO;
    }

    public void setRoomDetailsDTO(List<LeadSystemQuotationRoomDetailsEntityDTO> roomDetailsDTO) {
        this.roomDetailsDTO = roomDetailsDTO;
    }

    public String getGuestName() {
        return guestName;
    }

    public void setGuestName(String guestName) {
        this.guestName = guestName;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void updateDTOFromEntity(LeadSystemQuotationEntity leadSystemQuotationEntity){
        this.lsqid = lsqid;
        this.leadEntity = leadSystemQuotationEntity.getLeadEntity();
        this.clientEntity = leadSystemQuotationEntity.getClientEntity();
        this.versionId = leadSystemQuotationEntity.getVersionId();
        this.grandTotal = leadSystemQuotationEntity.getGrandTotal();
        this.discount = leadSystemQuotationEntity.getDiscount();
        this.remarks = leadSystemQuotationEntity.getRemarks();
        this.roomDetails = leadSystemQuotationEntity.getRoomDetails();
    }

}
