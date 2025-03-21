<jsp:include page="../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script src="<c:url value="/resources/core/jquery.1.10.2.min.js" />"></script>
<script src="<c:url value="/resources/core/jquery.autocomplete.min.js" />"></script>
<head>
    <meta charset="UTF-8">
    <title>Dynamic Form</title>
    <style>
           body {
               background-image: url('<%= request.getContextPath() %>/resources/images/quotation.jpg');
               background-size: cover; /* Ensures the image covers the full page */
               background-position: center; /* Centers the image */
               background-attachment: fixed; /* Keeps the background fixed while scrolling */
               height: 100vh; /* Ensures the background covers the full height of the viewport */
               position: relative; /* Required for the overlay */
           }

        select, input {
            height: 30px;
            margin: 5px;
        }
        .row {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        .hidden {
            display: none;
        }
        #mobile, #email {
            width: 150px;
        }

        .input-field {
            width: 220px; /* Fixed width for uniformity */
            height: 38px; /* Increased height for better readability */
            padding: 6px 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }


    </style>

</head>

<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}

.container {
    width: 80%;
    max-width: 1500px;
    background: #fff;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    margin: 50px auto;
    display: flex;
    flex-direction: column;
    align-items: center;
}

h2, h3 {
    text-align: center;
}

  .container {
             width: 60%;
             margin: auto;
             padding: 20px;
             border: 1px solid #ccc;
             border-radius: 10px;
             box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
         }
         .form-group {
             display: flex;
             align-items: center;
             margin-bottom: 15px;
         }
         .form-group label {
             width: 180px;
             font-weight: bold;
         }
         .form-group select, .form-group input {
             flex: 1;
             padding: 6px;
             height: 30px;
             border: 1px solid #ccc;
             border-radius: 5px;
             font-size: 14px;
         }
         .hidden {
             display: none;
         }
         .input-row {
             display: flex;
             gap: 15px;
         }
         .input-row .form-group {
             flex: 1;
         }


/* Room Table Styling */
#roomsTable {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
}

#roomsTable th, #roomsTable td {
    padding: 8px;
    text-align: center;
    border: 1px solid #ccc;
}

.btn {
    padding: 10px 15px;
    background-color: #007bff;
    color: #fff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    margin-top: 10px;
}

.btn:hover {
    background-color: #0056b3;
}

.btn-danger {
    background-color: #dc3545;
}

.btn-danger:hover {
    background-color: #b02a37;
}


</style>



<div class="container">
    <h2>Review Quotation</h2>

    <form:form method="post" action="process_quotation" modelAttribute="QUOTATION_OBJ">

        <!-- User Type Selection -->
            <div class="container">
            <div class="form-group">
              <label for="quotationAudienceType">Guest:</label>
                <form:input path="guestName" id="guestName" name="guestName"  class= "input-field" style="height:50px;"/>
            </div>

          <div id="clientBox" style="width: 700px;height: 60px;padding: 8px 12px;font-size: 16px;border: 2px solid #4CAF50;border-radius: 8px;background: linear-gradient(white, #f1f1f1);color: #333;outline: none;cursor: pointer;transition: all 0.3s ease-in-out;">
              <label for="clientName">Mobile:</label>
              <form:input path="mobile" type="number" id="mobile" name="mobile"  class= "input-field"/>
               <label for="quotationAudienceType">Email:</label>
              <form:input path="email" id="email" name="email"  type="email" class= "input-field" style="width:250px;"/>
          </div>
          </div>
