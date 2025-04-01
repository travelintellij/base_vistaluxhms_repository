package com.vistaluxhms.model;

public class WhatsAppMessageDTO {
    String recipientMobile;
    String recipientName;
    String queryId;
    String queryOwnerName;
    String queryOwnerMobile;
    String queryOwnerEmail;

    public String getRecipientMobile() {
        return recipientMobile;
    }

    public void setRecipientMobile(String recipientMobile) {
        this.recipientMobile = recipientMobile;
    }

    public String getRecipientName() {
        return recipientName;
    }

    public void setRecipientName(String recipientName) {
        this.recipientName = recipientName;
    }

    public String getQueryId() {
        return queryId;
    }

    public void setQueryId(String queryId) {
        this.queryId = queryId;
    }

    public String getQueryOwnerName() {
        return queryOwnerName;
    }

    public void setQueryOwnerName(String queryOwnerName) {
        this.queryOwnerName = queryOwnerName;
    }

    public String getQueryOwnerMobile() {
        return queryOwnerMobile;
    }

    public void setQueryOwnerMobile(String queryOwnerMobile) {
        this.queryOwnerMobile = queryOwnerMobile;
    }

    public String getQueryOwnerEmail() {
        return queryOwnerEmail;
    }

    public void setQueryOwnerEmail(String queryOwnerEmail) {
        this.queryOwnerEmail = queryOwnerEmail;
    }
}
