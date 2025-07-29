package com.vistaluxhms.model;

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

    // For logo upload
    private byte[] logoFile; // Optional, if you want to save it as a blob
    // OR use MultipartFile in controller for better handling

    // Getters and Setters
    // ... (generate via Lombok @Data or manually)


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

    public byte[] getLogoFile() {
        return logoFile;
    }

    public void setLogoFile(byte[] logoFile) {
        this.logoFile = logoFile;
    }
}
