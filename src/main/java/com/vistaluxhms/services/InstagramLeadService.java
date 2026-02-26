package com.vistaluxhms.services;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.vistaluxhms.entity.ClientEntity;
import com.vistaluxhms.entity.LeadEntity;
import com.vistaluxhms.repository.ClientEntityRepository;
import com.vistaluxhms.repository.LeadEntityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.persistence.*;
import org.springframework.transaction.annotation.Transactional;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class InstagramLeadService {

    @Value("${meta.page.access.token:}")
    private String pageAccessToken;

    @Value("${meta.lead.form.id:}")
    private String leadFormId;

    @Value("${meta.page.id:}")
    private String pageId;

    @Value("${meta.graph.api.version:v19.0}")
    private String apiVersion;

    @Autowired
    private ClientEntityRepository clientRepository;

    @Autowired
    private LeadEntityRepository leadRepository;

    @PersistenceContext
    private EntityManager entityManager;

    @Autowired
    private org.springframework.context.ApplicationContext applicationContext;

    private final ObjectMapper objectMapper = new ObjectMapper();

    private static final String GRAPH_API_BASE = "https://graph.facebook.com/";

    /**
     * Fetches new leads from Meta (Facebook/Instagram) Lead Ads API
     * and creates Client + Lead records in the CRM.
     *
     * @return List of newly imported lead details
     */
    public List<Map<String, String>> fetchAndImportLeads() {
        List<Map<String, String>> importedLeads = new ArrayList<>();

        try {

            // Fetch leads from Meta API
            String apiUrl = GRAPH_API_BASE + apiVersion + "/" + leadFormId
                    + "/leads?access_token=" + pageAccessToken
                    + "&limit=50&fields=id,created_time,field_data,platform";

            String response = makeGetRequest(apiUrl);
            JsonNode rootNode = objectMapper.readTree(response);
            JsonNode dataArray = rootNode.get("data");

            if (dataArray == null || !dataArray.isArray()) {
                System.out.println("[InstagramLeadService] No data array in API response");
                return importedLeads;
            }

            System.out.println("[InstagramLeadService] Found " + dataArray.size() + " leads from Meta API");

            for (JsonNode leadNode : dataArray) {
                String metaLeadId = leadNode.get("id").asText();
                String createdTime = leadNode.has("created_time") ? leadNode.get("created_time").asText() : "";
                String platform = leadNode.has("platform") ? leadNode.get("platform").asText() : "fb";

                // Check if this lead has already been imported
                if (isLeadAlreadyImported(metaLeadId)) {
                    System.out.println("[InstagramLeadService] Lead " + metaLeadId + " already imported, skipping");
                    continue;
                }

                // Parse field data
                Map<String, String> fieldData = parseFieldData(leadNode.get("field_data"));
                fieldData.put("meta_lead_id", metaLeadId);
                fieldData.put("created_time", createdTime);
                fieldData.put("platform", platform);

                try {
                    Map<String, String> result = applicationContext.getBean(InstagramLeadService.class)
                            .processAndImportLead(fieldData);
                    importedLeads.add(result);
                } catch (Exception ex) {
                    System.err.println(
                            "[InstagramLeadService] Error importing lead " + metaLeadId + ": " + ex.getMessage());
                }
            }

            // Handle pagination if there are more leads
            if (rootNode.has("paging") && rootNode.get("paging").has("next")) {
                String nextPageUrl = rootNode.get("paging").get("next").asText();
                importedLeads.addAll(fetchAndImportFromUrl(nextPageUrl));
            }

        } catch (Exception e) {
            System.err.println("[InstagramLeadService] Error fetching leads: " + e.getMessage());
            Map<String, String> errorMap = new HashMap<>();
            errorMap.put("status", "Error");
            errorMap.put("message", e.getMessage());
            importedLeads.add(errorMap);
        }

        return importedLeads;
    }

    /**
     * Process a single lead in its own transaction
     */
    @Transactional
    public Map<String, String> processAndImportLead(Map<String, String> fieldData) {
        String platform = fieldData.getOrDefault("platform", "fb");
        String metaLeadId = fieldData.getOrDefault("meta_lead_id", "");
        String createdTime = fieldData.getOrDefault("created_time", "");
        String sourceName = "ig".equals(platform) ? "Instagram Lead Ad" : "Facebook Lead Ad";

        ClientEntity client = findOrCreateClient(fieldData, sourceName);
        LeadEntity lead = createLead(client, fieldData, sourceName);
        logImportedLead(metaLeadId, lead.getLeadId(), platform, createdTime);

        fieldData.put("crm_lead_id", String.valueOf(lead.getLeadId()));
        fieldData.put("source", sourceName);
        fieldData.put("status", "Imported Successfully");

        System.out.println("[InstagramLeadService] Imported lead: " + fieldData.getOrDefault("full_name", "Unknown")
                + " from " + sourceName + " -> CRM Lead #" + lead.getLeadId());

        return fieldData;
    }

    /**
     * Fetch leads from a specific URL (for pagination)
     */
    private List<Map<String, String>> fetchAndImportFromUrl(String url) {
        List<Map<String, String>> results = new ArrayList<>();
        try {
            String response = makeGetRequest(url);
            JsonNode rootNode = objectMapper.readTree(response);
            JsonNode dataArray = rootNode.get("data");

            if (dataArray != null && dataArray.isArray()) {
                for (JsonNode leadNode : dataArray) {
                    String metaLeadId = leadNode.get("id").asText();
                    if (isLeadAlreadyImported(metaLeadId))
                        continue;

                    Map<String, String> fieldData = parseFieldData(leadNode.get("field_data"));
                    fieldData.put("meta_lead_id", metaLeadId);
                    fieldData.put("platform", leadNode.has("platform") ? leadNode.get("platform").asText() : "fb");
                    fieldData.put("created_time",
                            leadNode.has("created_time") ? leadNode.get("created_time").asText() : "");

                    try {
                        results.add(
                                applicationContext.getBean(InstagramLeadService.class).processAndImportLead(fieldData));
                    } catch (Exception ex) {
                        System.err.println("[InstagramLeadService] Pagination lead error: " + ex.getMessage());
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("[InstagramLeadService] Pagination error: " + e.getMessage());
        }
        return results;
    }

    /**
     * Parse the field_data array from Meta's lead response
     */
    private Map<String, String> parseFieldData(JsonNode fieldDataNode) {
        Map<String, String> fields = new HashMap<>();
        if (fieldDataNode != null && fieldDataNode.isArray()) {
            for (JsonNode field : fieldDataNode) {
                String name = field.get("name").asText();
                JsonNode valuesNode = field.get("values");
                if (valuesNode != null && valuesNode.isArray() && valuesNode.size() > 0) {
                    fields.put(name, valuesNode.get(0).asText());
                }
            }
        }
        return fields;
    }

    /**
     * Find existing client by email or mobile, or create a new one
     */
    private ClientEntity findOrCreateClient(Map<String, String> fieldData, String source) {
        String name = fieldData.getOrDefault("full_name", "Unknown Lead");
        String email = fieldData.getOrDefault("email", "");
        String phone = fieldData.getOrDefault("phone_number", "");

        // Clean phone number — remove +, spaces, country code prefix
        phone = phone.replaceAll("[^0-9]", "");
        if (phone.length() > 10 && phone.startsWith("91")) {
            phone = phone.substring(2); // Remove Indian country code
        }

        Long mobile = null;
        try {
            if (!phone.isEmpty()) {
                mobile = Long.parseLong(phone);
            }
        } catch (NumberFormatException e) {
            System.err.println("[InstagramLeadService] Invalid phone: " + phone);
        }

        // Try to find existing client by email
        ClientEntity client = null;
        if (!email.isEmpty()) {
            List<ClientEntity> byEmail = clientRepository.findAll();
            for (ClientEntity c : byEmail) {
                if (email.equalsIgnoreCase(c.getEmailId())) {
                    client = c;
                    break;
                }
            }
        }

        // Try to find by mobile if not found by email
        if (client == null && mobile != null) {
            List<ClientEntity> all = clientRepository.findAll();
            for (ClientEntity c : all) {
                if (mobile.equals(c.getMobile())) {
                    client = c;
                    break;
                }
            }
        }

        // Create new client if not found
        if (client == null) {
            client = new ClientEntity();
            client.setClientName(name);
            client.setEmailId(email);
            if (mobile != null) {
                client.setMobile(mobile);
            }
            client.setReference(source);
            client.setRemarks("Auto-imported from " + source);
            client.setActive(true);
            client.setB2b(false);
            client.setSalesPartnerFlag(false);
            client = clientRepository.save(client);
            System.out.println(
                    "[InstagramLeadService] Created new client: " + name + " (ID: " + client.getClientId() + ")");
        } else {
            System.out.println("[InstagramLeadService] Found existing client: " + client.getClientName() + " (ID: "
                    + client.getClientId() + ")");
        }

        return client;
    }

    /**
     * Create a new Lead record linked to the client
     */
    private LeadEntity createLead(ClientEntity client, Map<String, String> fieldData, String source) {
        LeadEntity lead = new LeadEntity();
        lead.setClient(client);
        lead.setAdults(1); // Default
        lead.setCwb(0);
        lead.setCnb(0);
        lead.setCompChild(0);
        lead.setLeadStatus(1); // Open
        lead.setLeadOwner(1); // Default admin user
        lead.setQualified(false);
        lead.setFlagged(false);
        lead.setFit(true);
        lead.setGroupEvent(false);
        lead.setMarriage(false);
        lead.setOthers(false);
        lead.setLeadCreationClientInformed(false);

        // Build remarks from all the lead form data
        StringBuilder remarks = new StringBuilder();
        remarks.append("[").append(source).append("]\n");

        if (fieldData.containsKey("what_is_your_traveling_date?")) {
            remarks.append("Travel Date: ").append(fieldData.get("what_is_your_traveling_date?")).append("\n");
            // Try to parse as check-in date
            try {
                String dateStr = fieldData.get("what_is_your_traveling_date?");
                // Try common date formats
                Date parsedDate = tryParseDate(dateStr);
                if (parsedDate != null) {
                    lead.setCheckInDate(parsedDate);
                }
            } catch (Exception e) {
                // Date parsing failed, just keep it in remarks
            }
        }

        if (fieldData.containsKey("what_is_your_departure_city?")) {
            remarks.append("Departure City: ").append(fieldData.get("what_is_your_departure_city?")).append("\n");
        }

        if (fieldData.containsKey("city")) {
            remarks.append("City: ").append(fieldData.get("city")).append("\n");
        }

        if (fieldData.containsKey("inbox_url")) {
            remarks.append("Inbox: ").append(fieldData.get("inbox_url")).append("\n");
        }

        remarks.append("Meta Lead ID: ").append(fieldData.getOrDefault("meta_lead_id", "N/A")).append("\n");
        remarks.append("Platform: ").append(fieldData.getOrDefault("platform", "N/A")).append("\n");
        remarks.append("Submitted: ").append(fieldData.getOrDefault("created_time", "N/A"));

        // Truncate remarks to fit in VARCHAR(255) if needed
        String remarksStr = remarks.toString();
        if (remarksStr.length() > 250) {
            remarksStr = remarksStr.substring(0, 250) + "...";
        }
        lead.setClientRemarks(remarksStr);

        String internalRemarks = "Auto-imported from " + source + " on " + new Date();
        if (internalRemarks.length() > 250) {
            internalRemarks = internalRemarks.substring(0, 250) + "...";
        }
        lead.setInternalRemarks(internalRemarks);

        // Manually set audit fields since @EnableJpaAuditing is not configured
        Date now = new Date();
        lead.setCreatedAt(now);
        lead.setUpdatedAt(now);

        leadRepository.save(lead);
        return lead;
    }

    /**
     * Try to parse a date string in various formats
     */
    private Date tryParseDate(String dateStr) {
        String[] formats = {
                "yyyy-MM-dd", "dd/MM/yyyy", "MM/dd/yyyy",
                "dd-MM-yyyy", "yyyy-MM-dd'T'HH:mm:ssZ",
                "MMMM dd, yyyy", "dd MMMM yyyy"
        };
        for (String format : formats) {
            try {
                return new SimpleDateFormat(format).parse(dateStr);
            } catch (Exception e) {
                // try next format
            }
        }
        return null;
    }

    /**
     * Make an HTTP GET request
     */
    private String makeGetRequest(String urlString) throws Exception {
        URL url = new URL(urlString);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");
        connection.setConnectTimeout(10000);
        connection.setReadTimeout(10000);

        int responseCode = connection.getResponseCode();
        BufferedReader reader;

        if (responseCode == HttpURLConnection.HTTP_OK) {
            reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        } else {
            reader = new BufferedReader(new InputStreamReader(connection.getErrorStream()));
        }

        StringBuilder response = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            response.append(line);
        }
        reader.close();

        if (responseCode != HttpURLConnection.HTTP_OK) {
            throw new RuntimeException("Meta API returned HTTP " + responseCode + ": " + response.toString());
        }

        return response.toString();
    }

    /**
     * Check if a Meta lead ID has already been imported
     */
    private boolean isLeadAlreadyImported(String metaLeadId) {
        try {
            Query query = entityManager.createNativeQuery(
                    "SELECT COUNT(*) FROM social_lead_log WHERE meta_lead_id = ?1");
            query.setParameter(1, metaLeadId);
            Number count = (Number) query.getSingleResult();
            return count.intValue() > 0;
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * Log an imported lead to prevent duplicate imports
     */
    private void logImportedLead(String metaLeadId, Long crmLeadId, String platform, String createdTime) {
        try {
            Query query = entityManager.createNativeQuery(
                    "INSERT INTO social_lead_log (meta_lead_id, crm_lead_id, platform, meta_created_time, imported_at) "
                            +
                            "VALUES (?1, ?2, ?3, ?4, ?5)");
            query.setParameter(1, metaLeadId);
            query.setParameter(2, crmLeadId);
            query.setParameter(3, platform);
            query.setParameter(4, createdTime);
            query.setParameter(5, new java.sql.Timestamp(System.currentTimeMillis()));
            query.executeUpdate();
        } catch (Exception e) {
            System.err.println("[InstagramLeadService] Error logging lead: " + e.getMessage());
        }
    }

    /**
     * Ensure the tracking table exists
     */
    private void ensureTrackingTableExists() {
        try {
            entityManager.createNativeQuery(
                    "CREATE TABLE IF NOT EXISTS social_lead_log (" +
                            "id INT AUTO_INCREMENT PRIMARY KEY, " +
                            "meta_lead_id VARCHAR(100) UNIQUE NOT NULL, " +
                            "crm_lead_id BIGINT, " +
                            "platform VARCHAR(20), " +
                            "meta_created_time VARCHAR(100), " +
                            "imported_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                            ")")
                    .executeUpdate();
        } catch (Exception e) {
            // Table might already exist, that's fine
            System.out.println("[InstagramLeadService] Tracking table check: " + e.getMessage());
        }
    }

    /**
     * Get count of imported leads
     */
    public int getImportedLeadCount() {
        try {
            Query query = entityManager.createNativeQuery("SELECT COUNT(*) FROM social_lead_log");
            return ((Number) query.getSingleResult()).intValue();
        } catch (Exception e) {
            return 0;
        }
    }

    /**
     * Test the API connection
     */
    public Map<String, Object> testConnection() {
        Map<String, Object> result = new HashMap<>();
        try {
            String apiUrl = GRAPH_API_BASE + apiVersion + "/" + leadFormId
                    + "?fields=id,name,status&access_token=" + pageAccessToken;
            String response = makeGetRequest(apiUrl);
            JsonNode node = objectMapper.readTree(response);
            result.put("success", true);
            result.put("formName", node.get("name").asText());
            result.put("formId", node.get("id").asText());
            result.put("formStatus", node.get("status").asText());
            result.put("message", "Connected to Meta API successfully!");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "Connection failed: " + e.getMessage());
        }
        return result;
    }

    /**
     * Automated cron job to fetch and import leads every 15 minutes.
     */
    @org.springframework.scheduling.annotation.Scheduled(cron = "0 0/15 * * * ?")
    public void scheduledLeadSync() {
        System.out.println("[InstagramLeadService] Automating scheduled lead sync at: " + new java.util.Date());
        try {
            List<Map<String, String>> imported = fetchAndImportLeads();
            System.out.println("[InstagramLeadService] Scheduled sync complete. Imported leads: " + imported.size());
        } catch (Exception e) {
            System.err.println("[InstagramLeadService] Scheduled sync failed: " + e.getMessage());
        }
    }
}
