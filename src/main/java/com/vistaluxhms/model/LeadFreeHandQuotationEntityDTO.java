package com.vistaluxhms.model;

import com.vistaluxhms.entity.LeadFreeHandQuotationEntity;
import com.vistaluxhms.entity.LeadSystemQuotationEntity;

import java.util.List;

public class LeadFreeHandQuotationEntityDTO extends LeadFreeHandQuotationEntity {
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

    public void updateDTOFromEntity(LeadFreeHandQuotationEntity leadFHQuotationEntity){
        this.lfhqid = lfhqid;
        this.leadEntity = leadFHQuotationEntity.getLeadEntity();
        this.clientEntity = leadFHQuotationEntity.getClientEntity();
        this.versionId = leadFHQuotationEntity.getVersionId();
        this.grandTotal = leadFHQuotationEntity.getGrandTotal();
        this.discount = leadFHQuotationEntity.getDiscount();
        this.remarks = leadFHQuotationEntity.getRemarks();
        this.roomDetails = leadFHQuotationEntity.getRoomDetails();
    }

}
