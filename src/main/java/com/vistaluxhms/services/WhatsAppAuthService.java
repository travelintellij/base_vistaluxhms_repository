package com.vistaluxhms.services;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;


import java.util.HashMap;
import java.util.Map;

@Service
public class WhatsAppAuthService {

    private static final String AUTH_URL = "https://{{api-adomain-url}}/api/v1.0/authenticate";

    @Value("${wbbox.username}")
    private String username;

    @Value("${wbbox.password}")
    private String password;

    private String accessToken;

    private final RestTemplate restTemplate;

    public WhatsAppAuthService(RestTemplateBuilder restTemplateBuilder) {
        this.restTemplate = restTemplateBuilder.build();
    }

    public String getAccessToken() {
        if (accessToken == null || isTokenExpired()) {
            authenticate();
        }
        return accessToken;
    }

    private void authenticate() {
        Map<String, String> request = new HashMap<>();
        request.put("username", username);
        request.put("password", password);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<Map<String, String>> entity = new HttpEntity<>(request, headers);

        ResponseEntity<Map> response = restTemplate.exchange(AUTH_URL, HttpMethod.POST, entity, Map.class);

        if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
            accessToken = (String) response.getBody().get("access_token");
        }
    }

    private boolean isTokenExpired() {
        // You can implement expiration logic based on "expires_in"
        return false;
    }
}
