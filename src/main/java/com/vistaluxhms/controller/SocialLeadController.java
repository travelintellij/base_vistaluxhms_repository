package com.vistaluxhms.controller;

import com.vistaluxhms.services.InstagramLeadService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class SocialLeadController {

    @Autowired
    private InstagramLeadService instagramLeadService;

    /**
     * Sync leads from Social Media Lead Ads (Facebook/Instagram)
     * Returns JSON with the import results
     */
    @GetMapping("/sync_instagram_leads")
    @ResponseBody
    public Map<String, Object> syncInstagramLeads() {
        Map<String, Object> response = new HashMap<>();
        try {
            List<Map<String, String>> importedLeads = instagramLeadService.fetchAndImportLeads();

            int newLeads = 0;
            int errors = 0;
            for (Map<String, String> lead : importedLeads) {
                if ("Imported Successfully".equals(lead.get("status"))) {
                    newLeads++;
                } else if ("Error".equals(lead.get("status"))) {
                    errors++;
                }
            }

            response.put("success", true);
            response.put("newLeadsImported", newLeads);
            response.put("errors", errors);
            response.put("totalImported", instagramLeadService.getImportedLeadCount());
            response.put("leads", importedLeads);
            response.put("message", newLeads > 0
                    ? newLeads + " new lead(s) imported successfully!"
                    : "No new leads to import. All leads are already synced.");

        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error syncing leads: " + e.getMessage());
            e.printStackTrace();
        }
        return response;
    }

    /**
     * Test the Meta API connection
     */
    @GetMapping("/test_instagram_connection")
    @ResponseBody
    public Map<String, Object> testConnection() {
        return instagramLeadService.testConnection();
    }
}
