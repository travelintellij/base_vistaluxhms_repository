<jsp:include page="../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lead Followup</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/ti.css">
    <script src="https://kit.fontawesome.com/6f6addf9b0.js" crossorigin="anonymous"></script>
    <script src="<c:url value="/resources/core/jquery.1.10.2.min.js" />"></script>
	<script src="<c:url value="/resources/core/jquery.autocomplete.min.js" />"></script>
	<link href="<c:url value="/resources/css/jquery.datetimepicker.min.css" />" rel="stylesheet">
	<script src="<c:url value="/resources/js/jquery.datetimepicker.full.js" />"></script>
</head>
<style>
 body {
        background-image: url('<%= request.getContextPath() %>/resources/images/leadlist.jpg');
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

.quotation-table {
    width: 100%;
    border-collapse: collapse;
    font-family: 'Segoe UI', sans-serif;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    margin: 20px 0;
    border-radius: 10px;
    overflow: hidden;
}

.quotation-table thead {
    background-color: #007bff;
    color: #fff;
    font-size: 15px;
}

.quotation-table th, .quotation-table td {
    padding: 12px 15px;
    text-align: left;
    border-bottom: 1px solid #e0e0e0;
}

.quotation-table tbody tr:hover {
    background-color: #f5faff;
}

.action-btn {
    display: inline-block;
    padding: 6px 12px;
    margin: 2px;
    font-size: 13px;
    border-radius: 5px;
    text-decoration: none;
    color: #fff;
    transition: background 0.3s ease;
}

.action-btn.view {
    background-color: #17a2b8;
}

.action-btn.edit {
    background-color: #28a745;
}

.action-btn.delete {
    background-color: #dc3545;
}

.action-btn:hover {
    opacity: 0.85;
}
.quotation-table {
    width: 100%;
    border-collapse: collapse;
    font-family: 'Segoe UI', sans-serif;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    margin: 20px 0;
    border-radius: 10px;
    overflow: hidden;
}

.quotation-table thead {
    background-color: #007bff;
    color: #fff;
    font-size: 15px;
}

.quotation-table th, .quotation-table td {
    padding: 12px 15px;
    text-align: left;
    border-bottom: 1px solid #e0e0e0;
}

.quotation-table tbody tr:hover {
    background-color: #f5faff;
}

.action-btn {
    display: inline-block;
    padding: 6px 12px;
    margin: 2px;
    font-size: 13px;
    border-radius: 5px;
    text-decoration: none;
    color: #fff;
    transition: background 0.3s ease;
}

.action-btn.view {
    background-color: #17a2b8;
}

.action-btn.edit {
    background-color: #28a745;
}

.action-btn.delete {
    background-color: #dc3545;
}

.action-btn:hover {
    opacity: 0.85;
}
.button-container-right {
    display: flex;
    justify-content: flex-end;
    gap: 10px;
    margin-top: 10px;
}

.action-btn {
    padding: 8px 16px;
    background-color: #007bff;
    border: none;
    color: white;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
}

.action-btn:hover {
    background-color: #0056b3;
}

.clear-filter-btn {
    background-color: #6c757d;
}

.clear-filter-btn:hover {
    background-color: #5a6268;
}


</style>

<div class="follow-up">
        <div class="follow-up-wrapper bs  container">
            <div class="follow-up-heading" style="padding-top:5px">
                <h1 style="color:blue;">System Quotation</h1>
            </div>
            <div align="center" style="margin: 10px 0;">
                <b>
                    <font color="green">${Success}</font>
                    <font color="red">${Error}</font>
                </b>
            </div>
            <div class="button-container-right">
                <form:form action="view_create_lead_system_quotation" modelAttribute="LEAD_OBJ" method="POST" style="display: inline;">
                    <form:hidden path="leadId" />
                    <input type="submit" value="Create System Quotation" class="action-btn">
                </form:form>
                <a href="view_filter_leads">
                    <input type="button" class="clear-filter-btn action-btn" value="View Leads List">
                </a>
            </div>
            <div class="follow-up-main-form">
            <table class="quotation-table">
                <thead>
                    <tr>
                        <th>Quotation ID</th>
                        <th>Version No.</th>
                        <th>Client Name</th>
                        <th>Total Amount</th>
                        <th>Discount</th>
                        <th>Net Amount </th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="quote" items="${LEAD_SYS_QUOTATION_LIST}">
                        <tr>
                            <td>${quote.lsqid}</td>
                            <td>${quote.versionId}</td>
                            <td>${quote.clientEntity.clientName}</td>
                            <td>INR ${quote.grandTotal}</td>
                            <td>INR ${quote.discount}</td>
                            <td>INR ${quote.grandTotal - quote.discount}</td>
                            <td>
                                <!-- View -->
                                <a href="view_review_system_quotation?lsqid=${quote.lsqid}" class="action-btn view">Load</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            </div>
            </div>

  <div class="quick-lead-view">
        <p class="qlv-text" >Quick Lead View</p>
        <i class="fa-solid fa-bars fa-xl hamburgur-i-follow-up ham"></i>
        <input type="checkbox" name="" id="show-fu-cb" class="hamburgur-i-follow-up hamCh fwtb">
        <div  class="inside-quick-lead-view">
        <form:form modelAttribute="LEAD_OBJ" action="create_create_lead_quotation">
		    <jsp:include page="../leads/leadDetailsOpenNavView.jsp" />
	        <form:hidden path = "leadId" />
	    </form:form>
        </div>
    </div>

<jsp:include page="../footer.jsp" />
