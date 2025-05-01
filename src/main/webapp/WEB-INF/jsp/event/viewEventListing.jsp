<jsp:include page="../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">
<style>
    body {
        background-image: url('<%= request.getContextPath() %>/resources/images/roomlist.jpg');
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


    .container {
        max-width: 60%;
        margin: 40px auto;
        padding: 20px;
        background: #fff;
        border-radius: 10px;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    }
    table {
        width: 100%;
    }
    th, td {
        text-align: center;
        vertical-align: middle;
    }
    .action-btns a {
        margin: 3px;
    }
   .lfilter-container {
      display: flex;
      justify-content: center;
      gap: 10px; /* space between inputs */
      margin: 20px auto; /* margin for spacing */
      text-align: center;
    }

    .lfilter-container input {
      padding: 8px 12px;
      border: 1px solid #ccc;
      border-radius: 6px;
      width: 200px;
    }
</style>
<body>
<form:form modelAttribute="FILTER_EVENT_OBJ" action="view_filter_events">
<div class="lfilter-container">
  <form:input path="eventId" name="eventId"  placeholder="Event Id" />
  <form:input path="clientName" name="clientName"  placeholder="Search by Guest Name" />
  <form:input path="startDate" type="date" />
  <form:input path="endDate" type="date" />
<div class="form-group">
                    <button type="submit" class="apply-filter-btn">Apply Filter</button>
                    <a href="view_filter_events">
                        <input type="button" class="clear-filter-btn" value="Clear Filter" />
                    </a>
                </div>
</div>

</form:form>


    <div class="container">
        <h2 class="text-center mb-4">Event Quotations List</h2>
        <div align="center" style="margin:10px 0">
            <b>
                <font color="green">${Success}</font>
                <font color="red">${Error}</font>
            </b>
        </div>
        <table class="table table-bordered table-striped">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Guest Name</th>
                    <th>Event Start Date</th>
                    <th>Event End Date</th>
                    <th>Total Guest</th>
                    <th>Total Amount</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="event" items="${FILTERED_EVENT_RECORDS}">
                    <tr >
                        <td style="background-color: #F9FAFB;">${event.id}</td>
                        <td style="background-color: #F9FAFB;">${event.guestName}</td>
                        <td style="background-color: #F9FAFB;">${event.formattedStartDate}</td>
                        <td style="background-color: #F9FAFB;">${event.formattedEndDate}</td>
                        <td style="background-color: #F9FAFB;">${event.baseGuestCount}</td>
                        <td style="background-color: #F9FAFB;">${event.grand_total_cost}</td>
                        <td class="action-btns">
                            <form action="load_event_quotation_wiz_2" method="POST" style="display:inline;">
                                <input type="hidden" name="id" value="${event.id}" />
                                <button type="submit" class="btn btn-info btn-sm">Open</button>
                             </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="text-center mt-3">
            <a href="view_event_quotation_form_wiz1" class="btn btn-success">New Event Quotation </a>


<!-- Pagination Section -->
<div class="pagination-container">
    <c:if test="${not empty FILTERED_EVENT_RECORDS}">
        <c:set var="totalRecords" value="${FILTERED_EVENT_RECORDS.size()}" />
        <c:set var="recordsPerPage" value="${pageSize}" /> <!-- You can adjust this value -->
        <c:set var="queryParams" value="&clientName=${FILTER_EVENT_OBJ.clientName}&startDate=${FILTER_EVENT_OBJ.startDate}&endDate=${FILTER_EVENT_OBJ.endDate}" />

  <!-- Display pagination links -->
        <c:if test="${currentPage > 0}">
            <a class="pagination-btn" href="view_filter_events?page=${currentPage-1}${queryParams}">Previous</a>
        </c:if>

        <c:forEach begin="0" end="${totalPages-1}" var="page">
            <c:choose>
                <c:when test="${page == currentPage}">
                    <span class="pagination-btn active">${page+1}</span> <!-- Current page is highlighted -->
                </c:when>
                <c:otherwise>
                    <a class="pagination-btn" href="view_filter_events?page=${page}${queryParams}">${page+1} </a>
                </c:otherwise>
            </c:choose>
        </c:forEach>



        <c:if test="${currentPage+1 < totalPages}">
                      <a class="pagination-btn" href="view_filter_events?page=${currentPage+1}${queryParams}">Next</a>
               </c:if>

    </c:if>
</div>
    </div>
    </div>

</body>
</html>
