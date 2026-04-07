package com.vistaluxhms.services;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.vistaluxhms.model.WhatsAppMessageDTO;
import com.vistaluxhms.model.WhatsAppResult;
import okhttp3.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

@Service
public class WhatsAppMessagingService {


    private static final Logger logger = LoggerFactory.getLogger(WhatsAppMessagingService.class);
    private final SettingsAndOtherServicesImpl configService;

    public WhatsAppMessagingService(SettingsAndOtherServicesImpl configService) {
        this.configService = configService;
    }

    private static final MediaType JSON = MediaType.parse("application/json");
    private final OkHttpClient client = new OkHttpClient();

    private String getApiUrl() {
        return configService.getWhatsAppConfig().getWhatsAppApiUrl();
    }

    private String getApiKey() {
        return configService.getWhatsAppConfig().getWhatsAppApiKey();
    }

    /**
     * NEW METHOD: Validates all WhatsApp configuration before attempting to send.
     * Checks API URL, Auth Key, and the specific Template ID.
     *
     * @param templateId    The template ID to validate (fetched from DB)
     * @param templateLabel A human-readable label for the template (e.g., "Query
     *                      Registration")
     *                      used in error messages so the user knows WHICH template
     *                      is missing.
     * @return A descriptive error message if any config is missing/invalid, or null
     *         if all is valid.
     */
    private String validateConfig(String templateId, String templateLabel) {
        String apiUrl = getApiUrl();
        String apiKey = getApiKey();

        // Check API URL — if missing from both DB and application.properties
        if (apiUrl == null || apiUrl.trim().isEmpty()) {
            return "WhatsApp API URL is not configured. "
                    + "Please set it in Settings > WhatsApp Configuration.";
        }

        // Check Auth Key — if missing from both DB and application.properties
        // Also check for "0" which is the default placeholder in application.properties
        if (apiKey == null || apiKey.trim().isEmpty() || "0".equals(apiKey.trim())) {
            return "WhatsApp Auth Key is not configured or is invalid (current value: '"
                    + (apiKey != null ? apiKey : "null") + "'). "
                    + "Please set a valid Auth Key in Settings > WhatsApp Configuration.";
        }

        // Check Template ID — NO fallback exists for template IDs.
        // Template IDs must be explicitly configured in the DB via the Settings UI.
        if (templateId == null || templateId.trim().isEmpty()) {
            return templateLabel + " Template ID is not configured. "
                    + "Please set it in Settings > WhatsApp Configuration.";
        }

        return null; // all config values are valid
    }

    /**
     * CHANGED: Return type changed from void to WhatsAppResult.
     * Previously this method silently swallowed errors. Now it returns a result
     * object so the controller can inform the frontend about the failure reason.
     *
     * Also REMOVED: The "0000" fallback for template ID.
     * Reason: There is no default template ID — using "0000" would silently fail at
     * the API.
     * Now the method validates the template ID BEFORE sending and returns a clear
     * error if missing.
     */
    public WhatsAppResult sendQueryRegistrationMessage(WhatsAppMessageDTO dto) {
        // CHANGED: Fetch template ID from DB — no more "0000" fallback
        String wid = configService.getWhatsAppConfig().getWhatsAppRegistrationTemplateId();

        // REMOVED (original code commented below):
        // if (wid == null || wid.trim().isEmpty()) {
        // wid = "0000"; // REMOVED: fallback hardcoded id was causing silent failures
        // }

        // ADDED: Pre-send validation — checks API URL, Auth Key, and Template ID
        String validationError = validateConfig(wid, "Query Registration");
        if (validationError != null) {
            logger.debug("WhatsApp Config Error: " + validationError);
            return new WhatsAppResult(false, validationError);
        }

        try {
            String jsonBody = "{\n" +
                    "  \"country_code\": \"91\",\n" +
                    "  \"mobile\": \"" + normalizeMobile(dto.getRecipientMobile()) + "\",\n" +
                    "  \"wid\": \"" + wid + "\",\n" +
                    "  \"type\": \"text\",\n" +
                    "  \"bodyValues\": {\n" +
                    "    \"1\": \"" + escape(dto.getRecipientName()) + "\",\n" +
                    "    \"2\": \"" + escape(dto.getQueryId()) + "\",\n" +
                    "    \"3\": \"" + escape(dto.getQueryOwnerName()) + "\",\n" +
                    "    \"4\": \"" + escape(dto.getQueryOwnerMobile()) + "\",\n" +
                    "    \"5\": \"" + escape(dto.getQueryOwnerEmail()) + "\"\n" +
                    "  }\n" +
                    "}";

            log(wid, dto.getRecipientMobile(), jsonBody);
            // CHANGED: Now capturing and returning the result from execute()
            return execute(jsonBody);

        } catch (Exception e) {
            logger.error("Exception caught", e);
            // CHANGED: Returning error result instead of silently swallowing the exception
            return new WhatsAppResult(false,
                    "WhatsApp message sending failed due to: " + e.getMessage());
        }
    }

