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
               background-image: url('<%= request.getContextPath() %>/resources/images/systemleadquote.jpg');
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

  .autocomplete-suggestions {
        width: 300px !important; /* Adjust the width as needed */
    }

    </style>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            handleUserTypeChange();  // Ensure user type selection is preserved
            handleContactChange();  // Ensure contact method selection is preserved
        });

        // Function to Show/Hide Sections Based on User Type
        function handleUserTypeChange() {
            var userType = document.getElementById("quotationAudienceType").value;
            document.getElementById("clientBox").classList.add("hidden");
            document.getElementById("salesBox").classList.add("hidden");
            document.getElementById("unregisteredBox").classList.add("hidden");

            if (userType === "1") {
                document.getElementById("clientBox").classList.remove("hidden");
            } /*else if (userType === "2") {
                document.getElementById("salesBox").classList.remove("hidden");
            } */else if (userType === "2") {
                document.getElementById("unregisteredBox").classList.remove("hidden");
            }
        }

        // Function to Show/Hide Contact Fields Based on Contact Method Selection
        function handleContactChange() {
            var contactMethod = document.getElementById("contactMethod").value;
            document.getElementById("mobile").classList.add("hidden");
            document.getElementById("email").classList.add("hidden");

            if (contactMethod === "mobile") {
                document.getElementById("mobile").classList.remove("hidden");
            } else if (contactMethod === "email") {
                document.getElementById("email").classList.remove("hidden");
            } else if (contactMethod === "both") {
                document.getElementById("mobile").classList.remove("hidden");
                document.getElementById("email").classList.remove("hidden");
            }
        }

    </script>
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
             width: 80%;
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
    margin-top: 10px;
    margin-bottom: 20px;
    background-color: #e6f2fa; /* light blue tone */
    padding: 12px;
    border-radius: 6px;
    box-shadow: 0 0 8px rgba(0, 0, 0, 0.05);
}

.client-info-table {
    width: 100%;
    border-collapse: collapse;
    font-family: Arial, sans-serif;
    font-size: 14px;
    color: #333;
}

.client-info-table th {
    background-color: #d0eaf7;
    padding: 10px;
    text-align: left;
    font-weight: 600;
    border: 1px solid #b2d8f5;
    width: 12%;
}

