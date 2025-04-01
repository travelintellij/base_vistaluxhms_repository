package com.vistaluxhms.util;

import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;

import okhttp3.*;
import org.json.JSONObject;

public class WbboxWhatsAppClient {

    private static final String AUTH_URL = "https://wbbox.in/api/v1.0/authenticate/";

    private static final String MESSAGE_API_URL = "https://cloudapi.wbbox.com/api/v1.0/send-message";

    private static final String USERNAME = "vistalux";
    private static final String PASSWORD = "Ind@2025";
    private static final String TEMPLATE_ID = "registration"; // WhatsApp-approved template ID

    public static void sendQuery(){
        try {
            OkHttpClient client = new OkHttpClient().newBuilder().build();

            MediaType mediaType = MediaType.parse("application/json");

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
            jsonBody = jsonBody.replace("{{recipient_number}}", "919999449267")
                    .replace("{{name}}", "Sushil Chugh")
                    .replace("{{query_id}}", "ATT-2025")
                    .replace("{{query_owner}}", "Kashish")
                    .replace("{{mobile}}", "+918810306997")
                    .replace("{{email}}", "sales@vistaluxhotel.com");

            RequestBody body = RequestBody.create(mediaType, jsonBody);

            // API URL & API Key placeholders
            String apiUrl = "https://cloudapi.wbbox.in/api/v1.0/messages/send-template/919354076156";
            String apiKey = "MvV6mMDct0uQxI2Y55eJzQ";

            Request request = new Request.Builder()
                    .url(apiUrl)
                    .method("POST", body)
                    .addHeader("Content-Type", "application/json")
                    .addHeader("Authorization", "Bearer " + apiKey)
                    .build();

            Response response = client.newCall(request).execute();
            System.out.println("Response is " + response.body().string()); // Print API response

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {

        sendQuery();

        /*
        try {
            OkHttpClient client = new OkHttpClient().newBuilder().build();

            MediaType mediaType = MediaType.parse("application/json");

            // JSON body with placeholders
            String jsonBody = "{\r\n" +
                    "  \"messaging_product\": \"whatsapp\",\r\n" +
                    "  \"recipient_type\": \"individual\",\r\n" +
                    "  \"to\": \"{{recipient_number}}\",\r\n" +
                    "  \"type\": \"template\",\r\n" +
                    "  \"template\": {\r\n" +
                    "    \"name\": \"{{template_name}}\",\r\n" +
                    "    \"language\": {\r\n" +
                    "      \"code\": \"en\"\r\n" +
                    "    },\r\n" +
                    "    \"components\": [\r\n" +
                    "      {\r\n" +
                    "        \"type\": \"body\",\r\n" +
                    "        \"parameters\": [\r\n" +
                    "          {\r\n" +
                    "            \"type\": \"text\",\r\n" +
                    "            \"text\": \"{{placeholder_value}}\"\r\n" +
                    "          }\r\n" +
                    "        ]\r\n" +
                    "      },\r\n" +
                    "      {\r\n" +
                    "        \"type\": \"button\",\r\n" +
                    "        \"parameters\": [\r\n" +
                    "          {\r\n" +
                    "            \"type\": \"text\",\r\n" +
                    "            \"text\": \"{{placeholder_value}}\"\r\n" +
                    "          }\r\n" +
                    "        ],\r\n" +
                    "        \"sub_type\": \"url\",\r\n" +
                    "        \"index\": \"0\"\r\n" +
                    "      }\r\n" +
                    "    ]\r\n" +
                    "  }\r\n" +
                    "}";

            // Replace placeholders with actual values
            jsonBody = jsonBody.replace("{{recipient_number}}", "919310010096") // Replace with recipient's phone number
                    .replace("{{template_name}}", "verificationcode") // Replace with template name
                    .replace("{{placeholder_value}}", "123"); // Replace with dynamic value

            RequestBody body = RequestBody.create(mediaType, jsonBody);

            // API URL & API Key placeholders
            String apiUrl = "https://cloudapi.wbbox.in/api/v1.0/messages/send-template/919354076156";
            String apiKey = "MvV6mMDct0uQxI2Y55eJzQ";

            Request request = new Request.Builder()
                    .url(apiUrl)
                    .method("POST", body)
                    .addHeader("Content-Type", "application/json")
                    .addHeader("Authorization", "Bearer " + apiKey)
                    .build();

            Response response = client.newCall(request).execute();
            System.out.println("Response is " + response.body().string()); // Print API response

        } catch (Exception e) {
            e.printStackTrace();
        }


       /*
        try {
            // Step 1: Authenticate and get the access token
            String accessToken = getAccessToken();
            System.out.println("Token is received Successfully!! " + accessToken);

            if (accessToken == null) {
                System.out.println("Failed to get access token.");
                return;
            }

            // Step 2: Send WhatsApp Template Message
            sendTemplateMessage(accessToken, "+919999449267", "Sushil", "Your booking is confirmed!");

        } catch (Exception e) {
            e.printStackTrace();
        }*/
    }

    public static String getAccessToken() {
        try {
            // Create JSON request payload
            JSONObject requestBody = new JSONObject();
            requestBody.put("username", USERNAME);
            requestBody.put("password", PASSWORD);

            // Open connection
            URL url = new URL(AUTH_URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            // Send request
            OutputStream os = conn.getOutputStream();
            os.write(requestBody.toString().getBytes());
            os.flush();
            os.close();

            // Read response
            Scanner sc = new Scanner(conn.getInputStream());
            StringBuilder response = new StringBuilder();
            while (sc.hasNext()) {
                response.append(sc.nextLine());
            }
            sc.close();

            // Parse JSON response
            JSONObject jsonResponse = new JSONObject(response.toString());
            return jsonResponse.getString("access_token");

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void sendTemplateMessage(String accessToken, String phoneNumber, String customerName, String bookingMessage) {
        try {
            // Create JSON request payload using template
            JSONObject requestBody = new JSONObject();
            requestBody.put("to", phoneNumber);
            requestBody.put("template_id", TEMPLATE_ID); // Use pre-approved template ID

            // Variables for dynamic placeholders in the template
            JSONObject templateData = new JSONObject();
            templateData.put("customer_name", customerName);
            templateData.put("booking_message", bookingMessage);

            requestBody.put("parameters", templateData);

            // Open connection
            URL url = new URL(MESSAGE_API_URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);
            conn.setDoOutput(true);

            // Send request
            OutputStream os = conn.getOutputStream();
            os.write(requestBody.toString().getBytes());
            os.flush();
            os.close();

            // Read response
            Scanner sc = new Scanner(conn.getInputStream());
            StringBuilder response = new StringBuilder();
            while (sc.hasNext()) {
                response.append(sc.nextLine());
            }
            sc.close();

            // Print API response
            System.out.println("✅ Message Sent! API Response: " + response.toString());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
