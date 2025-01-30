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
/* Modal Background */
.modal {
    display: none; /* Hidden by default */
    position: fixed;
    z-index: 1050;
    left: 0;
    top: 0;
    width: 100vw;
    height: 100vh;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
}

/* Modal Content */
.modal-content {
    position: relative;
    background-color: #fff;
    width: 60%;
    max-width: 800px;
    min-height: 300px;
    max-height: 80vh;
    overflow-y: auto;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
    padding: 20px;
    margin: auto; /* Ensures centering */
}

/* Header with Close Button on Right */
.modal-header {
    padding: 15px;
    font-size: 18px;
    font-weight: bold;
    background-color: #007bff;
    color: white;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
    position: relative;
}

/* Close Button - Properly Positioned */
.close {
    color: white;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
    transition: color 0.3s;
    margin-left: auto; /* Forces it to the right */
}

.close:hover {
    color: #000;
}

/* Modal Body */
.modal-body {
    padding: 20px;
    font-size: 16px;
    line-height: 1.5;
}

/* Modal Footer */
.modal-footer {
    padding: 10px;
    background-color: #f1f1f1;
    border-bottom-left-radius: 10px;
    border-bottom-right-radius: 10px;
    text-align: right;
}


</style>


<div class="page-container" style="display: flex; height: 100vh; overflow: hidden;">
    <!-- Sidebar -->
    <div id="filter-sidebar" class="filter-sidebar" style="width: 0; transition: 0.3s; overflow-x: hidden; background: #f4f4f4; height: calc(100% - 140px); position: fixed; z-index: 1000; left: 0; top: 90px; box-shadow: 2px 0px 5px rgba(0, 0, 0, 0.3);">
        <div style="padding: 15px; display: flex; flex-direction: column; gap: 15px;">
            <button onclick="toggleSidebar()" style="align-self: flex-end;">&times;</button>
            <h2>Filters</h2>
            <form:form modelAttribute="FILTER_LEAD_WL" action="view_filter_leads">
                <!-- Your existing filters -->
                <!-- Example: -->
                <div class="form-row" style="display: flex; flex-wrap: wrap; gap: 10px; align-items: center;">
                <div class="form-group">
                    <label for="leadId">Lead ID:</label>
                    <form:input path="leadId" name="leadId" style="width: 100%;" />
                </div>
                <div class="form-group" style="flex: 1; min-width: 200px;">
                    <label for="clientName">Client Name:</label>
                    <form:input path="clientName" name="clientName" style="width: 180px;" />
                </div>
                  <!-- Lead Owner (for ADMIN/LEAD_MANAGER) -->
                <sec:authorize access="hasAnyRole('ADMIN','LEAD_MANAGER')">
                    <div class="form-group" style="flex: 1; min-width: 200px;">
                        <label for="leadOwner">Lead Owner:</label>
                        <form:select path="leadOwner" required="required" style="width: 90%;">
                            <form:option value="0" label="***ALL***" class="service-small" />
                            <c:forEach items="${ACTIVE_USERS_MAP}" var="userMap">
                                <option class="service-small" value="${userMap.key}"
                                        ${userMap.key eq userId ? 'selected' : ''}>
                                    ${userMap.value}
                                </option>
                            </c:forEach>
                        </form:select>
                    </div>
                </sec:authorize>
            <div class="form-group" style="flex: 1; min-width: 200px;">
                <label for="salespartner">Sales Partner:</label>
                <form:select id="salesPartnerSelect" path="salesPartnerId">
                    <option value="0" selected>-- Please Select --</option>
                    <form:options items="${SALES_PARTNER_MAP}" />
                </form:select>
            </div>
            <div class="form-group" style="flex: 1; min-width: 250px;">
                <label for="b2b-client">Client Type:</label>
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
              <div class="form-group" style="flex: 1; min-width: 250px;">
                <label>Filters:</label>
                <div class="checkbox-container" >
                    <div class="checkbox-item">
                        <form:checkbox path="qualified" id="qualified" />
                        <label for="qualified">Qualified</label>
                    </div>
                    <div class="checkbox-item">
                        <form:checkbox path="flagged" id="flagged" />
                        <label for="flagged">Flagged</label>
                    </div>
                </div>
            </div>
          <div class="form-group" style="flex: 1; min-width: 250px;">
                <label for="leadStatus">Lead Status:</label>
                <form:select path="leadStatus" class="inf">
                    <form:options items="${LEAD_STATUS_MAP}" class="service-small" />
                </form:select>
            </div>
             <div class="form-group" style="flex: 1; display: flex; flex-direction: column; gap: 5px;">
                <label for="dateCriteria">Date Criteria:</label>
                <form:select path="dateCriteria" class="dsc">
                    <form:option value="0" label="Select Date Criteria" class="service-small" />
                    <form:option value="1" label="Creation Date" class="service-small" />
                    <form:option value="2" label="Check In Date" class="service-small" />
                </form:select>
                <div class="form-group" style="display: flex; justify-content: space-between; gap: 10px;">
                    <div class="form-cell">
                        <label for="startDate" >From:</label>
                        <form:input path="startDate" type="date" class="inf" />
                    </div>
                    <div class="form-cell">
                        <label for="endDate" >To:</label>
                        <form:input path="endDate" type="date" class="inf" />
                    </div>
                </div>
            </div>



                </div>
                <!-- Add other filters here -->
                <div class="form-group">
                    <button type="submit" class="apply-filter-btn">Apply Filter</button>
                    <a href="view_filter_leads">
                        <input type="button" class="clear-filter-btn" value="Clear Filter" />
                    </a>
                </div>
            </form:form>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content" style="margin-left: 0; flex: 1; padding: 15px; overflow-y: auto; transition: 0.3s;">
        <button onclick="toggleSidebar()" style="margin-bottom: 15px;">Open Filters</button>
        <!-- Results Section -->
        <div>
            <!-- Your results section will go here -->
            <h2>Results</h2>

