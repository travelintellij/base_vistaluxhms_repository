<jsp:include page="../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">

<style>
    body {
        background-image: url('<%= request.getContextPath() %>/resources/images/ratetypeadd.jpg');
        background-size: cover;
        background-position: center;
        background-attachment: fixed;
        height: 100vh;
        position: relative;
        opacity: .98;
    }

    body::after {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: rgba(255, 255, 255, 0.3);
        z-index: -1;
    }

    /* ---------- FORM CONTAINER ---------- */
    .form-container-wrapper {
        background: transparent !important;
        display: flex;
        justify-content: center;
        padding-top: 20px;
    }

    .form-container {
        width: 95%;
        max-width: 1200px;
        background: rgba(255, 255, 255, 0.9) !important;
        padding: 20px;
        border-radius: 12px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.1);
    }

    /* ---------- TWO COLUMNS LAYOUT ---------- */
    .two-columns {
        display: flex;
        gap: 20px;
    }

    .claimant-section {
        flex: 1.5;
    }

    .approver-section {
        flex: 1;
        background: #f0f7ff;
        padding: 20px;
        border-radius: 8px;
        border-left: 4px solid #3399ff;
    }

    /* ---------- FORM ROW ALIGNMENT ---------- */
    .form-row {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 8px;
    }

    .form-row label {
        width: 180px !important;
        min-width: 180px !important;
        flex: 0 0 180px !important;
        font-weight: 700 !important;
        color: #1B2A3D;
        display: inline-block;
        font-size: 15px !important;
    }

    .field-container {
        width: 380px !important;
        min-width: 380px !important;
        flex: 0 0 380px !important;
        display: flex;
        flex-direction: column;
    }

    /* ---------- INPUTS / SELECT / TEXTAREA ---------- */
    .form-row input,
    .form-row select,
    .form-row textarea,
    .date-input {
        width: 100% !important;
        padding: 8px 12px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
        height: 38px;
    }

    .form-row textarea {
        height: auto;
        min-height: 80px;
    }



    /* ---------- TABLE (BILLS) ---------- */
    .bills-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
        background: white;
    }

    .bills-table th, .bills-table td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: center;
        font-size: 13px;
    }

    .bills-table th {
        background-color: #1B2A3D;
        color: white;
    }

    /* ---------- BUTTONS ---------- */
    .button-container {
        display: flex;
        gap: 15px;
        margin-top: 25px;
        padding-top: 15px;
        border-top: 1px solid #eee;
    }

    .btn-submit {
        padding: 10px 25px;
        font-size: 14px;
        font-weight: 600;
        background: linear-gradient(135deg, #1B2A3D, #2c3e50);
        color: #fff;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        transition: all 0.3s;
    }

    .btn-submit:hover {
        background: linear-gradient(135deg, #C9A84C, #B8963F);
        transform: translateY(-1px);
    }

    .btn-view {
        padding: 10px 25px;
        background: #eee;
        color: #333;
        text-decoration: none;
        border-radius: 8px;
        font-weight: 600;
        font-size: 14px;
        display: inline-block;
        border: 1px solid #ccc;
    }

    .btn-view:hover {
        background: #ddd;
    }

    h2, h3 {
        color: #1B2A3D;
        border-bottom: 2px solid #C9A84C;
        padding-bottom: 8px;
        margin-bottom: 20px;
    }

    /* Force date inputs to behave like normal inputs */
    .form-row input[type="date"] {
        width: 67%;
        padding: 8px 12px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
        display: block;
    }

    /* Optional: remove browser weird spacing */
    .form-row input[type="date"]::-webkit-calendar-picker-indicator {
        margin: 0;
    }

</style>

<div class="form-container-wrapper">
<div class="form-container">
<form:form method="post" action="edit_edit_my_travel_claim" modelAttribute="MY_TRAVEL_CLAIMS_OBJ" enctype="multipart/form-data">
  <div class="two-columns">
    <!-- LEFT SIDE: CLAIMANT INFO -->
    <div class="claimant-section">
        <h2>Edit Travel Claim <span style="font-size: 14px; color: #666; float: right;">ID: ${MY_TRAVEL_CLAIMS_OBJ.travelClaimId}</span></h2>
        <form:hidden path="travelClaimId" />
        
        <div class="form-row">
            <label for="source">Source:</label>
            <div class="field-container">
                <form:input path="source" placeholder="Enter source" required="required"/>
                <font color="red"><form:errors path="source" cssClass="error"/></font>
            </div>
        </div>

        <div class="form-row">
            <label for="destination">Destination:</label>
            <div class="field-container">
                <form:input path="destination" placeholder="Enter destination" required="required"/>
                <font color="red"><form:errors path="destination" cssClass="error"/></font>
            </div>
        </div>

        <div class="form-row">
            <label for="expenseStartDate">Exp Start Date:</label>
            <div class="field-container">
                <form:input path="expenseStartDate" type="date" required="required" class="date-input"/>
                <font color="red"><form:errors path="expenseStartDate" cssClass="error"/></font>
            </div>
        </div>

        <div class="form-row">
            <label for="expenseEndDate">Exp End Date:</label>
            <div class="field-container">
                <form:input path="expenseEndDate" type="date" class="date-input"/>
                <font color="red"><form:errors path="expenseEndDate" cssClass="error"/></font>
            </div>
        </div>

        <div class="form-row">
            <label for="claimDetails">Details:</label>
            <div class="field-container">
                <form:textarea path="claimDetails" maxlength="500" rows="3" placeholder="Enter claim details"/>
                <font color="red"><form:errors path="claimDetails" cssClass="error"/></font>
            </div>
        </div>

        <div class="form-row">
            <label for="kms">Kilometers:</label>
            <div class="field-container">
                <form:input path="kms" type="number" min="0" required="required" />
                <font color="red"><form:errors path="kms" cssClass="error"/></font>
            </div>
        </div>

        <div class="form-row">
            <label for="travelMode">Travel Mode:</label>
            <div class="field-container">
                <form:select path="travelMode">
                    <form:options items="${CLAIM_TRAVEL_MODE}" />
                </form:select>
                <font color="red"><form:errors path="travelMode" cssClass="error"/></font>
            </div>
        </div>

        <div class="form-row">
            <label for="travelExpense">Travel Exp:</label>
            <div class="field-container">
                <form:input path="travelExpense" type="number" min="0" required="required" />
                <font color="red"><form:errors path="travelExpense" cssClass="error"/></font>
            </div>
        </div>

        <div class="form-row">
            <label for="foodExpense">Food Exp:</label>
            <div class="field-container">
                <form:input path="foodExpense" type="number" min="0" required="required" />
                <font color="red"><form:errors path="foodExpense" cssClass="error"/></font>
            </div>
        </div>

        <div class="form-row">
            <label for="parkingExpense">Parking Exp:</label>
            <div class="field-container">
                <form:input path="parkingExpense" type="number" min="0" />
                <font color="red"><form:errors path="parkingExpense" cssClass="error"/></font>
            </div>
        </div>

        <div class="form-row">
            <label for="otherExpense1">Other Expense 1:</label>
            <div class="field-container">
                <form:input path="otherExpense1" type="number" placeholder="Enter other expense 1" min="0" required="required" />
                <font color="red"><form:errors path="otherExpense1" cssClass="error"/></font>
            </div>
        </div>

        <div class="form-row">
            <label for="otherExpense2">Other Expense 2:</label>
            <div class="field-container">
                <form:input path="otherExpense2" type="number" placeholder="Enter other expense 2" min="0" required="required" />
                <font color="red"><form:errors path="otherExpense2" cssClass="error"/></font>
            </div>
        </div>

        <div class="form-row">
            <label for="otherExpense3">Other Expense 3:</label>
            <div class="field-container">
                <form:input path="otherExpense3" type="number" placeholder="Enter other expense 3" min="0" required="required" />
                <font color="red"><form:errors path="otherExpense3" cssClass="error"/></font>
            </div>
        </div>

        <div class="form-row">
            <label for="otherExpensesDetails">Other Details:</label>
            <div class="field-container">
                <form:textarea path="otherExpensesDetails" maxlength="500" rows="2" placeholder="Enter other details"/>
            </div>
        </div>

        <div class="form-row" style="align-items: flex-start;">
            <label>Existing Bills:</label>
            <div style="width: 67%;">
                <table class="bills-table">
                    <thead>
                        <tr>
                            <th>File Name</th>
                            <th>Action</th>
                            <th>Remove?</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${MY_TRAVEL_CLAIMS_OBJ.billsEntity}" var="bill">
                            <tr>
                                <td>${bill.fileName}</td>
                                <td><a href="${pageContext.request.contextPath}/travel-claim/bill/${bill.id}" target="_blank" style="color: #3399ff;">View</a></td>
                                <td><input type="checkbox" name="deleteBillIds" value="${bill.id}" /></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="form-row" style="margin-top: 15px; align-items: flex-start;">
            <label>Upload New:</label>
            <div style="flex: 1; display: flex; flex-direction: column; gap: 8px;">
                <div id="file-inputs">
                    <div class="file-input-row" style="display: flex; gap: 10px; width: 100%;">
                        <input type="file" name="bills" style="flex: 1; height: 38px; border: 1px solid #ccc; border-radius: 4px; padding: 4px;" />
                        <button type="button" onclick="removeFileInput(this)" style="padding: 8px 12px; background: #ff4d4d; color: white; border: none; border-radius: 4px; cursor: pointer;">Remove</button>
                    </div>
                </div>
                <button type="button" onclick="addFileInput()" style="padding: 8px 12px; background: #6c757d; color: white; border: none; border-radius: 4px; cursor: pointer; align-self: flex-start;">+ Add Another File</button>
            </div>
        </div>

        <div class="button-container">
            <input type="submit" value="Update Claim" class="btn-submit" />
            <a href="view_travel_claim_list?view_travelclaimlist" class="btn-view">View Claims List</a>
        </div>
    </div>

    <!-- RIGHT SIDE: APPROVER ACTIONS -->
    <div class="approver-section">
        <h3>Approver Actions</h3>
        <sec:authorize access="hasAnyRole('ROLE_SUPERADMIN', 'ROLE_EXPENSE_APPROVER')">
            <div class="form-row" style="flex-direction: column; align-items: flex-start;">
                <label>Update Status:</label>
                <form:select path="claimStatus" style="width: 100%;">
                    <form:options items="${TRAV_EXP_STATUS_MAP}" />
                </form:select>
            </div>
            <div class="form-row" style="flex-direction: column; align-items: flex-start; margin-top: 15px;">
                <label>Remarks:</label>
                <form:textarea path="approverRemarks" rows="6" maxlength="1000" style="width: 100%;" />
            </div>
        </sec:authorize>
        
        <sec:authorize access="! hasAnyRole('ROLE_SUPERADMIN', 'ROLE_EXPENSE_APPROVER')">
            <div class="form-row">
                <label style="width: auto;">Status:</label>
                <span style="font-weight: 600; color: #3399ff;">${MY_TRAVEL_CLAIMS_OBJ.statusName}</span>
            </div>
            <div class="form-row" style="flex-direction: column; align-items: flex-start; margin-top: 10px;">
                <label>Remarks:</label>
                <div style="width: 100%; background: #fff; padding: 10px; border: 1px solid #ddd; border-radius: 4px; min-height: 100px;">
                    ${MY_TRAVEL_CLAIMS_OBJ.approverRemarks}
                </div>
            </div>
        </sec:authorize>
    </div>
  </div>
</form:form>
</div>
</div>

<script language="JavaScript">
    function addFileInput() {
        const container = document.getElementById("file-inputs");
        const wrapper = document.createElement("div");
        wrapper.className = "file-input-row";
        wrapper.style.display = "flex";
        wrapper.style.gap = "10px";
        wrapper.style.width = "100%";
        wrapper.style.marginTop = "8px";

        const newInput = document.createElement("input");
        newInput.type = "file";
        newInput.name = "bills";
        newInput.style.flex = "1";
        newInput.style.height = "38px";
        newInput.style.border = "1px solid #ccc";
        newInput.style.borderRadius = "4px";
        newInput.style.padding = "4px";

        const removeBtn = document.createElement("button");
        removeBtn.type = "button";
        removeBtn.innerText = "Remove";
        removeBtn.style.padding = "8px 12px";
        removeBtn.style.background = "#ff4d4d";
        removeBtn.style.color = "white";
        removeBtn.style.border = "none";
        removeBtn.style.borderRadius = "4px";
        removeBtn.style.cursor = "pointer";
        removeBtn.onclick = function () {
            wrapper.remove();
        };

        wrapper.appendChild(newInput);
        wrapper.appendChild(removeBtn);
        container.appendChild(wrapper);
    }

    function removeFileInput(button) {
        button.parentElement.remove();
    }
</script>

<jsp:include page="../footer.jsp" />
