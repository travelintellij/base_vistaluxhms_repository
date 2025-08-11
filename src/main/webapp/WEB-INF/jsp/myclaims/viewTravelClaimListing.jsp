<jsp:include page="../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">
<script src="<c:url value="/resources/core/jquery.1.10.2.min.js" />"></script>
<script src="<c:url value="/resources/core/jquery.autocomplete.min.js" />"></script>
<style>
    body {
        background-image: url('<%= request.getContextPath() %>/resources/images/travelclaimlist.jpg');
        background-size: cover; /* Ensures the image covers the full page */
        background-position: center; /* Centers the image */
        background-attachment: fixed; /* Keeps the background fixed while scrolling */
        height: 100vh; /* Ensures the background covers the full height of the viewport */
        position: relative; /* Required for the overlay */
    }

    /* Create a watermark-like effect using an overlay */
    body::after {
        content: "";  /* Empty content for the overlay */
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;

        background: rgba(255, 255, 255, 0.3); /* Semi-transparent white overlay */
        z-index: -1; /* Place the overlay behind the content */
    }

    /* Optional: If you want to adjust the opacity of the image to make it more subtle */
    body {
        opacity: .98; /* Adjust the opacity for the background image */
    }
table {
  width: 100%;
  border-collapse: collapse;
  table-layout: fixed; /* this is important */
}

th, td {
  text-align: left;
  padding: 8px;
  border: 1px solid #ccc;
  word-wrap: break-word;
  text-align: center;
}

  .filter-bar {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    padding: 10px;
    background-color: #f8f9fa;
    border: 1px solid #ddd;
    border-radius: 8px;
  }

  .filter-bar label {
    font-weight: 600;
    margin-right: 5px;
  }

  .filter-item {
    display: flex;
    align-items: center;
    gap: 5px;
  }

  .filter-bar input[type="text"],
  .filter-bar select {
    padding: 5px 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
    min-width: 150px;
  }

  .filter-bar button {
    padding: 6px 12px;
    background-color: #007bff;
    color: #fff;
    font-weight: 600;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }

  .filter-bar button:hover {
    background-color: #0056b3;
  }

 .date-input {
    appearance: none;        /* Remove default styles (optional) */
    -webkit-appearance: none;
    -moz-appearance: none;

    background-color: #fff;
    border: 1px solid #ccc;
    border-radius: 4px;

    padding: 6px 10px;
    font-size: 14px;
    color: #333;

    width: 180px;            /* adjust width as per your layout */
    box-sizing: border-box;

    transition: border-color 0.3s, box-shadow 0.3s;
  }

  .date-input:focus {
    border-color: #007bff;
    box-shadow: 0 0 4px rgba(0, 123, 255, 0.4);
    outline: none;
  }

  .date-input::-webkit-calendar-picker-indicator {
    cursor: pointer;
    filter: invert(0.5);  /* optional: style the calendar icon */
  }

  .modal {
      display: none;
      position: fixed;
      z-index: 1000;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      overflow: auto;
      background-color: rgba(0,0,0,0.5); /* Background overlay */
  }

  .modal-content {
      background-color: #fff;
      margin: 15% auto;
      padding: 20px;
      border-radius: 8px;
      width: 30%;
      text-align: center;
  }