<!-- Success/Error Messages -->
<div align="center" style="margin: 10px 0;">
    <b>
        <font color="green">${Success}</font>
        <font color="red">${Error}</font>
    </b>
</div>


<!-- Client List Table Section -->
<div class="form-container client-list-container" style="width: 60%; min-width: 60%; max-width: 60%;">
    <c:set value="${FILTERED_LEADS_RECORDS}" var="leadsList" />
    <table>
        <thead>
            <tr>
                <th>Lead ID</th>
                <th>Qualified</th>
                <th>Flagged</th>
                <th>Client Name</th>
                <th>Check In</th>
                <th>Check Out</th>
                <th>Type</th>
                <th>Status</th>
                <th>Lead Owner</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${leadsList}" var="leadRec">
                <tr>
                    <td>${leadRec.leadId}</td>
                    <td><img src="<%= request.getContextPath() %>/resources/images/${leadRec.qualified ? 'tick.jpg' : 'cross.jpg'}"
                                 alt="${leadRec.qualified ? 'Qualified' : 'Not Qualified'}"
                                 style="width: 25px; height: 25px;" />
                    </td>
                    <td><img src="<%= request.getContextPath() %>/resources/images/${leadRec.flagged ? 'tick.jpg' : 'cross.jpg'}"
                                                         alt="${leadRec.flagged ? 'Flagged' : 'Not Flagged'}"
                                                         style="width: 25px; height: 25px;" /></td>
                    <td>${leadRec.clientName}</td>
                    <td>${leadRec.checkInDate}</td>
                    <td>${leadRec.checkOutDate}</td>
                    <td>${leadRec.b2b ? "B2B" : "B2C"}</td>
                    <td>${leadRec.statusName}</td>
                    <td>${leadRec.leadOwnerName}</td>
                    <td>
                        <a style="cursor: pointer;" id="myBtn[${leadRec.leadId}]" onclick="myLeadDisplay(this)" data-load-url="view_lead_details_modal?leadId=${leadRec.leadId}">
                            View
                        </a>

                        <form action="view_edit_lead_form" method="POST" style="display:inline;">
                            <input type="hidden" name="leadId" value="${leadRec.leadId}" />
                            <button type="submit" class="edit-btn" style="height: 25px; padding: 5px 10px;">Edit</button>
                        </form>

                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

 <div id="myModal" class="modal" style="display:none;">
     <div class="modal-content">
         <span class="close-btn" onclick="closeModal()">×</span>
         <div id="modalContent"></div> <!-- This will be populated with the dynamic content -->
     </div>
 </div>



