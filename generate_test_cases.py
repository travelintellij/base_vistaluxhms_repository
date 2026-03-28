import openpyxl
from openpyxl.styles import Font, PatternFill, Alignment, Border, Side
from openpyxl.utils import get_column_letter

def style_header(ws, row, cols, fill_color="1B2A3D"):
    header_font = Font(name='Calibri', bold=True, color="FFFFFF", size=11)
    header_fill = PatternFill(start_color=fill_color, end_color=fill_color, fill_type="solid")
    header_align = Alignment(horizontal="center", vertical="center", wrap_text=True)
    thin_border = Border(
        left=Side(style='thin'), right=Side(style='thin'),
        top=Side(style='thin'), bottom=Side(style='thin'))
    for col in range(1, cols+1):
        cell = ws.cell(row=row, column=col)
        cell.font = header_font
        cell.fill = header_fill
        cell.alignment = header_align
        cell.border = thin_border

def style_section_header(ws, row, cols, title, fill_color="C9A84C"):
    ws.merge_cells(start_row=row, start_column=1, end_row=row, end_column=cols)
    cell = ws.cell(row=row, column=1)
    cell.value = title
    cell.font = Font(name='Calibri', bold=True, color="1B2A3D", size=13)
    cell.fill = PatternFill(start_color=fill_color, end_color=fill_color, fill_type="solid")
    cell.alignment = Alignment(horizontal="center", vertical="center")

def add_data_row(ws, row, data):
    thin_border = Border(
        left=Side(style='thin'), right=Side(style='thin'),
        top=Side(style='thin'), bottom=Side(style='thin'))
    data_align = Alignment(vertical="top", wrap_text=True)
    for col, value in enumerate(data, 1):
        cell = ws.cell(row=row, column=col)
        cell.value = value
        cell.font = Font(name='Calibri', size=10)
        cell.alignment = data_align
        cell.border = thin_border

HEADERS = ["TC ID", "Test Scenario", "Test Steps", "Test Data / Inputs", "Expected Result", "Priority", "Status", "Remarks"]
NUM_COLS = len(HEADERS)

# ========== QUOTATION MANAGEMENT ==========
wb_q = openpyxl.Workbook()

# --- Sheet 1: System Quotation ---
ws_sq = wb_q.active
ws_sq.title = "System Quotation"
ws_sq.sheet_properties.tabColor = "1B2A3D"

# Column widths
col_widths = [10, 35, 50, 40, 40, 10, 10, 20]
for i, w in enumerate(col_widths, 1):
    ws_sq.column_dimensions[get_column_letter(i)].width = w

r = 1
style_section_header(ws_sq, r, NUM_COLS, "SYSTEM QUOTATION — TEST CASES")
r = 2
style_section_header(ws_sq, r, NUM_COLS, "Section A: Form Load & UI Validation", "E8E4DE")
r = 3
for col, h in enumerate(HEADERS, 1):
    ws_sq.cell(row=r, column=col, value=h)
style_header(ws_sq, r, NUM_COLS)

sq_tests_section_a = [
    ["SQ-001", "Load New System Quotation form", "1. Login as admin\n2. Navigate to Quotation Management > New System Quotation", "Valid admin credentials", "Form loads with empty fields; Sales Partner, Rate Type, Room Type, Meal Plan dropdowns populated", "High", "", ""],
    ["SQ-002", "Verify Sales Partner dropdown has active partners", "1. Open System Quotation form\n2. Check Sales Partner dropdown", "Active sales partners in DB", "Only active sales partners appear in dropdown", "High", "", ""],
    ["SQ-003", "Verify Rate Type dropdown has active rate types", "1. Open System Quotation form\n2. Check Rate Type dropdown", "Active rate types in DB", "Only active rate types listed", "Medium", "", ""],
    ["SQ-004", "Verify Room Type dropdown has active rooms", "1. Open System Quotation form\n2. Check Room Type dropdown", "Active rooms in DB", "Only active room categories shown", "High", "", ""],
    ["SQ-005", "Verify Meal Plan dropdown values", "1. Open System Quotation form\n2. Check Meal Plan dropdown", "N/A", "Shows: EPAI, CPAI, MAPAI, APAI", "Medium", "", "Mapped to IDs 1,2,3,4"],
    ["SQ-006", "Verify Audience Type toggle (Client vs Guest)", "1. Open form\n2. Select 'Client' audience type\n3. Select 'Guest' audience type", "N/A", "Client: shows client search field; Guest: shows manual name/email/mobile fields", "High", "", ""],
    ["SQ-007", "Verify add room row button", "1. Open form\n2. Click 'Add Room' button multiple times", "N/A", "New empty room detail rows are added dynamically each time", "Medium", "", ""],
]

r = 4
for test in sq_tests_section_a:
    add_data_row(ws_sq, r, test)
    r += 1

# Section B: Client Validation
r += 1
style_section_header(ws_sq, r, NUM_COLS, "Section B: Client/Guest Validation", "E8E4DE")
r += 1
for col, h in enumerate(HEADERS, 1):
    ws_sq.cell(row=r, column=col, value=h)
