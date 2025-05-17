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


</style>

<div class="follow-up">
        <div class="follow-up-wrapper bs  container">
            <div class="follow-up-heading" style="padding-top:5px">
                <h1 style="color:blue;">System Quotation</h1>
            </div>
            <div class="follow-up-main-form">
            <table class="quotation-table">
                <thead>
                    <tr>
                        <th>Quotation ID</th>
                        <th>Version No.</th>
                        <th>Client Name</th>
                        <th>Check-In</th>
                        <th>Check-Out</th>
                        <th>Total Amount</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="quote" items="${quotationList}">
                        <tr>
                            <td>${quote.quotationId}</td>
                            <td>${quote.versionNo}</td>
                            <td>${quote.clientName}</td>
                            <td>${quote.checkIn}</td>
                            <td>${quote.checkOut}</td>
                            <td>₹ ${quote.totalAmount}</td>
                            <td>
                                <!-- View -->
                                <a href="viewQuotation?quotationId=${quote.quotationId}" class="action-btn view">View</a>
                                <!-- Edit -->
                                <a href="editQuotation?quotationId=${quote.quotationId}" class="action-btn edit">Edit</a>
                                <!-- Delete -->
                                <a href="deleteQuotation?quotationId=${quote.quotationId}" class="action-btn delete" onclick="return confirm('Are you sure you want to delete this quotation?');">Delete</a>
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
