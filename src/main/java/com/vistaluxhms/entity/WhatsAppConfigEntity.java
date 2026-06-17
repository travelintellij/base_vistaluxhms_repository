package com.vistaluxhms.entity;

import javax.persistence.*;

@Entity
@Table(name = "hotel_whatsapp_config")
public class WhatsAppConfigEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    protected Integer id;

    @Column(name = "whats_app_api_url")
    private String whatsAppApiUrl;

    @Column(name = "whats_app_api_key")
    private String whatsAppApiKey;

    @Column(name = "whats_app_registration_template_id")
    private String whatsAppRegistrationTemplateId;

    @Column(name = "whats_app_stay_quotation_template_id")
    private String whatsAppStayQuotationTemplateId;

    @Column(name = "whats_app_guest_quotation_template_id")
    private String whatsAppGuestQuotationTemplateId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

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