style_header(ws_sq, r, NUM_COLS)
r += 1

sq_tests_section_b = [
    ["SQ-008", "Submit with Client audience type but no client selected", "1. Select audience type = Client\n2. Leave Guest Name empty\n3. Click Review", "Audience Type = 1, GuestId = 0", "Validation error: contact.error displayed", "High", "", ""],
    ["SQ-009", "Submit with Client but mismatched Guest Name", "1. Select audience type = Client\n2. Search & select a client\n3. Manually change Guest Name to different text\n4. Click Review", "GuestId = valid, GuestName = modified", "Validation error: Guest name must match client name from DB", "High", "", ""],
    ["SQ-010", "Submit with Client and correct matched name", "1. Select audience type = Client\n2. Search & select valid client\n3. Keep auto-filled Guest Name\n4. Click Review", "GuestId = valid, GuestName = matching", "Passes validation; mobile, email, rateType auto-populated from client's sales partner", "High", "", ""],
    ["SQ-011", "Submit with Guest audience type (manual entry)", "1. Select audience type = Guest\n2. Enter Guest Name, Mobile, Email manually\n3. Click Review", "Name=TestGuest, Mobile=9876543210, Email=test@test.com", "Should proceed without client validation", "High", "", ""],
]

for test in sq_tests_section_b:
    add_data_row(ws_sq, r, test)
    r += 1

# Section C: Room Details Validation
r += 1
style_section_header(ws_sq, r, NUM_COLS, "Section C: Room Details Validation", "E8E4DE")
r += 1
for col, h in enumerate(HEADERS, 1):
    ws_sq.cell(row=r, column=col, value=h)
style_header(ws_sq, r, NUM_COLS)
r += 1

sq_tests_section_c = [
    ["SQ-012", "Submit with zero adults and zero children", "1. Add a room row\n2. Set Adults=0, Children=0\n3. Click Review", "RoomCategory=valid, MealPlan=valid, Adults=0, NoOfChild=0", "Error: Guests must be greater than zero", "High", "", ""],
    ["SQ-013", "Submit with 1 adult", "1. Add a room row\n2. Set Adults=1, valid dates\n3. Click Review", "Adults=1", "Price calculated using Person1 rate from session", "High", "", ""],
    ["SQ-014", "Submit with 2 adults", "1. Add room\n2. Set Adults=2, valid dates\n3. Review", "Adults=2", "Price uses Person2 rate from session", "High", "", ""],
    ["SQ-015", "Submit with 3 adults", "1. Add room\n2. Set Adults=3\n3. Review", "Adults=3", "Price uses Person3 rate from session", "High", "", ""],
    ["SQ-016", "Submit with 4 adults", "1. Add room\n2. Set Adults=4\n3. Review", "Adults=4", "Price uses Person4 rate from session", "Medium", "", ""],
    ["SQ-017", "Submit with 5 adults", "1. Add room\n2. Set Adults=5\n3. Review", "Adults=5", "Price uses Person5 rate from session", "Medium", "", ""],
    ["SQ-018", "Submit with 6 adults", "1. Add room\n2. Set Adults=6\n3. Review", "Adults=6", "Price uses Person6 rate from session", "Medium", "", ""],
    ["SQ-019", "Submit with no check-in date", "1. Add room\n2. Leave Check-In blank\n3. Review", "CheckIn=null, CheckOut=valid", "Error: Check-in and Check-out dates are required", "High", "", ""],
    ["SQ-020", "Submit with no check-out date", "1. Add room\n2. Set Check-In, leave Check-Out blank\n3. Review", "CheckIn=valid, CheckOut=null", "Error: Check-in and Check-out dates are required", "High", "", ""],
    ["SQ-021", "Check-in date in the past", "1. Add room\n2. Set Check-In to yesterday\n3. Review", "CheckIn=yesterday", "Error: Check-in date cannot be in the past", "High", "", ""],
    ["SQ-022", "Check-out date in the past", "1. Add room\n2. Set Check-Out to yesterday\n3. Review", "CheckOut=yesterday", "Error: Check-out date cannot be in the past", "High", "", ""],
    ["SQ-023", "Check-out before check-in", "1. Add room\n2. Set Check-Out 1 day before Check-In\n3. Review", "CheckIn=tomorrow+1, CheckOut=tomorrow", "Error: Check-out date must be same or after Check-in date", "High", "", ""],
    ["SQ-024", "Same day check-in and check-out", "1. Add room\n2. Set Check-In = Check-Out = today\n3. Review", "CheckIn=today, CheckOut=today", "Should process with 0 nights (edge case — verify behavior)", "Medium", "", "Edge case"],
    ["SQ-025", "No room category selected", "1. Add room\n2. Leave Room Category at default\n3. Review", "RoomCategoryId=0", "Row should be filtered out (stream filter: roomCategoryId > 0)", "Medium", "", ""],
    ["SQ-026", "No meal plan selected", "1. Add room\n2. Leave Meal Plan at default\n3. Review", "MealPlanId=0", "Row should be filtered out (stream filter: mealPlanId > 0)", "Medium", "", ""],
    ["SQ-027", "Multiple room rows with mixed validity", "1. Add 3 rooms\n2. Room1=valid, Room2=invalid(no category), Room3=valid\n3. Review", "Mixed data", "Only Room1 & Room3 should be processed; Room2 filtered out", "High", "", ""],
]

