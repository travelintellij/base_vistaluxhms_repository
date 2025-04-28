package com.vistaluxevent.model;

import com.vistaluxevent.entity.EventMasterServiceEntity;
import com.vistaluxevent.entity.EventPackageEntity;

import java.time.format.DateTimeFormatter;
import java.util.List;

public class EventPackageEntityDTO extends EventPackageEntity {

    private String formattedStartDate;
    private String formattedEndDate;

    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yyyy");

    public void updateDTOFromEntity(EventPackageEntity eventPackageEntity){
        this.setGrand_total_cost(eventPackageEntity.getGrand_total_cost());
        this.setEventStartDate(eventPackageEntity.getEventStartDate());
        this.setServices(eventPackageEntity.getServices());
        this.setEventEndDate(eventPackageEntity.getEventEndDate());
        this.setEventType(eventPackageEntity.getEventType());
        this.setDiscount(eventPackageEntity.getDiscount());
        this.setEmail(eventPackageEntity.getEmail());
        this.setDescription(eventPackageEntity.getDescription());
        this.setCreatedBy(eventPackageEntity.getCreatedBy());
        this.setBaseGuestCount(eventPackageEntity.getBaseGuestCount());
        this.setContactMethod(eventPackageEntity.getContactMethod());
        this.setGstIncluded(eventPackageEntity.isGstIncluded());
        this.setGuestId(eventPackageEntity.getGuestId());
        this.setGuestName(eventPackageEntity.getGuestName());
        this.setMobile(eventPackageEntity.getMobile());
        this.setQuotationAudienceType(eventPackageEntity.getQuotationAudienceType());
        this.setShowBreakup(eventPackageEntity.isShowBreakup());
        this.setId(eventPackageEntity.getId());
        this.setPackageName(eventPackageEntity.getPackageName());
        this.setNumberOfRooms(eventPackageEntity.getNumberOfRooms());
        this.setFormattedStartDate(formatter.format(eventPackageEntity.getEventStartDate()));
        this.setFormattedEndDate(formatter.format(eventPackageEntity.getEventEndDate()));

    }

    public String getFormattedStartDate() {
        return formattedStartDate;
    }

    public void setFormattedStartDate(String formattedStartDate) {
        this.formattedStartDate = formattedStartDate;
    }

    public String getFormattedEndDate() {
        return formattedEndDate;
    }

    public void setFormattedEndDate(String formattedEndDate) {
        this.formattedEndDate = formattedEndDate;
    }
}
