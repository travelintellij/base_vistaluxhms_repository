package com.vistaluxhms.services;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.vistaluxhms.model.WhatsAppMessageDTO;
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

    @Value("${whatsAppApiUrl}")
    private String whatsAppApiUrl;

    @Value("${whatsAppApiKey}")
    private String whatsAppApiKey;

    private static final MediaType JSON = MediaType.parse("application/json");
    private final OkHttpClient client = new OkHttpClient();


    public void sendQueryRegistrationMessage(WhatsAppMessageDTO dto) {
        try {

            String jsonBody =
                    "{\n" +
                            "  \"country_code\": \"91\",\n" +
                            "  \"mobile\": \"" + normalizeMobile(dto.getRecipientMobile()) + "\",\n" +
                            "  \"wid\": \"25455\",\n" +
                            "  \"type\": \"text\",\n" +
                            "  \"bodyValues\": {\n" +
                            "    \"1\": \"" + escape(dto.getRecipientName()) + "\",\n" +
                            "    \"2\": \"" + escape(dto.getQueryId()) + "\",\n" +
                            "    \"3\": \"" + escape(dto.getQueryOwnerName()) + "\",\n" +
                            "    \"4\": \"" + escape(dto.getQueryOwnerMobile()) + "\",\n" +
                            "    \"5\": \"" + escape(dto.getQueryOwnerEmail()) + "\"\n" +
                            "  }\n" +
                            "}";

            log("25455", dto.getRecipientMobile(), jsonBody);
            execute(jsonBody);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void execute(String jsonBody) throws Exception {

        Request request = new Request.Builder()
                .url(whatsAppApiUrl)
                .post(RequestBody.create(JSON, jsonBody))
                .addHeader("Authorization", "Basic " + whatsAppApiKey)
                .addHeader("Content-Type", "application/json")
                .build();

        Response response = client.newCall(request).execute();

        System.out.println("WhatsApp Response: " +
                (response.body() != null ? response.body().string() : "NO RESPONSE"));
    }

    private void log(String wid, String mobile, String payload) {
        System.out.println("=========== WhatsApp API LOG ===========");
        System.out.println("Template ID : " + wid);
        System.out.println("Recipient Mobile : " + mobile);
        System.out.println("API URL : " + whatsAppApiUrl);
        System.out.println("Request Payload : ");
        System.out.println(payload);
        System.out.println("=======================================");
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
        if (mobile == null) return "";
        mobile = mobile.trim();
        if (mobile.startsWith("+91")) mobile = mobile.substring(3);
        if (mobile.startsWith("91") && mobile.length() > 10) mobile = mobile.substring(2);
        return mobile;
    }



    public void sendStayQuotationMessage(WhatsAppMessageDTO dto,String queryDetails) {

        try {
            Map<String, Object> payload = new HashMap<>();
            payload.put("country_code", "91");
            payload.put("mobile", normalizeMobile(dto.getRecipientMobile()));
            payload.put("wid", "27614");
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
            System.out.println("Final Json body is " + jsonBody);
            execute(jsonBody);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        /*
        try {
            String jsonBody =
                    "{\n" +
                            "  \"country_code\": \"91\",\n" +
                            "  \"mobile\": \"" + normalizeMobile(dto.getRecipientMobile()) + "\",\n" +
                            "  \"wid\": \"27185\",\n" +
                            "  \"type\": \"text\",\n" +
                            "  \"bodyValues\": {\n" +
                            "    \"1\": \"" + escape(dto.getRecipientName()) + "\",\n" +
                            "    \"2\": \"" + escape(queryDetails) + "\",\n" +
                            "    \"3\": \"" + dto.getFinalPrice() + "\",\n" +
                            "    \"4\": \"" + escape(dto.getQueryOwnerMobile()) + "\"\n" +
                            "  }\n" +
                            "}";

            log("27185", dto.getRecipientMobile(), jsonBody);
            execute(jsonBody);

        } catch (Exception e) {
            e.printStackTrace();
        }

             */
    }



    /*
    public void sendQueryRegistrationMessage(WhatsAppMessageDTO messageDetails) {
        try {
            OkHttpClient client = new OkHttpClient().newBuilder().build();

            okhttp3.MediaType mediaType = MediaType.parse("application/json");

            // JSON body with placeholders
            String jsonBody = "{\r\n" +
                    "  \"messaging_product\": \"whatsapp\",\r\n" +
                    "  \"recipient_type\": \"individual\",\r\n" +
                    "  \"to\": \"{{recipient_number}}\",\r\n" +
                    "  \"type\": \"template\",\r\n" +
                    "  \"template\": {\r\n" +
                    "    \"name\": \"queryregistration\",\r\n" +
                    "    \"language\": {\r\n" +
                    "      \"code\": \"en\"\r\n" +
                    "    },\r\n" +
                    "    \"components\": [\r\n" +
                    "      {\r\n" +
                    "        \"type\": \"body\",\r\n" +
                    "        \"parameters\": [\r\n" +
                    "          {\r\n" +
                    "            \"type\": \"text\",\r\n" +
                    "            \"text\": \"{{name}}\"\r\n" +
                    "          },\r\n" +
                    "          {\r\n" +
                    "            \"type\": \"text\",\r\n" +
                    "            \"text\": \"{{query_id}}\"\r\n" +
                    "          },\r\n" +
                    "          {\r\n" +
                    "            \"type\": \"text\",\r\n" +
                    "            \"text\": \"{{query_owner}}\"\r\n" +
                    "          },\r\n" +
                    "          {\r\n" +
                    "            \"type\": \"text\",\r\n" +
                    "            \"text\": \"{{mobile}}\"\r\n" +
                    "          },\r\n" +
                    "          {\r\n" +
                    "            \"type\": \"text\",\r\n" +
                    "            \"text\": \"{{email}}\"\r\n" +
                    "          }\r\n" +
                    "        ]\r\n" +
                    "      }\r\n" +
                    "    ]\r\n" +
                    "  }\r\n" +
                    "}";

            // Replace placeholders with actual values
            jsonBody = jsonBody.replace("{{recipient_number}}", messageDetails.getRecipientMobile())
                    .replace("{{name}}", messageDetails.getRecipientName())
                    .replace("{{query_id}}", messageDetails.getQueryId())
                    .replace("{{query_owner}}", messageDetails.getQueryOwnerName())
                    .replace("{{mobile}}", messageDetails.getQueryOwnerMobile())
                    .replace("{{email}}", messageDetails.getQueryOwnerEmail());

            RequestBody body = RequestBody.create(mediaType, jsonBody);

            Request request = new Request.Builder()
                    .url(whatsAppApiUrl)
                    .method("POST", body)
                    .addHeader("Content-Type", "application/json")
                    .addHeader("Authorization", "Bearer " + whatsAppApiKey)
                    .build();

            Response response = client.newCall(request).execute();
            System.out.println("Response is " + response.body().string()); // Print API response

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public void sendStayQuotationMessage(WhatsAppMessageDTO messageDetails) {
        try {
            OkHttpClient client = new OkHttpClient().newBuilder().build();
            MediaType mediaType = MediaType.parse("application/json");

            String jsonBody = "{\r\n" +
                    "  \"messaging_product\": \"whatsapp\",\r\n" +
                    "  \"recipient_type\": \"individual\",\r\n" +
                    "  \"to\": \"{{recipient_number}}\",\r\n" +
                    "  \"type\": \"template\",\r\n" +
                    "  \"template\": {\r\n" +
                    "    \"name\": \"stayquotation\",\r\n" +
                    "    \"language\": {\r\n" +
                    "      \"code\": \"en\"\r\n" +
                    "    },\r\n" +
                    "    \"components\": [\r\n" +
                    "      {\r\n" +
                    "        \"type\": \"body\",\r\n" +
                    "        \"parameters\": [\r\n" +
                    "          { \"type\": \"text\", \"text\": \"{{recipient_name}}\" },\r\n" +
                    "          { \"type\": \"text\", \"text\": \"{{guest_details}}\" },\r\n" +
                    "          { \"type\": \"text\", \"text\": \"{{room_type}}\" },\r\n" +
                    "          { \"type\": \"text\", \"text\": \"{{no_of_rooms}}\" },\r\n" +
                    "          { \"type\": \"text\", \"text\": \"{{meal_plan}}\" },\r\n" +
                    "          { \"type\": \"text\", \"text\": \"{{check_in}}\" },\r\n" +
                    "          { \"type\": \"text\", \"text\": \"{{check_out}}\" },\r\n" +
                    "          { \"type\": \"text\", \"text\": \"{{nett_price}}\" },\r\n" +
                    "          { \"type\": \"text\", \"text\": \"{{sender_name}}\" },\r\n" +
                    "          { \"type\": \"text\", \"text\": \"{{sender_mobile}}\" },\r\n" +
                    "          { \"type\": \"text\", \"text\": \"{{sender_email}}\" }\r\n" +
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
                    .replace("{{no_of_rooms}}", String.valueOf(messageDetails.getNoOfRooms()))
                    .replace("{{meal_plan}}", messageDetails.getMealPlan())
                    .replace("{{check_in}}", messageDetails.getCheckInDate())
                    .replace("{{check_out}}", messageDetails.getCheckOutDate())
                    .replace("{{nett_price}}", String.valueOf(messageDetails.getFinalPrice()))
                    .replace("{{sender_name}}", messageDetails.getQueryOwnerName())
                    .replace("{{sender_mobile}}", messageDetails.getQueryOwnerMobile())
                    .replace("{{sender_email}}", messageDetails.getQueryOwnerEmail());

            RequestBody body = RequestBody.create(mediaType, jsonBody);
            Request request = new Request.Builder()
                    .url(whatsAppApiUrl)
                    .method("POST", body)
                    .addHeader("Content-Type", "application/json")
                    .addHeader("Authorization", "Bearer " + whatsAppApiKey)
                    .build();

            Response response = client.newCall(request).execute();
            System.out.println("Response is " + response.body().string());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
*/



    public void sendGuestQuotationMessage(WhatsAppMessageDTO messageDetails) {
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
                    .replace("{{nett_price}}", String.valueOf(messageDetails.getFinalPrice()))  // New parameter added
                    .replace("{{sender_name}}", messageDetails.getQueryOwnerName())
                    .replace("{{sender_mobile}}", messageDetails.getQueryOwnerMobile())
                    .replace("{{sender_email}}", messageDetails.getQueryOwnerEmail());

            RequestBody body = RequestBody.create(mediaType, jsonBody);
            Request request = new Request.Builder()
                    .url(whatsAppApiUrl)
                    .method("POST", body)
                    .addHeader("Content-Type", "application/json")
                    .addHeader("Authorization", "Bearer " + whatsAppApiKey)
                    .build();

            Response response = client.newCall(request).execute();
            System.out.println("Response is " + response.body().string()); // Print API response

        } catch (Exception e) {
            e.printStackTrace();
        }
    }




}
