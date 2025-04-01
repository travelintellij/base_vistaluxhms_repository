package com.vistaluxhms.services;

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


}
