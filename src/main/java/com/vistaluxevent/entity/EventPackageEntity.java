package com.vistaluxevent.entity;

import com.vistaluxevent.model.EventPackageEntityDTO;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "event_package")
public class EventPackageEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    protected Long id;

    protected String packageName;
    protected String description;
    protected Integer baseGuestCount;
    protected int createdBy;
    protected int grand_total_cost;
    protected int discount;
    protected boolean gstIncluded=true;
    protected boolean showBreakup=true;


    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    protected LocalDate eventStartDate;

    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    protected LocalDate eventEndDate;

    protected int numberOfRooms;

    @OneToMany(mappedBy = "eventPackage", cascade = CascadeType.ALL)
    private List<EventPackageServiceEntity> services = new ArrayList<>();

    @ManyToOne
    @JoinColumn(name = "package_type", nullable = false)  // Maps to column 'package_type' which holds foreign key
    private EventTypeEntity eventType;


    protected long guestId;
    protected String guestName = "Guest";
    protected int quotationAudienceType;

    protected String contactMethod;
    protected String mobile;
    protected String email;

    public EventPackageEntity() {
    }

    //services list are not mapped in this constructor. that needs to be handled seperately.
    public EventPackageEntity(EventPackageEntityDTO eventPackageEntityDTO) {
        this.id = eventPackageEntityDTO.getId();
        this.packageName = eventPackageEntityDTO.getPackageName();
        this.description = eventPackageEntityDTO.getDescription();
        this.baseGuestCount = eventPackageEntityDTO.getBaseGuestCount();
        this.createdBy = eventPackageEntityDTO.getCreatedBy();
        this.grand_total_cost = eventPackageEntityDTO.getGrand_total_cost();
        this.discount = eventPackageEntityDTO.getDiscount();
        this.gstIncluded = eventPackageEntityDTO.isGstIncluded();
        this.showBreakup = eventPackageEntityDTO.isShowBreakup();
        this.eventStartDate = eventPackageEntityDTO.getEventStartDate();
        this.eventEndDate = eventPackageEntityDTO.getEventEndDate();
        this.numberOfRooms = eventPackageEntityDTO.getNumberOfRooms();
        this.guestId = eventPackageEntityDTO.getGuestId();
        this.guestName = eventPackageEntityDTO.getGuestName();
        this.quotationAudienceType = eventPackageEntityDTO.getQuotationAudienceType();
        this.contactMethod = eventPackageEntityDTO.getContactMethod();
        this.mobile = eventPackageEntityDTO.getMobile();
        this.email = eventPackageEntityDTO.getEmail();
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getBaseGuestCount() {
        return baseGuestCount;
    }

    public void setBaseGuestCount(Integer baseGuestCount) {
        this.baseGuestCount = baseGuestCount;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public List<EventPackageServiceEntity> getServices() {
        return services;
    }

    public void setServices(List<EventPackageServiceEntity> services) {
        this.services = services;
    }

    public EventTypeEntity getEventType() {
        return eventType;
    }

    public void setEventType(EventTypeEntity eventType) {
        this.eventType = eventType;
    }

    public int getGrand_total_cost() {
        return grand_total_cost;
    }

    public void setGrand_total_cost(int grand_total_cost) {
        this.grand_total_cost = grand_total_cost;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public LocalDate getEventStartDate() {
        return eventStartDate;
    }

    public void setEventStartDate(LocalDate eventStartDate) {
        this.eventStartDate = eventStartDate;
    }

    public LocalDate getEventEndDate() {
        return eventEndDate;
    }

    public void setEventEndDate(LocalDate eventEndDate) {
        this.eventEndDate = eventEndDate;
    }

    public int getNumberOfRooms() {
        return numberOfRooms;
    }

    public void setNumberOfRooms(int numberOfRooms) {
        this.numberOfRooms = numberOfRooms;
    }

    public boolean isGstIncluded() {
        return gstIncluded;
    }

    public void setGstIncluded(boolean gstIncluded) {
        this.gstIncluded = gstIncluded;
    }

    public boolean isShowBreakup() {
        return showBreakup;
    }

    public void setShowBreakup(boolean showBreakup) {
        this.showBreakup = showBreakup;
    }

    public long getGuestId() {
        return guestId;
    }

    public void setGuestId(long guestId) {
        this.guestId = guestId;
    }

    public String getGuestName() {
        return guestName;
    }

    public void setGuestName(String guestName) {
        this.guestName = guestName;
    }

    public int getQuotationAudienceType() {
        return quotationAudienceType;
    }

    public void setQuotationAudienceType(int quotationAudienceType) {
        this.quotationAudienceType = quotationAudienceType;
    }

    public String getContactMethod() {
        return contactMethod;
    }

    public void setContactMethod(String contactMethod) {
        this.contactMethod = contactMethod;
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

}