<!-- Pagination Section -->
<div class="pagination-container">
    <c:if test="${not empty FILTERED_LEADS_RECORDS}">
        <c:set var="totalRecords" value="${FILTERED_LEADS_RECORDS.size()}" />
        <c:set var="recordsPerPage" value="${pageSize}" /> <!-- You can adjust this value -->
        <c:set var="queryParams" value="&clientName=${FILTER_LEAD_WL.clientName}&leadOwner=${FILTER_LEAD_WL.leadOwner}&salesPartnerId=${FILTER_LEAD_WL.salesPartnerId}&b2b=${FILTER_LEAD_WL.b2b}&qualified=${FILTER_LEAD_WL.qualified}&flagged=${FILTER_LEAD_WL.flagged}&leadStatus=${FILTER_LEAD_WL.leadStatus}&dateCriteria=${FILTER_LEAD_WL.dateCriteria}&startDate=${FILTER_LEAD_WL.startDate}&endDate=${FILTER_LEAD_WL.endDate}" />

  <!-- Display pagination links -->
        <c:if test="${currentPage > 0}">
            <a class="pagination-btn" href="view_filter_leads?page=${currentPage-1}${queryParams}">Previous</a>
        </c:if>

        <c:forEach begin="0" end="${totalPages-1}" var="page">
            <c:choose>
                <c:when test="${page == currentPage}">
                    <span class="pagination-btn active">${page+1}</span> <!-- Current page is highlighted -->
                </c:when>
                <c:otherwise>
                    <a class="pagination-btn" href="view_filter_leads?page=${page}${queryParams}">${page+1} </a>
                </c:otherwise>
            </c:choose>
        </c:forEach>



        <c:if test="${currentPage+1 < totalPages}">
                      <a class="pagination-btn" href="view_filter_leads?page=${currentPage+1}${queryParams}">Next</a>
               </c:if>

    </c:if>
</div>



        </div>
    </div>
</div>




<script>
    function toggleSidebar() {
        const sidebar = document.getElementById("filter-sidebar");
        const mainContent = document.querySelector(".main-content");

        if (sidebar.style.width === "0px" || sidebar.style.width === "") {
            sidebar.style.width = "320px"; // Adjust the width as needed
            mainContent.style.marginLeft = "300px";
        } else {
            sidebar.style.width = "0";
            mainContent.style.marginLeft = "0";
        }
    }
</script>
<script>
    // Function to open the modal and load the content dynamically
    function myLeadDisplay(element) {
        // Fetch the URL to load content for the modal
        var url = element.getAttribute('data-load-url');

        // Use AJAX to load content into the modal
        fetch(url)
            .then(response => response.text())
            .then(data => {
                document.getElementById('modalContent').innerHTML = data;
                openModal(); // Show the modal after content is loaded
            })
            .catch(error => console.error('Error loading modal content:', error));
    }

    // Function to open the modal
    function openModal() {
        var modal = document.getElementById('myModal');
        modal.style.display = 'block';
    }

    // Function to close the modal
    function closeModal() {
        var modal = document.getElementById('myModal');
        modal.style.display = 'none';
    }

    // Optionally, close the modal if the user clicks outside of it
    window.onclick = function(event) {
        var modal = document.getElementById('myModal');
        if (event.target === modal) {
            closeModal();
        }
    }
</script>

<jsp:include page="../footer.jsp" />
