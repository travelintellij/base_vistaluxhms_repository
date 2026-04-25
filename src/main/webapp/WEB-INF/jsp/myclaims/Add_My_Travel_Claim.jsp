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
       }

        .form-container {
            width: 700px;
            max-width: 95%;
            margin: 0 auto;
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
            display: inline-block;
            font-size: 15px !important;
            color: #333;
        }

        .field-container {
            width: 430px !important;
            min-width: 430px !important;
            flex: 0 0 430px !important;
            display: flex;
            flex-direction: column;
        }

        .field-container input,
        .field-container select,
        .field-container textarea,
        .field-container .date-input {
            width: 100% !important;
            padding: 8px 12px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            height: 38px;
        }

        .field-container textarea {
            height: auto !important;
            min-height: 100px !important;
        }

       .date-input:focus {
           border-color: #3399ff;
           box-shadow: 0 0 3px rgba(51, 153, 255, 0.5);
       }

       /* ---------- TEXTAREA ---------- */
       .form-row textarea {
           resize: vertical;
       }

       /* ---------- FILE INPUT ROW ---------- */
       .file-input-row {
           display: flex;
           gap: 10px;
           margin-bottom: 5px;
       }

       /* ---------- TABLE (BILLS) ---------- */
       table {
           border-collapse: collapse;
           width: 67%;
       }

       th, td {
           border: 1px solid #ccc;
           padding: 6px;
           text-align: center;
       }

       /* ---------- BUTTONS ---------- */
       .button-container {
           display: flex;
           gap: 10px;
           margin-top: 15px;
       }

       /* Make both buttons identical */
       .button-container input[type="submit"],
       .button-container input[type="button"] {
           padding: 8px 18px;
           font-size: 13px;
           font-weight: 600;

           background: linear-gradient(135deg, #C9A84C, #B8963F);
           color: #fff;

           border: none;
           border-radius: 8px;
           cursor: pointer;
       }

       /* Hover effect */
       .button-container input:hover {
           background: linear-gradient(135deg, #B8963F, #A8842E);
       }

       /* ---------- OPTIONAL: APPROVER SECTION (if keeping 2-column) ---------- */
       .two-columns {
           display: flex;
           gap: 20px;
       }

       .claimant-section {
           flex: 2;
       }

       .approver-section {
           flex: 1;
           background: #e6f2ff;
           padding: 10px;
           border-left: 1px solid #ccc;
       }



</style>

<div class="form-container-wrapper" style="background: transparent !important;">
    <div class="form-container">
        <h2>Submit Travel Claim</h2>
        <form:form method="post" action="create_create_my_travel_claim" modelAttribute="MY_TRAVEL_CLAIMS_OBJ" enctype="multipart/form-data">

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
                <label for="expenseStartDate">Expense Start Date:</label>
                <div class="field-container">
                    <form:input path="expenseStartDate" type="date" required="required" class="date-input"/>
                    <font color="red"><form:errors path="expenseStartDate" cssClass="error"/></font>
                </div>
            </div>

            <div class="form-row">
                <label for="expenseEndDate">Expense End Date:</label>
                <div class="field-container">
                    <form:input path="expenseEndDate" type="date" class="date-input"/>
                    <font color="red"><form:errors path="expenseEndDate" cssClass="error"/></font>
                </div>
            </div>

            <div class="form-row">
                <label for="claimDetails">Claim Details:</label>
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
                <label for="travelExpense">Travel Expense:</label>
                <div class="field-container">
                    <form:input path="travelExpense" type="number" min="0" required="required" />
                    <font color="red"><form:errors path="travelExpense" cssClass="error"/></font>
                </div>
            </div>

            <div class="form-row">
                <label for="foodExpense">Food Expense:</label>
                <div class="field-container">
                    <form:input path="foodExpense" type="number" min="0" required="required" />
                    <font color="red"><form:errors path="foodExpense" cssClass="error"/></font>
                </div>
            </div>

            <div class="form-row">
                <label for="parkingExpense">Parking Expense:</label>
                <div class="field-container">
                    <form:input path="parkingExpense" type="number" min="0" required="required" />
                    <font color="red"><form:errors path="parkingExpense" cssClass="error"/></font>
                </div>
            </div>

            <div class="form-row">
                <label for="otherExpense1">Other Expense 1:</label>
                <div class="field-container">
                    <form:input path="otherExpense1" type="number" placeholder="Enter other expense 1" min="0" required="required"/>
                    <font color="red"><form:errors path="otherExpense1" cssClass="error"/></font>
                </div>
            </div>

            <div class="form-row">
                <label for="otherExpense2">Other Expense 2:</label>
                <div class="field-container">
                    <form:input path="otherExpense2" type="number" placeholder="Enter other expense 2" min="0" required="required"/>
                    <font color="red"><form:errors path="otherExpense2" cssClass="error"/></font>
                </div>
            </div>

            <div class="form-row">
                <label for="otherExpense3">Other Expense 3:</label>
                <div class="field-container">
                    <form:input path="otherExpense3" type="number" placeholder="Enter other expense 3" min="0" required="required"/>
                    <font color="red"><form:errors path="otherExpense3" cssClass="error"/></font>
                </div>
            </div>

            <div class="form-row">
                <label for="otherExpensesDetails">Other Expenses Details:</label>
                <div class="field-container">
                    <form:textarea path="otherExpensesDetails" maxlength="500" rows="3" placeholder="Enter other expense details"/>
                    <font color="red"><form:errors path="otherExpensesDetails" cssClass="error"/></font>
                </div>
            </div>
        <font color="red"><form:errors path="bills" cssClass="error"/></font>
          <div class="form-row" style="align-items: flex-start;">
              <label for="bills">Upload Bills:</label>
              <div class="field-container" style="height: auto;">
                  <div id="file-inputs">
                      <div class="file-input-row" style="display: flex; gap: 10px; width: 100%;">
                          <input type="file" name="bills" style="flex: 1; height: 38px; border: 1px solid #ccc; border-radius: 4px; padding: 4px; box-sizing: border-box;"/>
                          <button type="button" onclick="removeFileInput(this)" style="padding: 8px 12px; background: #ff4d4d; color: white; border: none; border-radius: 4px; cursor: pointer; height: 38px;">Remove</button>
                      </div>
                  </div>
                  <button type="button" onclick="addFileInput()" style="padding: 8px 12px; background: #6c757d; color: white; border: none; border-radius: 4px; cursor: pointer; align-self: flex-start; margin-top: 8px;">+ Add Another File</button>
              </div>
          </div>



            <div class="button-container">
                <input type="submit" value="Submit Claim" />
                <a href="view_travel_claim_list?view_travelclaimlist"><input type="button" class="clear-filter-btn" value="View Claims List"></input></a>
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
                removeFileInput(removeBtn);
            };

            wrapper.appendChild(newInput);
            wrapper.appendChild(removeBtn);

            container.appendChild(wrapper);
        }

        function removeFileInput(button) {
            const wrapper = button.parentElement;
            wrapper.remove();
        }
</script>

<jsp:include page="../footer.jsp" />
