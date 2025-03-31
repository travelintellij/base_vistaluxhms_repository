package com.vistaluxhms.services;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

public class WhatsAppMessagingService {

    private static final String MESSAGE_API_URL = "https://{{api-adomain-url}}/api/v1.0/send-message";

    private final WhatsAppAuthService authService;
    private final RestTemplate restTemplate;

    public WhatsAppMessagingService(WhatsAppAuthService authService, RestTemplate restTemplate) {
        this.authService = authService;
        this.restTemplate = restTemplate;
    }

    public void sendWhatsAppMessage(String phoneNumber, String message) {
        String accessToken = authService.getAccessToken();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setBearerAuth(accessToken);

        Map<String, String> body = new HashMap<>();
        body.put("to", phoneNumber);
        body.put("message", message);

        HttpEntity<Map<String, String>> entity = new HttpEntity<>(body, headers);
        restTemplate.exchange(MESSAGE_API_URL, HttpMethod.POST, entity, String.class);
    }
}
