<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Season Rates for ${salesPartnerName}</title>
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
</head>
<body>
<h3 style="text-align: center; font-family: Arial, sans-serif; font-size: 24px; font-weight: bold;">
    Season Rates for <span style="color: #007bff; font-size: 26px; font-weight: bold; text-transform: uppercase;">${salesPartnerName}</span>
</h3>
<#list sessionShareList as sessionWiseRecord>
<div class="session-container">
    <div class="session-header">
        <#if sessionWiseRecord.sessionDetailsMap?size gt 0>
        <#assign firstKey = sessionWiseRecord.sessionDetailsMap?keys?first />
        <#assign firstSubKey = sessionWiseRecord.sessionDetailsMap[firstKey]?keys?first />
        <#assign firstElement = sessionWiseRecord.sessionDetailsMap[firstKey][firstSubKey] />
        Rate Validity: Start Date: ${firstElement.sessionStartDate} | End Date: ${firstElement.sessionEndDate}
    </#if>
</div>
<table>
    <tr>
        <th>Room ID</th>
        <th>Room Category</th>
        <th>Max Occupancy</th>
        <th>Extra Bed</th>
        <#list mealPlans as key, mealPlanName>
        <th class="meal-plan">${mealPlanName}</th>
    </#list>
    </tr>
    <#list sessionWiseRecord.roomCategoryNames as roomId, roomDetails>
    <tr class="room-name">
        <td>${roomId}</td>
        <td>${roomDetails.roomCategoryName}</td>
        <td>${roomDetails.maxOccupancy}</td>
        <td>${roomDetails.extraBed}</td>
        <#list mealPlans as mealPlanKey, mealPlanName>
        <td>
            <#list 1..roomDetails.standardOccupancy as i>
            P${i}: ${sessionWiseRecord.sessionDetailsMap[roomId][mealPlanKey]["person" + i]}<br>
        </#list>
        </td>
    </#list>
    </tr>
</#list>
</table>
</div>
</#list>
</body>
</html>
