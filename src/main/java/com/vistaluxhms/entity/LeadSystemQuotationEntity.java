package com.vistaluxhms.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.vistaluxhms.model.LeadEntityDTO;
import com.vistaluxhms.model.LeadSystemQuotationEntityDTO;
import com.vistaluxhms.model.QuotationRoomDetailsDTO;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.List;


@Entity
@Table(name = "lead_system_quotation")
public class LeadSystemQuotationEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "lsqid")
    protected Long lsqid;

    @ManyToOne
    @JoinColumn(name = "leadId", nullable = false)
    protected LeadEntity leadEntity;

    @ManyToOne
    @JoinColumn(name = "clientId", nullable = false)
    protected ClientEntity clientEntity;

    protected int versionId;
    //protected int contactMethod;

    //protected String guestName;

    //@Column(length = 45)
    //protected String mobile;

    //@Column(length = 1000)
    //protected String email;

    protected long grandTotal;
    protected int discount;

    @Column(length = 1000)
    protected String remarks;

    @OneToMany(mappedBy = "leadSystemQuotationEntity", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    protected List<LeadSystemQuotationRoomDetailsEntity> roomDetails;



    public Long getLsqid() {
        return lsqid;
    }

    public void setLsqid(Long lsqid) {
        this.lsqid = lsqid;
    }

    public LeadEntity getLeadEntity() {
        return leadEntity;
    }

    public void setLeadEntity(LeadEntity leadEntity) {
        this.leadEntity = leadEntity;
    }

    public ClientEntity getClientEntity() {
        return clientEntity;
    }

    public void setClientEntity(ClientEntity clientEntity) {
        this.clientEntity = clientEntity;
    }

    public Integer getVersionId() {
        return versionId;
    }

    public void setVersionId(Integer versionId) {
        this.versionId = versionId;
    }


    public Long getGrandTotal() {
        return grandTotal;
    }

    public void setGrandTotal(long grandTotal) {
        this.grandTotal = grandTotal;
    }

    public Integer getDiscount() {
        return discount;
    }

    public void setDiscount(Integer discount) {
        this.discount = discount;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public List<LeadSystemQuotationRoomDetailsEntity> getRoomDetails() {
        return roomDetails;
    }

    public void setRoomDetails(List<LeadSystemQuotationRoomDetailsEntity> roomDetails) {
        this.roomDetails = roomDetails;
    }

    public void updateEntityfromVO(LeadSystemQuotationEntityDTO leadSystemQuotationEntityDTO){
        //this.lsqid = lsqid;
        this.leadEntity = leadSystemQuotationEntityDTO.getLeadEntity();
        this.clientEntity = leadSystemQuotationEntityDTO.getClientEntity();
        this.versionId = leadSystemQuotationEntityDTO.getVersionId();
        //this.contactMethod = contactMethod;
        //this.guestName = guestName;
        //this.mobile = mobile;
        //this.email = email;
        this.grandTotal = leadSystemQuotationEntityDTO.getGrandTotal();
        this.discount = leadSystemQuotationEntityDTO.getDiscount();
        this.remarks = leadSystemQuotationEntityDTO.getRemarks();
        //this.roomDetails = leadSystemQuotationEntityDTO.getRoomDetails();
    }

    @Override
    public String toString() {
        return "LeadSystemQuotationEntity{" +
                "lsqid=" + lsqid +
                ", leadEntity=" + leadEntity +
                ", clientEntity=" + clientEntity +
                ", versionId=" + versionId +
                ", grandTotal=" + grandTotal +
                ", discount=" + discount +
                ", remarks='" + remarks + '\'' +
                ", roomDetails=" + roomDetails +
                '}';
    }
}