.client-info-table td {
    background-color: #f7fbfd;
    padding: 10px;
    border: 1px solid #b2d8f5;
    width: 21%;
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
    <h2>Create System Quotation</h2>


    <form:form method="post" action="review_process_create_system_quotation" modelAttribute="LEAD_SYSTEM_QUOTATION_OBJ" id="myForm">
        <form:hidden path="lsqid" />
        <form:hidden path="versionId" />
        <input type="hidden" id="clientId" name="clientEntity.clientId" value="${LEAD_SYSTEM_QUOTATION_OBJ.clientEntity.clientId}" />
        <form:hidden path="discount" />
        <input type="hidden" id="leadId" name="leadEntity.leadId" value="${LEAD_SYSTEM_QUOTATION_OBJ.leadEntity.leadId}" />
        <!-- User Type Selection -->
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

        <%--
        <div class="form-group">
              <label for="quotationAudienceType">User Type:</label>

              <form:select path="quotationAudienceType" onchange="handleUserTypeChange()" style="width: 600px;height: 60px;padding: 8px 12px;font-size: 16px;border: 2px solid #4CAF50;border-radius: 8px;background: linear-gradient(white, #f1f1f1);color: #333;outline: none;cursor: pointer;transition: all 0.3s ease-in-out;">
                    <form:option value="0">Select</form:option>
                 <form:option value="1">Client</form:option>
                 <form:option value="2">Unregistered</form:option>
              </form:select>
          </div>

          <div id="clientBox" class="row hidden" style="width: 400px;height: 60px;padding: 8px 12px;font-size: 16px;border: 2px solid #4CAF50;border-radius: 8px;background: linear-gradient(white, #f1f1f1);color: #333;outline: none;cursor: pointer;transition: all 0.3s ease-in-out;">
              <label for="clientName">Client Name:</label>
              <form:input path="guestName" required="required" />
              <font color="red">
                  <form:errors path="guestName" cssClass="error"  />
              </font>
          </div>

          <div id="salesBox" class="row hidden" style="width: 400px;height: 60px;padding: 8px 12px;font-size: 16px;border: 2px solid #4CAF50;border-radius: 8px;background: linear-gradient(white, #f1f1f1);color: #333;outline: none;cursor: pointer;transition: all 0.3s ease-in-out;">
              <label for="salespartner">Sales Partner:</label>
              <input type="text" id="salespartner" name="salespartner" class="input-field">
          </div>


          <div id="unregisteredBox" class="hidden">
              <div class="row">
                  <label for="contactMethod">Contact By:</label>
                    <form:select path="contactMethod" onchange="handleContactChange()" style="width: 100px;height: 60px;padding: 8px 12px;font-size: 16px;border: 2px solid #4CAF50;border-radius: 8px;background: linear-gradient(white, #f1f1f1);color: #333;outline: none;cursor: pointer;transition: all 0.3s ease-in-out;">
                       <form:option value="">Select</form:option>
                       <form:option value="mobile">Mobile</form:option>
                       <form:option value="email">Email</form:option>
                       <form:option value="both">Both</form:option>
                    </form:select>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                   <label for="rateTypes">Rate Type:</label>
                    <form:select path="rateTypeId" style="width: 400px;height: 60px;padding: 8px 12px;font-size: 16px;border: 2px solid #4CAF50;border-radius: 8px;background: linear-gradient(white, #f1f1f1);color: #333;outline: none;cursor: pointer;transition: all 0.3s ease-in-out;">
                            <form:options items="${RATE_TYPE_MAP}" />
                    </form:select>
              </div>
              <div class="row">
                  <form:input path="mobile" id="mobile" name="mobile"  placeholder="Mobile" class= "input-field"/>
                  <form:input path="email" id="email" name="email"  placeholder="Email" class= "input-field" style="width:250px;"/>
              </div>
          </div>
        --%>
        <!-- Room Details (Dynamically Added Rows) -->
        <div id="roomsContainer">
            <h3>Room Details</h3>
            <button type="button" class="btn add-room" onclick="addRoom()">+ Add Room</button>
           <font color="red">
              <form:errors path="remarks" cssClass="error"  />
          </font>
            <table id="roomsTable">
                <thead>
                    <tr>
                        <th>Room Category</th>
                        <th>Meal Plan</th>
                        <th>Adults</th>
                        <th>Children (with bed)</th>
                        <th>Children (no bed)</th>
                        <th>Extra Bed (Adult)</th>
                        <th>Check-in</th>
                        <th>Check-out</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Dynamic Rows Will Be Added Here -->
    <c:forEach var="room" items="${LEAD_SYSTEM_QUOTATION_OBJ.roomDetails}" varStatus="status">
        <tr>
            <td>
                 <font color="red"><form:errors path="roomDetails[${status.index}].roomCategoryId" cssClass="error"  /></font>
                <select name="roomDetails[${status.index}].roomCategoryId" style="width: 200px;height: 60px;padding: 8px 12px;font-size: 16px;border: 2px solid #4CAF50;border-radius: 8px;background: linear-gradient(white, #f1f1f1);color: #333;outline: none;cursor: pointer;transition: all 0.3s ease-in-out;">
                    <c:forEach var="entry" items="${ROOM_TYPE_MAP}">
                        <option value="${entry.key}" ${room.roomCategoryId == entry.key ? 'selected' : ''}>${entry.value}</option>
                    </c:forEach>
                </select>
            </td>
            <td>
                <select name="roomDetails[${status.index}].mealPlanId" style="width: 100px;height: 60px;padding: 8px 12px;font-size: 16px;border: 2px solid #4CAF50;border-radius: 8px;background: linear-gradient(white, #f1f1f1);color: #333;outline: none;cursor: pointer;transition: all 0.3s ease-in-out;">
                    <c:forEach var="entry" items="${MEAL_PLAN_MAP}">
                        <option value="${entry.key}" ${room.mealPlanId == entry.key ? 'selected' : ''}>${entry.value}</option>
                    </c:forEach>
                </select>
            </td>
            <td>  <font color="red"><form:errors path="roomDetails[${status.index}].adults" cssClass="error"  /></font>
            <input type="number" name="roomDetails[${status.index}].adults" class="input-field" value="${room.adults}" min="1" style="width:70px;" required /></td>
            <td><input type="number" name="roomDetails[${status.index}].cwb" class="input-field" value="${room.cwb}" min="0" style="width:70px;" required /></td>
            <td>
                <font color="red"><form:errors path="roomDetails[${status.index}].cnb" cssClass="error"  /></font>
                <input type="number" name="roomDetails[${status.index}].cnb" class="input-field" value="${room.cnb}" min="0"  style="width:70px;" required />
            </td>
            <td><input type="number" name="roomDetails[${status.index}].extraBed" class="input-field" value="${room.extraBed}" min="0" style="width:70px;" required /></td>
            <td>
            <font color="red"><form:errors path="roomDetails[${status.index}].checkInDate" cssClass="error"  /></font>
            <input type="date" name="roomDetails[${status.index}].checkInDate" class="input-field" value="${room.checkInDate}" style="width: 150px;height: 60px;padding: 8px 12px;font-size: 16px;border: 2px solid #4CAF50;border-radius: 8px;background: linear-gradient(white, #f1f1f1);color: #333;outline: none;cursor: pointer;transition: all 0.3s ease-in-out;" required /></td>
            <td>
            <font color="red"><form:errors path="roomDetails[${status.index}].checkOutDate" cssClass="error"  /></font>
            <input type="date" name="roomDetails[${status.index}].checkOutDate" class="input-field" value="${room.checkOutDate}" style="width: 150px;height: 60px;padding: 8px 12px;font-size: 16px;border: 2px solid #4CAF50;border-radius: 8px;background: linear-gradient(white, #f1f1f1);color: #333;outline: none;cursor: pointer;transition: all 0.3s ease-in-out;" required /></td>
            <td>
                <button type="button" class="btn btn-danger" onclick="removeRoom(this)">Remove</button>
            </td>
        </tr>
    </c:forEach>

                </tbody>
            </table>
        </div>

                <br/><br/>
        <form:textarea
                path="remarks"
                name="remarks"
                style="width: 100%; height: 100px; padding: 10px; font-size: 16px; border: 2px solid #4CAF50; border-radius: 8px; background: linear-gradient(white, #f1f1f1); color: #333; outline: none; transition: all 0.3s ease-in-out;"
                placeholder="Enter remarks here"
            />


        <button type="submit" class="btn">Submit</button>
        <a href="view_system_leads_quotes?leadId=${LEAD_OBJ.leadId}"> <button type="button" style="background-color: #04AA6D;">View Quotes List</button></a>


</div>


  <script>

$('#guestName').autocomplete({
     serviceUrl: '${pageContext.request.contextPath}/getClientList', // Keeping the original endpoint
     paramName: "clientName", // Keeping original request param as expected by the backend
     delimiter: ",",
     onSelect: function (suggestion) {
         // Set only guestName in the input box
         $('#guestName').val(suggestion.value.split(" - ")[0]);

         // Set guestId in the hidden input
         guestID = suggestion.data;
         jQuery("#guestId").val(guestID);
         $('input[name=guestId]').val(guestID);
         return false;
     },
     transformResult: function (response) {
         return {
             suggestions: $.map($.parseJSON(response), function (item) {
                 return {
                     value: item.clientName + " - " + item.salesPartnerName, // Keep clientName from API response
                     data: item.clientId // Keep clientId for hidden input
                 };
             })
         };
     }
 });


document.addEventListener("DOMContentLoaded", function () {
    document.getElementById("quotationAudienceType").addEventListener("change", handleUserTypeChange);
    document.getElementById("contactMethod").addEventListener("change", handleContactChange);
    document.querySelector("form").addEventListener("submit", validateForm);

    function validateForm(event) {
        var userType = document.getElementById("quotationAudienceType").value;
        var contactMethod = document.getElementById("contactMethod").value;
        var mobile = document.getElementById("mobile").value.trim();
        var email = document.getElementById("email").value.trim();
        var isValid = true;

        if (userType === "3") { // If "Unregistered" is selected
            if (!contactMethod) {
                alert("Please select a contact method (Mobile, Email, or Both).");
                isValid = false;
            }

            if (contactMethod === "mobile" || contactMethod === "both") {
                if (!mobile) {
                    alert("Mobile number is required.");
                    isValid = false;
                } else if (!/^\d{10}$/.test(mobile)) {
                    alert("Please enter a valid 10-digit mobile number.");
                    isValid = false;
                }
            }

            if (contactMethod === "email" || contactMethod === "both") {
                if (!email) {
                    alert("Email is required.");
                    isValid = false;
                } else if (!/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/.test(email)) {
                    alert("Please enter a valid email address.");
                    isValid = false;
                }
            }
        }

        if (!isValid) {
            event.preventDefault(); // Prevent form submission if validation fails
        }
    }
});



function addRoom() {
    let tableBody = document.querySelector("#roomsTable tbody");
    let rowCount = tableBody.rows.length; // Get the row index for naming
    let newRow = document.createElement("tr");
    newRow.innerHTML = `
        <td>
            <select name="roomDetails[\${rowCount}].roomCategoryId" style="width: 200px;height: 60px;padding: 8px 12px;font-size: 16px;border: 2px solid #4CAF50;border-radius: 8px;background: linear-gradient(white, #f1f1f1);color: #333;outline: none;cursor: pointer;transition: all 0.3s ease-in-out;">
                <c:forEach var="entry" items="${ROOM_TYPE_MAP}">
                    <option value="${entry.key}">${entry.value}</option>
                </c:forEach>
            </select>
        </td>
        <td>
            <select name="roomDetails[\${rowCount}].mealPlanId" style="width: 100px;height: 60px;padding: 8px 12px;font-size: 16px;border: 2px solid #4CAF50;border-radius: 8px;background: linear-gradient(white, #f1f1f1);color: #333;outline: none;cursor: pointer;transition: all 0.3s ease-in-out;">
                <c:forEach var="entry" items="${MEAL_PLAN_MAP}">
                    <option value="${entry.key}">${entry.value}</option>
                </c:forEach>
            </select>
        </td>
        <td><input type="number" name="roomDetails[\${rowCount}].adults" class="input-field" min="1" style="width:70px;" value="2" required /></td>
        <td><input type="number" name="roomDetails[\${rowCount}].cwb" class="input-field" min="0" style="width:70px;" value="0" required /></td>
        <td><input type="number" name="roomDetails[\${rowCount}].cnb" class="input-field" min="0" style="width:70px;" value="0" required /></td>
        <td><input type="number" name="roomDetails[\${rowCount}].extraBed" class="input-field" min="0" style="width:70px;" value="0" required /></td>
        <td><input type="date" name="roomDetails[\${rowCount}].checkInDate"  style="width: 150px;height: 60px;padding: 8px 12px;font-size: 16px;border: 2px solid #4CAF50;border-radius: 8px;background: linear-gradient(white, #f1f1f1);color: #333;outline: none;cursor: pointer;transition: all 0.3s ease-in-out;"  required /></td>
        <td><input type="date" name="roomDetails[\${rowCount}].checkOutDate" style="width: 150px;height: 60px;padding: 8px 12px;font-size: 16px;border: 2px solid #4CAF50;border-radius: 8px;background: linear-gradient(white, #f1f1f1);color: #333;outline: none;cursor: pointer;transition: all 0.3s ease-in-out;" required  /></td>
        <td>
            <button type="button" class="btn btn-danger" onclick="removeRoom(this)">Remove</button>
        </td>
    `;
    tableBody.appendChild(newRow);

}

function removeRoom(button) {
    let row = button.parentNode.parentNode;
    row.parentNode.removeChild(row);
}





    </script>


<script>
    document.getElementById("myForm").addEventListener("submit", function(event) {
        const roomsTable = document.getElementById("roomsTable");
        const rowCount = roomsTable ? roomsTable.rows.length : 0;

        // Skip header row and check if there's at least one data row
        if (rowCount <= 1) {
            alert("Please add at least one room before submitting.");
            event.preventDefault();
        }
    });
</script>


</form:form>

<jsp:include page="../footer.jsp" />