package com.vistaluxhms.model;

import com.vistaluxhms.entity.LeadSystemQuotationEntity;

import java.util.List;

public class LeadSystemQuotationEntityDTO extends LeadSystemQuotationEntity {
    private List<LeadSystemQuotationRoomDetailsEntityDTO> roomDetailsDTO;

    public List<LeadSystemQuotationRoomDetailsEntityDTO> getRoomDetailsDTO() {
        return roomDetailsDTO;
    }

    public void setRoomDetailsDTO(List<LeadSystemQuotationRoomDetailsEntityDTO> roomDetailsDTO) {
        this.roomDetailsDTO = roomDetailsDTO;
    }
}
