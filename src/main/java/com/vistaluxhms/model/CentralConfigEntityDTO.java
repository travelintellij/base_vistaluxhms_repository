package com.vistaluxhms.model;

import org.springframework.web.multipart.MultipartFile;

import javax.persistence.Column;

public class CentralConfigEntityDTO {
    private String hotelName;
    private String hotelAddress;
    private String centralNumber;

    // Bank details
    private String bankName;
    private String accountNumber;
    private String ifscCode;
    private String branch;

    // Watcher settings
    private String globalWatcherEmails;
    private boolean globalWatcherEnabled;

    // Email & GST
    private String centralizedEmail;
    private String gstNumber;

    // Social media links
    private String facebookLink;
    private String instagramLink;
    private String linkedinLink;
    private String youtubeLink;
    private String xLink;

    private String baseUrl;

    private String escalationEmail;
    private String escalationPhone;

    private String website;

    // For logo upload
    private MultipartFile logoFile; // Optional, if you want to save it as a blob
    // OR use MultipartFile in controller for better handling

    private String logoPath;

    private String accountName;
    private String companyName;

    private String quotationTopCover;
    private String inclusions;
    private String tnc;

    private String usp;

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

    public MultipartFile getLogoFile() {
        return logoFile;
    }

    public void setLogoFile(MultipartFile logoFile) {
        this.logoFile = logoFile;
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
}
