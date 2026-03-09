package com.vistaluxhms.entity;

import javax.persistence.*;

@Entity
@Table(name = "hotel_email_config")
public class EmailConfigEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    protected Integer id;

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

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

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
