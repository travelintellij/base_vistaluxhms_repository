package com.vistaluxhms.controller;

import com.vistaluxhms.services.SocialMediaLeadService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Controller for managing Social Media (Facebook/Instagram) Lead Ads
 * operations.
 * 
 * Logic Added:
 * 1. sync_instagram_leads: Initiates the fetch/import process for a specific
 * campaign form.
 * 2. test_instagram_connection: Verifies if the Meta Token and Form ID are
 * correctly configured.
 */
@Controller
public class SocialLeadController {

    @Autowired
    private SocialMediaLeadService socialMediaLeadService;

    /**
     * Sync leads from Social Media Lead Ads (Facebook/Instagram)
     * Returns JSON with the import results
     */
    @GetMapping("/sync_social_leads")
    @ResponseBody
    public Map<String, Object> syncSocialLeads(
            @org.springframework.web.bind.annotation.RequestParam("campaignFormId") Long campaignFormId) {
        Map<String, Object> response = new HashMap<>();
        try {
            List<Map<String, String>> importedLeads = socialMediaLeadService.fetchAndImportLeads(campaignFormId);

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
            response.put("totalImported", socialMediaLeadService.getImportedLeadCount());
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
    @GetMapping("/test_social_connection")
    @ResponseBody
    public Map<String, Object> testConnection() {
        return socialMediaLeadService.testConnection();
    }
}
