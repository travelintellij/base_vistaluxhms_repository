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

.action-buttons {
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    gap: 15px;
    margin: 30px auto;
  }

  .btn {
    padding: 12px 20px;
    font-size: 15px;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    color: white;
    font-weight: 500;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    transition: all 0.3s ease-in-out;
  }

  .btn-recalc {
    background-color: #007bff;
  }

  .btn-save {
    background-color: #28a745;
  }

  .btn-download {
    background-color: #17a2b8;
  }

  .btn-whatsapp {
    background-color: #25D366;
  }

  .btn-email {
    background-color: #6f42c1;
  }

  .btn:hover {
    opacity: 0.9;
    transform: scale(1.03);
  }

  .btn-delete-event {
    background-color: #ff4d4d !important;
    border: none !important;
    color: white !important;
    padding: 8px 16px !important;
    text-align: center !important;
    text-decoration: none !important;
    display: inline-block !important;
    font-size: 14px !important;
    margin: 4px 2px !important;
    border-radius: 6px !important;
    cursor: pointer !important;
    transition: all 0.3s ease-in-out !important;
  }
  .btn-delete-event:hover {
    background-color: #ff3333 !important;
  }
  #finalAmount, #grandTotal {
    padding-right: 25px !important;
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

 .summary-container {
     margin-top: 30px;
     padding: 20px;
     border-radius: 12px;
     width: 60%;
     margin-left: auto;
     background-color: #f9f9f9;
     box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
     font-family: 'Segoe UI', sans-serif;
   }

   .styled-table {
     width: 100%;
     border-collapse: collapse;
   }

   .styled-table td, .styled-table th {
     padding: 12px;
     text-align: left;
     vertical-align: middle;
   }

   .styled-table th {
     color: #333;
     font-weight: 600;
   }

   .styled-table td {
     color: #2b2b2b;
   }

   .input-field {
     width: 120px;
     padding: 6px 10px;
     border-radius: 6px;
     border: 1px solid #ccc;
   }

   .custom-checkbox {
     display: flex;
     align-items: center;
   }

   .custom-checkbox input[type="checkbox"] {
     appearance: none;
     width: 18px;
     height: 18px;
     border: 2px solid #007b5e;
     border-radius: 4px;
     background-color: white;
     cursor: pointer;
     margin-right: 8px;
     position: relative;
   }

   .custom-checkbox input[type="checkbox"]:checked {
     background-color: #007b5e;
   }

   .custom-checkbox input[type="checkbox"]::after {
     content: '';
     position: absolute;
     top: 2px;
     left: 5px;
     width: 5px;
     height: 10px;
     border: solid white;
     border-width: 0 2px 2px 0;
     transform: rotate(45deg);
     display: none;
   }

   .custom-checkbox input[type="checkbox"]:checked::after {
     display: block;
   }

   #finalAmount {
     font-weight: bold;
     color: #007b5e;
     text-align: right;
   }

   #grandTotal {
     text-align: right;
   }
</style>




<div class="container">
    <h2>Update Event Quotation (<font color="blue"> Event Id: ${EVENT_PACKAGE.id} </font>) </h2>
      <c:if test="${not empty SuccessMessage}">
          <div class="alert alert-success"><font color="green">${SuccessMessage}<font></div>
      </c:if>

    <form:form method="post" action="create_create_event_quotation" modelAttribute="EVENT_PACKAGE" id="myForm">
        <form:hidden path="id" />
        <form:hidden path="guestId" />
        <form:hidden path="baseGuestCount" />
        <form:hidden path="numberOfRooms" />
        <form:hidden path="eventType.eventTypeId" />
        <form:hidden path="eventType.eventTypeName" />
        <form:hidden path="grand_total_cost" />
        <form:hidden path="quotationAudienceType" />
        <form:hidden path="contactMethod" />
        <form:hidden path="update" value="true"/>
        <input type="hidden" id="initialServiceCount" value="${fn:length(EVENT_PACKAGE.services)}" />
        <input type="hidden" name="deleteIndex" id="deleteIndex" />


         <div class="row" style="margin-bottom: 20px;">
          <div style="margin-right: 100px;">
            <label for="baseGuestCount"><b>Package Name</label><b>
            <form:input path="packageName" id="packageName" name="packageName" placeholder="Package Name" style="width: 300px; padding: 8px; font-size: 14px; border: 1px solid #ccc; border-radius: 4px;" min="5" required="required"/>
          </div>
        </div>
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
     <table class="key-value-table">
         <tr>
            <th>Number of Guests </th>
            <td>${EVENT_PACKAGE.baseGuestCount}</td>
            <th>Total Rooms</th>
            <td>${EVENT_PACKAGE.numberOfRooms}</td>
            <th>Event Start Date></th>
            <td>
                <form:input path="eventStartDate" type="date" style="padding: 8px; font-size: 14px; border: 1px solid #ccc; border-radius: 4px; width: 220px; background-color: #f9f9f9; color: #333; transition: all 0.3s ease-in-out;"/>


            </td>
            <th>Event End Date></th>
            <td>
                <form:input path="eventEndDate" type="date" style="padding: 8px; font-size: 14px; border: 1px solid #ccc; border-radius: 4px; width: 220px; background-color: #f9f9f9; color: #333; transition: all 0.3s ease-in-out;"/>
            </td>
         </tr>
      </table>
     <font color="red">
      <form:errors path="eventStartDate" cssClass="error"  />
    </font>
    <font color="red">
      <form:errors path="eventEndDate" cssClass="error"  />
    </font>
    <font color="red">
      <form:errors path="email" cssClass="error"  />
    </font>
    <h3>List of Services</h3>

    <div class="table-container">
     <table class="styled-table" id="service-table">
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