</style>



    <h2>Manage Claims </h2>
    <form:form id="filterForm" modelAttribute="TRAVEL_CLAIM_OBJ" action="view_travel_claim_list">
        <div class="filter-bar">
          <div class="filter-item">
            <label for="search">Travel Claim ID:</label>
            <form:input path="travelClaimId" name="travelClaimId" style="width:130px;" />
          </div>
          <sec:authorize access="hasAnyRole('ROLE_SUPERADMIN','ROLE_EXPENSE_APPROVER')">
              <div class="filter-item">
                <label for="category">Claimant:</label>
                <form:select path="claimentId" style="width:90%" required="required">
                     <form:option value="0">Please Select</form:option>
                     <form:options items="${ACTIVE_USERS_MAP}" class="service-small" />
                </form:select>
              </div>
          </sec:authorize>
          <div class="filter-item">
              <form:select path="dateSelOpt" style="width:90%" required="required">
                   <form:options items="${DATE_SEL_OPTIONS}" class="service-small" />
              </form:select>
          </div>
           <div class="filter-item">
                <label for="category">Expense Start Date:</label>
                <form:input type="date" path="expenseStartDate" name="expenseStartDate" class="date-input" />
           </div>
           <div class="filter-item">
                <label for="category">Expense End Date:</label>
               <form:input type="date" path="expenseEndDate" name="expenseEndDate" class="date-input" />
          </div>

         <div class="filter-item">
                <label for="category">Claim Status:</label>
               <form:select path="claimStatus">
                     <form:option value="0">Please Select</form:option>
                     <form:options items="${TRAV_EXP_STATUS_MAP}" />
                </form:select>
          </div>

        <div class="filter-item">
            <button type="submit" name="view_travelclaimlist" id="view_travelclaimlist">Apply Filter</button>
            <a href="view_travel_claim_list?view_travelclaimlist" style="background-color: green; color: white; border-radius: 4px; padding: 6px 12px; text-decoration: none; display: inline-block;">Clear Filter</a>
            <button type="submit" name="download_travelclaimlist" id="download_travelclaimlist">Download PDF</button>
            <button type="button" onclick="openEmailModal()">Email Claims</button>
        </div>
        <div id="emailModal" class="modal" style="display:none;">
                  <div class="modal-content">
                    <h3>Email Claims</h3>
                    <textarea id="emailId" name="emailId" rows="2" cols="30"
                              style="width: 95%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; font-size:14px;"
                              placeholder="Enter comma or semicolon separated email addresses"></textarea>

                    <div id="emailError" style="color:red; font-size:14px; margin-top:5px;"></div>
                    <button type="button" onclick="submitEmail()">Send</button>
                    <button type="button" onclick="closeEmailModal()">Cancel</button>
                  </div>
        </div>
        </div>
</form:form>


<div align="center" style="margin:10px 0">
    <b>
        <font color="green">${Success}</font>
        <font color="red">${Error}</font>
    </b>
</div>


<!-- Client List Table Section -->
<div class="form-container client-list-container" style="width: 60%; min-width: 60%; max-width: 60%;">
    <c:set value="${TRAVEL_CLAIM_FILTERED_LIST}" var="travelClaimList" />

    <table>
        <thead>

            <tr>
                <th>Claim ID</th>
                <th>Claimant</th>
                <th>Source</th>
                <th>Destination</th>
                <th>Expense Start Date</th>
                <th>Expense End Date</th>
                <th>Total Claim Amount</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${travelClaimList}" var="claimRec">
                 <c:set var="grandTotal" value="${grandTotal + claimRec.totalClaimAmount}" scope="page" />
                <tr>
                    <td>${claimRec.travelClaimId}</td>
                    <td>${claimRec.claimantName}</td>
                    <td>${claimRec.source}</td>
                    <td>${claimRec.destination}</td>
                    <td>${claimRec.formattedExpenseStartDate}</td>
                    <td>${claimRec.formattedExpenseEndDate}</td>
                    <td>INR ${claimRec.totalClaimAmount}</td>
                    <td>${claimRec.statusName}</td>
                    <td>
                        <form action="view_view_travel_claim_form" method="POST" style="display:inline;">
                                <input type="hidden" name="travelClaimId" value="${claimRec.travelClaimId}" />
                                <button type="submit" class="view-btn" style="height: 25px; padding: 5px 10px;background-color:gray;">View</button>
                        </form>
                        <c:set var="statusOK" value="${claimRec.claimStatus == TRAV_EXP_DEF_STATUS}" />
                        <c:set var="shouldShow" value="${statusOK}" />
                        <sec:authorize access="hasAnyRole('ROLE_SUPERADMIN', 'ROLE_EXPENSE_APPROVER')">
                            <c:set var="shouldShow" value="true" />
                        </sec:authorize>

                        <c:if test="${shouldShow}">
                            <form action="view_edit_travel_claim_form" method="POST" style="display:inline;">
                                <input type="hidden" name="travelClaimId" value="${claimRec.travelClaimId}" />
                                <button type="submit" class="edit-btn" style="height: 25px; padding: 5px 10px;">Edit</button>
                            </form>
                        </c:if>


                    </td>
                </tr>
            </c:forEach>
        </tbody>
        <!-- Grand Total Row -->
        <tfoot>
            <tr>
                <td colspan="6" style="text-align:right; font-weight:bold;">Grand Total:</td>
                <td style="font-weight:bold;">INR ${grandTotal}</td>
                <td colspan="2"></td>
            </tr>
        </tfoot>
    </table>


