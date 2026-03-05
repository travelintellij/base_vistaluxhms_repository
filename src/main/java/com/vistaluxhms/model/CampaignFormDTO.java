package com.vistaluxhms.model;

import com.vistaluxhms.entity.CampaignFormEntity;

public class CampaignFormDTO {

    private Long campaignFormId;
    private String formName;
    private String formType; // "META" or "GOOGLE"
    private String formId;
    private String campaignName;
    private String description;
    private Boolean active = true;

    public CampaignFormDTO() {
    }

    public void updateFromEntity(CampaignFormEntity entity) {
        this.campaignFormId = entity.getCampaignFormId();
        this.formName = entity.getFormName();
        this.formType = entity.getFormType();
        this.formId = entity.getFormId();
        this.campaignName = entity.getCampaignName();
        this.description = entity.getDescription();
        this.active = entity.getActive();
    }

    // Getters and Setters
    public Long getCampaignFormId() {
        return campaignFormId;
    }

    public void setCampaignFormId(Long campaignFormId) {
        this.campaignFormId = campaignFormId;
    }

    public String getFormName() {
        return formName;
    }

    public void setFormName(String formName) {
        this.formName = formName;
    }

    public String getFormType() {
        return formType;
    }

    public void setFormType(String formType) {
        this.formType = formType;
    }

    public String getFormId() {
        return formId;
    }

    public void setFormId(String formId) {
        this.formId = formId;
    }

    public String getCampaignName() {
        return campaignName;
    }

    public void setCampaignName(String campaignName) {
        this.campaignName = campaignName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }
}
