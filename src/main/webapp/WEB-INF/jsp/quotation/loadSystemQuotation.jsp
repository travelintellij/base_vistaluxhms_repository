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

 .button-container {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 10px; /* Space between buttons */
        margin-top: 20px;
    }

    .btn {
        background-color: #007bff; /* Blue color */
        color: white;
        padding: 10px 15px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
    }

    .btn:hover {
        background-color: #0056b3; /* Darker blue on hover */
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
    background: lightblue;
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
             width: 100%;
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

#roomsTable th {
    padding: 8px;
    text-align: center;
    border: 1px solid #4682B4 !important; /* Force apply */
    background-color: #FFF5EE; /* Optional for better visibility */

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

.client-info-container {
    width: 100%;
    max-width: 100%;
    overflow-x: auto;
    margin-top: 10px;
    margin-bottom: 20px;
    background-color: #e6f2fa;
    padding: 12px;
    border-radius: 6px;
    box-shadow: 0 0 8px rgba(0, 0, 0, 0.05);
}

.client-info-table {
    width: 100%;
    table-layout: auto;
    border-collapse: collapse;
    font-family: Arial, sans-serif;
    font-size: 14px;
    color: #333;
}

.client-info-table th,
.client-info-table td {
    padding: 10px;
    border: 1px solid #b2d8f5;
}

.client-info-table th {
    background-color: #d0eaf7;
    font-weight: 600;
    text-align: left;
}

.client-info-table td {
    background-color: #f7fbfd;
}

</style>

<!-- Toggle Button -->
<button onclick="document.getElementById('leadModal').style.display='block'"
        style="position: fixed; top: 150px; left: 0; background-color: #007bff; color: white; border: none; padding: 10px 15px; cursor: pointer;">
    View Lead Info
</button>

<!-- Modal Box -->
<div id="leadModal"
     style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background-color: rgba(0, 0, 0, 0.6); z-index: 9999;">

    <!-- Modal Content -->
    <div style="background-color: white; margin: 5% auto; padding: 20px;
                border-radius: 8px; width: 80%; max-width: 800px; position: relative;">

        <!-- Close Button -->
        <span onclick="document.getElementById('leadModal').style.display='none'"
              style="position: absolute; top: 10px; right: 15px; font-size: 22px; font-weight: bold; cursor: pointer;">&times;</span>

        <h2 style="margin-top: 0;">Lead Information</h2>

        <!-- Lead Info Table -->
        <table style="width: 100%; border-collapse: collapse; margin-top: 20px;">
            <tr>
                <th style="text-align: left; padding: 8px;">Lead ID</th>
                <td style="padding: 8px;">${LEAD_OBJ.leadId}</td>

                <th style="text-align: left; padding: 8px;">Client</th>
                <td style="padding: 8px;">${LEAD_OBJ.client.clientName}</td>
            </tr>
            <tr>
                <th style="text-align: left; padding: 8px;">Lead Owner</th>
                <td style="padding: 8px;">${LEAD_OBJ.leadOwnerName}</td>

                <th style="text-align: left; padding: 8px;">Status</th>
                <td style="padding: 8px;">${LEAD_OBJ.statusName}</td>
            </tr>
            <tr>
                <th style="text-align: left; padding: 8px;">Adults</th>
                <td style="padding: 8px;">${LEAD_OBJ.adults}</td>

                <th style="text-align: left; padding: 8px;">CWB | CNB</th>
                <td style="padding: 8px;">${LEAD_OBJ.cwb} | ${LEAD_OBJ.cnb}</td>
            </tr>
            <tr>
                <th style="text-align: left; padding: 8px;">Check-In Date</th>
                <td style="padding: 8px;">${LEAD_OBJ.formattedCheckInDate}</td>

                <th style="text-align: left; padding: 8px;">Check-Out Date</th>
                <td style="padding: 8px;">${LEAD_OBJ.formattedCheckOutDate}</td>
            </tr>
            <tr>
                <th style="text-align: left; padding: 8px; vertical-align: top;">Remarks</th>
                <td colspan="3" style="padding: 8px;">${LEAD_OBJ.clientRemarks}</td>
            </tr>
        </table>
    </div>
</div>



<div class="container">
    <h2>Review Quotation</h2>

    <form:form method="post" action="process_system_quotation" modelAttribute="LEAD_SYSTEM_QUOTATION_OBJ">
        <form:hidden path="lsqid" />
        <form:hidden path="versionId" />
        <input type="hidden" id="clientId" name="clientEntity.clientId" value="${LEAD_SYSTEM_QUOTATION_OBJ.clientEntity.clientId}" />
        <input type="hidden" id="leadId" name="leadEntity.leadId" value="${LEAD_SYSTEM_QUOTATION_OBJ.leadEntity.leadId}" />

        <!-- User Type Selection -->
            <div class="container">
            <div class="client-info-container">
                   <table class="client-info-table">
                       <tr>
                           <th>Client Name</th>
                           <td>${LEAD_SYSTEM_QUOTATION_OBJ.clientEntity.clientName}</td>

                           <th>Mobile</th>
                           <td>${LEAD_SYSTEM_QUOTATION_OBJ.clientEntity.mobile}</td>

                           <th>Email</th>
                           <td>${LEAD_SYSTEM_QUOTATION_OBJ.clientEntity.emailId}</td>
                       </tr>
                   </table>
               </div>
          </div>
          <br>
<button type="submit" class="btn" name="Back" id="Back" value="Back" style="float: right;" >Back</button>
<hr/>
        <!-- Room Details (Dynamically Added Rows) -->
        <div id="roomsContainer">
                <h3>Pricing Details</h3>
                <div align="center" style="margin: 10px 0;">
                   <b>
                       <font color="green">${Success}</font>
                       <font color="red">${Error}</font>
                   </b>
               </div>
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
                    <c:forEach var="room" items="${LEAD_SYSTEM_QUOTATION_OBJ.roomDetailsDTO}" varStatus="status">
                    <tr>
                        <td>${room.roomCategoryName}</td>
                        <td>${room.mealPlanName}</td>
                        <td><font size="2">${room.adults} Adult(s)</font> | <font color="blue" size="4"><b> &#8377; ${room.adultPrice} </b></font></td>
                        <td><font size="2">${room.cwb} CWB </font>| <font color="blue" size="4"><b> &#8377; ${room.childWithBedPrice}</b></font></td>
                        <td><font size="2">${room.cnb} CNB </font> | <font color="blue" size="4"><b> &#8377; ${room.childNoBedPrice}</b></font></td>
                        <td><font size="2">${room.extraBed} Extra Bed</font> | <font color="blue" size="4"><b> &#8377; ${room.extraBedPrice}</b></font></td>
                        <td>${room.formattedCheckInDate} </td>
                        <td>${room.formattedCheckOutDate}</td>
                        <td><font color="#503732" size="4"> <b>&#8377; ${room.totalPrice} </b></font></td>
                    </tr>
                     </c:forEach>
                     <tr>
                        <td colspan="6">&nbsp;</td>
                        <th style="background-color: maroon;color: white;padding: 10px;text-align: center;border: 1px solid #ddd;" colspan="2">Grand Total :</th>
                       <td><font color="blue"><b> &#8377; ${LEAD_SYSTEM_QUOTATION_OBJ.grandTotal} </b></font></td>
                     </tr>
                     <tr>
                         <td colspan="3">&nbsp;<span id="errorMessage" style="font-size: 14px; font-weight: bold;"></span></td>
                         <th style=" background-color: red;color: white;padding: 10px;text-align: center;border: 1px solid #ddd;" colspan="2">Discount :</th>
                        <td>&#8377; <form:input path="discount" type="number" id="discount" name="discount"  style="width:70px;padding: 0px 0px;height:25px;"/> </td>
                        <th style=" background-color:#4CAF50;color: white;padding: 10px;text-align: center;border: 1px solid #ddd;" colspan="2">Final Price :</th>
                         <td style="font-family: Arial, sans-serif;">&#8377;  <span id="finalPrice" style="font-size: 20px; font-weight: bold; color: blue;"> ${LEAD_SYSTEM_QUOTATION_OBJ.grandTotal - LEAD_SYSTEM_QUOTATION_OBJ.discount }</span></td>
                     </tr>
            </table>
        </div>

        <form:textarea
                path="remarks"
                name="remarks"
                style="width: 100%; height: 100px; padding: 10px; font-size: 16px; border: 2px solid #4CAF50; border-radius: 8px; background: linear-gradient(white, #f1f1f1); color: #333; outline: none; transition: all 0.3s ease-in-out;"
                readonly="true"
            />

        <div class="button-container">
                <button type="submit" class="btn" name="Email" id="Email" value="Email">Email Quotation</button> |
                <button type="submit" class="btn" style="background-color: green;" name="whatsapp" id="whatsapp" value="whatsapp">WhatsApp Quotation</button> |
                <button type="submit" class="btn" name="EmailAndWhatsApp" id="EmailAndWhatsApp" value="EmailAndWhatsApp">Email & WhatsApp Quotation</button> |
                <button type="submit" class="btn" style="background-color: green;"name="SaveQuotation" id="SaveQuotation" value="SaveQuotation">Save Quotation</button>
                <button type="submit" class="btn" name="Download" id="Download" value="Download">Download Quotation</button>
        </div>

</div>
<script>
    $(document).ready(function () {
        $("#discount").on("input", function () {
            var grandTotal = parseFloat(${LEAD_SYSTEM_QUOTATION_OBJ.grandTotal}); // Get the grand total
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