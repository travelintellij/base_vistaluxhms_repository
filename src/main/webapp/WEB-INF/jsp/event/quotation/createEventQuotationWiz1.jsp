<jsp:include page="../../_menu_builder_header.jsp" />
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
               background-image: url('<%= request.getContextPath() %>/resources/images/event-reg.jpg');
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
                 guestNameInput.setAttribute('required', 'required');
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
    <h2>Create Event Quotation</h2>

    <form:form method="post" action="create_event_quotation_wiz_2" modelAttribute="EVENT_PACKAGE" id="myForm">
        <form:hidden path="guestId" />
        <form:hidden path="discount" />
        <!-- User Type Selection -->

        <div class="form-group">
              <label for="quotationAudienceType">User Type:</label>

              <form:select path="quotationAudienceType" onchange="handleUserTypeChange()" style="width: 300px;height: 60px;padding: 8px 12px;font-size: 16px;border: 2px solid #4CAF50;border-radius: 8px;background: linear-gradient(white, #f1f1f1);color: #333;outline: none;cursor: pointer;transition: all 0.3s ease-in-out;">
                    <form:option value="0">Select</form:option>
                 <form:option value="1">Client</form:option>
                 <form:option value="2">Unregistered</form:option>
              </form:select>
                &nbsp;&nbsp;&nbsp;&nbsp;
              <label for="Event Type">Event Type:</label>
                <form:select path="eventType" style="width: 300px;height: 60px;padding: 8px 12px;font-size: 16px;border: 2px solid #4CAF50;border-radius: 8px;background: linear-gradient(white, #f1f1f1);color: #333;outline: none;cursor: pointer;transition: all 0.3s ease-in-out;">
                      <form:options items="${EVENT_TYPES}" itemValue="eventTypeId" itemLabel="eventTypeName" />
                  </form:select>
          </div>

          <div id="clientBox" class="row hidden" style="width: 400px;height: 60px;padding: 8px 12px;font-size: 16px;border: 2px solid #4CAF50;border-radius: 8px;background: linear-gradient(white, #f1f1f1);color: #333;outline: none;cursor: pointer;transition: all 0.3s ease-in-out;">
              <label for="clientName">Client Name:</label>
              <form:input path="guestName" />
              <font color="red">
                  <form:errors path="guestName" cssClass="error"  />
              </font>
          </div>

          <div id="salesBox" class="row hidden" style="width: 400px;height: 60px;padding: 8px 12px;font-size: 16px;border: 2px solid #4CAF50;border-radius: 8px;background: linear-gradient(white, #f1f1f1);color: #333;outline: none;cursor: pointer;transition: all 0.3s ease-in-out;">
              <label for="salespartner">Sales Partner:</label>
              <input type="text" id="salespartner" name="salespartner" class="input-field">
          </div>

          <div id="unregisteredBox" class="hidden" >
              <div class="form-group">
                  <label for="contactMethod">Contact By:</label>
                    <form:select path="contactMethod" onchange="handleContactChange()" style="width: 100px;height: 60px;padding: 8px 12px;font-size: 16px;border: 2px solid #4CAF50;border-radius: 8px;background: linear-gradient(white, #f1f1f1);color: #333;outline: none;cursor: pointer;transition: all 0.3s ease-in-out;">
                       <form:option value="">Select</form:option>
                       <form:option value="mobile">Mobile</form:option>
                       <form:option value="email">Email</form:option>
                       <form:option value="both">Both</form:option>
                    </form:select>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     <div class="row">
                          <form:input path="mobile" id="mobile" name="mobile"  placeholder="Mobile" class= "input-field"/>
                          <form:input path="email" id="email" name="email"  placeholder="Email" class= "input-field" style="width:250px;"/>
                      </div>
              </div>
          </div>

         <div class="form-group">
           <div id="eventDetails">
           <div class="row" style="margin-bottom: 20px;">
              <div style="margin-right: 100px;">
                <label for="baseGuestCount">Package Name</label><br/>
                <form:input path="packageName" id="packageName" name="packageName" placeholder="Package Name" style="width: 300px; padding: 8px; font-size: 14px; border: 1px solid #ccc; border-radius: 4px;" min="5" required="required"/>
              </div>
            </div>
             <div class="row" style="margin-bottom: 20px;">
               <div style="margin-right: 100px;">
                 <label for="baseGuestCount">Number of Guests:</label><br/>
                 <form:input path="baseGuestCount" id="baseGuestCount" name="baseGuestCount" placeholder="Guest Count" style="width: 120px; padding: 8px; font-size: 14px; border: 1px solid #ccc; border-radius: 4px;" min="5" required="required"/>
               </div>
              <div style="margin-right: 100px;">
                <label for="baseGuestCount">Total Rooms:</label><br/>
                <form:input path="numberOfRooms" id="numberOfRooms" name="numberOfRooms" placeholder="Total Rooms" style="width: 120px; padding: 8px; font-size: 14px; border: 1px solid #ccc; border-radius: 4px;" min="5" required="required"/>
              </div>

               <div style="margin-right: 100px;">
                 <label for="eventStartDate">Event Start Date:</label><br/>
                    <form:input path="eventStartDate" type="date" style="padding: 8px; font-size: 14px; border: 1px solid #ccc; border-radius: 4px; width: 220px; background-color: #f9f9f9; color: #333; transition: all 0.3s ease-in-out;"/>
                    <font color="red">
                          <form:errors path="eventStartDate" cssClass="error"  />
                      </font>
               </div>
               <div>
                 <label for="eventEndDate">Event End Date:</label><br/>
                    <form:input path="eventEndDate" type="date" style="padding: 8px; font-size: 14px; border: 1px solid #ccc; border-radius: 4px; width: 220px; background-color: #f9f9f9; color: #333; transition: all 0.3s ease-in-out;"/>
                    <font color="red">
                          <form:errors path="eventEndDate" cssClass="error"  />
                      </font>
                </div>
           </div>
            <button type="submit" class="btn">Next</button>
         </div>


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


    </script>




</form:form>

<jsp:include page="../../footer.jsp" />