    /**
     * CHANGED: execute() now returns WhatsAppResult instead of void.
     * Parses the API response to detect failures such as invalid template ID,
     * authentication errors, or other API-level rejections.
     *
     * Previously the method only printed the response and did not report
     * success/failure.
     */
    private WhatsAppResult execute(String jsonBody) {
        try {
            String apiUrl = getApiUrl();
            String apiKey = getApiKey();

            Request request = new Request.Builder()
                    .url(apiUrl)
                    .post(RequestBody.create(JSON, jsonBody))
                    .addHeader("Authorization", "Basic " + apiKey)
                    .addHeader("Content-Type", "application/json")
                    .build();

            Response response = client.newCall(request).execute();

            // ADDED: Read the response body to include in error messages for debugging
            String responseBody = (response.body() != null) ? response.body().string() : "NO RESPONSE";

            System.out.println("WhatsApp Response Code: " + response.code());
            logger.debug("WhatsApp Response Body: " + responseBody);

            // ADDED: Check HTTP status to detect API-level failures
            // (e.g., wrong template ID, invalid auth key, etc.)
            if (!response.isSuccessful()) {
                return new WhatsAppResult(false,
                        "WhatsApp message delivery failed. API returned HTTP " + response.code()
                                + ". Response: " + responseBody
                                + ". Please verify your Template ID and Auth Key in Settings.");
            }

            // ADDED: Success result — message was accepted by the WhatsApp API
            return new WhatsAppResult(true, null);

        } catch (Exception e) {
            logger.error("Exception caught", e);
            // ADDED: Return descriptive error for network/connection failures
            return new WhatsAppResult(false,
                    "WhatsApp message sending failed due to: " + e.getMessage());
        }
    }

    private void log(String wid, String mobile, String payload) {
        logger.debug("=========== WhatsApp API LOG ===========");
        logger.debug("Template ID : " + wid);
        logger.debug("Recipient Mobile : " + mobile);
        System.out.println("API URL : " + getApiUrl());
        logger.debug("Request Payload : ");
        logger.debug(payload);
        logger.debug("=======================================");
    }

    private String safe(String v) {
        return v == null ? "" : v;
    }

    private String escape(String v) {
        return safe(v)
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n");
    }

    private String normalizeMobile(String mobile) {
        if (mobile == null)
            return "";
        mobile = mobile.trim();
        if (mobile.startsWith("+91"))
            mobile = mobile.substring(3);
        if (mobile.startsWith("91") && mobile.length() > 10)
            mobile = mobile.substring(2);
        return mobile;
    }

