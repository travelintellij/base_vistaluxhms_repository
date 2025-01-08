package com.vistaluxhms.entity;

import com.vistaluxhms.model.ClientEntityDTO;

import javax.persistence.*;


import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.Objects;

@Entity
@Table(name = "client")
public class ClientEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "clientId")
    protected Long clientId;

    @NotNull
    @Column(name = "clientName", nullable = false)
    protected String clientName;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "cityId", referencedColumnName = "destinationId")
    protected City_Entity city;

    @Column(name = "mobile")
    protected Long mobile;

    @Column(name = "emailId")
    protected String emailId;

    @Column(name = "reference")
    protected String reference;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "salesPartnerId", referencedColumnName = "salesPartnerId")
    protected SalesPartnerEntity salesPartner;

    @Column(name = "remarks")
    protected String remarks;

    @Column(name = "active", nullable = false)
    protected Boolean active = true; // Active Status

    @Column(name = "b2b", nullable = false)
    protected Boolean b2b = true; // Active Status


    public ClientEntity(){}
    public ClientEntity(ClientEntityDTO clientEntityDto) {
        this.city= clientEntityDto.getCity();
        this.clientId=clientEntityDto.getClientId();
        this.mobile=clientEntityDto.getMobile();
        this.clientName=clientEntityDto.getClientName();
        this.reference=clientEntityDto.getReference();
        this.emailId=clientEntityDto.getEmailId();
        this.remarks=clientEntityDto.getRemarks();
        this.salesPartner=clientEntityDto.getSalesPartner();
        this.active=clientEntityDto.getActive();
        this.b2b=clientEntityDto.getB2b();
    }

    // Getters and Setters

    public Long getClientId() {
        return clientId;
    }

    public void setClientId(Long clientId) {
        this.clientId = clientId;
    }

    public String getClientName() {
        return clientName;
    }

    public void setClientName(String clientName) {
        this.clientName = clientName;
    }

    public City_Entity getCity() {
        return city;
    }

    public void setCity(City_Entity city) {
        this.city = city;
    }

    public Long getMobile() {
        return mobile;
    }

    public void setMobileNumber(Long mobile) {
        this.mobile = mobile;
    }

    public String getEmailId() {
        return emailId;
    }

    public void setEmailId(String emailId) {
        this.emailId = emailId;
    }

    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }

    public SalesPartnerEntity getSalesPartner() {
        return salesPartner;
    }

    public void setSalesPartner(SalesPartnerEntity salesPartner) {
        this.salesPartner = salesPartner;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    // Override equals and hashcode for proper entity comparison
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ClientEntity that = (ClientEntity) o;
        return Objects.equals(clientId, that.clientId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(clientId);
    }

    public void setMobile(Long mobile) {
        this.mobile = mobile;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public Boolean getB2b() {
        return b2b;
    }

    public void setB2b(Boolean b2b) {
        this.b2b = b2b;
    }
}
