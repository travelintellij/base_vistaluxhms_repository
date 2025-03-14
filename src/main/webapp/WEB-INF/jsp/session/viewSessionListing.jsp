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
        background-image: url('<%= request.getContextPath() %>/resources/images/salespartnerlist.jpg');
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

<div class="form-container filter-container" style="width: 60%; min-width: 60%; max-width: 60%;">
    <h2>View Session</h2>
    <form:form modelAttribute="SESSION_FILTER_OBJ" action="view_session_list">

        <div class="form-row" style="display: flex; flex-wrap: wrap; gap: 10px; align-items: center;">
            <div class="form-group" style="flex: 1; min-width: 200px;">
                <label for="salesPartnerId">Session ID:</label>
                <form:input path="sessionId" name="sessionId" style="width:130px;" />
            </div>
            <div class="form-group" style="flex: 1; min-width: 200px;">
                <label for="sessionName">Session Name:</label>
                <form:input path="sessionName" name="sessionName" style="width:180px;" />
            </div>
            <div class="form-group" style="flex: 1; min-width: 200px;">
                  <label for="active">Active:</label>
                  <form:select path="active" name="active">
                      <option value="">--Select--</option>
                      <option value="true" ${SESSION_FILTER_OBJ.active == 'true' ? 'selected' : ''}>Active</option>
                      <option value="false" ${SESSION_FILTER_OBJ.active == 'false' ? 'selected' : ''}>Inactive</option>
                  </form:select>
            </div>

        <div class="form-actions" style="flex: 1; min-width: 200px;">
            <button type="submit" class="apply-filter-btn">Apply Filter</button>
            <a href="view_session_list"><input type="button" class="clear-filter-btn" value="Clear Filter"></input></a>
        </div>
        </div>
    </form:form>
</div>

<div align="center" style="margin:10px 0">
    <b>
        <font color="green">${Success}</font>
        <font color="red">${Error}</font>
    </b>
</div>

<!-- Sales Partner List Table Section -->
<div class="form-container sales-partner-list-container" style="width: 100%;max-width: 1200px;margin: auto;">
    <c:set value="${SESSION_FILTER_OBJ}" var="sessionList" />
    <table style="width:100%;">
        <thead>
            <tr>
                <th style="width: 10%; border: 1px solid #ddd;text-align:center;">Session ID</th>
                <th style="width: 30%; border: 1px solid #ddd;text-align:center;">Session Name</th>
                <th style="width: 10%; border: 1px solid #ddd;text-align:center;">Status</th>
                <th style="width: 50%; border: 1px solid #ddd;text-align:center;">Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${SALES_PARTNER_FILTERED_LIST}" var="sessionRec">
                <tr>
                    <td style="width: 10%; border: 1px solid #ddd;text-align:center;">${sessionRec.sessionId}</td>
                    <td style="width: 30%; border: 1px solid #ddd;text-align:center;">${sessionRec.sessionName}</td>
                    <td style="width: 10%; border: 1px solid #ddd;text-align:center;">
                        <c:if test="${sessionRec.active eq true}">
                            <input type="button" style="background-color: #32cd32;border:none;outline:none;border-radius:5px;padding: 4px 5px;pointer-events: none;" value="Active" />
                        </c:if>
                        <c:if test="${sessionRec.active eq false}">
                            <input type="button" style="background-color: red;border:none;outline:none;border-radius:5px;padding: 4px 5px;pointer-events: none;" value="Inactive" />
                        </c:if>
                    </td>
                    <td style="width: 50%; border: 1px solid #ddd;text-align:center;">
                        <form action="view_session_details" method="POST" style="display:inline;">
                                <input type="hidden" name="sessionId" value="${sessionRec.sessionId}" />
                                <button type="submit" class="view-btn" style="height: 25px; padding: 5px 10px;background-color:gray;">View</button>
                        </form>
                        <form action="view_edit_session_form" method="POST" style="display:inline;">
                            <input type="hidden" name="sessionId" value="${sessionRec.sessionId}" />
                            <button type="submit" class="edit-btn" style="height: 25px; padding: 5px 10px;background-color:gray;">Edit</button>
                        </form>
                        <form action="view_edit_session_detail_form" method="POST" style="display:inline;">
                            <input type="hidden" name="sessionId" value="${sessionRec.sessionId}" />
                            <button type="submit" class="edit-btn" style="height: 25px; padding: 5px 10px;">Edit Session Details</button>
                        </form>
                        <form action="view_session_rate_mapping_form" method="POST" style="display:inline;">
                            <input type="hidden" name="sessionId" value="${sessionRec.sessionId}" />
                            <button type="submit" class="edit-btn" style="height: 25px; padding: 5px 10px;">Map Rates</button>
                        </form>

                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>


<jsp:include page="../footer.jsp" />
