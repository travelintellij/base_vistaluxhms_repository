package com.vistaluxhms.model;

/**
 * NEW CLASS: WhatsAppResult
 * Purpose: Carries the result of a WhatsApp send operation back to the
 * controller.
 * This allows controllers to know whether WhatsApp sending succeeded or failed,
 * and to display the exact failure reason on the frontend to the user.
 *
 * Usage: Every WhatsApp send method in WhatsAppMessagingService now returns
 * a WhatsAppResult instead of void, so the caller can check isSuccess()
 * and display getErrorMessage() to the frontend if it failed.
 *
 * Error scenarios covered:
 * - Template ID not configured in DB -> descriptive error message
 * - API URL not configured -> descriptive error message
 * - Auth Key not configured or invalid -> descriptive error message
 * - WhatsApp API returns HTTP error (e.g. wrong template at API level) ->
 * includes HTTP code and response
 * - Network/connection error -> includes exception message
 */
public class WhatsAppResult {

    // Whether the WhatsApp message was sent successfully
    private boolean success;

    // Descriptive error message explaining why the message failed.
    // This message is shown directly on the frontend to help the user fix the
    // issue.
    // Examples: "Template ID is not configured", "API returned HTTP 400", etc.
    private String errorMessage;

    // Constructor for success
    public WhatsAppResult(boolean success) {
        this.success = success;
        this.errorMessage = null;
    }

    // Constructor for success or failure with error message
    public WhatsAppResult(boolean success, String errorMessage) {
        this.success = success;
        this.errorMessage = errorMessage;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }

    @Override
    public String toString() {
        return "WhatsAppResult{" +
                "success=" + success +
                ", errorMessage='" + errorMessage + '\'' +
                '}';
    }
}
