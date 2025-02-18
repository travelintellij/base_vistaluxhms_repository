<jsp:include page="../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center mb-4">Seasonal Room Rates</h2>

    <!-- Form to Submit Rates -->
    <form action="saveRates" method="post">

        <!-- Date Range Selection -->
       <div class="row mb-4 align-items-center">
           <div class="col-sm-2">
               <label class="col-form-label"><b>Season Name:</b></label>
           </div>
           <div class="col-sm-3">
               <input type="text" name="seasonName" class="form-control" required>
           </div>

           <div class="col-sm-2">
               <label class="col-form-label"><b>Season Valid From:</b></label>
           </div>
           <div class="col-sm-2">
               <input type="date" name="seasonStart" class="form-control" required>
           </div>

           <div class="col-sm-1 text-end">
               <label class="col-form-label"><b>To:</b></label>
           </div>
           <div class="col-sm-2">
               <input type="date" name="seasonEnd" class="form-control" required>
           </div>
       </div>


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
                                <th>Meal Plan</th>
                                <th colspan="${room.maxOccupancy + room.extraBed}">Rates per Person</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="mealPlan" items="${mealPlanList}">
                                <tr>
                                    <td class="fw-bold">${mealPlan}</td>
                                    <c:forEach var="i" begin="1" end="${room.maxOccupancy-room.extraBed}">
                                        <td><input type="text" class="form-control input-box" name="rate_${room.roomCategoryId}_${mealPlan}_p${i}" placeholder="Person ${i}" required></td>
                                    </c:forEach>
                                    <c:forEach var="j" begin="1" end="${room.extraBed}">
                                        <td><input type="text" class="form-control input-box" name="rate_${room.roomCategoryId}_${mealPlan}_eb${j}" placeholder="Extra Bed ${j}" required></td>
                                    </c:forEach>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:forEach>

        <!-- Submit Button -->
        <div class="text-center mt-3">
            <button type="submit" class="btn btn-primary px-4">Save Rates</button>
        </div>
    </form>
</div>

<!-- Bootstrap JS for responsiveness -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<jsp:include page="../footer.jsp" />