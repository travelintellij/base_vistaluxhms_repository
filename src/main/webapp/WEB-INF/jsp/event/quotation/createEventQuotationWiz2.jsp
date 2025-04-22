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
    width: 100%;
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



     .key-value-table {
         width: 100%;
         border-collapse: collapse;
         table-layout: auto;         /* 👈 let the browser auto-size columns */
         word-break: keep-all;

       font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
       margin: 20px 0;
       background: #fff;
       border-radius: 10px;
       overflow: hidden;
       box-shadow: 0 2px 10px rgba(0,0,0,0.05);
     }

     .key-value-table th,
     .key-value-table td {
       padding: 14px 20px;
       font-size: 16px;
       border-bottom: 1px solid #eee;
       white-space: nowrap;
     }

    .key-value-table th {
      background: #f5f5f5;
      color: #333;
      font-weight: 600;
      text-align: left;
      white-space: nowrap;         /* 👈 prevents label text from wrapping */
      padding: 14px 20px;
      width: 30%;                  /* 👈 controls width */
      vertical-align: top;
    }


     .key-value-table td {
       background: #fff;
       color: #555;
     }

     .key-value-table tr:last-child th,
     .key-value-table tr:last-child td {
       border-bottom: none;
     }

     @media screen and (max-width: 768px) {
       .key-value-table tr {
         display: block;
         margin-bottom: 15px;
         border: 1px solid #ddd;
         border-radius: 8px;
       }

       .key-value-table th,
       .key-value-table td {
         display: block;
         width: 100%;
         padding: 10px 15px;
       }

       .key-value-table th {
         background: #e8f5e9;
       }

       .key-value-table td {
         background: #fdfdfd;
       }
     }

/* Base Styles */

/* Table Wrapper (optional) */
.table-container {
  max-width: 100%;
  overflow-x: auto;
  margin: 20px auto;
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  padding: 20px;
}

/* Table Styles */
.styled-table {
  width: 100%;
  border-collapse: collapse;
  table-layout: auto;
  min-width: 800px; /* Adjust based on columns */
}

/* Table Headers */
.styled-table thead tr {
  background-color: #4CAF50;
  color: white;
  text-align: left;
}

.styled-table th, .styled-table td {
  padding: 14px 20px;
  font-size: 15px;
  border-bottom: 1px solid #e0e0e0;
  white-space: nowrap;
}

/* Alternating Row Colors */
.styled-table tbody tr:nth-child(even) {
  background-color: #f9f9f9;
}

.styled-table tbody tr:hover {
  background-color: #f1f1f1;
  transition: background 0.3s ease;
}

/* Responsive Tweaks */
@media screen and (max-width: 768px) {
  .styled-table {
    font-size: 14px;
    min-width: 600px;
  }

  .styled-table th, .styled-table td {
    padding: 10px 14px;
  }
}
</style>




<div class="container">
    <h2>Create Event Quotation (Wiz 2) </h2>

    <form:form method="post" action="create_create_event_quoration" modelAttribute="EVENT_PACKAGE" id="myForm">
        <form:hidden path="guestId" />
        <form:hidden path="discount" />
        <!-- User Type Selection -->
     <table class="key-value-table">
       <tr>
         <th>Recipient Name</th>
         <td><form:input path="guestName" id="guestName" name="guestName"  class= "input-field" style="width:250px;"/></td>
         <th>Mobile</th>
         <td><form:input path="mobile" id="mobile" name="mobile"  placeholder="Mobile" class= "input-field"/>
         <th>Email</th>
         <td><form:input path="email" id="email" name="email"  placeholder="Email" class= "input-field" style="width:250px;"/></td>
         <th>Event Type</th>
         <td>${EVENT_PACKAGE.eventType.eventTypeName}</td>
       </tr>
     </table>
    <h3>List of Services</h3>
    <div class="table-container">
      <table class="styled-table">
        <thead>
          <tr>
            <th>Service Name</th>
            <th>Service Cost Type</th>
            <th>Base Cost</th>
            <th>Quantity</th>
            <th>Total Cost</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
        <c:forEach var="service" items="${eventPackageEntityDTO.services}" varStatus="status">
            <tr>
                <td><form:input path="services[${status.index}].serviceName" class= "input-field"  style="width:450px;" /></td>
              <td>
              <form:select path="services[${status.index}].eventServiceCostTypeEntity"
                                      items="${LIST_SERVICE_COST_TYPE}"
                                      itemValue="eventServiceCostTypeId"
                                      itemLabel="eventServiceCostTypeName"
                                      cssClass="form-control"/>
              </td>

              <td><form:input path="services[${status.index}].costPerUnit" class= "input-field" style="width:100px;" /></td>
              <td><form:input path="services[${status.index}].quantity" class= "input-field" style="width:100px;" /></td>
              <td><form:input path="services[${status.index}].totalCost" class= "input-field" style="width:100px;" /></td>
              <td><input type="button" name="update" value="update"> |<input type="button" name="Delete" value="Delete">
            </tr>
        </c:forEach>
          <!-- Add more rows -->
        </tbody>
      </table>
    </div>






        <button type="submit" class="btn">Generate</button>
</div>




</form:form>

<jsp:include page="../../footer.jsp" />