for test in sq_tests_section_c:
    add_data_row(ws_sq, r, test)
    r += 1

# Section D: Pricing Logic
r += 1
style_section_header(ws_sq, r, NUM_COLS, "Section D: Pricing Calculation Logic", "E8E4DE")
r += 1
for col, h in enumerate(HEADERS, 1):
    ws_sq.cell(row=r, column=col, value=h)
style_header(ws_sq, r, NUM_COLS)
r += 1

sq_tests_section_d = [
    ["SQ-028", "Child With Bed pricing = Person2 × 25% × count", "1. Set Adults=2, ChildWithBed=1\n2. Review", "ChildWithBed=1, Person2 rate=10000", "ChildWithBedPrice = 10000 × 25/100 × 1 = 2500", "High", "", "ANY_ROOM_EXTRA_BED_CHILD_PERCENTAGE=25"],
    ["SQ-029", "Child No Bed pricing = Person2 × 20% × count", "1. Set Adults=2, ChildNoBed=2\n2. Review", "ChildNoBed=2, Person2 rate=10000", "ChildNoBedPrice = 10000 × 20/100 × 2 = 4000", "High", "", "ANY_ROOM_CHILD_NO_BED_PERCENTAGE=20"],
    ["SQ-030", "Extra Bed pricing = Person2 × 35% × count", "1. Set Adults=2, ExtraBed=1\n2. Review", "ExtraBed=1, Person2 rate=10000", "ExtraBedPrice = 10000 × 35/100 × 1 = 3500", "High", "", "ANY_ROOM_EXTRA_BED_ADULT_PERCENTAGE=35"],
    ["SQ-031", "Multi-night pricing accumulation", "1. Set CheckIn=Day1, CheckOut=Day3 (2 nights)\n2. Adults=2\n3. Review", "2 nights, Person2=10000 each day", "TotalAdultPrice = 10000 + 10000 = 20000. Each night's rate from session looked up separately", "High", "", "Loop: checkIn to checkOut-1"],
    ["SQ-032", "Multi-night with children pricing accumulation", "1. 2 nights, Adults=2, ChildWithBed=1\n2. Review", "2 nights, Person2=10000", "ChildWithBed per night = 2500. Total = 5000 over 2 nights", "High", "", ""],
    ["SQ-033", "Grand Total = sum of all rooms total prices", "1. Add 2 rooms with different configs\n2. Review", "Room1 total=15000, Room2 total=20000", "GrandTotal = 35000", "High", "", ""],
    ["SQ-034", "No session rate mapping found for a date", "1. Set dates where no rate is configured in session\n2. Review", "Date with no rate mapping", "That day's price = 0 (sessionDetailsEntity is null, skipped)", "High", "", "Edge case"],
    ["SQ-035", "Zero ChildWithBed should not add to price", "1. Set ChildWithBed=0\n2. Review", "ChildWithBed=0", "ChildWithBedPrice = 0, no extra calculation done", "Medium", "", ""],
    ["SQ-036", "Zero ChildNoBed should not add to price", "1. Set ChildNoBed=0\n2. Review", "ChildNoBed=0", "ChildNoBedPrice = 0", "Medium", "", ""],
    ["SQ-037", "Zero ExtraBed should not add to price", "1. Set ExtraBed=0\n2. Review", "ExtraBed=0", "ExtraBedPrice = 0", "Medium", "", ""],
    ["SQ-038", "TotalPrice per room = Adult + ChildWithBed + ChildNoBed + ExtraBed", "1. Enter all occupancy types\n2. Review", "Adult=10000, CWB=2500, CNB=2000, EB=3500", "RoomTotal = 10000+2500+2000+3500 = 18000", "High", "", ""],
]

for test in sq_tests_section_d:
    add_data_row(ws_sq, r, test)
    r += 1

# Section E: Review & Send Actions
r += 1
style_section_header(ws_sq, r, NUM_COLS, "Section E: Review, Email, WhatsApp, PDF Actions", "E8E4DE")
r += 1
for col, h in enumerate(HEADERS, 1):
    ws_sq.cell(row=r, column=col, value=h)
style_header(ws_sq, r, NUM_COLS)
r += 1

