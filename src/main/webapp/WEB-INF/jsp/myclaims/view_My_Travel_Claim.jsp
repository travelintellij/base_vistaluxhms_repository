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
        <h2>View  Travel Claim</h2>
        <form:form method="post" action="create_create_my_travel_claim" modelAttribute="MY_TRAVEL_CLAIMS_OBJ" enctype="multipart/form-data">
             <div class="form-row" >
                <label for="source">Claim Id:</label>
                 <span style="display: inline-block; text-align: left; width: 500px;">
                        ${MY_TRAVEL_CLAIMS_OBJ.travelClaimId}
                 </span>
            </div>

            <div class="form-row" >
                <label for="source">Source:</label>
                 <span style="display: inline-block; text-align: left; width: 500px;">
                        ${MY_TRAVEL_CLAIMS_OBJ.source}
                 </span>
            </div>

            <div class="form-row">
                <label for="destination">Destination:</label>
                 <span style="display: inline-block; text-align: left; width: 500px;">
                 ${MY_TRAVEL_CLAIMS_OBJ.destination}
                 </span>
            </div>

            <div class="form-row">
                <label for="expenseStartDate">Expense Start Date:</label>
               <span style="display: inline-block; text-align: left; width: 500px;">
                ${MY_TRAVEL_CLAIMS_OBJ.formattedExpenseStartDate}
               </span>
            </div>

            <div class="form-row">
                <label for="expenseEndDate">Expense End Date:</label>
                <span style="display: inline-block; text-align: left; width: 500px;">
                    ${MY_TRAVEL_CLAIMS_OBJ.formattedExpenseEndDate}
                </span>
            </div>

            <div class="form-row">
                <label for="claimDetails">Claim Details:</label>
                <span style="display: inline-block; text-align: left; width: 500px;">
                    ${MY_TRAVEL_CLAIMS_OBJ.claimDetails}
                </span>
            </div>

            <div class="form-row">
                <label for="kms">Kilometers:</label>
                <span style="display: inline-block; text-align: left; width: 500px;">
                    ${MY_TRAVEL_CLAIMS_OBJ.kms}
                </span>
            </div>

            <div class="form-row">
                <label for="travelMode">Travel Mode:</label>
                <span style="display: inline-block; text-align: left; width: 500px;">
                    ${MY_TRAVEL_CLAIMS_OBJ.travelModeName}
                </span>
            </div>

             <div class="form-row">
                <label for="travelExpense">Travel Expense:</label>
                <span style="display: inline-block; text-align: left; width: 500px;">
                    ${MY_TRAVEL_CLAIMS_OBJ.travelExpense}
                </span>
            </div>

            <div class="form-row">
                <label for="foodExpense">Food Expense:</label>
                <span style="display: inline-block; text-align: left; width: 500px;">
                    ${MY_TRAVEL_CLAIMS_OBJ.foodExpense}
                </span>
            </div>

            <div class="form-row">
                <label for="parkingExpense">Parking Expense:</label>
                <span style="display: inline-block; text-align: left; width: 500px;">
                ${MY_TRAVEL_CLAIMS_OBJ.parkingExpense}
                </span>
            </div>

            <div class="form-row">
                <label for="otherExpense1">Other Expenses:</label>
                <span style="display: inline-block; text-align: left; width: 500px;">
                ${MY_TRAVEL_CLAIMS_OBJ.otherExpense1} |
                ${MY_TRAVEL_CLAIMS_OBJ.otherExpense2} |
                ${MY_TRAVEL_CLAIMS_OBJ.otherExpense3}
                </span>
            </div>
            <div class="form-row">
                <label for="otherExpensesDetails">Other Expenses Details:</label>
                <span style="display: inline-block; text-align: left; width: 500px;">
                 ${MY_TRAVEL_CLAIMS_OBJ.otherExpensesDetails}
                </span>
            </div>
            <div class="form-row">
                <label for="otherExpensesDetails">Total Expense</label>
                <span style="display: inline-block; text-align: left; width: 500px;">
               <mark> ${MY_TRAVEL_CLAIMS_OBJ.totalClaimAmount} </mark>
                </span>
            </div>

          <div class="form-row">
              <label for="bills">Bills:</label>
            <table>
                <thead>
                    <tr>
                        <th>File Name</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${MY_TRAVEL_CLAIMS_OBJ.billsEntity}" var="bill">
                        <tr>
                            <td>${bill.fileName}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/travel-claim/bill/${bill.id}" target="_blank">
                                    View
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

          </div>



            <div class="button-container">
                <input type="submit" value="Submit Claim" />
                <a href="view_claims"><input type="button" class="clear-filter-btn" value="View Claims List"></input></a>
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
