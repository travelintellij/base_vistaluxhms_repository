<html lang="en">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylefrmudn.css">

         <div class="modal-header">
                <h2 style="color: white; margin: 0;">Lead Details</h2>
                <button type="button" class="close-btn" onclick="closeModal()">X</button>

         </div>
   <div class="form-container">
       <form:form method="post" action="create_create_lead" modelAttribute="LEAD_OBJ" autocomplete="off">
           <div class="form-grid">
               <div class="form-cell"><label>Lead Id:</label> ${LEAD_OBJ.leadId}</div>
               <div class="form-cell"><label>Client Name:</label> ${LEAD_OBJ.clientName}</div>
               <div class="form-cell"><label>Lead Owner:</label> ${LEAD_OBJ.leadOwnerName}</div>
               <div class="form-cell"><label>Status:</label> ${LEAD_OBJ.statusName}</div>

               <div class="form-cell"><label>Adults:</label> ${LEAD_OBJ.adults}</div>
               <div class="form-cell"><label>Child With Bed:</label> ${LEAD_OBJ.cwb}</div>
               <div class="form-cell"><label>Child No Bed:</label> ${LEAD_OBJ.cnb}</div>
               <div class="form-cell"><label>Comp Child:</label> ${LEAD_OBJ.compChild}</div>

               <div class="form-cell"><label>Check In Date:</label> ${LEAD_OBJ.checkInDate}</div>
               <div class="form-cell"><label>Check Out Date:</label> ${LEAD_OBJ.checkOutDate}</div>
               <div class="form-cell"><label>Qualified:</label> ${LEAD_OBJ.qualified}</div>
               <div class="form-cell"><label>Flagged:</label> ${LEAD_OBJ.flagged}</div>

               <div class="form-cell full-width">
                   <label>Query Type:</label>
                   <div class="checkbox-group">
                       <form:checkbox path="fit" id="fit" disabled="true" class="small-checkbox" /><label for="fit">FIT</label>
                       <form:checkbox path="groupEvent" id="groupEvent" disabled="true" class="small-checkbox" /><label for="groupEvent">Group</label>
                       <form:checkbox path="marriage" id="marriage" disabled="true" class="small-checkbox" /><label for="marriage">Marriage</label>
                       <form:checkbox path="others" id="others" disabled="true" class="small-checkbox" /><label for="others">Others</label>
                   </div>
               </div>

               <div class="form-cell full-width">
                   <label>Client Remarks:</label>
                   <textarea readonly>${LEAD_OBJ.clientRemarks}</textarea>
               </div>
               <div class="form-cell full-width">
                   <label>Internal Remarks:</label>
                   <textarea readonly>${LEAD_OBJ.internalRemarks}</textarea>
               </div>

               <div class="form-cell full-width">
                   <label>Client Informed:</label>
                   ${LEAD_OBJ.leadCreationClientInformed}
               </div>

               <div class="form-cell"> <label>Email:</label> <form:checkbox path="notifyEmail" id="notifyEmail"  disabled="true" /></div>
               <div class="form-cell"><label>SMS:</label><form:checkbox path="notifySMS" id="notifySMS" disabled="true" /></div>
               <div class="form-cell"><label>WhatsApp:</label> <form:checkbox path="notifyWhatsapp" id="notifyWhatsapp" disabled="true" /></div>
           </div>

           <button type="submit" class="submit-btn">Edit Lead</button>
       </form:form>
   </div>
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




<jsp:include page="../footer.jsp" />