sq_tests_section_e = [
    ["SQ-039", "Review page displays correct Grand Total", "1. Complete form with valid data\n2. Click Review", "Multiple rooms", "Review page shows all room details, prices, and correct Grand Total", "High", "", ""],
    ["SQ-040", "Send quotation via Email with valid email", "1. Review quotation\n2. Enter valid email\n3. Click Send Email", "Email=valid@email.com", "Email sent successfully; success message displayed", "High", "", ""],
    ["SQ-041", "Send quotation via Email with invalid email", "1. Review quotation\n2. Enter invalid email\n3. Click Send Email", "Email=invalidemail", "Validation error for invalid email format", "High", "", ""],
    ["SQ-042", "Send quotation via Email with multiple emails (comma separated)", "1. Review quotation\n2. Enter multiple emails comma-separated\n3. Send", "Email=a@b.com,c@d.com", "Email sent to all valid recipients", "Medium", "", ""],
    ["SQ-043", "Send quotation via WhatsApp", "1. Review quotation\n2. Click Send WhatsApp", "Valid mobile number", "WhatsApp message sent; success message or WhatsApp failure reason shown", "High", "", ""],
    ["SQ-044", "Send quotation via both Email and WhatsApp", "1. Review\n2. Click Send Both", "Valid email & mobile", "Both channels triggered; individual success/failure shown", "Medium", "", ""],
    ["SQ-045", "Download quotation as PDF", "1. Review quotation\n2. Click Download PDF", "Valid quotation", "PDF file downloaded with correct data, formatting, room details", "High", "", ""],
    ["SQ-046", "Back button from Review returns to form with data preserved", "1. Review quotation\n2. Click Back", "N/A", "Returns to create form with all previously entered data intact", "Medium", "", ""],
]

for test in sq_tests_section_e:
    add_data_row(ws_sq, r, test)
    r += 1

# --- Sheet 2: Free Hand Quotation ---
ws_fh = wb_q.create_sheet("Free Hand Quotation")
ws_fh.sheet_properties.tabColor = "C9A84C"
for i, w in enumerate(col_widths, 1):
    ws_fh.column_dimensions[get_column_letter(i)].width = w

r = 1
style_section_header(ws_fh, r, NUM_COLS, "FREE HAND QUOTATION — TEST CASES")
r = 2
style_section_header(ws_fh, r, NUM_COLS, "Section A: Form Load & UI Validation", "E8E4DE")
r = 3
for col, h in enumerate(HEADERS, 1):
    ws_fh.cell(row=r, column=col, value=h)
style_header(ws_fh, r, NUM_COLS)
r = 4

fh_tests_a = [
    ["FH-001", "Load Free Hand Quotation form", "1. Login\n2. Navigate to Quotation Management > New Free Hand Quotation", "Valid credentials", "Form loads with empty fields; Room Type map, Meal Plan map, Rate Type map populated", "High", "", ""],
    ["FH-002", "Verify Room Category is text-based (not dropdown ID)", "1. Open FH form\n2. Check Room Category field", "N/A", "Room Category should allow free text entry (roomCategoryName, not roomCategoryId)", "High", "", "Key difference from System Quotation"],
    ["FH-003", "Verify Total Price is manual entry", "1. Open FH form\n2. Check Total Price field per room row", "N/A", "User can manually type in price (not auto-calculated from session rates)", "High", "", "Key difference from System Quotation"],
    ["FH-004", "Verify Meal Plan dropdown", "1. Open form\n2. Check Meal Plan dropdown", "N/A", "Shows: EPAI, CPAI, MAPAI, APAI", "Medium", "", ""],
    ["FH-005", "Add multiple room rows", "1. Click Add Room multiple times", "N/A", "New room rows added dynamically", "Medium", "", ""],
]

for test in fh_tests_a:
    add_data_row(ws_fh, r, test)
    r += 1

r += 1
style_section_header(ws_fh, r, NUM_COLS, "Section B: Validation Logic", "E8E4DE")
r += 1
for col, h in enumerate(HEADERS, 1):
    ws_fh.cell(row=r, column=col, value=h)
style_header(ws_fh, r, NUM_COLS)
r += 1

fh_tests_b = [
    ["FH-006", "Submit with empty Room Category Name", "1. Add room\n2. Leave roomCategoryName blank\n3. Review", "roomCategoryName=empty", "Row filtered out (filter: roomCategoryName != null && not empty)", "High", "", ""],
    ["FH-007", "Submit with zero MealPlanId", "1. Add room\n2. Leave Meal Plan unselected\n3. Review", "MealPlanId=0", "Row filtered out (filter: mealPlanId > 0)", "High", "", ""],
    ["FH-008", "Submit Client audience with no guest selected", "1. Audience=Client, GuestId=0\n2. Review", "AudienceType=1, GuestId=0", "Error: contact.error", "High", "", ""],
    ["FH-009", "Submit Client audience with mismatched name", "1. Audience=Client, select client\n2. Change Guest Name\n3. Review", "GuestName != DB ClientName", "Error: contact.error", "High", "", ""],
    ["FH-010", "Check-in date in past", "1. Set CheckIn=yesterday\n2. Review", "CheckIn=past date", "Error: Check-in date cannot be in the past", "High", "", ""],
    ["FH-011", "Check-out before check-in", "1. Set CheckOut before CheckIn\n2. Review", "CheckOut < CheckIn", "Error: Check-out date must be same or after Check-in", "High", "", ""],
    ["FH-012", "Both dates null", "1. Leave both dates empty\n2. Review", "CheckIn=null, CheckOut=null", "Error: Check-in and Check-out dates are required", "High", "", ""],
    ["FH-013", "Adults=0 and Children=0", "1. Set Adults=0, NoOfChild=0\n2. Review", "Adults=0, NoOfChild=0", "Error: Guests must be greater than zero", "High", "", ""],
]

