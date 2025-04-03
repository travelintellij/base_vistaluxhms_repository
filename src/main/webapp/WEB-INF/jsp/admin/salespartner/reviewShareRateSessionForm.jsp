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
    </style>
  <h2 class="text-center mb-4">Seasonal Room Rates</h2>
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





</body>
</html>
