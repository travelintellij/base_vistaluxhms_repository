"""
Generate a professionally formatted Excel (.xlsx) file for Add Client Test Cases.
Also regenerates the CSV for completeness.
"""
import csv
import os
import sys

# Use the venv's openpyxl
sys.path.insert(0, "/tmp/testcase_venv/lib/python3.13/site-packages")

from openpyxl import Workbook
from openpyxl.styles import Font, PatternFill, Alignment, Border, Side
from openpyxl.utils import get_column_letter

OUTPUT_DIR = os.path.dirname(os.path.abspath(__file__))
XLSX_FILE = os.path.join(OUTPUT_DIR, "Add_Client_Test_Cases.xlsx")
CSV_FILE = os.path.join(OUTPUT_DIR, "Add_Client_Test_Cases.csv")

# ─── Column definitions ─────────────────────────────────────────────────
HEADERS = [
    "TC ID",
    "Category",
    "Priority",
    "Test Case Title",
    "Pre-Conditions",
    "Test Steps",
    "Test Data",
    "Expected Result",
    "Type\n(Manual / Automation)",
    "Status",
    "Remarks / Defect ID",
]

# Column widths (approximate character widths)
COL_WIDTHS = [12, 28, 10, 50, 40, 55, 45, 60, 18, 12, 22]

# ─── Styles ──────────────────────────────────────────────────────────────
TITLE_FONT = Font(name="Calibri", bold=True, size=16, color="FFFFFF")
TITLE_FILL = PatternFill(start_color="1F4E79", end_color="1F4E79", fill_type="solid")

HEADER_FONT = Font(name="Calibri", bold=True, size=11, color="FFFFFF")
HEADER_FILL = PatternFill(start_color="2E75B6", end_color="2E75B6", fill_type="solid")

CATEGORY_FONT = Font(name="Calibri", bold=True, size=11, color="1F4E79")
CATEGORY_FILL = PatternFill(start_color="D6E4F0", end_color="D6E4F0", fill_type="solid")

DATA_FONT = Font(name="Calibri", size=10)
DATA_ALIGNMENT = Alignment(wrap_text=True, vertical="top")

PRIORITY_FILLS = {
    "Critical": PatternFill(start_color="FF4444", end_color="FF4444", fill_type="solid"),
    "High":     PatternFill(start_color="FFA726", end_color="FFA726", fill_type="solid"),
    "Medium":   PatternFill(start_color="FFD54F", end_color="FFD54F", fill_type="solid"),
    "Low":      PatternFill(start_color="81C784", end_color="81C784", fill_type="solid"),
}
PRIORITY_FONTS = {
    "Critical": Font(name="Calibri", bold=True, size=10, color="FFFFFF"),
    "High":     Font(name="Calibri", bold=True, size=10, color="FFFFFF"),
    "Medium":   Font(name="Calibri", bold=True, size=10, color="000000"),
    "Low":      Font(name="Calibri", bold=True, size=10, color="FFFFFF"),
}

THIN_BORDER = Border(
    left=Side(style="thin", color="B0B0B0"),
    right=Side(style="thin", color="B0B0B0"),
    top=Side(style="thin", color="B0B0B0"),
    bottom=Side(style="thin", color="B0B0B0"),
)

EVEN_ROW_FILL = PatternFill(start_color="F2F7FB", end_color="F2F7FB", fill_type="solid")

