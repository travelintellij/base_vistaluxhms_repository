package com.vistaluxhms.services;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.vistaluxhms.entity.ClientEntity;
import com.vistaluxhms.entity.LeadEntity;
import com.vistaluxhms.entity.SalesPartnerEntity;
import com.vistaluxhms.repository.ClientEntityRepository;
import com.vistaluxhms.repository.LeadEntityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.persistence.*;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Service for handling Meta (Facebook/Instagram) Lead Ads synchronization.
 * 
 * Logic Added:
 * 1. Automated Lead Fetching: Connects to Meta Graph API using Page Access
 * Token.
 * 2. Client Conversion: Every synced lead is automatically converted into a
 * ClientEntity.
 * 3. Default Sales Partner: Assigns "Digital Marketing" as the default sales
 * partner.
 * 4. Default Dates: Sets default Check-In (tomorrow) and Check-Out (+7 days)
 * since Meta forms lack travel dates.
 * 5. Deduplication: Tracks imported Meta Lead IDs in 'social_lead_log' table.
 */
@Service
public class SocialMediaLeadService {


    private static final Logger logger = LoggerFactory.getLogger(SocialMediaLeadService.class);
    @Autowired
    private ClientEntityRepository clientRepository;

    @Autowired
    private LeadEntityRepository leadRepository;

    @PersistenceContext
    private EntityManager entityManager;

    @Autowired
    private com.vistaluxhms.repository.CentralConfigEntityRepository centralConfigRepository;

    @Autowired
    private org.springframework.context.ApplicationContext applicationContext;

    private final ObjectMapper objectMapper = new ObjectMapper();

    private static final String GRAPH_API_BASE = "https://graph.facebook.com/";

    @Autowired
    private com.vistaluxhms.repository.CampaignFormRepository campaignFormRepository;

    @Autowired
    private com.vistaluxhms.repository.SalesPartnerEntityRepository salesPartnerRepository;

    @Autowired
    private EmailServiceImpl emailService;

    @Autowired
    private com.vistaluxhms.repository.UserRepository userRepository;

    @Autowired
    private SettingsAndOtherServicesImpl settingsService;