<br>
<hr/>
        <!-- Room Details (Dynamically Added Rows) -->
        <div id="roomsContainer">
            <h3>Pricing Details</h3>

            <table id="roomsTable">
                <thead>
                    <tr>
                        <th style=" background-color: #4CAF50;color: white;padding: 10px;text-align: center;border: 1px solid #ddd;">Room Category</th>
                        <th style=" background-color: #4CAF50;color: white;padding: 10px;text-align: center;border: 1px solid #ddd;">Meal Plan</th>
                        <th style=" background-color: #4CAF50;color: white;padding: 10px;text-align: center;border: 1px solid #ddd;">Adults</th>
                        <th style=" background-color: #4CAF50;color: white;padding: 10px;text-align: center;border: 1px solid #ddd;">Child with bed</th>
                        <th style=" background-color: #4CAF50;color: white;padding: 10px;text-align: center;border: 1px solid #ddd;">Child no bed</th>
                        <th style=" background-color: #4CAF50;color: white;padding: 10px;text-align: center;border: 1px solid #ddd;">Extra Bed</th>
                        <th style=" background-color: #4CAF50;color: white;padding: 10px;text-align: center;border: 1px solid #ddd;">Check-in</th>
                        <th style=" background-color: #4CAF50;color: white;padding: 10px;text-align: center;border: 1px solid #ddd;">Check-out</th>
                        <th style=" background-color: #4CAF50;color: white;padding: 10px;text-align: center;border: 1px solid #ddd;">Total</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Dynamic Rows Will Be Added Here -->
                    <c:forEach var="room" items="${QUOTATION_OBJ.roomDetails}" varStatus="status">
                    <tr>
                        <td>${room.roomCategoryName}</td>
                        <td>${room.mealPlanName}</td>
                        <td><font size="2">${room.adults} Adult(s)</font> | <font color="blue" size="4"><b> &#8377; ${room.adultPrice} </b></font></td>
                        <td><font size="2">${room.childWithBed} CWB </font>| <font color="blue" size="4"><b> &#8377; ${room.childWithBedPrice}</b></font></td>
                        <td><font size="2">${room.childNoBed} CNB </font> | <font color="blue" size="4"><b> &#8377; ${room.childNoBedPrice}</b></font></td>
                        <td><font size="2">${room.extraBed} Extra Bed</font> | <font color="blue" size="4"><b> &#8377; ${room.extraBedPrice}</b></font></td>
                        <td>${room.checkInDate}</td>
                        <td>${room.checkOutDate}</td>
                        <td><font color="#503732" size="4"> <b>&#8377; ${room.totalPrice} </b></font></td>
                    </tr>
                     </c:forEach>
                     <tr>
                        <td colspan="6">&nbsp;</td>
                        <th style=" background-color: maroon;color: white;padding: 10px;text-align: center;border: 1px solid #ddd;" colspan="2">Grand Total :</th>
                       <td><font color="blue"><b> &#8377; ${QUOTATION_OBJ.grandTotal} </b></font></td>
                     </tr>
                     <tr>
                         <td colspan="3">&nbsp;<span id="errorMessage" style="font-size: 14px; font-weight: bold;"></span></td>
                         <th style=" background-color: red;color: white;padding: 10px;text-align: center;border: 1px solid #ddd;" colspan="2">Discount :</th>
                        <td>&#8377; <form:input path="discount" type="number" id="discount" name="discount"  style="width:70px;"/> </td>
                        <th style=" background-color:#4CAF50;color: white;padding: 10px;text-align: center;border: 1px solid #ddd;" colspan="2">Final Price :</th>
                         <td style="font-family: Arial, sans-serif;">&#8377;  <span id="finalPrice" style="font-size: 20px; font-weight: bold; color: blue;"> ${QUOTATION_OBJ.grandTotal}</span></td>
                     </tr>
            </table>
        </div>

        <button type="submit" class="btn">Submit</button>

</div>
<script>
    $(document).ready(function () {
        $("#discount").on("input", function () {
            var grandTotal = parseFloat(${QUOTATION_OBJ.grandTotal}); // Get the grand total
            var discount = parseFloat($(this).val()) || 0; // Get discount or set to 0 if empty

            // Check if discount exceeds grand total
            if (discount > grandTotal) {
                $("#errorMessage").text("Discount cannot exceed the grand total!").css("color", "red");
                $("#discount").val(grandTotal); // Reset discount input to max allowed
                discount = grandTotal; // Set discount to grand total
            } else {
                $("#errorMessage").text(""); // Clear error message
            }

            var finalPrice = grandTotal - discount; // Calculate final price
            $("#finalPrice").html(finalPrice.toFixed(2)); // Update final price label
        });
    });
</script>



</form:form>

<jsp:include page="../footer.jsp" />