<tbody id="services-table-body">

<c:forEach var="service"
           items="${eventPackageEntityDTO.services}"
           varStatus="status">

  <form:hidden path="services[${status.index}].id" />

  <tr>

    <td>
      <form:input path="services[${status.index}].serviceName"
                  class="input-field"
                  style="width:450px;" />
    </td>

    <td>
      <form:select path="services[${status.index}].eventServiceCostTypeEntity.eventServiceCostTypeId"
                   items="${LIST_SERVICE_COST_TYPE}"
                   itemValue="eventServiceCostTypeId"
                   itemLabel="eventServiceCostTypeName"
                   cssClass="form-control service-cost-type" />
    </td>

    <td>
      <input name="services[${status.index}].costPerUnit"
                  class="input-field service-cost-per-unit"
                  style="width:100px;" placeholder="0" value="${service.costPerUnit == 0 ? '' : service.costPerUnit}" />
    </td>

    <td>
      <input name="services[${status.index}].quantity"
                  class="input-field service-quantity"
                  style="width:100px;" placeholder="0" value="${service.quantity == 0 ? '' : service.quantity}" />
    </td>

    <td>
      <form:input path="services[${status.index}].totalCost"
                  class="input-field service-total-cost"
                  style="width:100px;" readonly="true" />
    </td>

    <td>
      <button type="button" class="btn-delete-event"
              onclick="submitTo('delete_delete_package_service',
               ${EVENT_PACKAGE.id},
               '${service.id}',this); updateGrandTotal();">
        Delete
      </button>
    </td>

  </tr>

</c:forEach>


</tbody>


      </table>
<!-- Template Row (completely outside of <table>) -->




<button type="button" onclick="addServiceRow()">Add Service</button>
<div class="summary-container">
   <table class="styled-table">
    <tr>
    <td rowspan="3" style="vertical-align: top; padding-right: 20px;">
           <form:textarea path="description" rows="10" cols="30"
             placeholder="Enter remarks..."
             style="padding:8px; font-size:14px; border:1px solid #ccc; border-radius:4px; resize:vertical;" />
         </td>


       <th>GST Included</th>
       <td>
         <div class="custom-checkbox">
           <form:checkbox path="gstIncluded" id="gstIncluded" cssClass="styled-checkbox" />
         </div>
       </td>
       <td><strong>Grand Total</strong></td>
       <td id="grandTotal">${eventPackageEntityDTO.grand_total_cost}</td>
     </tr>
     <tr>
       <th>Show Cost Breakup</th>
       <td>
         <div class="custom-checkbox">
           <form:checkbox path="showBreakup" id="showBreakup" cssClass="styled-checkbox" />
         </div>
       </td>
       <td><strong>Discount</strong></td>
       <td>
         <form:input path="discount" cssClass="input-field" id="discountInput" />
         <div id="discountError" style="color:red; font-size: 12px;"></div>
       </td>
     </tr>

     <tr>
        <th>Hide Cost</th>
        <td>
          <div class="custom-checkbox">
            <form:checkbox path="hideCost" id="hideCost" cssClass="styled-checkbox" />
          </div>
        </td>
     </tr>

     <tr>
       <td colspan="3" style="font-weight: 600;"><strong>Final Amount</strong></td>
       <td id="finalAmount">${eventPackageEntityDTO.grand_total_cost - eventPackageEntityDTO.discount}</td>

     </tr>
   </table>
  </div>
 <div class="action-buttons">
   <button type="submit" class="btn btn-recalc" name="recalculate" id="recalculate" value="recalculate">Re-Calculate</button>
   <button type="submit" class="btn btn-save" name="updateQuotation" id="updateQuotation" value="updateQuotation">Save Quotation</button>
   <button type="submit" class="btn btn-download" name="Download" id="Download" value="Download">Download Quotation</button>
   <button type="submit" class="btn btn-email" name="Email" id="Email" value="Email">Email Quotation</button>
 </div>