for test in fh_tests_b:
    add_data_row(ws_fh, r, test)
    r += 1

r += 1
style_section_header(ws_fh, r, NUM_COLS, "Section C: Pricing Logic (Manual)", "E8E4DE")
r += 1
for col, h in enumerate(HEADERS, 1):
    ws_fh.cell(row=r, column=col, value=h)
style_header(ws_fh, r, NUM_COLS)
r += 1

fh_tests_c = [
    ["FH-014", "Grand Total = sum of all rooms' manual TotalPrice", "1. Add 2 rooms\n2. Room1 TotalPrice=15000, Room2=20000\n3. Review", "Manual prices", "GrandTotal = 35000 (sum of each room's totalPrice)", "High", "", "No session rate lookup"],
    ["FH-015", "Room with TotalPrice=0", "1. Add room\n2. Set TotalPrice=0\n3. Review", "TotalPrice=0", "GrandTotal should include 0; no error", "Medium", "", ""],
    ["FH-016", "Meal Plan name auto-set on review", "1. Add room\n2. Select MealPlanId=3\n3. Review", "MealPlanId=3", "MealPlanName should show 'MAPAI' in review", "Medium", "", ""],
]

for test in fh_tests_c:
    add_data_row(ws_fh, r, test)
    r += 1

r += 1
style_section_header(ws_fh, r, NUM_COLS, "Section D: Review, Email, WhatsApp, PDF", "E8E4DE")
r += 1
for col, h in enumerate(HEADERS, 1):
    ws_fh.cell(row=r, column=col, value=h)
style_header(ws_fh, r, NUM_COLS)
r += 1

fh_tests_d = [
    ["FH-017", "Review page shows correct data", "1. Fill valid FH form\n2. Review", "Valid data", "Review page shows all room details and Grand Total", "High", "", ""],
    ["FH-018", "Send FH quotation via Email", "1. Review\n2. Enter valid email\n3. Send Email", "Valid email", "Email sent successfully", "High", "", ""],
    ["FH-019", "Send FH quotation via WhatsApp", "1. Review\n2. Click Send WhatsApp", "Valid mobile", "WhatsApp message sent or failure reason shown", "High", "", ""],
    ["FH-020", "Download FH quotation PDF", "1. Review\n2. Download PDF", "Valid quotation", "PDF generated with correct data", "High", "", ""],
    ["FH-021", "Invalid email format in FH email send", "1. Review\n2. Enter invalid email\n3. Send", "Email=notanemail", "Validation error", "High", "", ""],
    ["FH-022", "Multiple comma-separated emails", "1. Review\n2. Enter a@b.com, c@d.com\n3. Send", "Multiple valid emails", "Email sent to all recipients", "Medium", "", ""],
]

for test in fh_tests_d:
    add_data_row(ws_fh, r, test)
    r += 1

q_file = "/Users/sarthakjain/vistaluxhms_repository/base_vistaluxhms_repository/Quotation_Management_TestCases.xlsx"
wb_q.save(q_file)
print(f"✅ Saved: {q_file}")


# ========== EVENT MANAGEMENT ==========
wb_e = openpyxl.Workbook()

# --- Sheet 1: Event Quotation Creation ---
ws_e1 = wb_e.active
ws_e1.title = "Event Quotation Creation"
ws_e1.sheet_properties.tabColor = "1B2A3D"
for i, w in enumerate(col_widths, 1):
    ws_e1.column_dimensions[get_column_letter(i)].width = w

r = 1
style_section_header(ws_e1, r, NUM_COLS, "EVENT QUOTATION CREATION — TEST CASES")
r = 2
style_section_header(ws_e1, r, NUM_COLS, "Section A: Wizard Step 1 — Client & Event Details", "E8E4DE")
r = 3
for col, h in enumerate(HEADERS, 1):
    ws_e1.cell(row=r, column=col, value=h)
style_header(ws_e1, r, NUM_COLS)
r = 4

