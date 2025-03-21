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
    <script>
        function handleUserTypeChange() {
            var userType = document.getElementById("quotationAudienceType").value;
            document.getElementById("clientBox").classList.add("hidden");
            document.getElementById("salesBox").classList.add("hidden");
            document.getElementById("unregisteredBox").classList.add("hidden");
            document.getElementById("contactMethod").value = ""; // Reset contact dropdown
            document.getElementById("mobile").classList.add("hidden");
            document.getElementById("email").classList.add("hidden");

            if (userType === "1") {
                document.getElementById("clientBox").classList.remove("hidden");
            } else if (userType === "2") {
                document.getElementById("salesBox").classList.remove("hidden");
            } else if (userType === "3") {
                document.getElementById("unregisteredBox").classList.remove("hidden");
            }
        }

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
    <h2>Create Quotation</h2>

    <form:form method="post" action="review_process_create_quotation" modelAttribute="QUOTATION_OBJ">

        <!-- User Type Selection -->
  <div class="form-group">
              <label for="quotationAudienceType">User Type:</label>

              <form:select path="quotationAudienceType" onchange="handleUserTypeChange()" style="width: 600px;height: 60px;padding: 8px 12px;font-size: 16px;border: 2px solid #4CAF50;border-radius: 8px;background: linear-gradient(white, #f1f1f1);color: #333;outline: none;cursor: pointer;transition: all 0.3s ease-in-out;">
                    <form:option value="0">Select</form:option>
                 <form:option value="1">Client</form:option>
                 <form:option value="2">Sales Partner</form:option>
                 <form:option value="3">Unregistered</form:option>
              </form:select>
          </div>

          <div id="clientBox" class="row hidden" style="width: 400px;height: 60px;padding: 8px 12px;font-size: 16px;border: 2px solid #4CAF50;border-radius: 8px;background: linear-gradient(white, #f1f1f1);color: #333;outline: none;cursor: pointer;transition: all 0.3s ease-in-out;">
              <label for="clientName">Client Name:</label>
              <input type="text" id="clientName" name="clientName" class="input-field">
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

        <!-- Room Details (Dynamically Added Rows) -->
        <div id="roomsContainer">
            <h3>Room Details</h3>
            <button type="button" class="btn add-room" onclick="addRoom()">+ Add Room</button>
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
    <c:forEach var="room" items="${QUOTATION_OBJ.roomDetails}" varStatus="status">
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
            <td><input type="number" name="roomDetails[${status.index}].childWithBed" class="input-field" value="${room.childWithBed}" min="0" style="width:70px;" required /></td>
            <td>
                <font color="red"><form:errors path="roomDetails[${status.index}].childNoBed" cssClass="error"  /></font>
                <input type="number" name="roomDetails[${status.index}].childNoBed" class="input-field" value="${room.childNoBed}" min="0"  style="width:70px;" required />
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

        <button type="submit" class="btn">Submit</button>

</div>


  <script>

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
        <td><input type="number" name="roomDetails[\${rowCount}].adults" class="input-field" min="1" style="width:70px;" required /></td>
        <td><input type="number" name="roomDetails[\${rowCount}].childWithBed" class="input-field" min="0" style="width:70px;" required /></td>
        <td><input type="number" name="roomDetails[\${rowCount}].childNoBed" class="input-field" min="0" style="width:70px;" required /></td>
        <td><input type="number" name="roomDetails[\${rowCount}].extraBed" class="input-field" min="0" style="width:70px;" required /></td>
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

</form:form>

<jsp:include page="../footer.jsp" />