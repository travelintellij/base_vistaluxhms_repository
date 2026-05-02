<jsp:include page="../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css?v=3">

<style>
    /* Theme Alignment matching Grand Suite used in view_filterLeads.jsp */
    body {
        background-color: var(--gs-ivory, #FAF8F5);
        font-family: 'Inter', sans-serif;
    }
    .report-page-container {
        padding: 20px;
        max-width: 98%;
        margin: 0 auto;
    }
    .report-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
        border-bottom: 2px solid #C9A84C;
        padding-bottom: 10px;
    }
    .report-header h2 {
        color: #1B2A3D;
        margin: 0;
        font-size: 24px;
    }
    .filter-card {
        background: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        margin-bottom: 25px;
    }
    .results-card {
        background: white;
        padding: 0;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        overflow: hidden;
    }
    
    /* Standardizing Form Row to match leads filter */
    .filter-row {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
        align-items: flex-end;
    }
    
    .form-group label {
        display: block;
        font-weight: 600;
        margin-bottom: 8px;
        color: #1B2A3D;
        font-size: 13px;
    }
    
    /* Ensuring inputs match the .inf class used in other modules */
    .inf-select {
        height: 38px;
        border: 1px solid #ddd;
        border-radius: 4px;
        padding: 0 10px;
        min-width: 180px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        table-layout: fixed; /* Ensures rigid column alignment */
    }
    
    thead th {
        background-color: #1B2A3D;
        color: #FFFFFF;
        text-align: left;
        padding: 15px;
        font-weight: 600;
        font-size: 13px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        box-sizing: border-box;
    }
    
    tbody td {
        padding: 12px 15px;
        border-bottom: 1px solid #f0f0f0;
        color: #444;
        font-size: 14px;
        box-sizing: border-box;
        white-space: nowrap; /* Force single line */
        overflow: hidden;
        text-overflow: ellipsis;
    }
    
    tbody tr:hover {
        background-color: #FAF8F5;
    }
    
    .lead-id-link {
        color: #C9A84C;
        font-weight: 700;
        text-decoration: none;
    }
    .lead-id-link:hover {
        text-decoration: underline;
    }
    
    .status-badge {
        padding: 4px 10px;
        border-radius: 12px;
        font-size: 11px;
        font-weight: 600;
        background: #f0f0f0;
        color: #1B2A3D;
        border: 1px solid #ddd;
    }

    /* Strict alignment classes */
    .col-id { width: 70px !important; text-align: center !important; }
    .col-client { width: 160px !important; text-align: left !important; }
    .col-status { width: 130px !important; text-align: center !important; }
    .col-response { width: 220px !important; text-align: left !important; }
    .col-time { width: 140px !important; text-align: left !important; }
    .col-plan { width: 180px !important; text-align: left !important; }
    .col-owner { width: 100px !important; text-align: center !important; }

    /* Flex container for cells with Read More */
    .cell-flex {
        display: flex;
        justify-content: space-between;
        align-items: center;
        width: 100%;
        overflow: hidden;
    }
    .truncate-text {
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        flex: 1;
    }

    /* Modal Styles */
    .modal-overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0,0,0,0.6);
        z-index: 10000;
        justify-content: center;
        align-items: center;
        backdrop-filter: blur(3px);
    }
    .modal-content {
        background: white;
        padding: 30px;
        border-radius: 12px;
        max-width: 600px;
        width: 90%;
        box-shadow: 0 20px 40px rgba(0,0,0,0.3);
        position: relative;
        animation: modalFadeIn 0.3s ease-out;
    }
    @keyframes modalFadeIn {
        from { opacity: 0; transform: translateY(-20px); }
        to { opacity: 1; transform: translateY(0); }
    }
    .modal-header {
        font-size: 20px;
        font-weight: 700;
        color: #1B2A3D;
        margin-bottom: 20px;
        border-bottom: 2px solid #C9A84C;
        padding-bottom: 10px;
    }
    .modal-body {
        font-size: 15px;
        line-height: 1.6;
        color: #333;
        max-height: 450px;
        overflow-y: auto;
        white-space: pre-wrap;
        background: #f9f9f9;
        padding: 15px;
        border-radius: 8px;
        border: 1px solid #eee;
    }
    .modal-close {
        position: absolute;
        top: 20px;
        right: 20px;
        cursor: pointer;
        font-size: 28px;
        color: #999;
        line-height: 1;
    }
    .modal-close:hover { color: #1B2A3D; }
    .view-more-link {
        color: #C9A84C;
        cursor: pointer;
        font-weight: 700;
        font-size: 11px;
        text-transform: uppercase;
        margin-top: 5px;
        display: block;
        letter-spacing: 0.5px;
    }
    .view-more-link:hover { text-decoration: underline; }
</style>

<div class="report-page-container">
    <div class="report-header">
        <h2>Lead Follow-up Report</h2>
    </div>

    <!-- Filter Section using standard styles -->
    <div class="filter-card">
        <form:form modelAttribute="FILTER_OBJ" action="view_lead_followup_report" method="POST">

<form:hidden path="sortOrder" id="sortOrder"/>
            <div class="filter-row">
                <div class="form-group">
                    <label for="startDate">From Date</label>
                    <form:input path="startDate" type="date" class="inf" style="width: 220px; height: 42px;"/>
                </div>
                
                <div class="form-group">
                    <label for="endDate">To Date</label>
                    <form:input path="endDate" type="date" class="inf" style="width: 220px; height: 42px;"/>
                </div>
                
                <div class="form-group">
                    <label for="leadStatus">Lead Status</label>
                    <form:select path="leadStatus" class="inf inf-select" style="height: 42px;">
                        <form:options items="${LEAD_STATUS_MAP}" />
                    </form:select>
                </div>
                
                <c:if test="${isAdmin}">
                    <div class="form-group">
                        <label for="leadOwner">Lead Owner</label>
                        <form:select path="leadOwner" class="inf inf-select" style="height: 42px;">
                            <option value="0">*** All Owners ***</option>
                            <c:forEach items="${ACTIVE_USERS_MAP}" var="userMap">
                                <option value="${userMap.key}" ${userMap.key eq FILTER_OBJ.leadOwner ? 'selected' : ''}>
                                    ${userMap.value}
                                </option>
                            </c:forEach>
                        </form:select>
                    </div>
                </c:if>

                <div class="form-group" style="display: flex; gap: 10px;">
                    <button type="submit" class="apply-filter-btn" style="height: 42px; margin-bottom: 0;">Apply Filters</button>
                    
                    <a class="export-btn" 
                       href="${pageContext.request.contextPath}/exportFollowupsExcel?startDate=${FILTER_OBJ.startDate}&endDate=${FILTER_OBJ.endDate}&leadStatus=${FILTER_OBJ.leadStatus}&leadOwner=${FILTER_OBJ.leadOwner}&sortOrder=${FILTER_OBJ.sortOrder}"
                       style="text-decoration: none; display: flex; align-items: center; justify-content: center; height: 42px;">
                       Export Excel
                    </a>

                    <a href="view_lead_followup_report" class="clear-filter-btn" style="text-decoration: none; display: flex; align-items: center; justify-content: center; height: 42px;">
                        Clear
                    </a>
                </div>
            </div>
        </form:form>
    </div>

    <!-- Results Table Section -->
    <div class="results-card">
        <table>
            <thead>
                <tr>
                    <th class="col-id">Lead ID</th>
                    <th class="col-client">Client Name</th>
                    <th class="col-status">Status</th>
                    <th class="col-response">Last Response</th>
                    <th class="col-time">Response Time</th>
                    <th class="col-time" style="cursor:pointer;" onclick="toggleSort()">
                        Next Follow-up
                        <span>
                            <c:choose>
                                <c:when test="${not empty FILTER_OBJ and FILTER_OBJ.sortOrder eq 'asc'}">&#9650;</c:when>
                                <c:when test="${not empty FILTER_OBJ and FILTER_OBJ.sortOrder eq 'desc'}">&#9660;</c:when>
                                <c:otherwise>&#8645;</c:otherwise>
                            </c:choose>
                        </span>
                    </th>
                    <th class="col-plan">Next Plan</th>
                    <th class="col-owner">Owner</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${FOLLOWUP_LIST}" var="followup">
                    <tr>
                        <td class="col-id">
                            <a href="form_view_lead_followup_details?leadId=${followup.leadEntity.leadId}" class="lead-id-link">
                                ${followup.leadEntity.leadId}
                            </a>
                        </td>
                        <td class="col-client" style="font-weight: 600;">${fn:escapeXml(followup.leadEntity.client.clientName)}</td>
                        <td class="col-status">
                            <c:set var="statusName" value="${FULL_STATUS_MAP[followup.leadEntity.leadStatus]}" />
                            <span class="status-badge" style="background: ${followup.leadEntity.leadStatus < 2000 ? '#e3f2fd' : '#f5f5f5'}; color: ${followup.leadEntity.leadStatus < 2000 ? '#1976d2' : '#666'}; border-color: ${followup.leadEntity.leadStatus < 2000 ? '#bbdefb' : '#ddd'};">
                                ${not empty statusName ? statusName : 'Unknown'}
                            </span>
                        </td>
                        <td class="col-response">
                            <div class="cell-flex">
                                <span class="truncate-text">"${fn:escapeXml(followup.response)}"</span>
                                <c:if test="${fn:length(followup.response) > 30}">
                                    <a class="view-more-link" onclick="openDetailsModal('Last Response', this)" data-content="${fn:escapeXml(followup.response)}" style="margin-left: 8px;">Read More</a>
                                </c:if>
                            </div>
                        </td>
                        <td class="col-time">
                            <fmt:parseDate value="${followup.followuptime}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedFollowTime" type="both" />
                            <span style="font-size: 13px; color: #555;"><fmt:formatDate value="${parsedFollowTime}" pattern="dd-MMM-yyyy HH:mm" /></span>
                        </td>
                        <td class="col-time">
                            <fmt:parseDate value="${followup.nextfollowuptime}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedNextTime" type="both" />
                            <span style="font-weight: 600; color: #1B2A3D;"><fmt:formatDate value="${parsedNextTime}" pattern="dd-MMM-yyyy HH:mm" /></span>
                        </td>
                        <td class="col-plan">
                            <div class="cell-flex">
                                <span class="truncate-text">${fn:escapeXml(followup.nextactionplan)}</span>
                                <c:if test="${fn:length(followup.nextactionplan) > 30}">
                                    <a class="view-more-link" onclick="openDetailsModal('Next Action Plan', this)" data-content="${fn:escapeXml(followup.nextactionplan)}" style="margin-left: 8px;">Read More</a>
                                </c:if>
                            </div>
                        </td>
                        <td class="col-owner">
                            <span class="status-badge">
                                <c:choose>
                                    <c:when test="${not empty ACTIVE_USERS_MAP[followup.leadEntity.leadOwner]}">
                                        ${ACTIVE_USERS_MAP[followup.leadEntity.leadOwner]}
                                    </c:when>
                                    <c:otherwise>
                                        ID: ${followup.leadEntity.leadOwner}
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty FOLLOWUP_LIST}">
                    <tr>
                        <td colspan="8" style="text-align: center; padding: 40px; color: #999;">
                            <div style="font-size: 48px; margin-bottom: 10px;">&#128194;</div>
                            No follow-ups found for these filters.
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<!-- Modal for viewing full text -->
<div id="detailsModal" class="modal-overlay">
    <div class="modal-content">
        <span class="modal-close" onclick="closeDetailsModal()">&times;</span>
        <div class="modal-header" id="modalTitle">Details</div>
        <div class="modal-body" id="modalBody"></div>
    </div>
</div>

<script>
    function openDetailsModal(title, element) {
        const content = element.getAttribute('data-content');
        document.getElementById('modalTitle').innerText = title;
        document.getElementById('modalBody').innerText = content;
        document.getElementById('detailsModal').style.display = 'flex';
        document.body.style.overflow = 'hidden'; // Prevent background scrolling
    }

    function closeDetailsModal() {
        document.getElementById('detailsModal').style.display = 'none';
        document.body.style.overflow = 'auto';
    }

    // Close on escape key
    document.addEventListener('keydown', function(event) {
        if (event.key === "Escape") {
            closeDetailsModal();
        }
    });

    // Close on outside click
    window.onclick = function(event) {
        const modal = document.getElementById('detailsModal');
        if (event.target == modal) {
            closeDetailsModal();
        }
    }

    function toggleSort() {
        let sortInput = document.getElementById("sortOrder");

        if (!sortInput.value || sortInput.value === "desc") {
            sortInput.value = "asc";
        } else {
            sortInput.value = "desc";
        }

        sortInput.form.submit();
    }

</script>

<jsp:include page="../footer.jsp" />
