<jsp:include page="../../_menu_builder_header.jsp" />
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
        background-image: url('<%= request.getContextPath() %>/resources/images/clientlist.jpg');
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

</style>

<sec:authorize access="hasAnyRole('ADMIN','CLIENT_MANAGE')">
<div class="form-container filter-container" style="width: 85%; min-width: 85%; max-width: 90%;">
    <h2>View Clients </h2>
    <form:form modelAttribute="CLIENT_OBJ" action="view_clients_list">
        <div class="form-row" style="display: flex; flex-wrap: wrap; gap: 10px; align-items: center;">
            <div class="form-group" style="flex: 1; min-width: 200px;">
                <label for="clientId">Client ID:</label>
                <form:input path="clientId" name="clientId" style="width:130px;" />
            </div>
            <div class="form-group" style="flex: 1; min-width: 200px;">
                <label for="clientName">Client Name:</label>
                <form:input path="clientName" name="clientName" style="width:180px;" />
            </div>
            <div class="form-group" style="flex: 1; min-width: 200px;">
                <label for="city">City:</label>
                <form:input path="cityName" name="cityName" style="width:200px;" />
                 <input type="hidden" id="destinationId" name="city.destinationId" value="${CLIENT_OBJ.city.destinationId}" />
                <font color="red">
                    <form:errors path="cityName" cssClass="error" />
                </font>
            </div>
            <div class="form-group" style="flex: 1; min-width: 200px;">
                <label for="salespartner">Sales Partner:</label>
                  <form:select id="salesPartnerSelect" path="salesPartner.salesPartnerId">
                    <option value="0" selected>-- Please Select --</option>
                    <form:options items="${SALES_PARTNER_MAP}" />
                   </form:select>
            </div>
            <div class="form-group" style="flex: 1; min-width: 250px;">
               <label for="b2b-client">Client Type: </label>
               <div class="radio-group-container">
                   <div class="radio-group">
                       <label>
                           <form:radiobutton path="b2b" value="true" />
                           <span>B2B</span>
                       </label>
                       <label>
                           <form:radiobutton path="b2b" value="false" />
                           <span>B2C</span>
                       </label>
                       <label>
                          <form:radiobutton path="b2b" value="" />
                          <span>Both</span>
                      </label>
                   </div>
               </div>
           </div>

            <div class="form-group" style="flex: 1; min-width: 200px;">
                  <label for="active">Active:</label>
                  <form:select path="active" name="active">
                      <option value="">--Select--</option>
                      <option value="true" ${CLIENT_OBJ.active == 'true' ? 'selected' : ''}>Active</option>
                      <option value="false" ${CLIENT_OBJ.active == 'false' ? 'selected' : ''}>Inactive</option>
                  </form:select>
            </div>


        <div class="form-actions" style="flex: 1; min-width: 200px;">
            <button type="submit" class="apply-filter-btn">Apply Filter</button>
            <a href="view_clients_list"><input type="button" class="clear-filter-btn" value="Clear Filter"></input></a>
        </div>
        </div>
    </form:form>
</div>
</sec:authorize>


<div align="center" style="margin:10px 0">
    <b>
        <font color="green">${Success}</font>
        <font color="red">${Error}</font>
    </b>
</div>


<sec:authorize access="hasAnyRole('ADMIN','CLIENT_MANAGE')">
<!-- Client List Table Section -->
<div class="form-container client-list-container" style="width: 60%; min-width: 60%; max-width: 60%;">
    <c:set value="${CLIENT_FILTERED_LIST}" var="clientList" />
    <table>
        <thead>
            <tr>
                <th>Client ID</th>
                <th>Client Name</th>
                <th>City</th>
                <th>Email</th>
                <th>Mobile</th>
                <th>Type</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${clientList}" var="clientRec">
                <tr>
                    <td>${clientRec.clientId}</td>
                    <td>${clientRec.clientName}</td>
                    <td>${clientRec.cityName}</td>
                    <td>${clientRec.emailId}</td>
                    <td>${clientRec.mobile}</td>
                    <td>${clientRec.b2b ? "B2B" : "B2C"}</td>

                    <td>
                        <c:if test="${clientRec.active eq true}">
                            <input type="button" style="background-color: #32cd32;border:none;outline:none;border-radius:5px;padding: 4px 5px;pointer-events: none;" value="Active" />
                        </c:if>
                        <c:if test="${clientRec.active eq false}">
                            <input type="button" style="background-color: red;border:none;outline:none;border-radius:5px;padding: 4px 5px;pointer-events: none;" value="Inactive" />
                        </c:if>
                    </td>
                    <td>
                        <form action="view_client_details" method="POST" style="display:inline;">
                                <input type="hidden" name="clientId" value="${clientRec.clientId}" />
                                <button type="submit" class="view-btn" style="height: 25px; padding: 5px 10px;background-color:gray;">View</button>
                        </form>
                        <form action="view_edit_client_form" method="POST" style="display:inline;">
                            <input type="hidden" name="clientId" value="${clientRec.clientId}" />
                            <button type="submit" class="edit-btn" style="height: 25px; padding: 5px 10px;">Edit</button>
                        </form>

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
</sec:authorize>
<script>
    $(document).ready(function () {
        $('#cityName').autocomplete({
            serviceUrl: '${pageContext.request.contextPath}/getCityList',
            paramName: "cityName",
            delimiter: ",",
            onSelect: function (suggestion) {
                const cityID = suggestion.data;
                $("#destinationId").val(cityID); // Set value in hidden field
                return false; // Prevent default behavior if needed
            },
            transformResult: function (response) {
                // Ensure response is parsed and transformed correctly
                return {
                    suggestions: $.map($.parseJSON(response), function (item) {
                        return {
                            value: item.cityName, // Display city name
                            data: item.destinationId // Use destinationId as data
                        };
                    })
                };
            }
        });
    });

     document.addEventListener("DOMContentLoaded", function () {
            var destinationInput = document.getElementById("destinationId");
            if (destinationInput && destinationInput.value.trim() === "") {
                destinationInput.value = "0";
            }
        });
</script>

<jsp:include page="../../footer.jsp" />
