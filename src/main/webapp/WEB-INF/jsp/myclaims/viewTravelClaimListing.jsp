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

</style>



    <h2>Manage Claims </h2>
    <form:form modelAttribute="TRAVEL_CLAIM_OBJ" action="view_travel_claim_list">
        <div class="filter-bar">
          <div class="filter-item">
            <label for="search">Travel Claim ID:</label>
            <form:input path="travelClaimId" name="travelClaimId" style="width:130px;" />
          </div>
          <sec:authorize access="hasAnyRole('ROLE_SUPERADMIN','ROLE_EXPENSE_APPROVER')">
              <div class="filter-item">
                <label for="category">Category:</label>
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
            <button type="submit">Apply Filter</button>
            <a href="view_travel_claim_list"
               style="background-color: green; color: white; border-radius: 4px; padding: 6px 12px; text-decoration: none; display: inline-block;">Clear Filter</a>
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
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${travelClaimList}" var="claimRec">
                <tr>
                    <td>${claimRec.travelClaimId}</td>
                    <td>${claimRec.claimantName}</td>
                    <td>${claimRec.source}</td>
                    <td>${claimRec.destination}</td>
                    <td>${claimRec.formattedExpenseStartDate}</td>
                    <td>${claimRec.formattedExpenseEndDate}</td>
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
    </table>
</div>



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