</div>

<script>
  var LIST_SERVICE_COST_TYPE = [
     <c:forEach var="type" items="${LIST_SERVICE_COST_TYPE}" varStatus="loop">
       {
         id: "${type.eventServiceCostTypeId}",
         name: "${type.eventServiceCostTypeName}"
       }<c:if test="${!loop.last}">,</c:if>
     </c:forEach>
   ];

   function createServiceCostTypeSelect(serviceIndex) {
     let select = document.createElement('select');
     select.name = 'services[' + serviceIndex + '].eventServiceCostTypeEntity.eventServiceCostTypeId';
     select.className = 'form-control';

     LIST_SERVICE_COST_TYPE.forEach(type => {
       let option = document.createElement('option');
       option.value = type.id;
       option.text = type.name;
       select.appendChild(option);
     });

     return select.outerHTML; // Use this when inserting into innerHTML
   }

  let serviceIndexCounter = parseInt(document.getElementById("initialServiceCount").value) || 0;

function addServiceRow() {

    const tableBody = document.querySelector("#services-table-body");
    const serviceIndex = serviceIndexCounter++;

    const selectHTML = createServiceCostTypeSelect(serviceIndex);

    const newRow = document.createElement("tr");

    newRow.innerHTML = `
      <td>
        <input name="services[` + serviceIndex + `].serviceName"
               class="input-field"
               style="width:450px;" />
      </td>

      <td>` + selectHTML + `</td>

      <td>
        <input name="services[` + serviceIndex + `].costPerUnit"
               class="input-field service-cost-per-unit"
               style="width:100px;"
               min="0"
               type="number" value="" placeholder="0" />
      </td>

      <td>
        <input name="services[` + serviceIndex + `].quantity"
               class="input-field service-quantity"
               style="width:100px;"
               min="0"
               type="number" value="" placeholder="0" />
      </td>

      <td>
        <input name="services[` + serviceIndex + `].totalCost"
               class="input-field service-total-cost"
               style="width:100px;"
               min="0"
               type="number" value="0" readonly />
      </td>

      <td>
        <input type="button"
               value="Delete"
               class="btn-delete-event"
               onclick="deleteRow(this); updateGrandTotal();" />
      </td>
    `;

    tableBody.appendChild(newRow);
    updateGrandTotal();
}




function deleteRow(button) {
  const row = button.closest("tr"); // Get the row containing the clicked button
  const tableBody = document.querySelector("#services-table-body");

  // Remove the selected row
  tableBody.removeChild(row);

  // Re-index the remaining rows
  Array.from(tableBody.rows).forEach((row, index) => {
    const inputs = row.querySelectorAll("input, select");

    inputs.forEach(input => {
      if (input.name) {
        input.name = input.name.replace(/services\[\d+\]/, 'services[' + index + ']');
      }
    });
  });




}

