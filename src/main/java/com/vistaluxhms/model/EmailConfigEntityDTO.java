package com.vistaluxhms.model;

public class EmailConfigEntityDTO {
    private String emailSmtpHost;
    private String emailSmtpPort;
    private String emailSmtpUsername;
    private String emailSmtpPassword;
    private String emailFromAddress;
    private String emailReplyTo;
    private String emailDefaultCc;
    private String emailNotifyTo;
    private String emailClientActive;
    private String emailInternalActive;

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
}
