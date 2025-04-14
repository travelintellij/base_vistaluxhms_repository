
    
    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
      
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/6f6addf9b0.js" crossorigin="anonymous"></script> 
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/revamped/style.css">
</head>
<body>

<form:form modelAttribute="LEAD_OBJ" action="form_view_editlead">
    <form:hidden path="leadId" />

    <div class="follow-up-pop-up container" >

    <div>

    <input type="checkbox" class="lead-de-ch" style="height:20px;width:20px;position:absolute;top:7px;left:10px;opacity:0">
    </div>
    
    
    
        <h1>Lead Details</h1>
        <div class="fupp-fir-line ab">
            <div class="fupp-1-d">
                <h3>Lead ID</h3>
                <p>${LEAD_OBJ.leadId}</p>
            </div>
            <div class="fupp-1-d">
                <h3>Client</h3>
                <p>${LEAD_OBJ.client.clientName}</p>
            </div>
            <div class="fupp-1-d">
                <h3>Lead Owner</h3>
                <p>${LEAD_OBJ.leadOwnerName}</p>
            </div>
            <div class="fupp-1-d">
                <h3>Status</h3>
                <p>${LEAD_OBJ.statusName}</p>
            </div>
        </div>
        <div class="fupp-2nd-line ab">
            <div class="fupp-1-d">
                <h3>Adults</h3>
                <p>${LEAD_OBJ.adults}</p>
            </div>
            <div class="fupp-1-d">
                <h3>Child with Bed | Child No Bed</h3>
                <p>${LEAD_OBJ.cwb} | ${LEAD_OBJ.cnb}</p>
            </div>
            <div class="fupp-1-d">
                <h3>Check In date</h3>
                ${LEAD_OBJ.formattedCheckInDate}
            </div>
            <div class="fupp-1-d">
                <h3>Check Out date</h3>
                ${LEAD_OBJ.formattedCheckOutDate}
            </div>
        </div>

        <div class="fupp-5th-line ab" >
            <h3>Remarks</h3>
            <p>${LEAD_OBJ.clientRemarks}</p>
        </div>
                 </div>
              
            </form:form>

    </body>
</html>