function setDeleteIndex(index) {
        document.getElementById("deleteIndex").value = index;
}



   function getRowTotal(row) {
     const costTypeId = row.querySelector(".service-cost-type, select").value;
     const costPerUnit = parseFloat(row.querySelector(".service-cost-per-unit").value) || 0;
     const quantity = parseFloat(row.querySelector(".service-quantity").value) || 0;

     const startDateInput = document.getElementById("eventStartDate") || document.getElementsByName("eventStartDate")[0];
     const endDateInput = document.getElementById("eventEndDate") || document.getElementsByName("eventEndDate")[0];
     
     const startDate = new Date(startDateInput.value);
     const endDate = new Date(endDateInput.value);
     let totalNights = 1;
     if (!isNaN(startDate) && !isNaN(endDate) && endDate >= startDate) {
       totalNights = Math.ceil((endDate - startDate) / (1000 * 60 * 60 * 24));
       if (totalNights <= 0) totalNights = 1;
     }
     const totalDays = totalNights + 1;

     let costTypeName = "";
     LIST_SERVICE_COST_TYPE.forEach(type => {
       if (type.id == costTypeId) costTypeName = type.name;
     });

     let totalCost = 0;
     switch (costTypeName) {
       case "PER_GUEST_PER_NIGHT":
         totalCost = quantity * costPerUnit * totalNights;
         break;
       case "PER_GUEST_ONE_TIME":
         totalCost = quantity * costPerUnit;
         break;
       case "PER_GUEST_PER_DAY":
         totalCost = quantity * costPerUnit * totalDays;
         break;
       case "PER_ROOM_ONE_TIME":
         totalCost = quantity * costPerUnit;
         break;
       case "PER_ROOM_PER_NIGHT":
         totalCost = quantity * costPerUnit * totalNights;
         break;
       case "PER_DAY":
         totalCost = quantity * costPerUnit * totalDays;
         break;
       case "PER_NIGHT":
         totalCost = quantity * costPerUnit * totalNights;
         break;
       case "ONE_TIME":
         totalCost = quantity * costPerUnit;
         break;
       default:
         totalCost = quantity * costPerUnit;
     }
     return totalCost;
   }

   function calculateRowTotal(row) {
     const totalCost = getRowTotal(row);
     const totalCostInput = row.querySelector(".service-total-cost");
     totalCostInput.value = totalCost.toFixed(2);
   }

   function updateGrandTotal() {
     let grandTotal = 0;
     document.querySelectorAll("#services-table-body tr").forEach(row => {
       grandTotal += getRowTotal(row);
     });
     document.getElementById("grandTotal").textContent = grandTotal.toFixed(2);
     updateFinalAmount();
   }

  function updateFinalAmount() {
    const grandTotalText = document.getElementById("grandTotal").textContent.trim();
    const grandTotal = parseFloat(grandTotalText) || 0;
    const discountInput = document.getElementById("discountInput");
    let discount = parseFloat(discountInput.value) || 0;
    const errorEl = document.getElementById("discountError");

    if (discount > grandTotal) {
      errorEl.textContent = "Discount cannot exceed Grand Total.";
      discountInput.value = grandTotal;
      discount = grandTotal;
    } else {
      errorEl.textContent = "";
    }

    const finalAmount = grandTotal - discount;
    document.getElementById("finalAmount").textContent = finalAmount.toFixed(2);
  }

  document.addEventListener("DOMContentLoaded", function () {
    const discountInput = document.getElementById("discountInput");
    discountInput.addEventListener("input", updateFinalAmount);
    
    const recalculateBtn = document.getElementById("recalculate");
    if (recalculateBtn) {
        recalculateBtn.addEventListener("click", function(e) {
            // Recalculate all rows
            document.querySelectorAll("#services-table-body tr").forEach(row => {
                calculateRowTotal(row);
            });
            updateGrandTotal();
        });
    }

     // Real-time calculation listeners
     const tableBody = document.getElementById("services-table-body");
     if (tableBody) {
         tableBody.addEventListener("input", function(e) {
             if (e.target.matches(".service-cost-per-unit, .service-quantity")) {
                 updateGrandTotal();
             }
         });
         tableBody.addEventListener("change", function(e) {
             if (e.target.matches(".service-cost-type")) {
                 updateGrandTotal();
             }
         });
     }

     updateGrandTotal();

    // Initial calculation (optional)
    // document.querySelectorAll("#services-table-body tr").forEach(calculateRowTotal);
    // updateGrandTotal();
  });


  function submitTo(url, param1,param2,button) {
    if (!param2 || param2 === "0" || param2 === "undefined") {
      deleteRow(button);
    } else {
      document.getElementById('myForm').action = url;
      document.getElementById('id').value = param1;
      document.getElementById('deleteIndex').value = param2;
      document.getElementById('myForm').submit();
      }
  }
</script>

<script>
document.addEventListener("DOMContentLoaded", function () {

    const showBreakup = document.getElementById("showBreakup");
    const hideCost = document.getElementById("hideCost");

    function handleCheckboxChange(changed) {

        if (changed === showBreakup && showBreakup.checked) {
            hideCost.checked = false;
        }

        if (changed === hideCost && hideCost.checked) {
            showBreakup.checked = false;
        }
    }

    showBreakup.addEventListener("change", function () {
        handleCheckboxChange(showBreakup);
    });

    hideCost.addEventListener("change", function () {
        handleCheckboxChange(hideCost);
    });

});
</script>


</form:form>

<jsp:include page="../../footer.jsp" />