"""
Generate BLANK test case Excel templates for each Sales Management feature.
Each file has only styled column headers — ready for manual test case entry.
"""
import os, sys

for subdir in os.listdir("/tmp/testcase_venv/lib"):
    sp = f"/tmp/testcase_venv/lib/{subdir}/site-packages"
    if os.path.isdir(sp):
        sys.path.insert(0, sp)

from openpyxl import Workbook
from openpyxl.styles import Font, PatternFill, Alignment, Border, Side
from openpyxl.utils import get_column_letter

# ── Styles ──
HEADER_FILL = PatternFill(start_color="1F4E79", end_color="1F4E79", fill_type="solid")
HEADER_FONT = Font(name="Calibri", bold=True, color="FFFFFF", size=11)
THIN_BORDER = Border(
    left=Side(style="thin"), right=Side(style="thin"),
    top=Side(style="thin"), bottom=Side(style="thin"),
)

HEADERS = [
    "TC ID",
    "Category",
    "Priority",
    "Test Case Title",
    "Pre-Conditions",
    "Test Steps",
    "Test Data",
    "Expected Result",
    "Actual Result",
    "Status (Pass/Fail/Blocked)",
    "Remarks",
]

COL_WIDTHS = [12, 22, 12, 42, 30, 48, 38, 48, 40, 18, 28]


def create_blank_template(filepath, sheet_title, feature_label):
    """Create a professionally styled blank test case Excel with header row only."""
    wb = Workbook()
    ws = wb.active
    ws.title = sheet_title
    ws.freeze_panes = "A2"
    ws.auto_filter.ref = f"A1:{get_column_letter(len(HEADERS))}1"

    # ── Title / info row (Row 1 — merged) ──
    ws.merge_cells(start_row=1, start_column=1, end_row=1, end_column=len(HEADERS))
    title_cell = ws.cell(row=1, column=1, value=f"Test Cases — {feature_label}  |  Module: Sales Management  |  Application: AxisHMS Pro CRM")
    title_cell.fill = PatternFill(start_color="0D3B66", end_color="0D3B66", fill_type="solid")
    title_cell.font = Font(name="Calibri", bold=True, color="FFFFFF", size=13)
    title_cell.alignment = Alignment(horizontal="center", vertical="center")
    title_cell.border = THIN_BORDER
    ws.row_dimensions[1].height = 32

    # ── Column headers (Row 2) ──
    for c, header in enumerate(HEADERS, 1):
        cell = ws.cell(row=2, column=c, value=header)
        cell.fill = HEADER_FILL
        cell.font = HEADER_FONT
        cell.alignment = Alignment(horizontal="center", vertical="center", wrap_text=True)
        cell.border = THIN_BORDER

    ws.row_dimensions[2].height = 28

    # ── Column widths ──
    for c, w in enumerate(COL_WIDTHS, 1):
        ws.column_dimensions[get_column_letter(c)].width = w

    # ── Pre-format 50 empty data rows with borders & alignment ──
    DATA_FONT = Font(name="Calibri", size=10)
    for row in range(3, 53):
        for c in range(1, len(HEADERS) + 1):
            cell = ws.cell(row=row, column=c)
            cell.font = DATA_FONT
            cell.alignment = Alignment(wrap_text=True, vertical="top")
            cell.border = THIN_BORDER
            # Priority column — add data validation
            if c == 3:
                cell.alignment = Alignment(horizontal="center", vertical="top")

    # ── Data validation for Priority column (C3:C52) ──
    from openpyxl.worksheet.datavalidation import DataValidation
    priority_dv = DataValidation(
        type="list",
        formula1='"Critical,High,Medium,Low"',
        showDropDown=False,
        errorTitle="Invalid Priority",
        error="Please select: Critical, High, Medium, or Low"
    )
    priority_dv.sqref = f"C3:C52"
    ws.add_data_validation(priority_dv)

    # ── Data validation for Status column (J3:J52) ──
    status_dv = DataValidation(
        type="list",
        formula1='"Pass,Fail,Blocked,Not Tested"',
        showDropDown=False,
        errorTitle="Invalid Status",
        error="Please select: Pass, Fail, Blocked, or Not Tested"
    )
    status_dv.sqref = f"J3:J52"
    ws.add_data_validation(status_dv)

    wb.save(filepath)
    print(f"  ✅  {filepath}")


# ═══════════════════════════════════════════════════════════════════════
#  Create files for each Sales Management feature
# ═══════════════════════════════════════════════════════════════════════
OUTPUT_DIR = "/Users/sarthakjain/vistaluxhms_repository/base_vistaluxhms_repository/test_cases"

features = [
    {
        "filename": "Rate_Type_Test_Cases.xlsx",
        "sheet": "Rate Type",
        "label": "Rate Type (Add / Edit / Manage)",
    },
    {
        "filename": "Sales_Partner_Test_Cases.xlsx",
        "sheet": "Sales Partner",
        "label": "Sales Partner (Add / Edit / Manage)",
    },
    {
        "filename": "Master_Rooms_Test_Cases.xlsx",
        "sheet": "Master Rooms",
        "label": "Master Rooms Management (Add / Edit / Manage)",
    },
]

print(f"\n📂  Output folder: {OUTPUT_DIR}\n")
for feat in features:
    create_blank_template(
        filepath=os.path.join(OUTPUT_DIR, feat["filename"]),
        sheet_title=feat["sheet"],
        feature_label=feat["label"],
    )

print(f"\n📊  Created {len(features)} blank test case templates")
print("    Each file has: styled headers, freeze panes, auto-filter,")
print("    Priority dropdown (Critical/High/Medium/Low),")
print("    Status dropdown (Pass/Fail/Blocked/Not Tested),")
print("    and 50 pre-formatted rows ready for manual entry.\n")