# ─── Test Case Data ──────────────────────────────────────────────────────
TEST_CASES = [
    # ── 1. PAGE LOAD & NAVIGATION ──
    ["TC_AC_001", "Page Load & Navigation", "High",
     "Verify Add Client page loads successfully",
     "User is logged in with ADMIN or CLIENT_MANAGE role",
     "1. Click 'Client Management' menu\n2. Click 'Add Client' sub-menu",
     "URL: /ashokacrm/view_add_client_form",
     "Add Client page loads with all form fields visible: Client Id (Auto Generated), Client Source, Client Name, Client Type (B2B/B2C), Email Id, Mobile, City, Active, Reference, Remarks. 'Add Client' and 'View Client List' buttons are visible.",
     "Both", "", ""],
    ["TC_AC_002", "Page Load & Navigation", "High",
     "Verify Client Id shows 'Auto Generated' label",
     "Add Client page is open",
     "1. Observe the 'Client Id' field",
     "N/A",
     "Client Id field displays the text 'Auto Generated' in blue font. No input field is shown for Client Id.",
     "Both", "", ""],
    ["TC_AC_003", "Page Load & Navigation", "High",
     "Verify Sales Partner dropdown is loaded with active partners",
     "Add Client page is open. Sales partners exist in the database.",
     "1. Click the 'Client Source (Sales Partner)' dropdown",
     "N/A",
     "Dropdown shows '-- Please Select --' as default + all active sales partners from the DB.",
     "Both", "", ""],
    ["TC_AC_004", "Page Load & Navigation", "Medium",
     "Verify Active dropdown defaults to 'Active'",
     "Add Client page is open",
     "1. Observe the 'Active' dropdown",
     "N/A",
     "Active dropdown shows 'Active' (value=true) selected by default.",
     "Both", "", ""],
    ["TC_AC_005", "Page Load & Navigation", "Medium",
     "Verify default state of Client Type radio buttons",
     "Add Client page is open",
     "1. Observe Client Type radio buttons (B2B, B2C)",
     "N/A",
     "Neither B2B nor B2C is pre-selected.",
     "Both", "", ""],

    # ── 2. HAPPY PATH ──
    ["TC_AC_006", "Happy Path", "Critical",
     "Add Client with all mandatory fields filled (B2B, Active)",
     "User logged in with ADMIN role. At least one active Sales Partner and City 'Delhi' exist in DB.",
     "1. Select a Sales Partner\n2. Enter Client Name\n3. Select 'B2B'\n4. Enter valid Email\n5. Enter valid 10-digit Mobile\n6. Type city name, select from autocomplete\n7. Keep Active = 'Active'\n8. Click 'Add Client'",
     "Sales Partner: first available | Client Name: 'Test Hotel Pvt Ltd' | Email: test@hotel.com | Mobile: 9876543210 | City: Delhi | B2B: true | Active: Active",
     "Client is saved. User is redirected to Client List page. Flash message 'Client record is updated successfully.' is shown. New client appears in the list.",
     "Both", "", ""],
    ["TC_AC_007", "Happy Path", "Critical",
     "Add Client with all mandatory fields filled (B2C, Active)",
     "Same as TC_AC_006",
     "Same steps as TC_AC_006 but select 'B2C' instead of 'B2B'",
     "Sales Partner: first available | Client Name: 'Rahul Sharma' | Email: rahul@mail.com | Mobile: 9123456789 | City: Noida | B2C: true | Active: Active",
     "Client is saved with b2b=false. User is redirected to Client List page.",
     "Both", "", ""],
    ["TC_AC_008", "Happy Path", "High",
     "Add Client with all fields including optional (Reference, Remarks)",
     "Same as TC_AC_006",
     "1. Fill all mandatory fields\n2. Enter Reference\n3. Enter Remarks\n4. Click 'Add Client'",
     "Reference: 'Google Ads' | Remarks: 'VIP client needs special attention'",
     "Client is saved with Reference and Remarks properly stored in the DB.",
     "Both", "", ""],
    ["TC_AC_009", "Happy Path", "High",
     "Add Client with Active status set to 'In-Active'",
     "Same as TC_AC_006",
     "1. Fill all mandatory fields\n2. Set Active = 'In-Active'\n3. Click 'Add Client'",
     "Active: In-Active (false)",
     "Client is saved with active=false in the database.",
     "Both", "", ""],

    # ── 3. MANDATORY FIELD VALIDATION ──
    ["TC_AC_010", "Mandatory Field Validation", "Critical",
     "Submit form without selecting Sales Partner",
     "Add Client page is open",
     "1. Leave Sales Partner as '-- Please Select --'\n2. Fill all other mandatory fields\n3. Click 'Add Client'",
     "Sales Partner: (not selected)",
     "Form submission is blocked. Browser shows HTML5 validation error 'Please select an item in the list' on the Sales Partner dropdown.",
     "Both", "", ""],
    ["TC_AC_011", "Mandatory Field Validation", "Critical",
     "Submit form without entering Client Name",
     "Add Client page is open",
     "1. Leave Client Name blank\n2. Fill all other mandatory fields\n3. Click 'Add Client'",
     "Client Name: (empty)",
     "Form submission is blocked. Browser HTML5 validation error 'Please fill out this field' is shown on Client Name.",
     "Both", "", ""],
    ["TC_AC_012", "Mandatory Field Validation", "Critical",
     "Submit form without selecting Client Type (B2B/B2C)",
     "Add Client page is open",
     "1. Do not select B2B or B2C\n2. Fill all other mandatory fields\n3. Click 'Add Client'",
     "Client Type: (none selected)",
     "Form submission is blocked. Browser shows validation error for the radio button group.",
     "Both", "", ""],
    ["TC_AC_013", "Mandatory Field Validation", "Critical",
     "Submit form without entering Email Id",
     "Add Client page is open",
     "1. Leave Email Id blank\n2. Fill all other mandatory fields\n3. Click 'Add Client'",
     "Email: (empty)",
     "Form submission is blocked. HTML5 validation error on Email field.",
     "Both", "", ""],
    ["TC_AC_014", "Mandatory Field Validation", "Critical",
     "Submit form without entering Mobile number",
     "Add Client page is open",
     "1. Leave Mobile blank\n2. Fill all other mandatory fields\n3. Click 'Add Client'",
     "Mobile: (empty)",
     "Form submission is blocked. HTML5 validation error on Mobile field.",
     "Both", "", ""],
    ["TC_AC_015", "Mandatory Field Validation", "High",
     "Submit form with completely empty form (all fields blank)",
     "Add Client page is open",
     "1. Do not fill any field\n2. Click 'Add Client'",
     "All fields: (empty)",
     "Form submission is blocked. First required field shows validation error.",
     "Manual", "", ""],

    # ── 4. CLIENT NAME VALIDATION ──
    ["TC_AC_016", "Client Name - Field Validation", "High",
     "Enter Client Name with only spaces",
     "Add Client page is open",
     "1. Enter '     ' (spaces only) in Client Name\n2. Fill other fields\n3. Click 'Add Client'",
     "Client Name: '     '",
     "Form should ideally reject whitespace-only names. If no server-side trim validation, the client may be saved with blank name (potential bug to verify).",
     "Both", "", ""],
    ["TC_AC_017", "Client Name - Field Validation", "Medium",
     "Enter Client Name with special characters / XSS attempt",
     "Add Client page is open",
     "1. Enter '<script>alert(1)</script>' as Client Name\n2. Fill other fields\n3. Click 'Add Client'",
     "Client Name: '<script>alert(1)</script>'",
     "Client should either be rejected or the special characters should be sanitized/escaped. No XSS script execution should occur.",
     "Both", "", ""],
    ["TC_AC_018", "Client Name - Field Validation", "Medium",
     "Enter Client Name exceeding DB column length (255 chars)",
     "Add Client page is open",
     "1. Enter a string of 256 characters in Client Name\n2. Fill other fields\n3. Click 'Add Client'",
     "Client Name: 'A' × 256 (256-char string)",
     "Either form should restrict to 255 chars via maxlength, or server should return a proper error. No truncation should silently occur.",
     "Both", "", ""],
    ["TC_AC_019", "Client Name - Field Validation", "Low",
     "Enter Client Name with exactly 255 characters (max boundary)",
     "Add Client page is open",
     "1. Enter exactly 255 characters\n2. Fill other fields\n3. Click 'Add Client'",
     "Client Name: 'A' × 255",
     "Client should be saved successfully with the full 255-character name.",
     "Both", "", ""],
    ["TC_AC_020", "Client Name - Field Validation", "Low",
     "Enter Client Name with single character",
     "Add Client page is open",
     "1. Enter 'A' as Client Name\n2. Fill other fields\n3. Click 'Add Client'",
     "Client Name: 'A'",
     "Client should be saved successfully with single character name.",
     "Both", "", ""],
    ["TC_AC_021", "Client Name - Field Validation", "Medium",
     "Enter Client Name with SQL injection string",
     "Add Client page is open",
     "1. Enter: ' OR 1=1; DROP TABLE client; --\n2. Fill other fields\n3. Click 'Add Client'",
     "Client Name: ' OR 1=1; DROP TABLE client; --",
     "No SQL injection occurs. The value is treated as a literal string. Spring Data JPA parameterized queries prevent injection.",
     "Both", "", ""],
    ["TC_AC_022", "Client Name - Field Validation", "Low",
     "Enter Client Name with Unicode/Multilingual characters",
     "Add Client page is open",
     "1. Enter 'ホテル東京旅館' or 'होटल मुंबई' as Client Name\n2. Fill other fields\n3. Click 'Add Client'",
     "Client Name: 'ホテル東京旅館'",
     "Client should be saved with Unicode characters correctly (DB charset is utf8mb4).",
     "Both", "", ""],

    # ── 5. EMAIL VALIDATION ──
    ["TC_AC_023", "Email - Field Validation", "High",
     "Enter invalid email format (no @ symbol)",
     "Add Client page is open",
     "1. Enter 'testhotel.com' in Email field\n2. Fill other fields\n3. Click 'Add Client'",
     "Email: 'testhotel.com'",
     "HTML5 email validation blocks submission. Error: 'Please include an @ in the email address.'",
     "Both", "", ""],
    ["TC_AC_024", "Email - Field Validation", "High",
     "Enter invalid email format (no domain)",
     "Add Client page is open",
     "1. Enter 'test@' in Email field\n2. Fill other fields\n3. Click 'Add Client'",
     "Email: 'test@'",
     "HTML5 email validation blocks submission.",
     "Both", "", ""],
    ["TC_AC_025", "Email - Field Validation", "Medium",
     "Enter email exceeding DB column length (250 chars)",
     "Add Client page is open",
     "1. Enter an email string where total length > 250\n2. Fill other fields\n3. Click 'Add Client'",
     "Email: 'a' × 240 + '@test.com' (248+ chars)",
     "Either the input is restricted by maxlength or server returns a proper error.",
     "Both", "", ""],
    ["TC_AC_026", "Email - Field Validation", "Medium",
     "Enter email with spaces",
     "Add Client page is open",
     "1. Enter 'test @hotel.com' (space before @)\n2. Fill other fields\n3. Click 'Add Client'",
     "Email: 'test @hotel.com'",
     "HTML5 type=email rejects the input. If it passes, server should reject it.",
     "Both", "", ""],
    ["TC_AC_027", "Email - Field Validation", "Low",
     "Enter valid email with + sign and subdomain",
     "Add Client page is open",
     "1. Enter 'test+crm@sub.hotel.com'\n2. Fill other fields\n3. Click 'Add Client'",
     "Email: 'test+crm@sub.hotel.com'",
     "Client saved successfully with the email address.",
     "Both", "", ""],

    # ── 6. MOBILE NUMBER VALIDATION ──
    ["TC_AC_028", "Mobile - Field Validation", "High",
     "Enter mobile number with less than 10 digits",
     "Add Client page is open",
     "1. Enter '98765' in Mobile\n2. Fill other fields\n3. Click 'Add Client'",
     "Mobile: '98765'",
     "HTML5 pattern=[0-9]{10} validation blocks submission. Error message about pattern mismatch.",
     "Both", "", ""],
    ["TC_AC_029", "Mobile - Field Validation", "High",
     "Enter mobile number with more than 10 digits",
     "Add Client page is open",
     "1. Enter '98765432109' (11 digits) in Mobile\n2. Fill other fields\n3. Click 'Add Client'",
     "Mobile: '98765432109'",
     "HTML5 pattern validation blocks submission.",
     "Both", "", ""],
    ["TC_AC_030", "Mobile - Field Validation", "High",
     "Enter mobile number with alphabetic characters",
     "Add Client page is open",
     "1. Enter 'ABCDEFGHIJ' in Mobile\n2. Fill other fields\n3. Click 'Add Client'",
     "Mobile: 'ABCDEFGHIJ'",
     "HTML5 type=tel with pattern=[0-9]{10} rejects the input.",
     "Both", "", ""],
    ["TC_AC_031", "Mobile - Field Validation", "High",
     "Enter valid 10-digit mobile number",
     "Add Client page is open",
     "1. Enter '9876543210' in Mobile\n2. Fill other fields\n3. Click 'Add Client'",
     "Mobile: '9876543210'",
     "Client is saved. Mobile stored as Long in DB = 9876543210.",
     "Both", "", ""],
    ["TC_AC_032", "Mobile - Field Validation", "Medium",
     "Enter mobile number with special characters (+91-style)",
     "Add Client page is open",
     "1. Enter '+919876543210' in Mobile\n2. Fill other fields\n3. Click 'Add Client'",
     "Mobile: '+919876543210'",
     "Pattern [0-9]{10} rejects the input since + is not allowed.",
     "Both", "", ""],
    ["TC_AC_033", "Mobile - Field Validation", "Medium",
     "Enter mobile number '0000000000' (all zeros)",
     "Add Client page is open",
     "1. Enter '0000000000'\n2. Fill other fields\n3. Click 'Add Client'",
     "Mobile: '0000000000'",
     "Passes pattern validation (10 digits). Client may be saved — potential logic gap (no business rule for all zeros).",
     "Both", "", ""],

    # ── 7. CITY AUTOCOMPLETE VALIDATION ──
    ["TC_AC_034", "City - Autocomplete Validation", "High",
     "Select a valid city from autocomplete",
     "Add Client page is open. City 'Delhi' exists in cities table.",
     "1. Type 'Del' in City field\n2. Wait for autocomplete suggestions\n3. Select 'Delhi' from the dropdown",
     "City typed: 'Del' → select 'Delhi'",
     "City field shows 'Delhi'. Hidden field 'city.destinationId' is set to the correct destinationId (e.g., 10).",
     "Both", "", ""],
    ["TC_AC_035", "City - Autocomplete Validation", "High",
     "Type a city name that does not exist in DB",
     "Add Client page is open",
     "1. Type 'XYZNonExistentCity' in City field\n2. No autocomplete suggestion appears\n3. Click 'Add Client'",
     "City: 'XYZNonExistentCity', destinationId: (empty/0)",
     "Server-side validation catches city mismatch. Error: 'Error: Invalid City Name Selected.' is shown on the form.",
     "Both", "", ""],
    ["TC_AC_036", "City - Autocomplete Validation", "High",
     "Type valid city name but do NOT select from autocomplete (hidden ID not set)",
     "Add Client page is open",
     "1. Type 'Delhi' manually in City field but do NOT click the autocomplete suggestion\n2. Fill other fields\n3. Click 'Add Client'",
     "City: 'Delhi', destinationId: (not set via JS)",
     "Server-side validation rejects because destinationId is 0/null and won't match the typed city name.",
     "Both", "", ""],
    ["TC_AC_037", "City - Autocomplete Validation", "Medium",
     "Submit form with City field left completely empty",
     "Add Client page is open",
     "1. Leave City field blank\n2. Fill all other mandatory fields\n3. Click 'Add Client'",
     "City: (empty), destinationId: (empty)",
     "City is not required in HTML. Form submits. Controller may save client with null city OR throw NullPointerException. Verify behavior.",
     "Both", "", ""],
    ["TC_AC_038", "City - Autocomplete Validation", "Medium",
     "Select a city, then manually change the text after selection",
     "Add Client page is open",
     "1. Type 'Noi' → Select 'Noida' from autocomplete\n2. Manually change text to 'NoiXYZ'\n3. Click 'Add Client'",
     "City visible: 'NoiXYZ', hidden destinationId: Noida's ID",
     "Server-side validation catches mismatch between destinationId and cityName. Error shown.",
     "Both", "", ""],

    # ── 8. ACTIVE STATUS DROPDOWN ──
    ["TC_AC_039", "Active Dropdown", "Medium",
     "Add Client with Active status = 'In-Active'",
     "Add Client page is open",
     "1. Fill all mandatory fields\n2. Select 'In-Active' from Active dropdown\n3. Click 'Add Client'",
     "Active: In-Active (false)",
     "Client saved with active=false(0) in DB.",
     "Both", "", ""],
    ["TC_AC_040", "Active Dropdown", "Medium",
     "Verify Active dropdown has exactly 2 options",
     "Add Client page is open",
     "1. Click on Active dropdown\n2. Count options",
     "N/A",
     "Dropdown has exactly 2 options: 'Active' (true) and 'In-Active' (false).",
     "Both", "", ""],

    # ── 9. REFERENCE FIELD (OPTIONAL) ──
    ["TC_AC_041", "Reference - Optional Field", "Medium",
     "Add Client without filling Reference field",
     "Add Client page is open",
     "1. Fill all mandatory fields\n2. Leave Reference blank\n3. Click 'Add Client'",
     "Reference: (empty)",
     "Client saved successfully. Reference is stored as null in DB.",
     "Both", "", ""],
    ["TC_AC_042", "Reference - Optional Field", "Low",
     "Enter Reference exceeding DB column length (255 chars)",
     "Add Client page is open",
     "1. Enter 256-char string in Reference\n2. Fill other fields\n3. Click 'Add Client'",
     "Reference: 'R' × 256",
     "Server should return error or truncate. No silent data loss.",
     "Both", "", ""],

    # ── 10. REMARKS FIELD (OPTIONAL) ──
    ["TC_AC_043", "Remarks - Optional Field", "Medium",
     "Add Client without filling Remarks",
     "Add Client page is open",
     "1. Fill all mandatory fields\n2. Leave Remarks blank\n3. Click 'Add Client'",
     "Remarks: (empty)",
     "Client saved successfully. Remarks is null in DB.",
     "Both", "", ""],
    ["TC_AC_044", "Remarks - Optional Field", "Medium",
     "Enter Remarks up to maxlength (255 chars as per JSP)",
     "Add Client page is open",
     "1. Enter exactly 255 characters in Remarks\n2. Fill other fields\n3. Click 'Add Client'",
     "Remarks: 'R' × 255",
     "Client saved. All 255 chars stored in DB. Textarea should not accept more than 255 chars.",
     "Both", "", ""],
    ["TC_AC_045", "Remarks - Optional Field", "Low",
     "Attempt to enter more than 255 chars in Remarks (maxlength test)",
     "Add Client page is open",
     "1. Attempt to type 300 chars into Remarks textarea\n2. Observe character limit behavior",
     "Remarks: 'R' × 300",
     "Textarea stops accepting input after 255 characters (HTML maxlength=255 enforced by browser).",
     "Manual", "", ""],

    # ── 11. SECURITY & AUTHORIZATION ──
    ["TC_AC_046", "Security & Authorization", "Critical",
     "Access Add Client page without logging in",
     "User is NOT logged in (no active session)",
     "1. Open browser\n2. Navigate to: http://192.168.1.6:8080/ashokacrm/view_add_client_form",
     "URL: /ashokacrm/view_add_client_form",
     "User is redirected to the login page (/ashokacrm/login). Add Client page is NOT accessible.",
     "Both", "", ""],
    ["TC_AC_047", "Security & Authorization", "Critical",
     "Verify 'View Client List' button visibility per role",
     "User logged in with a role that does NOT have ADMIN or CLIENT_MANAGE privilege",
     "1. Navigate to Add Client page\n2. Check if 'View Client List' button is visible",
     "User role: (non-ADMIN, non-CLIENT_MANAGE)",
     "'View Client List' button is hidden. 'Add Client' submit button is still visible.",
     "Manual", "", ""],
    ["TC_AC_048", "Security & Authorization", "High",
     "Submit Add Client via direct POST (CSRF disabled scenario)",
     "CSRF is disabled in SecurityConfiguration. User is authenticated.",
     "1. Use Postman/curl to send POST to /ashokacrm/create_create_client with valid data\n2. Observe response",
     "POST body with valid client fields",
     "Since CSRF is disabled, the request is accepted. Client is saved. User is redirected (302) to view_clients_list.",
     "Manual", "", ""],

    # ── 12. CLIENT TYPE B2B/B2C ──
    ["TC_AC_049", "Client Type - B2B/B2C", "High",
     "Switch between B2B and B2C radio buttons",
     "Add Client page is open",
     "1. Select B2B\n2. Verify B2B is selected\n3. Now select B2C\n4. Verify B2C is selected and B2B is deselected",
     "N/A",
     "Only one radio button can be selected at a time. Switching deselects the other.",
     "Both", "", ""],

    # ── 13. BACKEND / DB VALIDATION ──
    ["TC_AC_050", "Backend - DB Validation", "Critical",
     "Verify client is saved in 'client' table with correct column mapping",
     "A new client is successfully added via the form",
     "1. Add a client via the form\n2. Query DB: SELECT * FROM client WHERE clientName='Test Hotel Pvt Ltd'",
     "N/A",
     "DB record exists with correct values: clientName, cityId (FK→cities), b2b, mobile, emailId, reference, salesPartnerId (FK→salespartner), remarks, isSalesPartner=0, active.",
     "Manual", "", ""],
    ["TC_AC_051", "Backend - DB Validation", "High",
     "Verify clientId is auto-incremented on save",
     "Some clients exist in DB",
     "1. Note the current max clientId\n2. Add a new client\n3. Query: SELECT MAX(clientId) FROM client",
     "N/A",
     "New clientId = previous max + 1 (AUTO_INCREMENT behavior).",
     "Manual", "", ""],
    ["TC_AC_052", "Backend - DB Validation", "High",
     "Verify salesPartnerFlag is set to false on new client creation",
     "A new client is successfully added",
     "1. Add a new client\n2. Query: SELECT isSalesPartner FROM client WHERE clientId=<new_id>",
     "N/A",
     "isSalesPartner = 0 (false). Set in controller: clientEntity.setSalesPartnerFlag(false).",
     "Manual", "", ""],
    ["TC_AC_053", "Backend - DB Validation", "High",
     "Verify foreign key for cityId references cities.destinationId",
     "A new client is added with City = 'Delhi'",
     "1. Query: SELECT c.clientName, ci.CityName FROM client c JOIN cities ci ON c.cityId=ci.destinationId WHERE c.clientId=<new_id>",
     "City: Delhi (destinationId=10)",
     "Join succeeds. CityName = 'Delhi'.",
     "Manual", "", ""],
    ["TC_AC_054", "Backend - DB Validation", "High",
     "Verify foreign key for salesPartnerId references salespartner table",
     "A new client is added with a valid sales partner",
     "1. Query: SELECT c.clientName, sp.salesPartnerShortName FROM client c JOIN salespartner sp ON c.salesPartnerId=sp.salesPartnerId WHERE c.clientId=<new_id>",
     "N/A",
     "Join succeeds. Sales partner name matches the selected dropdown value.",
     "Manual", "", ""],

    # ── 14. POST-SUBMISSION REDIRECT & FLASH ──
    ["TC_AC_055", "Post-Submission Flow", "High",
     "Verify redirect to Client List page after successful add",
     "User adds a valid client",
     "1. Fill all mandatory fields correctly\n2. Click 'Add Client'\n3. Observe URL and page",
     "Valid client data",
     "User is redirected to /ashokacrm/view_clients_list. URL changes accordingly.",
     "Both", "", ""],
    ["TC_AC_056", "Post-Submission Flow", "High",
     "Verify success flash message after adding client",
     "User adds a valid client and is redirected",
     "1. After redirect to Client List page, check for flash message",
     "N/A",
     "Flash message 'Client record is updated successfully.' is displayed.",
     "Both", "", ""],
    ["TC_AC_057", "Post-Submission Flow", "Medium",
     "Verify form reloads with errors when city validation fails",
     "User typed invalid city",
     "1. Fill all fields\n2. Enter a city name that doesn't match its destinationId\n3. Click 'Add Client'",
     "City: 'XYZ' with destinationId of Delhi",
     "Form reloaded (NOT redirected). City error 'Error: Invalid City Name Selected.' shown. Previously entered data is retained.",
     "Both", "", ""],

    # ── 15. VIEW CLIENT LIST BUTTON ──
    ["TC_AC_058", "Navigation - View Client List", "Medium",
     "Click 'View Client List' button navigates correctly",
     "Add Client page is open. User has ADMIN/CLIENT_MANAGE role.",
     "1. Click 'View Client List' button",
     "N/A",
     "User is navigated to /ashokacrm/view_clients_list page. Client listing is displayed.",
     "Both", "", ""],

    # ── 16. DUPLICATE DATA ──
    ["TC_AC_059", "Duplicate Data", "High",
     "Add client with same name and mobile as an existing client",
     "A client 'Test Hotel' with mobile 9876543210 already exists in DB",
     "1. Enter Client Name: 'Test Hotel'\n2. Enter Mobile: 9876543210\n3. Fill other fields\n4. Click 'Add Client'",
     "Duplicate name + mobile",
     "No unique constraint on (clientName, mobile). Client saved as duplicate. Verify if intended or bug.",
     "Both", "", ""],
    ["TC_AC_060", "Duplicate Data", "Medium",
     "Add client with same Email as an existing client",
     "A client with email 'test@hotel.com' already exists",
     "1. Enter Email: 'test@hotel.com'\n2. Fill other fields\n3. Click 'Add Client'",
     "Email: 'test@hotel.com' (duplicate)",
     "No unique constraint on emailId. Client saved. Verify if duplicates are acceptable.",
     "Both", "", ""],

    # ── 17. CONCURRENCY & SESSION ──
    ["TC_AC_061", "Concurrency & Session", "Medium",
     "Session timeout while filling the form",
     "User starts filling the form. Session times out.",
     "1. Open the Add Client form\n2. Wait for session timeout (or manually invalidate)\n3. Click 'Add Client'",
     "N/A",
     "User is redirected to the login page. Data is lost. No server error.",
     "Manual", "", ""],
    ["TC_AC_062", "Concurrency & Session", "Medium",
     "Double-click 'Add Client' button rapidly",
     "Add Client form with valid data filled",
     "1. Fill all fields with valid data\n2. Rapidly double-click 'Add Client' button",
     "Valid client data",
     "Only ONE client record should be created, not two. Verify double-submit prevention.",
     "Manual", "", ""],

    # ── 18. UI & BROWSER COMPATIBILITY ──
    ["TC_AC_063", "UI & Browser", "Medium",
     "Verify form layout across Chrome, Firefox, Safari",
     "Add Client page is open",
     "1. Open page in Chrome, Firefox, Safari\n2. Compare layout, alignment, buttons",
     "N/A",
     "Form layout is consistent. All fields properly aligned. No overlapping elements.",
     "Manual", "", ""],
    ["TC_AC_064", "UI & Browser", "Medium",
     "Verify form on mobile viewport / responsive design",
     "Add Client page is open",
     "1. Resize browser to mobile width (375px)\n2. Check form usability",
     "Viewport: 375px width",
     "Form is usable on mobile. Fields stack vertically. Buttons clickable. No horizontal scrolling.",
     "Manual", "", ""],
    ["TC_AC_065", "UI & Browser", "Low",
     "Verify background image loads correctly",
     "Add Client page is open",
     "1. Observe the background image on the page",
     "Image: /resources/images/clientadd.jpg",
     "Background image 'clientadd.jpg' loads, covers full page, fixed on scroll, with semi-transparent overlay.",
     "Manual", "", ""],

    # ── 19. EDGE CASES & ERROR HANDLING ──
    ["TC_AC_066", "Edge Case", "High",
     "Add client when Sales Partner dropdown is empty (no active partners in DB)",
     "No active sales partners exist in the database",
     "1. Navigate to Add Client page\n2. Check Sales Partner dropdown",
     "N/A",
     "Dropdown shows only '-- Please Select --'. User cannot submit. Form fails gracefully.",
     "Manual", "", ""],
    ["TC_AC_067", "Edge Case", "High",
     "Add client when Cities table is completely empty",
     "No cities exist in the cities table",
     "1. Navigate to Add Client page\n2. Type anything in City field\n3. No autocomplete results\n4. Click 'Add Client'",
     "N/A",
     "City validation fails gracefully. Error displayed without server crash.",
     "Manual", "", ""],
    ["TC_AC_068", "Edge Case", "Medium",
     "Database connection failure during form submission",
     "DB is down or unreachable",
     "1. Fill all fields correctly\n2. Stop MySQL service\n3. Click 'Add Client'",
     "N/A",
     "Application shows proper error page / 500 error. No stack trace exposed to user.",
     "Manual", "", ""],
    ["TC_AC_069", "Edge Case", "Medium",
     "Network disconnection after clicking Add Client",
     "Add Client form filled. Network disrupted.",
     "1. Fill all fields\n2. Disconnect network\n3. Click 'Add Client'",
     "N/A",
     "Browser shows connection error. No partial data saved. Retry works after reconnection.",
     "Manual", "", ""],
    ["TC_AC_070", "Edge Case", "Low",
     "Browser back/forward after successful submission",
     "Client just added, user on Client List page",
     "1. Click browser Back button\n2. Observe form\n3. Click 'Add Client' again",
     "N/A",
     "Browser may show resubmission dialog. Duplicate may be created — verify safeguard.",
     "Manual", "", ""],

    # ── 20. PERFORMANCE ──
    ["TC_AC_071", "Performance", "Low",
     "Measure page load time for Add Client page",
     "User is logged in",
     "1. Open DevTools > Network tab\n2. Navigate to Add Client page\n3. Note load time",
     "N/A",
     "Page loads within 3 seconds. Sales Partner dropdown fetched efficiently.",
     "Manual", "", ""],
    ["TC_AC_072", "Performance", "Low",
     "Measure city autocomplete response time",
     "Add Client page is open",
     "1. Open DevTools > Network\n2. Type 'Del' in City\n3. Note /getCityList API response time",
     "City search: 'Del'",
     "Autocomplete results within 1 second. API response < 500ms.",
     "Manual", "", ""],

    # ── 21. ACCESSIBILITY ──
    ["TC_AC_073", "Accessibility", "Low",
     "Verify form is navigable using keyboard (Tab key)",
     "Add Client page is open",
     "1. Press Tab through each field\n2. Verify logical focus order",
     "N/A",
     "All fields reachable via Tab in logical order. Focus visible on each element.",
     "Manual", "", ""],
    ["TC_AC_074", "Accessibility", "Low",
     "Verify labels are associated with input fields",
     "Add Client page is open",
     "1. Inspect HTML source\n2. Check <label> 'for' attributes match input IDs",
     "N/A",
     "Labels properly associated. (Note: some may not match — verify.)",
     "Manual", "", ""],
]


