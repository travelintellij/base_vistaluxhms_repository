<jsp:include page="../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">
<script src="<c:url value="/resources/core/jquery.1.10.2.min.js" />"></script>
<script src="<c:url value="/resources/core/jquery.autocomplete.min.js" />"></script>
<style>
    body {
        background-image: url('<%= request.getContextPath() %>/resources/images/newlead.jpg');
        background-size: cover; /* Ensures the image covers the full page */
        background-position: center; /* Centers the image */
        background-attachment: fixed; /* Keeps the background fixed while scrolling */
        height: 100vh; /* Ensures the background covers the full height of the viewport */
        position: relative; /* Required for the overlay */
    }

    /* Create a watermark-like effect using an overlay */
    body::after {
        content: "";  /* Empty content for the overlay */
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;

        background: rgba(255, 255, 255, 0.3); /* Semi-transparent white overlay */
        z-index: -1; /* Place the overlay behind the content */
    }

    /* Optional: If you want to adjust the opacity of the image to make it more subtle */
    body {
        opacity: .98; /* Adjust the opacity for the background image */
    }

</style>


    <h2>New Lead</h2> <!-- Bold Header -->
    <div class="form-container" style="width: 60%; min-width: 60%; max-width: 60%;">
        <form:form method="post" action="create_create_lead" modelAttribute="LEAD_OBJ" autocomplete="off">
            <input type="hidden" id="clientId" name="client.clientId" value="${LEAD_OBJ.client.clientId}" />
            <div class="form-table">
                <div class="form-cell">
                    <label for="field1">Lead Id</label>
                    Auto Generated
                </div>
                <div class="form-cell">
                    <label for="field2" style="font-weight:600">Client Name</label>
                    <form:input path="clientName" required="required" />
                    <font color="red">
                        <form:errors path="clientName" cssClass="error"  />
                    </font>
                </div>
                <div class="form-cell">
                    <div class="form-row">
                        <label for="field4">Lead Owner:</label>
                        <sec:authorize access="hasAnyRole('ADMIN','LEAD_MANAGER')">
                                    <form:select path="leadOwner" required="required" style="width:90%">
                                        <c:forEach items="${ACTIVE_USERS_MAP}" var="userMap">
                                            <c:if test="${userMap.key eq userId }">
                                                <option class="service-small" value="${userMap.key}" selected>
                                                    ${userMap.value}</option>
                                            </c:if>
                                            <c:if test="${userMap.key ne userId }">
                                                <option class="service-small" value="${userMap.key}">
                                                    ${userMap.value}</option>
                                            </c:if>
                                        </c:forEach>
                                    </form:select>
                        </sec:authorize>
                        <sec:authorize access="! hasAnyRole('ADMIN','LEAD_MANAGER')">
                              <b><font color="red">${userName}</font></b>
                        </sec:authorize>
                        </div>
                </div>
                <div class="form-cell" >
                    <div class="form-row">
                        <label for="active-status">Status:</label>
                       <form:select path="leadStatus" required="required" style="width:20%">
                           <form:options items="${LEAD_STATUS_MAP}" />
                       </form:select>
                    </div>
                 </div>
                </div>
                <div class="form-table">
                <div class="form-cell" >
                    <label for="field5">Adults</label>
                    <form:input path="adults" type="number" required="required" min="1" /> <br>
                    <font color="red">
                        <form:errors path="adults" cssClass="error" />
                    </font>
                </div>
                <div class="form-cell">
                    <label for="field6">Child With Bed</label>
                    <form:input path="cwb" type="number" required="required" />
                    <font color="red">
                        <form:errors path="cwb" cssClass="error" />
                    </font>
                </div>
                <div class="form-cell">
                    <label for="field7">Child No Bed</label>
                    <form:input path="cnb" type="number" required="required" /> <br>
                    <font color="red">
                        <form:errors path="cnb" cssClass="error" />
                    </font>
                </div>
                <div class="form-cell">
                    <label for="field8">Comp Child</label>
                    <form:input path="compChild" /> <br>
                    <font color="red">
                        <form:errors path="compChild" cssClass="error" />
                    </font>
                </div>
                <div class="form-cell">
                     <label for="" >Check In Date</label>
                     <form:input path="checkInDate" type="date" required="required" />
                 </div>
                  <div class="form-cell">
                     <label for="field8">Check Out Date</label>
                     <form:input path="checkOutDate" type="date" required="required" /> <br>
                     <font color="red">
                         <form:errors path="checkOutDate" cssClass="error" />
                     </font>
                 </div>
                  <div class="form-cell">
                      <label for="Qualified">Qualified:</label>
                         <div class="radio-group-container">
                             <div class="radio-group">
                                 <label>
                                     <form:radiobutton path="qualified" name="qualified" value="true" required="required" />
                                     <span>Yes</span>
                                 </label>
                                 <label>
                                     <form:radiobutton path="qualified" name="qualified"  value="false" required="required" />
                                     <span>No</span>
                                 </label>
                             </div>
                         </div>
                   </div>
                   <div class="form-cell">
                      <label for="">Flagged:</label>
                      <div class="radio-group-container">
                           <div class="radio-group">
                               <label>
                                   <form:radiobutton path="flagged" name="flagged" value="true" required="required" />
                                   <span>Yes</span>
                               </label>
                               <label>
                                   <form:radiobutton path="flagged" name="flagged"  value="false" required="required" />
                                   <span>No</span>
                               </label>
                           </div>
                       </div>
                  </div>

            </div>

           <div class="form-table">
        <div class="form-cell">
            <font color="red">
                <form:errors path="minOneserviceError" cssClass="error" />
            </font>
            <label for="b2b-client">Query Type:</label>
                 <div class="checkbox-container">
                     <div class="checkbox-item">
                         <form:checkbox path="fit" id="fit" />
                         <label for="fit">FIT</label>
                     </div>
                     <div class="checkbox-item">
                         <form:checkbox path="groupEvent" id="groupEvent" />
                         <label for="groupEvent">Group</label>
                     </div>
                     <div class="checkbox-item">
                         <form:checkbox path="marriage" id="marriage" />
                         <label for="marriage">Marriage</label>
                     </div>
                     <div class="checkbox-item">
                         <form:checkbox path="others" id="others" />
                         <label for="others">Others</label>
                     </div>
                 </div>
             </div>


            <div class="form-cell" >
               <label for="">Client Remarks</label> <br>
               <form:textarea path = "clientRemarks" rows="6" maxlength="1000" style="width: 100%; box-sizing: border-box;" />
           </div>
            <div class="form-cell">
               <label for="">Internal Remarks</label> <br>
               <form:textarea path = "internalRemarks" rows="6"  maxlength="1000" style="width: 100%; box-sizing: border-box;"/>
           </div>
           <div class="form-cell">

                                <label for="b2b-client">Notify Client:</label>
                                   <div class="radio-group-container">
                                       <div class="radio-group">
                                           <label>
                                               <form:radiobutton path="leadCreationClientInformed" name="leadCreationClientInformed" value="true" required="required" />
                                               <span>Yes</span>
                                           </label>
                                           <label>
                                               <form:radiobutton path="leadCreationClientInformed" name="leadCreationClientInformed"  value="false" required="required" />
                                               <span>No</span>
                                           </label>
                                       </div>
                                   </div>
                 <div class="checkbox-container">
                    <div class="checkbox-item">
                        <form:checkbox path="notifyEmail" id="notifyEmail" />
                        <label for="notifyEmail">Email</label>
                    </div>
                    <div class="checkbox-item">
                        <form:checkbox path="notifySMS" id="notifySMS" disabled="true" />
                        <label for="notifySMS" style="color: gray; cursor: not-allowed;">SMS</label>
                    </div>
                    <div class="checkbox-item">
                        <form:checkbox path="notifyWhatsapp" id="notifyWhatsapp" />
                        <label for="notifyWhatsapp">Whats App</label>
                    </div>
                </div>
            </div>

    </div>

           <div class="button-container">
                <input type="submit" value="Create">
                <a href="view_filter_leads"><input type="button" class="clear-filter-btn" value="View Leads List"></input></a>
            </div>
        </form:form>
    </div>

<script>
   $('#clientName').autocomplete({
       serviceUrl: '${pageContext.request.contextPath}/getClientList',
       paramName: "clientName",
       delimiter: ",",
       onSelect: function (suggestion) {
           // Set only clientName in the input box
           $('#clientName').val(suggestion.value.split(" - ")[0]);

           // Set clientId in the hidden input
           clientID = suggestion.data;
           jQuery("#clientId").val(clientID);
           $('input[name=clientId]').val(clientID);
           return false;
       },
       transformResult: function (response) {
           return {
               suggestions: $.map($.parseJSON(response), function (item) {
                   return {
                       value: item.clientName + " - " + item.salesPartnerName, // Display suggestion as clientName - salesPartnerName
                       data: item.clientId // Retain clientId for use in onSelect
                   };
               })
           };
       }
   });



    </script>

<jsp:include page="../footer.jsp" />