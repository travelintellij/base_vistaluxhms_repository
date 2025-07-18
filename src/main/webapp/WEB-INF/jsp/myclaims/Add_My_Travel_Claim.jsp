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

    body {
        opacity: .98;
    }
    .date-input {
        height: 40px; /* taller than default (~20px) */
        padding: 5px 10px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 4px;
        outline: none;
        width: 220px;
        box-sizing: border-box;
        transition: border-color 0.3s;
      }

      .date-input:focus {
        border-color: #3399ff;
        box-shadow: 0 0 3px rgba(51, 153, 255, 0.5);
      }

</style>

<div class="form-container-wrapper" style="background: transparent !important;">
    <div class="form-container">
        <h2>Submit Travel Claim</h2>
        <form:form method="post" action="create_create_my_travel_claim" modelAttribute="MY_TRAVEL_CLAIMS_OBJ" enctype="multipart/form-data">

            <div class="form-row">
                <label for="source">Source:</label>
                <form:input path="source" placeholder="Enter source" required="required"/>
                <font color="red"><form:errors path="source" cssClass="error"/></font>
            </div>

            <div class="form-row">
                <label for="destination">Destination:</label>
                <form:input path="destination" placeholder="Enter destination" required="required"/>
                <font color="red"><form:errors path="destination" cssClass="error"/></font>
            </div>

            <div class="form-row">
                <label for="expenseStartDate">Expense Start Date:</label>
                <form:input path="expenseStartDate" type="date" required="required" class="date-input"/>
                <font color="red"><form:errors path="expenseStartDate" cssClass="error"/></font>
            </div>

            <div class="form-row">
                <label for="expenseEndDate">Expense End Date:</label>
                <form:input path="expenseEndDate" type="date" class="date-input"/>
                <font color="red"><form:errors path="expenseEndDate" cssClass="error"/></font>
            </div>

            <div class="form-row">
                <label for="claimDetails">Claim Details:</label>
                <form:textarea path="claimDetails" maxlength="500" cols="68" rows="3" placeholder="Enter claim details"/>
                <font color="red"><form:errors path="claimDetails" cssClass="error"/></font>
            </div>

            <div class="form-row">
                <label for="kms">Kilometers:</label>
                <form:input path="kms" type="number" min="0" required="required" />
                <font color="red"><form:errors path="kms" cssClass="error"/></font>
            </div>

            <div class="form-row">
                <label for="travelMode">Travel Mode:</label>
                <form:select path="travelMode">
                    <form:options items="${CLAIM_TRAVEL_MODE}" />
                </form:select>
                <font color="red"><form:errors path="travelMode" cssClass="error"/></font>
            </div>

             <div class="form-row">
                <label for="travelExpense">Travel Expense:</label>
                <form:input path="travelExpense" type="number" min="0" required="required" />
                <font color="red"><form:errors path="travelExpense" cssClass="error"/></font>
            </div>

            <div class="form-row">
                <label for="foodExpense">Food Expense:</label>
                <form:input path="foodExpense" type="number" min="0" required="required" />
                <font color="red"><form:errors path="foodExpense" cssClass="error"/></font>
            </div>

            <div class="form-row">
                <label for="parkingExpense">Parking Expense:</label>
                <form:input path="parkingExpense" type="number" min="0" required="required" />
                <font color="red"><form:errors path="parkingExpense" cssClass="error"/></font>
            </div>

            <div class="form-row">
                <label for="otherExpense1">Other Expenses:</label>
                <form:input path="otherExpense1" type="number" placeholder="Other 1" min="0" required="required"/>
                <form:input path="otherExpense2" type="number" placeholder="Other 2" min="0" required="required"/>
                <form:input path="otherExpense3" type="number" placeholder="Other 3" min="0" required="required"/>
                <font color="red"><form:errors path="otherExpense1" cssClass="error"/></font>
            </div>
            <div class="form-row">
                <label for="otherExpensesDetails">Other Expenses Details:</label>
                <form:textarea path="otherExpensesDetails" maxlength="500" cols="68" rows="3" placeholder="Enter claim details"/>
            </div>
        <font color="red"><form:errors path="bills" cssClass="error"/></font>
          <div class="form-row">
              <label for="bills">Upload Bills:</label>
              <div id="file-inputs">
                  <div class="file-input-row">
                      <input type="file" name="bills" />
                      <button type="button" onclick="removeFileInput(this)">Remove</button>
                  </div>
              </div>
              <button type="button" onclick="addFileInput()">+ Add Another File</button>
          </div>



            <div class="button-container">
                <input type="submit" value="Submit Claim" />
                <a href="view_travel_claim_list"><input type="button" class="clear-filter-btn" value="View Claims List"></input></a>
            </div>


        </form:form>
    </div>
</div>

<script language="JavaScript">
     function addFileInput() {
            const container = document.getElementById("file-inputs");

            const wrapper = document.createElement("div");
            wrapper.className = "file-input-row";

            const newInput = document.createElement("input");
            newInput.type = "file";
            newInput.name = "bills";

            const removeBtn = document.createElement("button");
            removeBtn.type = "button";
            removeBtn.innerText = "Remove";
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
