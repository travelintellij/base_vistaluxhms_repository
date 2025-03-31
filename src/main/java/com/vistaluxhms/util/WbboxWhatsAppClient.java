package com.vistaluxhms.util;

import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;
import org.json.JSONObject;

public class WbboxWhatsAppClient {

    private static final String AUTH_URL = "https://cloudapi.wbbox.com/api/v1.0/authenticate";

    private static final String MESSAGE_API_URL = "https://cloudapi.wbbox.com/api/v1.0/send-message";

    private static final String USERNAME = "vistalux";
    private static final String PASSWORD = "Ind@2025";
    private static final String TEMPLATE_ID = "registration"; // WhatsApp-approved template ID

    public static void main(String[] args) {
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
        }
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
