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

    <h2>New Lead</h2> <!-- Bold Header -->
    <div class="form-container" style="width: 60%; min-width: 60%; max-width: 60%;">
        <form:form method="post" action="create_create_lead" modelAttribute="LEAD_OBJ" autocomplete="off">
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
                          <div class="radio-group-container">
                            <label for="field4">Lead Owner:</label>
                            Lead Owner
                        </div>
                </div>
                <div class="form-cell" >
                    <div class="form-row">
                        <label for="active-status">Status:</label>
                       <form:select path="leadStatus" required="required" style="width:20%">
                       </form:select>
                    </div>
                 </div>
                </div>
                <div class="form-table">
                <div class="form-cell" >
                    <label for="field5">Adults</label>
                    <form:input path="adults" required="required" /> <br>
                    <font color="red">
                        <form:errors path="adults" cssClass="error" />
                    </font>
                </div>
                <div class="form-cell">
                    <label for="field6">Child With Bed</label>
                    <form:input path="cwb" required="required" />
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
                     <form:input path="checkOutDate" type="date" /> <br>
                     <font color="red">
                         <form:errors path="checkOutDate" cssClass="error" />
                     </font>
                 </div>
                  <div class="form-cell">
                      <div class="radio-group-container">
                        <label for="field4">Qualified:</label>
                         Qualified
                    </div>
                   </div>
                   <div class="form-cell">
                      <label for="">Flagged</label>
                      <form:input path="flagged" />
                  </div>

            </div>

           <div class="form-table">



            <div class="form-cell">
               <label for="">Client Remarks</label> <br>
               <form:textarea path = "clientRemarks" rows="3" maxlength="1000"/>
           </div>
            <div class="form-cell">
               <label for="">Internal Remarks</label> <br>
               <form:textarea path = "internalRemarks" rows="3" maxlength="1000"/>
           </div>

           </div>
           <div class="button-container">
                <input type="submit" value="Add User">
                <a href="view_users_list"><input type="button" class="clear-filter-btn" value="View User List"></input></a>
            </div>
        </form:form>
    </div>

<jsp:include page="../footer.jsp" />