    /**
     * CHANGED: Return type changed from void to WhatsAppResult.
     * Previously this method threw RuntimeException on errors. Now it returns a
     * result
     * object with a descriptive error message for frontend display.
     *
     * Also REMOVED: The "0000" fallback for template ID.
     * Reason: There is no default template ID — using "0000" would silently fail at
     * the API.
     */
    public WhatsAppResult sendStayQuotationMessage(WhatsAppMessageDTO dto, String queryDetails) {
        // CHANGED: Fetch template ID from DB — no more "0000" fallback
        String wid = configService.getWhatsAppConfig().getWhatsAppStayQuotationTemplateId();

        // REMOVED (original code commented below):
        // if (wid == null || wid.trim().isEmpty()) {
        // wid = "0000"; // REMOVED: fallback hardcoded id was causing silent failures
        // }

        // ADDED: Pre-send validation — checks API URL, Auth Key, and Template ID
        String validationError = validateConfig(wid, "Stay Quotation");
        if (validationError != null) {
            logger.debug("WhatsApp Config Error: " + validationError);
            return new WhatsAppResult(false, validationError);
        }

        try {
            Map<String, Object> payload = new HashMap<>();
            payload.put("country_code", "91");
            payload.put("mobile", normalizeMobile(dto.getRecipientMobile()));
            payload.put("wid", wid);
            payload.put("type", "text");

            Map<String, String> bodyValues = new HashMap<>();
            bodyValues.put("1", dto.getRecipientName());
            bodyValues.put("2", String.valueOf(dto.getNoOfRooms()));
            bodyValues.put("3", dto.getGuestDetails());
            bodyValues.put("4", String.valueOf(dto.getFinalPrice()));
            bodyValues.put("5", dto.getQueryOwnerName() + " | " + dto.getQueryOwnerMobile());

            payload.put("bodyValues", bodyValues);
            ObjectMapper mapper = new ObjectMapper();
            String jsonBody = mapper.writeValueAsString(payload);
            logger.debug("Final Json body is " + jsonBody);
            // CHANGED: Now capturing and returning the result from execute()
            return execute(jsonBody);

        } catch (Exception e) {
            // CHANGED: Returning error result instead of throwing RuntimeException
            // REMOVED (original code):
            // throw new RuntimeException(e);
            logger.error("Exception caught", e);
            return new WhatsAppResult(false,
                    "WhatsApp message sending failed due to: " + e.getMessage());
        }
        /*
         * try {
         * String jsonBody =
         * "{\n" +
         * "  \"country_code\": \"91\",\n" +
         * "  \"mobile\": \"" + normalizeMobile(dto.getRecipientMobile()) + "\",\n" +
         * "  \"wid\": \"27185\",\n" +
         * "  \"type\": \"text\",\n" +
         * "  \"bodyValues\": {\n" +
         * "    \"1\": \"" + escape(dto.getRecipientName()) + "\",\n" +
         * "    \"2\": \"" + escape(queryDetails) + "\",\n" +
         * "    \"3\": \"" + dto.getFinalPrice() + "\",\n" +
         * "    \"4\": \"" + escape(dto.getQueryOwnerMobile()) + "\"\n" +
         * "  }\n" +
         * "}";
         * 
         * log("27185", dto.getRecipientMobile(), jsonBody);
         * execute(jsonBody);
         * 
         * } catch (Exception e) {
         * logger.error("Exception caught", e);
         * }
         * 
         */
    }