<script>
function openEmailModal() {
    document.getElementById('emailModal').style.display = 'block';
}

function closeEmailModal() {
    document.getElementById('emailModal').style.display = 'none';
}

function submitEmail() {
    var emailInput = document.getElementById('emailId').value.trim();
    var errorDiv = document.getElementById('emailError');
    var form = document.getElementById('filterForm');

    // Validate
    if (!validateEmails(emailInput)) {
        errorDiv.innerText = "Invalid email(s). Please check and try again.";
        return;
    } else {
        errorDiv.innerText = "";
    }

    // Clear previous hidden inputs (avoid duplicates)
    var existingAction = document.getElementById('hiddenAction');
    if (existingAction) existingAction.remove();
    var existingEmail = document.getElementById('hiddenEmail');
    if (existingEmail) existingEmail.remove();

    // Add hidden field for the Spring param it expects
    var hiddenAction = document.createElement('input');
    hiddenAction.type = 'hidden';
    hiddenAction.id = 'hiddenAction';
    hiddenAction.name = 'email_travelclaimlist'; // <-- Spring expects this
    hiddenAction.value = 'true';
    form.appendChild(hiddenAction);

    // Add hidden field for the email list
    var hiddenEmail = document.createElement('input');
    hiddenEmail.type = 'hidden';
    hiddenEmail.id = 'hiddenEmail';
    hiddenEmail.name = 'emailId';
    hiddenEmail.value = emailInput;
    form.appendChild(hiddenEmail);

    // Submit form programmatically
    form.submit();
}

function validateEmails(emailString) {
    // Allow both ',' and ';' as separators
    var emails = emailString.split(/[;,]/).map(function(e) { return e.trim(); });
    var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    for (var i = 0; i < emails.length; i++) {
        if (!emailRegex.test(emails[i])) {
            return false;
        }
    }
    return true;
}
</script>



<!-- Pagination Section -->
<div class="pagination-container">
    <c:choose>
        <c:when test="${CLIENT_OBJ.city.destinationId == null || CLIENT_OBJ.city.destinationId == 0}">
            <c:set var="destinationId" value="0" />
        </c:when>
        <c:otherwise>
            <c:set var="destinationId" value="${CLIENT_OBJ.city.destinationId}" />
        </c:otherwise>
    </c:choose>

    <c:if test="${not empty CLIENT_FILTERED_LIST}">
        <c:set var="totalRecords" value="${CLIENT_FILTERED_LIST.size()}" />
        <c:set var="recordsPerPage" value="${pageSize}" /> <!-- You can adjust this value -->

        <!-- Display pagination links -->
        <c:if test="${currentPage > 0}">
            <a class="pagination-btn" href="view_clients_list?page=${currentPage-1}&city.destinationId=${destinationId}&cityName=${CLIENT_OBJ.cityName}&salesPartner.salesPartnerId=${CLIENT_OBJ.salesPartner.salesPartnerId}&b2b=${CLIENT_OBJ.b2b}&active=${CLIENT_OBJ.active}">Previous</a>
        </c:if>

        <c:forEach begin="0" end="${totalPages-1}" var="page">
            <c:choose>
                <c:when test="${page == currentPage}">
                    <span class="pagination-btn active">${page+1}</span> <!-- Current page is highlighted -->
                </c:when>
                <c:otherwise>
                    <a class="pagination-btn" href="view_clients_list?page=${page}&city.destinationId=${destinationId}&cityName=${CLIENT_OBJ.cityName}&salesPartner.salesPartnerId=${CLIENT_OBJ.salesPartner.salesPartnerId}&b2b=${CLIENT_OBJ.b2b}&active=${CLIENT_OBJ.active}">${page+1} </a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:if test="${currentPage+1 < totalPages}">
               <a class="pagination-btn" href="view_clients_list?page=${currentPage+1}&city.destinationId=${destinationId}&cityName=${CLIENT_OBJ.cityName}&salesPartner.salesPartnerId=${CLIENT_OBJ.salesPartner.salesPartnerId}&b2b=${CLIENT_OBJ.b2b}&active=${CLIENT_OBJ.active}">Next</a>
        </c:if>
    </c:if>
</div>



<jsp:include page="../footer.jsp" />