def create_xlsx():
    wb = Workbook()
    ws = wb.active
    ws.title = "Add Client - Test Cases"

    # ── Title Row ──
    ws.merge_cells(start_row=1, start_column=1, end_row=1, end_column=len(HEADERS))
    title_cell = ws.cell(row=1, column=1,
                         value="AxisHMS Pro CRM — Add Client Feature — Test Cases (74)")
    title_cell.font = TITLE_FONT
    title_cell.fill = TITLE_FILL
    title_cell.alignment = Alignment(horizontal="center", vertical="center")
    ws.row_dimensions[1].height = 36

    # ── Sub-title Row ──
    ws.merge_cells(start_row=2, start_column=1, end_row=2, end_column=len(HEADERS))
    sub = ws.cell(row=2, column=1,
                  value="Module: Client Management  |  Feature: Add Client  |  URL: /ashokacrm/view_add_client_form  |  Generated: 2026-02-23")
    sub.font = Font(name="Calibri", size=10, italic=True, color="555555")
    sub.alignment = Alignment(horizontal="center")
    ws.row_dimensions[2].height = 22

    # ── Header Row (row 3) ──
    for col_idx, header in enumerate(HEADERS, 1):
        cell = ws.cell(row=3, column=col_idx, value=header)
        cell.font = HEADER_FONT
        cell.fill = HEADER_FILL
        cell.alignment = Alignment(horizontal="center", vertical="center", wrap_text=True)
        cell.border = THIN_BORDER
    ws.row_dimensions[3].height = 30

    # ── Set column widths ──
    for col_idx, width in enumerate(COL_WIDTHS, 1):
        ws.column_dimensions[get_column_letter(col_idx)].width = width

    # ── Data Rows ──
    current_category = None
    row_num = 4

    for tc in TEST_CASES:
        # Insert category separator row
        if tc[1] != current_category:
            current_category = tc[1]
            ws.merge_cells(start_row=row_num, start_column=1,
                           end_row=row_num, end_column=len(HEADERS))
            sep_cell = ws.cell(row=row_num, column=1, value=f"▸ {current_category}")
            sep_cell.font = CATEGORY_FONT
            sep_cell.fill = CATEGORY_FILL
            sep_cell.alignment = Alignment(vertical="center")
            sep_cell.border = THIN_BORDER
            ws.row_dimensions[row_num].height = 24
            row_num += 1

        # Write test case row
        is_even = (row_num % 2 == 0)
        for col_idx, value in enumerate(tc, 1):
            cell = ws.cell(row=row_num, column=col_idx, value=value)
            cell.font = DATA_FONT
            cell.alignment = DATA_ALIGNMENT
            cell.border = THIN_BORDER

            if is_even:
                cell.fill = EVEN_ROW_FILL

        # Priority colour coding (column 3)
        priority = tc[2]
        priority_cell = ws.cell(row=row_num, column=3)
        if priority in PRIORITY_FILLS:
            priority_cell.fill = PRIORITY_FILLS[priority]
            priority_cell.font = PRIORITY_FONTS[priority]
            priority_cell.alignment = Alignment(horizontal="center", vertical="top")

        # Center TC ID column
        ws.cell(row=row_num, column=1).alignment = Alignment(horizontal="center", vertical="top")
        # Center Type column
        ws.cell(row=row_num, column=9).alignment = Alignment(horizontal="center", vertical="top", wrap_text=True)
        # Center Status column
        ws.cell(row=row_num, column=10).alignment = Alignment(horizontal="center", vertical="top")

        ws.row_dimensions[row_num].height = 72
        row_num += 1

    # ── Summary Row ──
    row_num += 1
    ws.merge_cells(start_row=row_num, start_column=1, end_row=row_num, end_column=3)
    ws.cell(row=row_num, column=1, value="Total Test Cases:").font = Font(bold=True, size=11)
    ws.cell(row=row_num, column=4, value=len(TEST_CASES)).font = Font(bold=True, size=11, color="1F4E79")

    row_num += 1
    ws.merge_cells(start_row=row_num, start_column=1, end_row=row_num, end_column=3)
    ws.cell(row=row_num, column=1, value="Critical:").font = Font(bold=True, size=10, color="FF4444")
    ws.cell(row=row_num, column=4,
            value=sum(1 for tc in TEST_CASES if tc[2] == "Critical")).font = Font(bold=True, size=10)

    row_num += 1
    ws.merge_cells(start_row=row_num, start_column=1, end_row=row_num, end_column=3)
    ws.cell(row=row_num, column=1, value="High:").font = Font(bold=True, size=10, color="E65100")
    ws.cell(row=row_num, column=4,
            value=sum(1 for tc in TEST_CASES if tc[2] == "High")).font = Font(bold=True, size=10)

    row_num += 1
    ws.merge_cells(start_row=row_num, start_column=1, end_row=row_num, end_column=3)
    ws.cell(row=row_num, column=1, value="Medium:").font = Font(bold=True, size=10, color="F9A825")
    ws.cell(row=row_num, column=4,
            value=sum(1 for tc in TEST_CASES if tc[2] == "Medium")).font = Font(bold=True, size=10)

    row_num += 1
    ws.merge_cells(start_row=row_num, start_column=1, end_row=row_num, end_column=3)
    ws.cell(row=row_num, column=1, value="Low:").font = Font(bold=True, size=10, color="2E7D32")
    ws.cell(row=row_num, column=4,
            value=sum(1 for tc in TEST_CASES if tc[2] == "Low")).font = Font(bold=True, size=10)

    # ── Freeze panes ──
    ws.freeze_panes = "A4"

    # ── Auto-filter ──
    ws.auto_filter.ref = f"A3:{get_column_letter(len(HEADERS))}{row_num}"

    wb.save(XLSX_FILE)
    print(f"✅  Excel file saved:  {XLSX_FILE}")


def create_csv():
    with open(CSV_FILE, "w", newline="", encoding="utf-8-sig") as f:
        writer = csv.writer(f)
        writer.writerow(HEADERS)
        for tc in TEST_CASES:
            writer.writerow(tc)
    print(f"✅  CSV file saved:    {CSV_FILE}")


if __name__ == "__main__":
    create_xlsx()
    create_csv()
    print(f"\n📊  Total test cases:  {len(TEST_CASES)}")
    print("📂  Both files are in: test_cases/")