    /*
     * public void sendQueryRegistrationMessage(WhatsAppMessageDTO messageDetails) {
     * try {
     * OkHttpClient client = new OkHttpClient().newBuilder().build();
     * 
     * okhttp3.MediaType mediaType = MediaType.parse("application/json");
     * 
     * // JSON body with placeholders
     * String jsonBody = "{\r\n" +
     * "  \"messaging_product\": \"whatsapp\",\r\n" +
     * "  \"recipient_type\": \"individual\",\r\n" +
     * "  \"to\": \"{{recipient_number}}\",\r\n" +
     * "  \"type\": \"template\",\r\n" +
     * "  \"template\": {\r\n" +
     * "    \"name\": \"queryregistration\",\r\n" +
     * "    \"language\": {\r\n" +
     * "      \"code\": \"en\"\r\n" +
     * "    },\r\n" +
     * "    \"components\": [\r\n" +
     * "      {\r\n" +
     * "        \"type\": \"body\",\r\n" +
     * "        \"parameters\": [\r\n" +
     * "          {\r\n" +
     * "            \"type\": \"text\",\r\n" +
     * "            \"text\": \"{{name}}\"\r\n" +
     * "          },\r\n" +
     * "          {\r\n" +
     * "            \"type\": \"text\",\r\n" +
     * "            \"text\": \"{{query_id}}\"\r\n" +
     * "          },\r\n" +
     * "          {\r\n" +
     * "            \"type\": \"text\",\r\n" +
     * "            \"text\": \"{{query_owner}}\"\r\n" +
     * "          },\r\n" +
     * "          {\r\n" +
     * "            \"type\": \"text\",\r\n" +
     * "            \"text\": \"{{mobile}}\"\r\n" +
     * "          },\r\n" +
     * "          {\r\n" +
     * "            \"type\": \"text\",\r\n" +
     * "            \"text\": \"{{email}}\"\r\n" +
     * "          }\r\n" +
     * "        ]\r\n" +
     * "      }\r\n" +
     * "    ]\r\n" +
     * "  }\r\n" +
     * "}";
     * 
     * // Replace placeholders with actual values
     * jsonBody = jsonBody.replace("{{recipient_number}}",
     * messageDetails.getRecipientMobile())
     * .replace("{{name}}", messageDetails.getRecipientName())
     * .replace("{{query_id}}", messageDetails.getQueryId())
     * .replace("{{query_owner}}", messageDetails.getQueryOwnerName())
     * .replace("{{mobile}}", messageDetails.getQueryOwnerMobile())
     * .replace("{{email}}", messageDetails.getQueryOwnerEmail());
     * 
     * RequestBody body = RequestBody.create(mediaType, jsonBody);
     * 
     * Request request = new Request.Builder()
     * .url(whatsAppApiUrl)
     * .method("POST", body)
     * .addHeader("Content-Type", "application/json")
     * .addHeader("Authorization", "Bearer " + whatsAppApiKey)
     * .build();
     * 
     * Response response = client.newCall(request).execute();
     * System.out.println("Response is " + response.body().string()); // Print API
     * response
     * 
     * } catch (Exception e) {
     * logger.error("Exception caught", e);
     * }
     * }
     * 
     * 
     * public void sendStayQuotationMessage(WhatsAppMessageDTO messageDetails) {
     * try {
     * OkHttpClient client = new OkHttpClient().newBuilder().build();
     * MediaType mediaType = MediaType.parse("application/json");
     * 
     * String jsonBody = "{\r\n" +
     * "  \"messaging_product\": \"whatsapp\",\r\n" +
     * "  \"recipient_type\": \"individual\",\r\n" +
     * "  \"to\": \"{{recipient_number}}\",\r\n" +
     * "  \"type\": \"template\",\r\n" +
     * "  \"template\": {\r\n" +
     * "    \"name\": \"stayquotation\",\r\n" +
     * "    \"language\": {\r\n" +
     * "      \"code\": \"en\"\r\n" +
     * "    },\r\n" +
     * "    \"components\": [\r\n" +
     * "      {\r\n" +
     * "        \"type\": \"body\",\r\n" +
     * "        \"parameters\": [\r\n" +
     * "          { \"type\": \"text\", \"text\": \"{{recipient_name}}\" },\r\n" +
     * "          { \"type\": \"text\", \"text\": \"{{guest_details}}\" },\r\n" +
     * "          { \"type\": \"text\", \"text\": \"{{room_type}}\" },\r\n" +
     * "          { \"type\": \"text\", \"text\": \"{{no_of_rooms}}\" },\r\n" +
     * "          { \"type\": \"text\", \"text\": \"{{meal_plan}}\" },\r\n" +
     * "          { \"type\": \"text\", \"text\": \"{{check_in}}\" },\r\n" +
     * "          { \"type\": \"text\", \"text\": \"{{check_out}}\" },\r\n" +
     * "          { \"type\": \"text\", \"text\": \"{{nett_price}}\" },\r\n" +
     * "          { \"type\": \"text\", \"text\": \"{{sender_name}}\" },\r\n" +
     * "          { \"type\": \"text\", \"text\": \"{{sender_mobile}}\" },\r\n" +
     * "          { \"type\": \"text\", \"text\": \"{{sender_email}}\" }\r\n" +
     * "        ]\r\n" +
     * "      }\r\n" +
     * "    ]\r\n" +
     * "  }\r\n" +
     * "}";
     * 
     * // Replace placeholders with actual values
     * jsonBody = jsonBody.replace("{{recipient_number}}",
     * messageDetails.getRecipientMobile())
     * .replace("{{recipient_name}}", messageDetails.getRecipientName())
     * .replace("{{guest_details}}", messageDetails.getGuestDetails())
     * .replace("{{room_type}}", messageDetails.getRoomType())
     * .replace("{{no_of_rooms}}", String.valueOf(messageDetails.getNoOfRooms()))
     * .replace("{{meal_plan}}", messageDetails.getMealPlan())
     * .replace("{{check_in}}", messageDetails.getCheckInDate())
     * .replace("{{check_out}}", messageDetails.getCheckOutDate())
     * .replace("{{nett_price}}", String.valueOf(messageDetails.getFinalPrice()))
     * .replace("{{sender_name}}", messageDetails.getQueryOwnerName())
     * .replace("{{sender_mobile}}", messageDetails.getQueryOwnerMobile())
     * .replace("{{sender_email}}", messageDetails.getQueryOwnerEmail());
     * 
     * RequestBody body = RequestBody.create(mediaType, jsonBody);
     * Request request = new Request.Builder()
     * .url(whatsAppApiUrl)
     * .method("POST", body)
     * .addHeader("Content-Type", "application/json")
     * .addHeader("Authorization", "Bearer " + whatsAppApiKey)
     * .build();
     * 
     * Response response = client.newCall(request).execute();
     * System.out.println("Response is " + response.body().string());
     * 
     * } catch (Exception e) {
     * logger.error("Exception caught", e);
     * }
     * }
     */