    /**
     * Fetches new leads from Meta (Facebook/Instagram) Lead Ads API
     * and creates Client + Lead records in the CRM.
     *
     * @return List of newly imported lead details
     */
    public List<Map<String, String>> fetchAndImportLeads(Long campaignFormId) {
        List<Map<String, String>> importedLeads = new ArrayList<>();

        try {
            // Table must be created manually before syncing leads.

            com.vistaluxhms.entity.CampaignFormEntity formConfig = campaignFormRepository.findById(campaignFormId)
                    .orElse(null);
            if (formConfig == null) {
                Map<String, String> errorMap = new HashMap<>();
                errorMap.put("status", "Error");
                errorMap.put("message", "Campaign Form not found with ID: " + campaignFormId);
                importedLeads.add(errorMap);
                return importedLeads;
            }

            com.vistaluxhms.entity.CentralConfigEntity centralConfig = centralConfigRepository.findTopByOrderByIdAsc();
            String activeFormId = formConfig.getFormId();

            if (centralConfig == null || centralConfig.getMetaPageAccessToken() == null
                    || centralConfig.getMetaPageAccessToken().isEmpty()) {
                throw new RuntimeException("Meta Page Access Token is not configured. Please set it in Settings.");
            }
            String activeAccessToken = centralConfig.getMetaPageAccessToken();

            String activeApiVersion = (centralConfig.getMetaGraphApiVersion() != null
                    && !centralConfig.getMetaGraphApiVersion().isEmpty())
                            ? centralConfig.getMetaGraphApiVersion()
                            : "v19.0";

            // Fetch leads from Meta API
            String apiUrl = GRAPH_API_BASE + activeApiVersion + "/" + activeFormId
                    + "/leads?access_token=" + activeAccessToken
                    + "&limit=50&fields=id,created_time,field_data,platform";

            String response = makeGetRequest(apiUrl);
            JsonNode rootNode = objectMapper.readTree(response);
            JsonNode dataArray = rootNode.get("data");

            if (dataArray == null || !dataArray.isArray()) {
                logger.debug("[SocialMediaLeadService] No data array in API response");
                return importedLeads;
            }

            System.out.println("[SocialMediaLeadService] Found " + dataArray.size() + " leads from Meta API");

            for (JsonNode leadNode : dataArray) {
                String metaLeadId = leadNode.get("id").asText();
                String createdTime = leadNode.has("created_time") ? leadNode.get("created_time").asText() : "";
                String platform = leadNode.has("platform") ? leadNode.get("platform").asText() : "fb";

                // Check if this lead has already been imported
                if (isLeadAlreadyImported(metaLeadId)) {
                    logger.debug("[SocialMediaLeadService] Lead " + metaLeadId + " already imported, skipping");
                    continue;
                }

                // Parse field data
                Map<String, String> fieldData = parseFieldData(leadNode.get("field_data"));
                fieldData.put("meta_lead_id", metaLeadId);
                fieldData.put("created_time", createdTime);
                fieldData.put("platform", platform);

                try {
                    Map<String, String> result = applicationContext.getBean(SocialMediaLeadService.class)
                            .processAndImportLead(fieldData);
                    importedLeads.add(result);

                    // Send notification ONLY after transaction has committed successfully.
                    // This prevents emails being sent for leads that get rolled back.
                    notifyLeadOwnerFromFieldData(result);
                } catch (Exception ex) {
                    logger.error("Error importing lead " + metaLeadId, ex);
                    Map<String, String> errorMap = new HashMap<>();
                    errorMap.put("status", "Error");
                    errorMap.put("message", "Failed to import lead " + metaLeadId + ": " + ex.getMessage());
                    importedLeads.add(errorMap);
                }
            }

            // Handle pagination if there are more leads
            if (rootNode.has("paging") && rootNode.get("paging").has("next")) {
                String nextPageUrl = rootNode.get("paging").get("next").asText();
                importedLeads.addAll(fetchAndImportFromUrl(nextPageUrl));
            }

        } catch (Exception e) {
            System.err.println("[SocialMediaLeadService] Error fetching leads: " + e.getMessage());
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
        // Log in a separate transaction so a logging failure can't roll back the lead import
        applicationContext.getBean(SocialMediaLeadService.class)
                .logImportedLead(metaLeadId, lead.getLeadId(), platform, createdTime);

        fieldData.put("crm_lead_id", String.valueOf(lead.getLeadId()));
        fieldData.put("source", sourceName);
        fieldData.put("status", "Imported Successfully");
        fieldData.put("client_name", client.getClientName() != null ? client.getClientName() : "Unknown");
        fieldData.put("client_email", client.getEmailId() != null ? client.getEmailId() : "");
        fieldData.put("client_mobile", client.getMobile() != null ? String.valueOf(client.getMobile()) : "");

        System.out.println("[SocialMediaLeadService] Imported lead: " + fieldData.getOrDefault("full_name", "Unknown")
                + " from " + sourceName + " -> CRM Lead #" + lead.getLeadId());

        // NOTE: Email notification is now sent AFTER the transaction commits
        // (from fetchAndImportLeads) to prevent sending emails for rolled-back leads

        return fieldData;
    }

    /**
     * Notify the default lead owner (admin) via email when a new lead is imported.
     * For now, the default lead owner is always "admin".
     * This will be enhanced later to support round-robin or rule-based assignment.
     */
    private void notifyLeadOwner(LeadEntity lead, ClientEntity client, String source) {
        try {
            // Get the default lead owner ID from Central Config
            int leadOwnerId = lead.getLeadOwner(); // This was already set from config in createLead
            com.vistaluxhms.entity.AshokaTeam ownerUser = userRepository.findById(leadOwnerId).orElse(null);

            if (ownerUser == null) {
                System.out.println("[SocialMediaLeadService] Lead owner (ID: " + leadOwnerId
                        + ") not found. Skipping notification.");
                return;
            }

            String ownerEmail = ownerUser.getEmail();

            if (ownerEmail == null || ownerEmail.trim().isEmpty()) {
                logger.debug("[SocialMediaLeadService] Lead owner has no email. Skipping notification.");
                return;
            }

            String clientName = client.getClientName() != null ? client.getClientName() : "Unknown";
            String leadId = "ATT-" + lead.getLeadId();
            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd-MMM-yyyy HH:mm");

            String subject = "New Lead Assigned: " + clientName + " [" + leadId + "]";
            String body = "Hello " + ownerUser.getName() + ",\n\n"
                    + "A new lead has been automatically imported and assigned to you.\n\n"
                    + "Lead Details:\n"
                    + "-------------------------------\n"
                    + "Lead ID       : " + leadId + "\n"
                    + "Client Name   : " + clientName + "\n"
                    + "Client Mobile : " + (client.getMobile() != null ? client.getMobile() : "N/A") + "\n"
                    + "Client Email  : " + (client.getEmailId() != null ? client.getEmailId() : "N/A") + "\n"
                    + "Source        : " + source + "\n"
                    + "Imported At   : " + sdf.format(new java.util.Date()) + "\n"
                    + "-------------------------------\n\n"
                    + "Please log in to the CRM and take action on this lead.\n\n"
                    + "Regards,\nAxisHMS Pro - CRM System";

            emailService.sendMail(ownerEmail, subject, body);
            System.out.println("[SocialMediaLeadService] Lead owner notification sent to: " + ownerEmail + " for Lead #"
                    + lead.getLeadId());

        } catch (Exception e) {
            // Never let email failure break the lead sync process
            System.out.println("[SocialMediaLeadService] Failed to send lead owner notification: " + e.getMessage());
            logger.error("Exception caught", e);
        }
    }

    /**
     * Send lead owner notification using data from the import result map.
     * Called AFTER the transaction has committed to ensure we don't send
     * emails for leads that got rolled back.
     */
    private void notifyLeadOwnerFromFieldData(Map<String, String> fieldData) {
        try {
            String crmLeadIdStr = fieldData.get("crm_lead_id");
            if (crmLeadIdStr == null) return;

            Long crmLeadId = Long.parseLong(crmLeadIdStr);
            LeadEntity lead = leadRepository.findById(crmLeadId).orElse(null);
            if (lead == null) {
                logger.warn("Cannot notify: Lead #{} not found after import", crmLeadId);
                return;
            }

            ClientEntity client = lead.getClient();
            String source = fieldData.getOrDefault("source", "Social Media Lead Ad");

            notifyLeadOwner(lead, client, source);
        } catch (Exception e) {
            // Never let notification failure affect the import result
            logger.error("Post-import notification failed", e);
        }
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
                        Map<String, String> result = applicationContext.getBean(SocialMediaLeadService.class)
                                .processAndImportLead(fieldData);
                        results.add(result);
                        notifyLeadOwnerFromFieldData(result);
                    } catch (Exception ex) {
                        logger.error("Pagination lead error for " + metaLeadId, ex);
                        Map<String, String> errorMap = new HashMap<>();
                        errorMap.put("status", "Error");
                        errorMap.put("message", "Failed to import lead: " + ex.getMessage());
                        results.add(errorMap);
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("[SocialMediaLeadService] Pagination error: " + e.getMessage());
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
            System.err.println("[SocialMediaLeadService] Invalid phone: " + phone);
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

            // Assign Default Sales Partner: "Digital Marketing"
            client.setSalesPartner(getOrCreateDefaultSalesPartner());

            client = clientRepository.save(client);
            System.out.println(
                    "[SocialMediaLeadService] Created new client: " + name + " (ID: " + client.getClientId() + ")");
        } else {
            // Even if existing client, ensure sales partner is set for this source if not
            // already
            if (client.getSalesPartner() == null) {
                client.setSalesPartner(getOrCreateDefaultSalesPartner());
                client = clientRepository.save(client);
            }
            System.out.println("[SocialMediaLeadService] Found existing client: " + client.getClientName() + " (ID: "
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
        lead.setLeadStatus(101); // Open (workload_status ID 101)

        // Use default lead owner from Central Config, fallback to 1 (admin)
        int defaultOwnerId = 1;
        try {
            com.vistaluxhms.model.CentralConfigEntityDTO config = settingsService.getCentralConfig();
            if (config != null && config.getDefaultLeadOwnerId() != null) {
                defaultOwnerId = config.getDefaultLeadOwnerId();
            }
        } catch (Exception e) {
            System.out
                    .println("[SocialMediaLeadService] Could not read default lead owner from config, using admin (1)");
        }
        lead.setLeadOwner(defaultOwnerId);
        lead.setQualified(false);
        lead.setFlagged(false);
        lead.setFit(true);
        lead.setGroupEvent(false);
        lead.setMarriage(false);
        lead.setOthers(false);
        lead.setLeadCreationClientInformed(false);

        // Set Default Check-In and Check-Out Dates
        // Default: Check-in = Tomorrow, Check-out = Tomorrow + 7 days
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_YEAR, 1);
        Date defaultCheckIn = cal.getTime();
        cal.add(Calendar.DAY_OF_YEAR, 7);
        Date defaultCheckOut = cal.getTime();

        lead.setCheckInDate(defaultCheckIn);
        lead.setCheckOutDate(defaultCheckOut);

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
     * Get or Create the default Sales Partner "Digital Marketing"
     */
    private SalesPartnerEntity getOrCreateDefaultSalesPartner() {
        return salesPartnerRepository.findBySalesPartnerName("Digital Marketing")
                .orElseGet(() -> {
                    SalesPartnerEntity sp = new SalesPartnerEntity();
                    sp.setSalesPartnerName("Digital Marketing");
                    sp.setSalesPartnerShortName("DIGITAL");
                    sp.setActive(true);
                    sp.setDescription("Default partner for Social Media Leads");
                    sp.setReference("System Generated");
                    return salesPartnerRepository.save(sp);
                });
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
     * Log an imported lead to prevent duplicate imports.
     * Runs in its own transaction (REQUIRES_NEW) so that a logging failure
     * cannot roll back the main lead import transaction.
     */
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void logImportedLead(String metaLeadId, Long crmLeadId, String platform, String createdTime) {
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
            System.err.println("[SocialMediaLeadService] Error logging lead: " + e.getMessage());
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
            com.vistaluxhms.entity.CentralConfigEntity centralConfig = centralConfigRepository.findTopByOrderByIdAsc();

            if (centralConfig == null || centralConfig.getMetaPageAccessToken() == null
                    || centralConfig.getMetaPageAccessToken().isEmpty()) {
                throw new RuntimeException("Meta Page Access Token is not configured. Please set it in Settings.");
            }
            if (centralConfig.getMetaLeadFormId() == null || centralConfig.getMetaLeadFormId().trim().isEmpty()) {
                throw new RuntimeException("Meta Lead Form ID is not configured. Please set it in Settings.");
            }

            String token = centralConfig.getMetaPageAccessToken();
            String formId = centralConfig.getMetaLeadFormId();
            String version = (centralConfig.getMetaGraphApiVersion() != null
                    && !centralConfig.getMetaGraphApiVersion().isEmpty()) ? centralConfig.getMetaGraphApiVersion()
                            : "v19.0";

            String apiUrl = GRAPH_API_BASE + version + "/" + formId
                    + "?fields=id,name,status&access_token=" + token;
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

}
