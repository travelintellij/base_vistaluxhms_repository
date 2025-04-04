<jsp:include page="../../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

 <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 20px;
            padding: 20px;
        }
        .session-container {
            margin-bottom: 30px;
            border: 2px solid #007bff;
            border-radius: 10px;
            background: #ffffff;
            padding: 15px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        .session-header {
            background: #007bff;
            color: white;
            padding: 10px;
            font-size: 18px;
            font-weight: bold;
            text-align: center;
            border-radius: 8px 8px 0 0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            background: #ffffff;
        }
        th, td {
            border: 1px solid #dee2e6;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        .room-name {
            font-weight: bold;
            background: #e9ecef;
        }
        .meal-plan {
            font-style: italic;
            color: #343a40;
        }
         .submit-btn {
                margin-top: 10px;
                display: flex;
                justify-content: center;
            }
    </style>
  <form:form modelAttribute="SALES_PARTNER_OBJ" action="send_send_sales_partner_rate_share">
        <form:hidden path="salesPartnerId" />

        <c:forEach var="ratesessionId" items="${RATE_TYPE_SESSION_MAPPING_ID_LIST}">
            <input type="hidden" name="rateSessionMappingIds" value="${ratesessionId}" />
        </c:forEach>

        <h3 style="text-align: center; font-family: Arial, sans-serif; font-size: 24px; font-weight: bold;">
                Share Season Rates with
                <span style="color: #007bff; font-size: 26px; font-weight: bold; text-transform: uppercase;">
                    ${SALES_PARTNER_OBJ.salesPartnerName}
                </span>
            </h3>

      <!-- Back Button Row -->
   <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
       <div style="flex: 1; margin-right: 10px;">
          To: <form:input path="email" id="email" name="email" class="form-control" style="height: 38px;width:500px; font-size: 20px;" /> (Comma Seperated)
       </div>
       <div>
           <button type="button" class="btn btn-secondary"
               onclick="location.href='view_share_season_sales_partner_form?salesPartnerId=${SALES_PARTNER_OBJ.salesPartnerId}'">
               Back
           </button>
       </div>
   </div>

        <div align="center" style="margin:10px 0"><b>
            <font color="green">${Success} </font>
            <font color="red">${Error}</font>
        </b></div>



       <c:forEach var="sessionWiseRecord" items="${SESSION_SHARE_LIST}">
           <div class="session-container">
               <!-- Session Header -->
               <div class="session-header">
                   <c:if test="${not empty sessionWiseRecord.sessionDetailsMap}">
                       <c:set var="firstKey" value="${sessionWiseRecord.sessionDetailsMap.keySet().iterator().next()}" />
                       <c:set var="firstSubKey" value="${sessionWiseRecord.sessionDetailsMap[firstKey].keySet().iterator().next()}" />
                       <c:set var="firstElement" value="${sessionWiseRecord.sessionDetailsMap[firstKey][firstSubKey]}" />
                       Rate Validity : Start Date: ${firstElement.sessionStartDate} |  End Date: ${firstElement.sessionEndDate}
                   </c:if>
               </div>
               <table>
                   <tr>
                       <th>Room ID</th>
                       <th>Room Category</th>
                       <th>Max Occupancy</th>
                       <th>Extra Bed</th>
                       <c:forEach var="mealPlanEntry" items="${mealPlans}">
                           <th class="meal-plan">${mealPlanEntry.value}</th>
                       </c:forEach>
                   </tr>
                   <c:forEach var="roomEntry" items="${sessionWiseRecord.roomCategoryNames}">
                       <c:set var="roomId" value="${roomEntry.key}" />
                       <c:set var="roomDetails" value="${roomEntry.value}" />
                       <tr class="room-name">
                           <td>${roomId}</td>
                           <td>${roomDetails.roomCategoryName}</td>
                           <td>${roomDetails.maxOccupancy}</td>
                           <td>${roomDetails.extraBed}</td>
                           <c:forEach var="mealPlanEntry" items="${mealPlans}">
                               <td>
                                   <c:forEach var="i" begin="1" end="${roomDetails.standardOccupancy}">
                                       <c:set var="personField" value="person${i}" />
                                       P${i}: ${sessionWiseRecord.sessionDetailsMap[roomId][mealPlanEntry.key][personField]}<br>
                                   </c:forEach>
                               </td>
                           </c:forEach>
                       </tr>
                   </c:forEach>
               </table>
           </div>
       </c:forEach>
       <div class="submit-btn">
            <button type="submit" class="btn"  id="email" value="email">Send Season Rates</button>
            <button type="submit" class="btn" name="download" id="download" value="download">Download Pricing</button>
        </div>
</form:form>

<script>
    function isValidEmail(email) {
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        return emailRegex.test(email.trim());
    }

    document.addEventListener("DOMContentLoaded", function () {
        const form = document.querySelector("form");
        const emailInput = document.getElementById("email");

        form.addEventListener("submit", function (e) {
            const emailStr = emailInput.value;
            const emailList = emailStr.split(",").map(email => email.trim()).filter(email => email !== "");

            if (emailList.length === 0) {
                alert("Please enter at least one email address.");
                e.preventDefault();
                return;
            }

            const invalidEmails = emailList.filter(email => !isValidEmail(email));

            if (invalidEmails.length > 0) {
                alert("The following email(s) are invalid:\n" + invalidEmails.join("\n"));
                e.preventDefault();
                return;
            }
        });
    });
</script>

<jsp:include page="../../footer.jsp" />