ev_tests_a = [
    ["EV-001", "Load Event Quotation Wizard Step 1", "1. Login\n2. Navigate to Event Management\n3. Click New Event Quotation", "Valid credentials", "Wizard Step 1 loads with Client fields, Event Type dropdown, Date pickers, Guest Count, Number of Rooms", "High", "", ""],
    ["EV-002", "Verify Event Type dropdown populates correctly", "1. Open Step 1\n2. Check Event Type dropdown", "Active event types in DB", "Shows all active event types (e.g., Wedding=1, MICE=2)", "High", "", ""],
    ["EV-003", "Client audience: submit with no client selected", "1. Audience=Client, GuestId=0\n2. Click Next", "AudienceType=1, GuestId=0", "Error: contact.error — client must be selected", "High", "", ""],
    ["EV-004", "Client audience: mismatched Guest Name", "1. Audience=Client, select client\n2. Change Guest Name\n3. Click Next", "GuestName != DB ClientName", "Error: contact.error", "High", "", ""],
    ["EV-005", "Client audience: correct selection auto-fills mobile & email", "1. Audience=Client\n2. Select valid client\n3. Click Next", "Valid client with mobile & email in DB", "Mobile and Email auto-populated from ClientEntity", "High", "", ""],
    ["EV-006", "Guest audience: submit with manual entry", "1. Audience=Guest\n2. Enter Name, Mobile, Email\n3. Click Next", "Name=TestEvent, Mobile=9876543210", "Proceeds to Step 2 without client validation", "High", "", ""],
    ["EV-007", "Event Start Date in the past", "1. Set Start Date = yesterday\n2. Click Next", "StartDate=yesterday", "Error: Start date should be today or a future date", "High", "", ""],
    ["EV-008", "Event End Date before Start Date", "1. Set EndDate before StartDate\n2. Click Next", "StartDate=tomorrow+1, EndDate=tomorrow", "Error: End date cannot be before the start date", "High", "", ""],
    ["EV-009", "Same day Start and End date", "1. Set StartDate=EndDate=tomorrow\n2. Click Next", "Same date", "Valid — totalNights=0, totalDays=1", "Medium", "", "Edge case"],
    ["EV-010", "Valid dates with multi-day event", "1. Set Start=Day1, End=Day3 (2-night event)\n2. Click Next", "StartDate=Day1, EndDate=Day3", "Proceeds to Step 2; totalNights=2, totalDays=3", "High", "", ""],
    ["EV-011", "Set base guest count to 0", "1. Set BaseGuestCount=0\n2. Click Next", "BaseGuestCount=0", "Proceed (but per-guest service costs will be 0)", "Medium", "", "Edge case"],
    ["EV-012", "Set number of rooms to 0", "1. Set NumberOfRooms=0\n2. Click Next", "NumberOfRooms=0", "Proceed (but per-room service costs will be 0)", "Medium", "", "Edge case"],
]

for test in ev_tests_a:
    add_data_row(ws_e1, r, test)
    r += 1

# Section B: Service Cost Calculations
r += 1
style_section_header(ws_e1, r, NUM_COLS, "Section B: Wizard Step 2 — Service Cost Calculations", "E8E4DE")
r += 1
for col, h in enumerate(HEADERS, 1):
    ws_e1.cell(row=r, column=col, value=h)
style_header(ws_e1, r, NUM_COLS)
r += 1

ev_tests_b = [
    ["EV-013", "PER_GUEST_PER_NIGHT cost calculation", "1. Create event (2 nights, 50 guests)\n2. Service with cost type PER_GUEST_PER_NIGHT, BaseCost=500", "Qty=50, CostPerUnit=500, Nights=2", "TotalCost = 50 × 500 × 2 = 50,000", "High", "", ""],
    ["EV-014", "PER_GUEST_ONE_TIME cost calculation", "1. Create event (2 nights, 50 guests)\n2. Service type PER_GUEST_ONE_TIME, BaseCost=200", "Qty=50, CostPerUnit=200", "TotalCost = 50 × 200 × 1 = 10,000", "High", "", ""],
    ["EV-015", "PER_GUEST_PER_DAY cost calculation", "1. Create event (2 nights = 3 days, 50 guests)\n2. Service type PER_GUEST_PER_DAY, BaseCost=300", "Qty=50, CostPerUnit=300, Days=3", "TotalCost = 50 × 300 × 3 = 45,000", "High", "", ""],
    ["EV-016", "PER_ROOM_ONE_TIME cost calculation", "1. Create event (10 rooms)\n2. Service type PER_ROOM_ONE_TIME, BaseCost=1000", "Qty=10, CostPerUnit=1000", "TotalCost = 10 × 1000 × 1 = 10,000", "High", "", ""],
    ["EV-017", "PER_ROOM_PER_NIGHT cost calculation", "1. Create event (10 rooms, 3 nights)\n2. Service type PER_ROOM_PER_NIGHT, BaseCost=2000", "Qty=10, CostPerUnit=2000, Nights=3", "TotalCost = 10 × 2000 × 3 = 60,000", "High", "", ""],
    ["EV-018", "PER_DAY cost calculation", "1. Create event (2 nights = 3 days)\n2. Service type PER_DAY, BaseCost=5000", "Qty=1, CostPerUnit=5000, Days=3", "TotalCost = 1 × 5000 × 3 = 15,000", "High", "", ""],
    ["EV-019", "PER_NIGHT cost calculation", "1. Create event (3 nights)\n2. Service type PER_NIGHT, BaseCost=8000", "Qty=3, CostPerUnit=8000, Nights=3", "TotalCost = 3 × 8000 × 3 = 72,000", "High", "", ""],
    ["EV-020", "ONE_TIME cost calculation", "1. Service type ONE_TIME, BaseCost=25000", "Qty=1, CostPerUnit=25000", "TotalCost = 1 × 25000 × 1 = 25,000", "High", "", ""],
    ["EV-021", "Grand Total = sum of all services", "1. Add multiple services of different types\n2. Check Grand Total", "Service1=50000, Service2=10000, Service3=15000", "GrandTotal = 75,000", "High", "", ""],
    ["EV-022", "Service with unknown cost type", "1. Service has undefined cost type in DB", "costTypeName=INVALID_TYPE", "No calculation; prints 'Unknown cost type' to console", "Low", "", "Edge case"],
]

