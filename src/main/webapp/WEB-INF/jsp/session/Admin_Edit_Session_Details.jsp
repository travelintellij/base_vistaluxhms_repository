<jsp:include page="../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Season Rates Management</title>

    <!-- Bootstrap CSS for a clean and modern look -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <style>
    body {
        background-image: url('<%= request.getContextPath() %>/resources/images/sessionadd.jpg');
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

    textarea {
        width: 70%;
        height: 50px;
        padding: 12px 20px;
        box-sizing: border-box;
        border: 2px solid #ccc;
        border-radius: 4px;
        background-color: #f8f8f8;
        font-size: 16px;
        resize: none;
      }

    /* Optional: If you want to adjust the opacity of the image to make it more subtle */
    body {
        opacity: .98; /* Adjust the opacity for the background image */
    }

    body {
        background-color: #f8f9fa;
    }
    .container {
        margin-top: 30px;
        max-width: 90%;
    }
    .table {
        background-color: white;
    }
    .meal-header {
        background-color: #007bff;
        color: white;
    }
    .input-box {
        width: 120px;
        text-align: center;
    }
th:first-child, td:first-child {
    background-color: #28a745; /* Green */
    color: white;
    text-align: center;
    font-weight: bold;
}

th:not(:first-child), td:not(:first-child) {
    background-color: #f8f9fa; /* Light Gray */
    text-align: center;
    padding: 8px;
}


    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center mb-4">Seasonal Room Rates</h2>

    <!-- Form to Submit Rates -->


        <!-- Date Range Selection -->
       <form:form action="view_edit_session_form" modelAttribute="SESSION_MASTER_OBJ" method="post">
       <form:hidden path="sessionId"/>
       <div class="row mb-4 align-items-center">
           <div class="col-sm-2">
               <label class="col-form-label"><b>Session Name:</b></label>
           </div>
           <div class="col-sm-3">
                ${SESSION_MASTER_OBJ.sessionName}
           </div>
            <div class="col-sm-2">
               <label class="col-form-label"><b>Remarks:</b></label>
           </div>
           <div class="col-sm-3">
                ${SESSION_MASTER_OBJ.remarks}
           </div>
           <div class="col-sm-2">
               <div class="text-center mt-3"><button type="submit" class="btn btn-primary px-4">Edit Session Master</button></div>
          </div>
       </div>
       </form:form>

        <c:forEach var="entry" items="${sessionDetailsMap}">
            <c:set var="roomCategoryId" value="${entry.key}" />
            <c:set var="room" value="${roomCategoryNames[roomCategoryId]}" />
                <div class="card mb-4 shadow-sm">
                    <div class="card-header bg-dark text-white">
                        <h5 class="mb-0">${room.roomCategoryName} (Max: ${room.maxOccupancy}, Extra Beds: ${room.extraBed})</h5>
                    </div>
                     <div class="card-body">
                            <table class="table table-bordered">
                                <thead class="meal-header">
                                    <tr>
                                        <th style="background-color: #007bff; color: white;">Meal Plan</th>
                                        <th colspan="${room.maxOccupancy + room.extraBed}" style="background-color: #007bff; color: white;">Rates per Person</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="mealPlanEntry" items="${entry.value}">
                                <c:set var="sessionDetail" value="${mealPlanEntry.value}" />
                                <form:form action="create_create_session_detail" modelAttribute="SESSION_DETAIL_OBJ" method="post">
                                       <input type="hidden" name="mealPlanId" value="${mealPlanEntry.key}" />
                                       <input type="hidden" name="sessionId" value="${SESSION_DETAIL_OBJ.session.sessionId}" />
                                       <input type="hidden" name="roomCategoryId" value="${roomCategoryId}" />
                                       <form:hidden path="sessionDetailId" />
                                       <c:set var="mealPlanId" value="${mealPlanEntry.key}" />
                                        <c:set var="sessionDetail" value="${mealPlanEntry.value}" />

                                    <tr>
                                        <td class="fw-bold" style="width: 20%; text-align: center; white-space: nowrap;">${mealPlans[mealPlanId]}</td>
                                        <td style="width: 70%; text-align: center;">
                                            <div style="display: flex; justify-content: left; gap: 10px;">
                                            <c:forEach var="i" begin="1" end="${room.standardOccupancy}">
                                                <c:set var="personField" value="person${i}" />
                                                Person ${i} <input type="text" name="person${i}" value="${sessionDetail[personField]}" />

                                                <%-- <form:input path="person${i}" id="person${i}" placeholder="Person ${i}" class="form-control" style="width:120px;" required="required" /> --%>
                                            </c:forEach>
                                            </div>
                                         </td>
                                         <td><div class="text-center mt-3"><button type="submit" class="btn btn-primary px-4">Save Rates</button></div></td>
                                    </tr>
                                </form:form>
                                </c:forEach>

                                </tbody>
                                </table>
                    </div>
                 </div>
        </c:forEach>



<%--

        <!-- Meal Plans -->
        <c:set var="mealPlans" value="EP,CP,MAP,AP"/>
        <c:set var="mealPlanList" value="${mealPlans.split(',')}"/>

        <c:forEach var="room" items="${ACTIVE_ROOM_LIST}">
            <div class="card mb-4 shadow-sm">
                <div class="card-header bg-dark text-white">
                    <h5 class="mb-0">${room.roomCategoryName} (Max: ${room.maxOccupancy}, Extra Beds: ${room.extraBed})</h5>
                </div>
                <div class="card-body">
                    <table class="table table-bordered">
                        <thead class="meal-header">
                            <tr>
                                <th style="background-color: #007bff; color: white;">Meal Plan</th>
                                <th colspan="${room.maxOccupancy + room.extraBed}" style="background-color: #007bff; color: white;">Rates per Person</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="mealPlan" items="${mealPlanList}">
                                <form:form action="create_create_session_detail" modelAttribute="SESSION_DETAIL_OBJ" method="post">
                                <tr>
                                    <td class="fw-bold" style="width: 20%; text-align: center; white-space: nowrap;">${mealPlan}</td>
                                    <td style="width: 70%; text-align: center;">
                                        <div style="display: flex; justify-content: left; gap: 10px;">
                                        <c:forEach var="i" begin="1" end="${room.standardOccupancy}">
                                            Person ${i} <form:input path="person${i}" id="person${i}" placeholder="Person ${i}" class="form-control" style="width:120px;" required="required" />
                                        </c:forEach>
                                        </div>
                                     </td>
                                     <td><div class="text-center mt-3"><button type="submit" class="btn btn-primary px-4">Save Rates</button></div></td>
                                </tr>
                                </form:form>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:forEach>
    --%>
</div>

<!-- Bootstrap JS for responsiveness -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<jsp:include page="../footer.jsp" />