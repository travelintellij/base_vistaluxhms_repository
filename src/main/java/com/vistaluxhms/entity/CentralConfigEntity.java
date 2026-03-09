package com.vistaluxhms.entity;

import com.vistaluxhms.model.ClientEntityDTO;

import javax.persistence.*;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.Objects;

@Entity
@Table(name = "hotel_central_config")
public class CentralConfigEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    protected Integer id;

    @Column(name = "hotel_name", nullable = false)
    private String hotelName;

    @Column(name = "hotel_address", nullable = false)
    private String hotelAddress;

    @Column(name = "hotel_central_number")
    private String centralNumber;

    // Bank details
    @Column(name = "bank_name")
    private String bankName;

    @Column(name = "account_number")
    private String accountNumber;

    @Column(name = "ifsc_code")
    private String ifscCode;

    private String branch;

    // Watcher settings
    @Column(name = "global_watcher_emails")
    private String globalWatcherEmails;

    @Column(name = "global_watcher_enabled")
    private boolean globalWatcherEnabled;

    // Email & GST
    @Column(name = "centralized_email")
    private String centralizedEmail;

    @Column(name = "resort_gst_number")
    private String gstNumber;

    // Social media links
    @Column(name = "facebook_link")
    private String facebookLink;

    @Column(name = "instagram_link")
    private String instagramLink;

    @Column(name = "linkedin_link")
    private String linkedinLink;

    @Column(name = "youtube_link")
    private String youtubeLink;

    @Column(name = "x_link")
    private String xLink;

    @Column(name = "logo_path")
    private String logoPath;

    @Column(name = "baseUrl")
    private String baseUrl;

    @Column(name = "escalationEmail")
    private String escalationEmail;

    @Column(name = "escalationPhone")
    private String escalationPhone;

    @Column(name = "website")
    private String website;

    @Column(name = "accountName")
    private String accountName;

    @Column(name = "companyName")
    private String companyName;

    @Column(name = "quotationTopCover")
    private String quotationTopCover;

    @Column(name = "inclusions")
    private String inclusions;

    @Column(name = "tnc")
    private String tnc;

    @Column(name = "usp")
    private String usp;

    @Column(name = "hotelInfo")
    private String hotelInfo;

    // WhatsApp Settings
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

    // ===== AI MODIFICATION START =====
    // Change: Added Email Configuration fields to CentralConfigEntity
    // Reason: Email settings should be configurable from frontend, not hardcoded in
    // application.properties
    // Scope: Communication Channels > Email Config
    @Column(name = "email_smtp_host")
    private String emailSmtpHost;

    @Column(name = "email_smtp_port")
    private String emailSmtpPort;

    @Column(name = "email_smtp_username")
    private String emailSmtpUsername;

    @Column(name = "email_smtp_password")
    private String emailSmtpPassword;

    @Column(name = "email_from_address")
    private String emailFromAddress;

    @Column(name = "email_reply_to")
    private String emailReplyTo;

    @Column(name = "email_default_cc")
    private String emailDefaultCc;

    @Column(name = "email_notify_to")
    private String emailNotifyTo;

    @Column(name = "email_client_active")
    private String emailClientActive;

    @Column(name = "email_internal_active")
    private String emailInternalActive;
    // ===== AI MODIFICATION END =====

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getHotelName() {
        return hotelName;
    }

    public void setHotelName(String hotelName) {
        this.hotelName = hotelName;
    }

    public String getHotelAddress() {
        return hotelAddress;
    }

    public void setHotelAddress(String hotelAddress) {
        this.hotelAddress = hotelAddress;
    }

    public String getCentralNumber() {
        return centralNumber;
    }

    public void setCentralNumber(String centralNumber) {
        this.centralNumber = centralNumber;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public String getIfscCode() {
        return ifscCode;
    }

    public void setIfscCode(String ifscCode) {
        this.ifscCode = ifscCode;
    }

    public String getBranch() {
        return branch;
    }

    public void setBranch(String branch) {
        this.branch = branch;
    }

    public String getGlobalWatcherEmails() {
        return globalWatcherEmails;
    }

    public void setGlobalWatcherEmails(String globalWatcherEmails) {
        this.globalWatcherEmails = globalWatcherEmails;
    }

    public boolean isGlobalWatcherEnabled() {
        return globalWatcherEnabled;
    }

    public void setGlobalWatcherEnabled(boolean globalWatcherEnabled) {
        this.globalWatcherEnabled = globalWatcherEnabled;
    }

    public String getCentralizedEmail() {
        return centralizedEmail;
    }

    public void setCentralizedEmail(String centralizedEmail) {
        this.centralizedEmail = centralizedEmail;
    }

    public String getGstNumber() {
        return gstNumber;
    }

    public void setGstNumber(String gstNumber) {
        this.gstNumber = gstNumber;
    }

    public String getFacebookLink() {
        return facebookLink;
    }

    public void setFacebookLink(String facebookLink) {
        this.facebookLink = facebookLink;
    }

    public String getInstagramLink() {
        return instagramLink;
    }

    public void setInstagramLink(String instagramLink) {
        this.instagramLink = instagramLink;
    }

    public String getLinkedinLink() {
        return linkedinLink;
    }

    public void setLinkedinLink(String linkedinLink) {
        this.linkedinLink = linkedinLink;
    }

    public String getYoutubeLink() {
        return youtubeLink;
    }

    public void setYoutubeLink(String youtubeLink) {
        this.youtubeLink = youtubeLink;
    }

    public String getxLink() {
        return xLink;
    }

    public void setxLink(String xLink) {
        this.xLink = xLink;
    }

    public String getLogoPath() {
        return logoPath;
    }

    public void setLogoPath(String logoPath) {
        this.logoPath = logoPath;
    }

    public String getBaseUrl() {
        return baseUrl;
    }

    public void setBaseUrl(String baseUrl) {
        this.baseUrl = baseUrl;
    }

    public String getEscalationEmail() {
        return escalationEmail;
    }

    public void setEscalationEmail(String escalationEmail) {
        this.escalationEmail = escalationEmail;
    }

    public String getEscalationPhone() {
        return escalationPhone;
    }

    public void setEscalationPhone(String escalationPhone) {
        this.escalationPhone = escalationPhone;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getQuotationTopCover() {
        return quotationTopCover;
    }

    public void setQuotationTopCover(String quotationTopCover) {
        this.quotationTopCover = quotationTopCover;
    }

    public String getInclusions() {
        return inclusions;
    }

    public void setInclusions(String inclusions) {
        this.inclusions = inclusions;
    }

    public String getTnc() {
        return tnc;
    }

    public void setTnc(String tnc) {
        this.tnc = tnc;
    }

    public String getUsp() {
        return usp;
    }

    public void setUsp(String usp) {
        this.usp = usp;
    }

    public String getHotelInfo() {
        return hotelInfo;
    }

    public void setHotelInfo(String hotelInfo) {
        this.hotelInfo = hotelInfo;
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

    // ===== AI MODIFICATION START =====
    // Change: Added getters/setters for Email Configuration fields
    // Reason: Required for JPA mapping of new email config DB columns
    // Scope: Communication Channels > Email Config
    public String getEmailSmtpHost() {
        return emailSmtpHost;
    }

    public void setEmailSmtpHost(String emailSmtpHost) {
        this.emailSmtpHost = emailSmtpHost;
    }

    public String getEmailSmtpPort() {
        return emailSmtpPort;
    }

    public void setEmailSmtpPort(String emailSmtpPort) {
        this.emailSmtpPort = emailSmtpPort;
    }

    public String getEmailSmtpUsername() {
        return emailSmtpUsername;
    }

    public void setEmailSmtpUsername(String emailSmtpUsername) {
        this.emailSmtpUsername = emailSmtpUsername;
    }

    public String getEmailSmtpPassword() {
        return emailSmtpPassword;
    }

    public void setEmailSmtpPassword(String emailSmtpPassword) {
        this.emailSmtpPassword = emailSmtpPassword;
    }

    public String getEmailFromAddress() {
        return emailFromAddress;
    }

    public void setEmailFromAddress(String emailFromAddress) {
        this.emailFromAddress = emailFromAddress;
    }

    public String getEmailReplyTo() {
        return emailReplyTo;
    }

    public void setEmailReplyTo(String emailReplyTo) {
        this.emailReplyTo = emailReplyTo;
    }

    public String getEmailDefaultCc() {
        return emailDefaultCc;
    }

    public void setEmailDefaultCc(String emailDefaultCc) {
        this.emailDefaultCc = emailDefaultCc;
    }

    public String getEmailNotifyTo() {
        return emailNotifyTo;
    }

    public void setEmailNotifyTo(String emailNotifyTo) {
        this.emailNotifyTo = emailNotifyTo;
    }

    public String getEmailClientActive() {
        return emailClientActive;
    }

    public void setEmailClientActive(String emailClientActive) {
        this.emailClientActive = emailClientActive;
    }

    public String getEmailInternalActive() {
        return emailInternalActive;
    }

    public void setEmailInternalActive(String emailInternalActive) {
        this.emailInternalActive = emailInternalActive;
    }
    // ===== AI MODIFICATION END =====
}
