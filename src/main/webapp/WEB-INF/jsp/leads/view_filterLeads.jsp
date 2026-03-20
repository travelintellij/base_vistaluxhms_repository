<jsp:include page="../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
                    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
                        <link rel="stylesheet"
                            href="<%= request.getContextPath() %>/resources/css/stylesfilter.css?v=3">
                        <script src="<c:url value=" /resources/core/jquery.1.10.2.min.js" />"></script>
                        <script src="<c:url value=" /resources/core/jquery.autocomplete.min.js" />"></script>
                        <%--=====AI MODIFICATION START=====Change: Removed old blue/green inline styles. All styling now
                            comes from stylesfilter.css (Grand Suite theme). Reason: Theme alignment -
                            charcoal/gold/ivory throughout Scope: view_filterLeads.jsp --%>
                            <style>
                                /* Page-specific: clean ivory background, no heavy image */
                                body {
                                    background-color: var(--gs-ivory, #FAF8F5);
                                    background-image: none;
                                }

                                /* Toast notification styles */
                                .sync-toast {
                                    visibility: hidden;
                                    min-width: 250px;
                                    background-color: #333;
                                    color: #fff;
                                    text-align: center;
                                    border-radius: 6px;
                                    padding: 16px;
                                    position: fixed;
                                    z-index: 2000;
                                    left: 50%;
                                    bottom: 30px;
                                    transform: translateX(-50%);
                                    font-size: 14px;
                                    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
                                }

                                .sync-toast.show {
                                    transform: translateX(0);
                                }

                                .sync-toast.success {
                                    background: linear-gradient(135deg, #28a745, #20c997);
                                }

                                .sync-toast.info {
                                    background: linear-gradient(135deg, #17a2b8, #6610f2);
                                }

                                .sync-toast.error {
                                    background: linear-gradient(135deg, #dc3545, #e83e8c);
                                }
                            </style>
                            <%--=====AI MODIFICATION END=====--%>


                                <div class="page-container" style="display: flex; min-height: calc(100vh - 100px);">
                                    <!-- Sidebar -->
                                    <div id="filter-sidebar" class="filter-sidebar"
                                        style="width: 0; transition: 0.3s; overflow-x: hidden; background: #FFFFFF; height: calc(100% - 110px); position: fixed; z-index: 1000; left: 0; top: 108px; box-shadow: 4px 0 16px rgba(27,42,61,0.1); border-right: 2px solid #C9A84C;">
                                        <div style="padding: 15px; display: flex; flex-direction: column; gap: 15px;">
                                            <button onclick="toggleSidebar()"
                                                style="align-self: flex-end;">&times;</button>
                                            <h2>Filters</h2>
                                            <form:form modelAttribute="FILTER_LEAD_WL" action="view_filter_leads">
                                                <!-- Your existing filters -->
                                                <!-- Example: -->
                                                <div class="form-row"
                                                    style="display: flex; flex-wrap: wrap; gap: 10px; align-items: center;">
                                                    <div class="form-group">
                                                        <label for="leadId">Lead ID:</label>
                                                        <form:input path="leadId" name="leadId" style="width: 100%;" />
                                                    </div>
                                                    <div class="form-group" style="flex: 1; min-width: 200px;">
                                                        <label for="clientName">Client Name:</label>
                                                        <form:input path="clientName" name="clientName"
                                                            style="width: 180px;" />
                                                    </div>
                                                    <!-- Lead Owner (for ADMIN/LEAD_MANAGER) -->
                                                    <sec:authorize access="hasAnyRole('ADMIN','LEAD_MANAGER')">
                                                        <div class="form-group" style="flex: 1; min-width: 200px;">
                                                            <label for="leadOwner">Lead Owner:</label>
                                                            <form:select path="leadOwner" required="required"
                                                                style="width: 90%;">
                                                                <form:option value="0" label="***ALL***"
                                                                    class="service-small" />
                                                                <c:forEach items="${ACTIVE_USERS_MAP}" var="userMap">
                                                                    <option class="service-small" value="${userMap.key}"
                                                                        ${userMap.key eq userId ? 'selected' : '' }>
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
                                                        <div class="checkbox-container">
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
                                                            <form:options items="${LEAD_STATUS_MAP}"
                                                                class="service-small" />
                                                        </form:select>
                                                    </div>
                                                    <div class="form-group"
                                                        style="flex: 1; display: flex; flex-direction: column; gap: 5px;">
                                                        <label for="dateCriteria">Date Criteria:</label>
                                                        <form:select path="dateCriteria" class="dsc">
                                                            <form:option value="0" label="Select Date Criteria"
                                                                class="service-small" />
                                                            <form:option value="1" label="Creation Date"
                                                                class="service-small" />
                                                            <form:option value="2" label="Check In Date"
                                                                class="service-small" />
                                                        </form:select>
                                                        <div class="form-group"
                                                            style="display: flex; justify-content: space-between; gap: 10px;">
                                                            <div class="form-cell">
                                                                <label for="startDate">From:</label>
                                                                <form:input path="startDate" type="date" class="inf" />
                                                            </div>
                                                            <div class="form-cell">
                                                                <label for="endDate">To:</label>
                                                                <form:input path="endDate" type="date" class="inf" />
                                                            </div>
                                                        </div>
                                                    </div>



                                                </div>
                                                <!-- Add other filters here -->
                                                <div class="form-group">
                                                    <button type="submit" class="apply-filter-btn">Apply Filter</button>
                                                    <a href="view_filter_leads">
                                                        <input type="button" class="clear-filter-btn"
                                                            value="Clear Filter" />
                                                    </a>
                                                </div>
                                            </form:form>
                                        </div>
                                    </div>

                                    <!-- Main Content -->
                                    <div class="main-content"
                                        style="margin-left: 0; flex: 1; padding: 15px; transition: 0.3s;">
                                        <div
                                            style="display: flex; align-items: center; gap: 12px; margin-bottom: 15px; flex-wrap: wrap;">
                                            <button onclick="toggleSidebar()">Open Filters</button>

                                            <div
                                                style="display: flex; align-items: center; border: 1px solid #ccc; border-radius: 6px; padding: 4px; background: #f8f9fa;">
                                                <select id="campaignFormSelect" class="form-control"
                                                    style="border: none; background: transparent; padding: 6px; margin-right: 10px; font-weight: 500;">
                                                    <option value="">-- Select Campaign Form --</option>
                                                    <c:forEach items="${ACTIVE_META_FORMS}" var="form">
                                                        <option value="${form.campaignFormId}">${form.formName}
                                                            (${form.campaignName})</option>
                                                    </c:forEach>
                                                </select>
                                                <button id="syncIgBtn" class="sync-ig-btn"
                                                    onclick="syncInstagramLeads()">
                                                    <span class="spinner"></span>
                                                    <span class="btn-text">&#9889; Sync Leads</span>
                                                </button>
                                            </div>
                                        </div>
                                        <!-- Toast notification -->
                                        <div id="syncToast" class="sync-toast"></div>
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

                                            <!-- ADDED: WhatsApp-specific error alert block.
     This displays when WhatsApp message sending fails (e.g., missing template ID,
     wrong auth key, API error). The 'WhatsAppError' attribute is set by the controllers
     when WhatsAppResult.isSuccess() returns false. -->
                                            <c:if test="${not empty WhatsAppError}">
                                                <div style="background-color: #fff3cd; color: #856404; border: 1px solid #ffc107;
                padding: 12px 20px; margin: 10px auto; border-radius: 6px;
                max-width: 80%; text-align: left; font-size: 14px; position: relative;">
                                                    <strong>&#9888; WhatsApp Alert:</strong> ${WhatsAppError}
                                                    <span onclick="this.parentElement.style.display='none'" style="position: absolute; right: 10px; top: 10px; cursor: pointer;
                     font-size: 18px; font-weight: bold;">&times;</span>
                                                </div>
                                            </c:if>


                                            <!-- Leads List Table Section -->
                                            <div class="form-container leads-list-container"
                                                style="width: 100%; max-width: 100%; margin: 20px 0;">
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
                                                                <td>${leadRec.formattedCheckInDate}</td>
                                                                <td>${leadRec.formattedCheckOutDate}</td>
                                                                <td>${leadRec.b2b ? "B2B" : "B2C"}</td>
                                                                <td>${leadRec.statusName}</td>
                                                                <td>${leadRec.leadOwnerName}</td>
                                                                <td>
                                                                    <div class="dropdown">
                                                                        <button class="dropbtn">Actions</button>
                                                                        <div class="dropdown-content">

                                                                            <!-- View -->
                                                                            <a style="cursor: pointer;"
                                                                                id="myBtn[${leadRec.leadId}]"
                                                                                onclick="myLeadDisplay(this)"
                                                                                data-load-url="view_lead_details_modal?leadId=${leadRec.leadId}">
                                                                                View
                                                                            </a>

                                                                            <!-- Edit -->
                                                                            <form action="view_edit_lead_form"
                                                                                method="POST" style="margin: 0;">
                                                                                <input type="hidden" name="leadId"
                                                                                    value="${leadRec.leadId}" />
                                                                                <button type="submit"
                                                                                    class="dropdown-button">Edit</button>
                                                                            </form>

                                                                            <!-- Follow-Up -->
                                                                            <a href="form_view_lead_followup_details?leadId=${leadRec.leadId}"
                                                                                class="dropdown-button">Follow-Up</a>

                                                                            <!-- Quotations Submenu -->
                                                                            <div class="submenu">
                                                                                <span
                                                                                    class="dropdown-button">Quotations</span>
                                                                                <div class="submenu-content">
                                                                                    <a
                                                                                        href="view_system_leads_quotes?leadId=${leadRec.leadId}">System
                                                                                        Quotation</a>
                                                                                    <a
                                                                                        href="view_fh_leads_quotes?leadId=${leadRec.leadId}">Freehand
                                                                                        Quotation</a>
                                                                                    <!--
                           <a href="generate_event_quotation?leadId=${leadRec.leadId}">Event Quotation</a>
                           -->
                                                                                </div>
                                                                            </div>

                                                                        </div>
                                                                    </div>
                                                                </td>


                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>

                                            <div id="myModal" class="modal" style="display:none;">
                                                <div class="modal-content">
                                                    <span class="close-btn" onclick="closeModal()">×</span>
                                                    <div id="modalContent"></div>
                                                    <!-- This will be populated with the dynamic content -->
                                                </div>
                                            </div>



                                            <!-- Pagination Section -->
                                            <div class="pagination-container">
                                                <c:if test="${not empty FILTERED_LEADS_RECORDS}">
                                                    <c:set var="totalRecords"
                                                        value="${FILTERED_LEADS_RECORDS.size()}" />
                                                    <c:set var="recordsPerPage" value="${pageSize}" />
                                                    <!-- You can adjust this value -->
                                                    <c:set var="queryParams"
                                                        value="&clientName=${FILTER_LEAD_WL.clientName}&leadOwner=${FILTER_LEAD_WL.leadOwner}&salesPartnerId=${FILTER_LEAD_WL.salesPartnerId}&b2b=${FILTER_LEAD_WL.b2b}&qualified=${FILTER_LEAD_WL.qualified}&flagged=${FILTER_LEAD_WL.flagged}&leadStatus=${FILTER_LEAD_WL.leadStatus}&dateCriteria=${FILTER_LEAD_WL.dateCriteria}&startDate=${FILTER_LEAD_WL.startDate}&endDate=${FILTER_LEAD_WL.endDate}" />

                                                    <!-- Display pagination links -->
                                                    <c:if test="${currentPage > 0}">
                                                        <a class="pagination-btn"
                                                            href="view_filter_leads?page=${currentPage-1}${queryParams}">Previous</a>
                                                    </c:if>

                                                    <c:forEach begin="0" end="${totalPages-1}" var="page">
                                                        <c:choose>
                                                            <c:when test="${page == currentPage}">
                                                                <span class="pagination-btn active">${page+1}</span>
                                                                <!-- Current page is highlighted -->
                                                            </c:when>
                                                            <c:otherwise>
                                                                <a class="pagination-btn"
                                                                    href="view_filter_leads?page=${page}${queryParams}">${page+1}
                                                                </a>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>



                                                    <c:if test="${currentPage+1 < totalPages}">
                                                        <a class="pagination-btn"
                                                            href="view_filter_leads?page=${currentPage+1}${queryParams}">Next</a>
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
                                    window.onclick = function (event) {
                                        var modal = document.getElementById('myModal');
                                        if (event.target === modal) {
                                            closeModal();
                                        }
                                    }
                                </script>
                                <script>
                                    function syncInstagramLeads() {
                                        var select = document.getElementById('campaignFormSelect');
                                        var formId = select.value;
                                        if (!formId) {
                                            showSyncToast('Please select a Campaign Form first.', 'error');
                                            return;
                                        }

                                        var btn = document.getElementById('syncIgBtn');
                                        btn.classList.add('loading');
                                        btn.disabled = true;

                                        fetch('<%= request.getContextPath() %>/sync_instagram_leads?campaignFormId=' + formId)
                                            .then(function (response) { return response.json(); })
                                            .then(function (data) {
                                                btn.classList.remove('loading');
                                                btn.disabled = false;
                                                if (data.success && data.newLeadsImported > 0) {
                                                    showSyncToast(data.newLeadsImported + ' new lead(s) imported!', 'success');
                                                    setTimeout(function () { window.location.reload(); }, 1500);
                                                } else if (data.success) {
                                                    showSyncToast('No new leads to import.', 'info');
                                                } else {
                                                    showSyncToast('Sync failed: ' + (data.message || 'Unknown error'), 'error');
                                                }
                                            })
                                            .catch(function (err) {
                                                btn.classList.remove('loading');
                                                btn.disabled = false;
                                                showSyncToast('Connection error: ' + err.message, 'error');
                                            });
                                    }

                                    function showSyncToast(message, type) {
                                        var toast = document.getElementById('syncToast');
                                        toast.textContent = message;
                                        toast.className = 'sync-toast ' + type + ' show';
                                        setTimeout(function () {
                                            toast.classList.remove('show');
                                        }, 4000);
                                    }
                                </script>

                                <jsp:include page="../footer.jsp" />