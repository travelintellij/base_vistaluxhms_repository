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
        background-image: url('<%= request.getContextPath() %>/resources/images/leadedit.jpg');
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

    <h2>Update Lead</h2> <!-- Bold Header -->
    <div class="form-container" style="width: 60%; min-width: 60%; max-width: 60%;">
        <form:form method="post" action="edit_edit_lead" modelAttribute="LEAD_OBJ" autocomplete="off">
               <form:hidden path="leadId" />
            <form:hidden path="client.clientId" id="clientId" />
            <div class="form-table">
                <div class="form-cell">
                    <label for="field1">Lead Id</label>
                    ${LEAD_OBJ.leadId}
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
                                <form:select path="leadOwner" style="width:90%" required="required">
                                    <form:options items="${ACTIVE_USERS_MAP}" class="service-small" />
                                </form:select>
                        </sec:authorize>
                        <sec:authorize access="! hasAnyRole('ADMIN','LEAD_MANAGER')">
                              <b><font color="red">${LEAD_OBJ.leadOwnerName}</font></b>
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
                               <form:radiobutton path="notifyAgain" name="leadCreationClientInformed" value="true" required="required" />
                               <span>Yes</span>
                           </label>
                           <label>
                               <form:radiobutton path="notifyAgain" name="leadCreationClientInformed"  value="false" required="required" />
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
                        <form:checkbox path="notifyWhatsapp" id="notifyWhatsapp" disabled="true" />
                        <label for="notifyWhatsapp" style="color: gray; cursor: not-allowed;">Whats App</label>
                    </div>
                </div>
           </div>
            <div class="form-cell">
             <div class="checkbox-container">
                   <div class="checkbox-item">
                       <form:checkbox path="leadCreationClientInformed" disabled="true"/> Client Informed Earlier
                   </div>
             </div>
           </div>
           <div class="form-cell">
                <label for="leadcontibutors">Lead Contributors:</label> <br>
                 <sec:authorize access="hasAnyRole('ADMIN','LEAD_MANAGER')">
                        <form:select path="leadContributors" multiple="true" style="min-height: 80px; width: 250px;">
                        <form:option value="0">----- Select Contributors -----</form:option>
                            <c:forEach var="entry" items="${ACTIVE_CONTRIBUTORS_MAP}">
                                <option value="${entry.key}"
                                    ${SELECTED_CONTRIBUTORS.contains(entry.key) ? 'selected="selected"' : ''}>
                                    ${entry.value}
                                </option>
                            </c:forEach>
                     </form:select>
                  </sec:authorize>
                  <sec:authorize access="! hasAnyRole('ADMIN','LEAD_MANAGER')">
                        <form:select path="leadContributors" multiple="true" disabled="true" style="min-height: 80px; width: 250px;">
                        <form:option value="0">----- Select Contributors -----</form:option>
                            <c:forEach var="entry" items="${ACTIVE_CONTRIBUTORS_MAP}">
                                <option value="${entry.key}"
                                    ${SELECTED_CONTRIBUTORS.contains(entry.key) ? 'selected="selected"' : ''}>
                                    ${entry.value}
                                </option>
                            </c:forEach>
                     </form:select>
                  </sec:authorize>

           </div>

           <div class="button-container">
                <input type="submit" value="Update Lead">
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