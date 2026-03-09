package com.vistaluxhms.model;

public class WhatsAppConfigEntityDTO {
    private String whatsAppApiUrl;
    private String whatsAppApiKey;
    private String whatsAppRegistrationTemplateId;
    private String whatsAppStayQuotationTemplateId;
    private String whatsAppGuestQuotationTemplateId;

    public String getWhatsAppApiUrl() {
        return whatsAppApiUrl;
    }

    public void setWhatsAppApiUrl(String whatsAppApiUrl) {
        this.whatsAppApiUrl = whatsAppApiUrl;
    }

    public String getWhatsAppApiKey() {
        return whatsAppApiKey;
    }

    public void setWhatsAppApiKey(String whatsAppApiKey) {
        this.whatsAppApiKey = whatsAppApiKey;
    }

    public String getWhatsAppRegistrationTemplateId() {
        return whatsAppRegistrationTemplateId;
    }

    public void setWhatsAppRegistrationTemplateId(String whatsAppRegistrationTemplateId) {
        this.whatsAppRegistrationTemplateId = whatsAppRegistrationTemplateId;
    }

    public String getWhatsAppStayQuotationTemplateId() {
        return whatsAppStayQuotationTemplateId;
    }

    public void setWhatsAppStayQuotationTemplateId(String whatsAppStayQuotationTemplateId) {
        this.whatsAppStayQuotationTemplateId = whatsAppStayQuotationTemplateId;
    }

    public String getWhatsAppGuestQuotationTemplateId() {
        return whatsAppGuestQuotationTemplateId;
    }

    public void setWhatsAppGuestQuotationTemplateId(String whatsAppGuestQuotationTemplateId) {
        this.whatsAppGuestQuotationTemplateId = whatsAppGuestQuotationTemplateId;
    }
}
