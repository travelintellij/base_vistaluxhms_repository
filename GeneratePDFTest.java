import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;
import org.xhtmlrenderer.pdf.ITextRenderer;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.StringWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GeneratePDFTest {
    public static void main(String[] args) {
        try {
            System.out.println("Starting PDF rendering tests...");
            Configuration cfg = new Configuration(Configuration.VERSION_2_3_29);
            cfg.setDirectoryForTemplateLoading(new File("src/main/resources/templates"));
            cfg.setDefaultEncoding("UTF-8");
            cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
            cfg.setLogTemplateExceptions(false);
            cfg.setWrapUncheckedExceptions(true);

            // Read base64 background image if it exists, otherwise use a tiny dummy base64
            String bgImageBase64 = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg==";
            File bgFile = new File("base64_image_15pct.txt");
            if (bgFile.exists()) {
                bgImageBase64 = new String(Files.readAllBytes(bgFile.toPath())).trim();
            } else {
                bgFile = new File("base64_image.txt");
                if (bgFile.exists()) {
                    bgImageBase64 = new String(Files.readAllBytes(bgFile.toPath())).trim();
                }
            }

            // Create common model data
            Map<String, Object> model = new HashMap<>();
            model.put("bgImageBase64", bgImageBase64);
            model.put("contactName", "John Doe");
            model.put("remarks", "Please note that check-in time is 2:00 PM and check-out time is 11:00 AM.\nEarly check-in is subject to availability.");
            model.put("grandTotalSum", 75000.0);
            model.put("discount", 5000.0);
            model.put("finalPrice", 70000.0);
            model.put("serviceAdvisorMobile", "9876543210");

            Map<String, Object> centralConfig = new HashMap<>();
            centralConfig.put("logoPath", "https://winsomeresorts.com/wp-content/uploads/2021/09/winsome-logo.png");
            centralConfig.put("hotelName", "Winsome Resorts & Spa");
            centralConfig.put("quotationTopCover", "Thank you for choosing Winsome Resorts & Spa. We are pleased to offer you the following quotation for your upcoming stay.");
            centralConfig.put("inclusions", "Welcome Drink on Arrival\nBuffet Breakfast & Dinner\nComplimentary Wi-Fi Access\nAccess to Swimming Pool & Gym\nOne Complimentary Nature Walk");
            centralConfig.put("usp", "Voted Top Luxury Resort in the Region\nSurrounded by lush green forests\n5-star dining experience with organic ingredients");
            centralConfig.put("tnc", "Check-in time: 2:00 PM, Check-out time: 11:00 AM.\n100% advance payment required to confirm booking.\nCancellation policies apply.");
            centralConfig.put("bankName", "HDFC Bank");
            centralConfig.put("accountName", "Winsome Resorts Private Limited");
            centralConfig.put("accountNumber", "50200012345678");
            centralConfig.put("ifscCode", "HDFC0000123");
            centralConfig.put("branch", "Ramnagar, Uttarakhand");
            centralConfig.put("hotelAddress", "Choi, Jim Corbett National Park, Ramnagar, Uttarakhand 244715");
            centralConfig.put("centralNumber", "+91-9876543210");
            centralConfig.put("centralizedEmail", "reservations@winsomeresorts.com");
            centralConfig.put("gstNumber", "05AAAAA1111A1Z1");
            centralConfig.put("facebookLink", "https://facebook.com/winsomeresort");
            centralConfig.put("instagramLink", "https://instagram.com/winsomeresort");
            centralConfig.put("linkedinLink", "https://linkedin.com/company/winsomeresort");
            centralConfig.put("xLink", "https://x.com/winsomeresort");
            centralConfig.put("website", "https://winsomeresorts.com");

            model.put("centralConfig", centralConfig);

            // Test 1: LeadFITPDFQuotation.ftl
            {
                System.out.println("Processing LeadFITPDFQuotation.ftl...");
                List<Map<String, Object>> roomDetails = new ArrayList<>();
                Map<String, Object> room1 = new HashMap<>();
                room1.put("roomCategoryName", "Luxury Tiger Den Room");
                room1.put("mealPlanName", "MAPI");
                room1.put("adults", 2);
                room1.put("cwb", 1);
                room1.put("cnb", 1);
                room1.put("extraBed", 1);
                room1.put("formattedCheckInDate", "2026-06-01");
                room1.put("formattedCheckOutDate", "2026-06-04");
                room1.put("totalPrice", 45000.0);
                roomDetails.add(room1);

                Map<String, Object> room2 = new HashMap<>();
                room2.put("roomCategoryName", "Corbett Luxury Cottage");
                room2.put("mealPlanName", "APAI");
                room2.put("adults", 2);
                room2.put("cwb", 0);
                room2.put("cnb", 0);
                room2.put("extraBed", 0);
                room2.put("formattedCheckInDate", "2026-06-01");
                room2.put("formattedCheckOutDate", "2026-06-04");
                room2.put("totalPrice", 30000.0);
                roomDetails.add(room2);

                model.put("roomDetails", roomDetails);

                renderPDF(cfg, "LeadFITPDFQuotation.ftl", model, "test_leadfit.pdf");
            }

            // Test 2: PDFFreeHandQuotation.ftl
            {
                System.out.println("Processing PDFFreeHandQuotation.ftl...");
                List<Map<String, Object>> roomDetails = new ArrayList<>();
                Map<String, Object> room1 = new HashMap<>();
                room1.put("roomCategoryName", "Premium Pool Facing Room");
                room1.put("mealPlanName", "CPAI");
                room1.put("noOfRooms", 2);
                room1.put("adults", 4);
                room1.put("noOfChild", 2);
                room1.put("formattedCheckInDate", "2026-07-10");
                room1.put("formattedCheckOutDate", "2026-07-12");
                room1.put("totalPrice", 40000.0);
                roomDetails.add(room1);

                model.put("roomDetails", roomDetails);

                renderPDF(cfg, "PDFFreeHandQuotation.ftl", model, "test_freehand.pdf");
            }

            // Test 3: PDFQuotation.ftl
            {
                System.out.println("Processing PDFQuotation.ftl...");
                List<Map<String, Object>> roomDetails = new ArrayList<>();
                Map<String, Object> room1 = new HashMap<>();
                room1.put("roomCategoryName", "Luxury Jacuzzi Villa");
                room1.put("mealPlanName", "APAI");
                room1.put("adults", 2);
                room1.put("childWithBed", 1);
                room1.put("childNoBed", 0);
                room1.put("extraBed", 1);
                room1.put("formattedCheckInDate", "2026-08-15");
                room1.put("formattedCheckOutDate", "2026-08-18");
                room1.put("totalPrice", 75000.0);
                roomDetails.add(room1);

                model.put("roomDetails", roomDetails);

                renderPDF(cfg, "PDFQuotation.ftl", model, "test_standard.pdf");
            }

            System.out.println("All PDF rendering tests completed successfully!");

        } catch (Exception e) {
            System.err.println("Error during rendering tests:");
            e.printStackTrace();
            System.exit(1);
        }
    }

    private static void renderPDF(Configuration cfg, String templateName, Map<String, Object> model, String outputPath) throws Exception {
        Template template = cfg.getTemplate(templateName);
        StringWriter writer = new StringWriter();
        template.process(model, writer);
        String htmlContent = writer.toString();

        // Safe replace ampersands like in VlxCommonServicesImpl
        String safeHtmlContent = htmlContent.replaceAll("&(?![a-zA-Z0-9]+;|#[0-9]+;|#x[0-9a-fA-F]+;)", "&amp;");

        ITextRenderer renderer = new ITextRenderer();
        renderer.setDocumentFromString(safeHtmlContent);
        renderer.layout();

        try (OutputStream os = new FileOutputStream(outputPath)) {
            renderer.createPDF(os);
            renderer.finishPDF();
        }
        System.out.println("Successfully generated PDF: " + outputPath);
    }
}