    /**
     * NOTE: sendGuestQuotationMessage still uses the old Meta/WhatsApp Cloud API
     * format
     * with template placeholders. It has been updated to use
     * getApiUrl()/getApiKey()
     * from the DB-first approach, but the template ID ("yourquotation") is still
     * hardcoded in the JSON body. This method was NOT using the central config
     * template ID in the original code either.
     *
     * CHANGED: Return type changed from void to WhatsAppResult for consistent error
     * handling.
     */
    public WhatsAppResult sendGuestQuotationMessage(WhatsAppMessageDTO messageDetails) {
        try {
            OkHttpClient client = new OkHttpClient().newBuilder().build();

            okhttp3.MediaType mediaType = MediaType.parse("application/json");

            // Updated JSON body with "guestquotation" template and Nett Price
            String jsonBody = "{\r\n" +
                    "  \"messaging_product\": \"whatsapp\",\r\n" +
                    "  \"recipient_type\": \"individual\",\r\n" +
                    "  \"to\": \"{{recipient_number}}\",\r\n" +
                    "  \"type\": \"template\",\r\n" +
                    "  \"template\": {\r\n" +
                    "    \"name\": \"yourquotation\",\r\n" +
                    "    \"language\": {\r\n" +
                    "      \"code\": \"en\"\r\n" +
                    "    },\r\n" +
                    "    \"components\": [\r\n" +
                    "      {\r\n" +
                    "        \"type\": \"body\",\r\n" +
                    "        \"parameters\": [\r\n" +
                    "          {\r\n" +
                    "            \"type\": \"text\",\r\n" +
                    "            \"text\": \"{{recipient_name}}\"\r\n" +
                    "          },\r\n" +
                    "          {\r\n" +
                    "            \"type\": \"text\",\r\n" +
                    "            \"text\": \"{{guest_details}}\"\r\n" +
                    "          },\r\n" +
                    "          {\r\n" +
                    "            \"type\": \"text\",\r\n" +
                    "            \"text\": \"{{room_type}}\"\r\n" +
                    "          },\r\n" +
                    "          {\r\n" +
                    "            \"type\": \"text\",\r\n" +
                    "            \"text\": \"{{meal_plan}}\"\r\n" +
                    "          },\r\n" +
                    "          {\r\n" +
                    "            \"type\": \"text\",\r\n" +
                    "            \"text\": \"{{check_in}}\"\r\n" +
                    "          },\r\n" +
                    "          {\r\n" +
                    "            \"type\": \"text\",\r\n" +
                    "            \"text\": \"{{check_out}}\"\r\n" +
                    "          },\r\n" +
                    "          {\r\n" +
                    "            \"type\": \"text\",\r\n" +
                    "            \"text\": \"{{nett_price}}\"\r\n" +
                    "          },\r\n" +
                    "          {\r\n" +
                    "            \"type\": \"text\",\r\n" +
                    "            \"text\": \"{{sender_name}}\"\r\n" +
                    "          },\r\n" +
                    "          {\r\n" +
                    "            \"type\": \"text\",\r\n" +
                    "            \"text\": \"{{sender_mobile}}\"\r\n" +
                    "          },\r\n" +
                    "          {\r\n" +
                    "            \"type\": \"text\",\r\n" +
                    "            \"text\": \"{{sender_email}}\"\r\n" +
                    "          }\r\n" +
                    "        ]\r\n" +
                    "      }\r\n" +
                    "    ]\r\n" +
                    "  }\r\n" +
                    "}";

            // Replace placeholders with actual values
            jsonBody = jsonBody.replace("{{recipient_number}}", messageDetails.getRecipientMobile())
                    .replace("{{recipient_name}}", messageDetails.getRecipientName())
                    .replace("{{guest_details}}", messageDetails.getGuestDetails())
                    .replace("{{room_type}}", messageDetails.getRoomType())
                    .replace("{{meal_plan}}", messageDetails.getMealPlan())
                    .replace("{{check_in}}", messageDetails.getCheckInDate())
                    .replace("{{check_out}}", messageDetails.getCheckOutDate())
                    .replace("{{nett_price}}", String.valueOf(messageDetails.getFinalPrice())) // New parameter added
                    .replace("{{sender_name}}", messageDetails.getQueryOwnerName())
                    .replace("{{sender_mobile}}", messageDetails.getQueryOwnerMobile())
                    .replace("{{sender_email}}", messageDetails.getQueryOwnerEmail());

            RequestBody body = RequestBody.create(mediaType, jsonBody);
            Request request = new Request.Builder()
                    .url(getApiUrl())
                    .method("POST", body)
                    .addHeader("Content-Type", "application/json")
                    .addHeader("Authorization", "Bearer " + getApiKey())
                    .build();

            Response response = client.newCall(request).execute();
            // CHANGED: Read and check response for errors
            String responseBody = (response.body() != null) ? response.body().string() : "NO RESPONSE";
            logger.debug("Response is " + responseBody);

            // ADDED: Check HTTP status to detect API-level failures
            if (!response.isSuccessful()) {
                return new WhatsAppResult(false,
                        "WhatsApp Guest Quotation delivery failed. API returned HTTP " + response.code()
                                + ". Response: " + responseBody);
            }

            return new WhatsAppResult(true, null);

        } catch (Exception e) {
            logger.error("Exception caught", e);
            // CHANGED: Returning error result instead of silently swallowing the exception
            return new WhatsAppResult(false,
                    "WhatsApp Guest Quotation sending failed due to: " + e.getMessage());
        }
    }

}
