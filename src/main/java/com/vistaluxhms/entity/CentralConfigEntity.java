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
}