for test in ev_tests_b:
    add_data_row(ws_e1, r, test)
    r += 1

# Section C: Recalculate
r += 1
style_section_header(ws_e1, r, NUM_COLS, "Section C: Recalculate Functionality", "E8E4DE")
r += 1
for col, h in enumerate(HEADERS, 1):
    ws_e1.cell(row=r, column=col, value=h)
style_header(ws_e1, r, NUM_COLS)
r += 1

ev_tests_c = [
    ["EV-023", "Recalculate after changing guest count", "1. Open Step 2\n2. Change quantity on a PER_GUEST service\n3. Click Recalculate", "Changed qty from 50 to 100", "TotalCost recalculated with new qty; Grand Total updated", "High", "", ""],
    ["EV-024", "Recalculate after changing cost per unit", "1. Change CostPerUnit on a service\n2. Click Recalculate", "Changed CostPerUnit from 500 to 800", "TotalCost = newQty × 800 × nights/days", "High", "", ""],
    ["EV-025", "Recalculate after changing event dates", "1. Change Start/End dates\n2. Click Recalculate", "Change from 2 nights to 5 nights", "All PER_NIGHT/PER_DAY services recalculated with new duration", "High", "", ""],
    ["EV-026", "Recalculate with Show Breakup + Hide Cost both checked", "1. Check both Show Breakup and Hide Cost\n2. Click Recalculate", "showBreakup=true, hideCost=true", "Error: Please select either Show Breakup OR Hide Cost, not both", "High", "", "Mutual exclusion validation"],
    ["EV-027", "Recalculate with empty service name filtered out", "1. Have a service row with empty name\n2. Click Recalculate", "ServiceName=empty", "Empty rows filtered out from final services list", "Medium", "", ""],
    ["EV-028", "Recalculate with invalid dates", "1. Set End date before Start date\n2. Click Recalculate", "EndDate < StartDate", "Error: End date cannot be before the start date; recalculation stopped", "High", "", ""],
]

for test in ev_tests_c:
    add_data_row(ws_e1, r, test)
    r += 1

# Section D: Save & Edit
r += 1
style_section_header(ws_e1, r, NUM_COLS, "Section D: Save, Edit, PDF, Email Actions", "E8E4DE")
r += 1
for col, h in enumerate(HEADERS, 1):
    ws_e1.cell(row=r, column=col, value=h)
style_header(ws_e1, r, NUM_COLS)
r += 1

ev_tests_d = [
    ["EV-029", "Save event quotation with valid data", "1. Complete Step 1 & 2\n2. Click Save", "All valid data", "Record saved; redirects to event list with success message", "High", "", ""],
    ["EV-030", "Save event quotation with invalid dates", "1. Set invalid dates\n2. Click Save", "EndDate < StartDate", "Error displayed; not saved", "High", "", ""],
    ["EV-031", "Save event with discount applied", "1. Set Discount value\n2. Save", "Discount=5000", "Discount stored in entity; grand_total_cost not affected by discount at save time", "Medium", "", ""],
    ["EV-032", "Save event with GST included flag", "1. Check GST Included\n2. Save", "gstIncluded=true", "Flag saved correctly in DB", "Medium", "", ""],
    ["EV-033", "Save event with Hide Cost flag", "1. Check Hide Cost\n2. Save", "hideCost=true", "Flag saved correctly; PDF should hide cost column", "Medium", "", ""],
    ["EV-034", "Save event with Show Breakup flag", "1. Check Show Breakup\n2. Save", "showBreakup=true", "Flag saved correctly", "Medium", "", ""],
    ["EV-035", "Edit existing event quotation", "1. Open saved event\n2. Change guest count & dates\n3. Click Update", "Modified data", "Event package updated; services synced; success message shown", "High", "", ""],
    ["EV-036", "Delete a service row from event", "1. Open event Step 2\n2. Delete a service row\n3. Recalculate/Save", "Service deleted", "Service removed; Grand Total recalculated without it", "Medium", "", ""],
    ["EV-037", "Download Event Quotation PDF", "1. Open event\n2. Click Download PDF", "Valid event", "PDF generated with services, costs, event details", "High", "", ""],
    ["EV-038", "Send Event Quotation via Email", "1. Open event\n2. Enter valid email\n3. Click Send Email", "Valid email", "Email sent with event quotation; success message", "High", "", ""],
    ["EV-039", "Send Event Email with invalid email", "1. Enter invalid email\n2. Click Send", "Email=notanemail", "Validation error for invalid email format", "High", "", ""],
    ["EV-040", "Send Event Email with multiple recipients", "1. Enter a@b.com,c@d.com\n2. Send", "Multiple emails", "Email sent to all valid recipients", "Medium", "", ""],
]

