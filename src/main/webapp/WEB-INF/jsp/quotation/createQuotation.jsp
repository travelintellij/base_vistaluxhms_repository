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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quotation Form</title>
    <link rel="stylesheet" href="styles.css">
    <script src="script.js" defer></script>
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
    max-width: 1200px;
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

.form-group {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 100%;
    margin-bottom: 15px;
}

/* User Selection Styles */
.select-box {
    width: 80%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

.mobile-email-container {
    display: flex;
    gap: 10px;
    width: 65%;
}

.input-field {
    width: 80%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 5px;
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

    <form id="quotationForm">
        <!-- User Type Selection -->
        <div class="form-group">
            <label for="userType">Select Type:</label>
            <select class="select-box" style="width:200px;" id="userType" onchange="toggleFields()">
                <option value="">Select</option>
                <option value="client">Client</option>
                <option value="salespartner">Sales Partner</option>
                <option value="unregistered">Unregistered</option>
            </select>

            <!-- Mobile & Email Fields (Hidden by Default) -->
            <div class="mobile-email-container" id="mobileEmailContainer" style="display: none;">
                <input type="text" id="mobile" class="input-field" placeholder="Enter Mobile Number">
                <input type="email" id="email" class="input-field" placeholder="Enter Email">
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
                </tbody>
            </table>
        </div>

        <button type="submit" class="btn">Submit</button>
    </form>
</div>

    <script>
    function toggleFields() {
        let userType = document.getElementById("userType").value;
        let mobileEmailContainer = document.getElementById("mobileEmailContainer");

        let mobileInput = document.getElementById("mobile");
        let emailInput = document.getElementById("email");

        if (userType === "unregistered") {
            mobileEmailContainer.style.display = "flex";
            mobileInput.placeholder = "Enter Mobile Number";
            emailInput.placeholder = "Enter Email";
        } else if (userType === "client" || userType === "salespartner") {
            mobileEmailContainer.style.display = "flex";
            mobileInput.placeholder = "Enter Name"; // Change placeholder for name
            emailInput.placeholder = "Enter Company Name"; // Change placeholder for company name
        } else {
            mobileEmailContainer.style.display = "none";
        }
    }


     // Function to Add a Room
     function addRoom() {
         let tableBody = document.querySelector("#roomsTable tbody");
         let newRow = document.createElement("tr");

         newRow.innerHTML = `
             <td>
                 <select class="select-box" style="width:200px;">
                     <option value="Deluxe">Deluxe</option>
                     <option value="Super Deluxe">Super Deluxe</option>
                     <option value="Suite">Suite</option>
                 </select>
             </td>
             <td>
                 <select class="select-box" style="width:100px;>
                     <option value="CP">CP (Breakfast)</option>
                     <option value="MAP">MAP (Breakfast + Dinner)</option>
                     <option value="AP">AP (All Meals)</option>
                 </select>
             </td>
             <td><input type="number" class="input-field" placeholder="Adults" min="1"></td>
             <td><input type="number" class="input-field" placeholder="Child (with bed)" min="0"></td>
             <td><input type="number" class="input-field" placeholder="Child (no bed)" min="0"></td>
             <td><input type="number" class="input-field" placeholder="Extra Bed" min="0"></td>
             <td><input type="date" class="input-field"></td>
             <td><input type="date" class="input-field"></td>
             <td>
                 <button type="button" class="btn btn-danger" onclick="removeRoom(this)">Remove</button>
             </td>
         `;

         tableBody.appendChild(newRow);
     }

     // Function to Remove a Room
     function removeRoom(button) {
         let row = button.parentNode.parentNode;
         row.parentNode.removeChild(row);
     }

    </script>



<jsp:include page="../footer.jsp" />