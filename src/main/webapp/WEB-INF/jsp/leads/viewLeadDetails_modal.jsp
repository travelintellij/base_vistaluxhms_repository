<html lang="en">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">

         <div class="modal-header">
                <button type="button" class="close-btn" onclick="closeModal()">X</button>
         </div>
    <h2>Lead Details</h2> <!-- Bold Header -->
    <div class="form-container" style="width: 60%; min-width: 60%; max-width: 60%;">
        <form:form method="post" action="create_create_lead" modelAttribute="LEAD_OBJ" autocomplete="off">
            <div class="form-table">
                <div class="form-cell">
                    <label for="field1">Lead Id</label>
                    ${LEAD_OBJ.leadId}
                </div>
                <div class="form-cell">
                    <label for="field2" style="font-weight:600">Client Name</label>
                    ${LEAD_OBJ.clientName}
                </div>
                <div class="form-cell">
                        <label for="field4">Lead Owner:</label>
                         ${LEAD_OBJ.leadOwnerName}
                </div>
                <div class="form-cell" >
                        <label for="active-status">Status:</label>
                        ${LEAD_OBJ.statusName}
                 </div>
                </div>
                <div class="form-table">
                <div class="form-cell" >
                    <label for="field5">Adults</label>
                    ${LEAD_OBJ.adults}
                </div>
                <div class="form-cell">
                    <label for="field6">Child With Bed</label>
                    ${LEAD_OBJ.cwb}
                </div>
                <div class="form-cell">
                    <label for="field7">Child No Bed</label>
                    ${LEAD_OBJ.cnb}
                </div>
                <div class="form-cell">
                    <label for="field8">Comp Child</label>
                    <br>
                    ${LEAD_OBJ.compChild}
                </div>
                <div class="form-cell">
                     <label for="" >Check In Date</label>
                     ${LEAD_OBJ.checkInDate}
                 </div>
                  <div class="form-cell">
                     <label for="field8">Check Out Date</label>
                     ${LEAD_OBJ.checkOutDate}
                 </div>
                  <div class="form-cell">
                      <label for="Qualified">Qualified:</label>
                         ${LEAD_OBJ.qualified}
                   </div>
                   <div class="form-cell">
                      <label for="">Flagged:</label>
                        ${LEAD_OBJ.flagged}
                  </div>


           <div class="form-table">
        <div class="form-cell">
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
               ${LEAD_OBJ.clientRemarks}
           </div>
            <div class="form-cell">
               <label for="">Internal Remarks</label> <br>
               ${LEAD_OBJ.internalRemarks}
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
                        <form:checkbox path="notifyWhatsapp" id="notifyWhatsapp" disabled="true" />
                        <label for="notifyWhatsapp" style="color: gray; cursor: not-allowed;">Whats App</label>
                    </div>
                </div>
            </div>

    </div>

           <div class="button-container">
                <input type="submit" value="Create">
                <a href="view_leads_list"><input type="button" class="clear-filter-btn" value="Edit Lead"></input></a>
            </div>
        </form:form>
        <script>
                // Close modal function
                function closeModal() {
                    alert('closing');
                    document.querySelector('.viewLeadDetails_modal').style.display = 'none';
                }

                // Optional: Open modal function (in parent JSP)
                function openModal() {
                    document.querySelector('.viewLeadDetails_modal').style.display = 'block';
                }
            </script>

    </div>



<jsp:include page="../footer.jsp" />