for test in ev_tests_d:
    add_data_row(ws_e1, r, test)
    r += 1

# --- Sheet 2: Event Master Services ---
ws_e2 = wb_e.create_sheet("Master Services Management")
ws_e2.sheet_properties.tabColor = "C9A84C"
for i, w in enumerate(col_widths, 1):
    ws_e2.column_dimensions[get_column_letter(i)].width = w

r = 1
style_section_header(ws_e2, r, NUM_COLS, "EVENT MASTER SERVICES — TEST CASES")
r = 2
for col, h in enumerate(HEADERS, 1):
    ws_e2.cell(row=r, column=col, value=h)
style_header(ws_e2, r, NUM_COLS)
r = 3

ev_ms_tests = [
    ["MS-001", "Load Add Master Service form", "1. Navigate to Event Management > Master Services\n2. Click Add", "N/A", "Form loads with fields: Name, Cost Type dropdown, Base Cost, Event Type, Active flag", "High", "", ""],
    ["MS-002", "Create a new master service", "1. Fill Name, CostType, BaseCost, EventType\n2. Save", "Name=DJ Setup, CostType=ONE_TIME, BaseCost=25000", "Service saved; appears in list", "High", "", ""],
    ["MS-003", "Edit an existing master service", "1. Open existing service\n2. Change BaseCost\n3. Save", "BaseCost changed from 25000 to 30000", "Service updated in DB", "High", "", ""],
    ["MS-004", "View master service details", "1. Click on a service name", "N/A", "Details page shows all field values", "Medium", "", ""],
    ["MS-005", "View rooms/venues list", "1. Navigate to Rooms/Venues list", "N/A", "All rooms/venues listed", "Medium", "", ""],
    ["MS-006", "Deactivate a master service", "1. Edit service\n2. Set Active=false\n3. Save", "Active=false", "Service no longer appears in active quotation service lists", "High", "", ""],
    ["MS-007", "Create service without name", "1. Leave Name blank\n2. Save", "Name=empty", "Validation error", "High", "", ""],
    ["MS-008", "Create service with BaseCost=0", "1. Set BaseCost=0\n2. Save", "BaseCost=0", "Service saved; calculations will produce 0 costs when used", "Medium", "", "Edge case"],
]

for test in ev_ms_tests:
    add_data_row(ws_e2, r, test)
    r += 1

# --- Sheet 3: Event List & Filtering ---
ws_e3 = wb_e.create_sheet("Event List & Filtering")
ws_e3.sheet_properties.tabColor = "7C2D3E"
for i, w in enumerate(col_widths, 1):
    ws_e3.column_dimensions[get_column_letter(i)].width = w

r = 1
style_section_header(ws_e3, r, NUM_COLS, "EVENT LIST & FILTERING — TEST CASES")
r = 2
for col, h in enumerate(HEADERS, 1):
    ws_e3.cell(row=r, column=col, value=h)
style_header(ws_e3, r, NUM_COLS)
r = 3

ev_list_tests = [
    ["EL-001", "Load event list page", "1. Navigate to Event Management\n2. View Events list", "N/A", "Paginated list of events loads; default page size applied", "High", "", ""],
    ["EL-002", "Filter events by Event Type", "1. Select Event Type filter\n2. Apply", "EventTypeId=1 (Wedding)", "Only wedding events shown", "High", "", ""],
    ["EL-003", "Filter events by date range", "1. Set Date Range filter\n2. Apply", "Start=01-01-2026, End=31-01-2026", "Only events within that range shown", "Medium", "", ""],
    ["EL-004", "Pagination works correctly", "1. Create >20 events\n2. Navigate to page 2", "20+ events", "Page 2 shows next set of events", "Medium", "", ""],
    ["EL-005", "Sort events by ID", "1. Click Sort by ID", "N/A", "Events sorted by ID ascending/descending", "Low", "", ""],
    ["EL-006", "Delete image from event", "1. Open event with images\n2. Click delete on an image", "Valid image ID", "Image deleted; event updated", "Medium", "", ""],
]

for test in ev_list_tests:
    add_data_row(ws_e3, r, test)
    r += 1

e_file = "/Users/sarthakjain/vistaluxhms_repository/base_vistaluxhms_repository/Event_Management_TestCases.xlsx"
wb_e.save(e_file)
print(f"✅ Saved: {e_file}")
print("\n🎉 Both test case Excel files generated successfully!")
