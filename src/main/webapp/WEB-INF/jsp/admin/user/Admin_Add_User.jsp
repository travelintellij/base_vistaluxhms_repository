<jsp:include page="../../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">
<script src="<c:url value="/resources/core/jquery.1.10.2.min.js" />"></script>
<script src="<c:url value="/resources/core/jquery.autocomplete.min.js" />"></script>

    <h2>Add User</h2> <!-- Bold Header -->
    <div class="form-container" style="width: 60%; min-width: 60%; max-width: 60%;">
        <form:form method="post" action="create_create_Admin_User" modelAttribute="USER_OBJ">
            <div class="form-table">
                <div class="form-cell">
                    <label for="field1">Login Id</label>
                    <form:input path="username" maxlength="100" />
                    <font color="red">
                        <form:errors path="username" cssClass="error" />
                    </font>
                </div>
                <div class="form-cell">
                    <label for="field2" style="font-weight:600">Password</label>
                    <form:password path="password" showPassword="true"/>
                    <font color="red">
                        <form:errors path="password" cssClass="error" />
                    </font>
                </div>
                <div class="form-cell">
                    <label for="field3" style="font-weight:600">Confirm Password</label>
                    <form:password path="passwordConfirm" showPassword="true"  />
                    <font color="red">
                        <form:errors path="passwordConfirm" cssClass="error" />
                </div>
                <div class="form-cell">
                          <div class="radio-group-container">
                            <label for="field4">User Type:</label>
                            <div class="radio-group">
                               <label>
                                   <form:radiobutton path="roleName" name="roleName" value="USER" required="required" />
                                   <span>USER</span>
                               </label>
                               <label>
                                   <form:radiobutton path="roleName" name="roleName"  value="ADMIN" required="required" />
                                   <span>ADMIN</span>
                               </label>
                           </div>
                        </div>
                </div>
                </div>
                <div class="form-table">
                <div class="form-cell" >
                    <label for="field5">User Full Name</label>
                    <form:input path="name" /> <br>
                    <font color="red">
                        <form:errors path="name" cssClass="error" />
                    </font>
                </div>
                <div class="form-cell">
                    <label for="field6">Company Email</label>
                    <form:input path="email" />
                    <font color="red">
                        <form:errors path="email" cssClass="error" />
                    </font>
                </div>
                <div class="form-cell">
                    <label for="field7">Company Mobile</label>
                    <form:input path="mobile" type="number" required="required" /> <br>
                    <font color="red">
                        <form:errors path="mobile" cssClass="error" />
                    </font>
                </div>
                <div class="form-cell">
                    <label for="field8">Designation</label>
                    <form:input path="designation" /> <br>
                    <font color="red">
                        <form:errors path="designation" cssClass="error" />
                    </font>
                </div>
               <div class="form-cell">
                   <label for="">Date of Birth</label>
                   <form:input path="dob" type="date" required="required" />
               </div>
                <div class="form-cell">
                    <label for="" >Personal Email</label>
                    <form:input path="personalEmail" type="email" required="required" />
                </div>
                <div class="form-cell">
                     <label for="" >Personal Phone</label>
                     <form:input path="personalMobile" type="number" required="required" />
                 </div>
                  <div class="form-cell">
                     <label for="field8">Address</label>
                     <form:input path="address" /> <br>
                     <font color="red">
                         <form:errors path="address" cssClass="error" />
                     </font>
                 </div>
            </div>

           <div class="form-table">
            <div class="form-cell" >
                <div class="form-row">
                    <label for="active-status">Active:</label>
                   <form:select path="active" required="required" style="width:20%">
                       <form:option value="true">Active</form:option>
                       <form:option value="false">In-Active</form:option>
                   </form:select>
                </div>
             </div>
             <div class="form-cell">
                 <div class="radio-group-container">
                   <label for="field4">Account Lock:</label>
                   <div class="radio-group">
                      <label>
                          <form:radiobutton path="accountLocked" name="accountLocked" value="YES" required="required" />
                          <span>Yes</span>
                      </label>
                      <label>
                          <form:radiobutton path="accountLocked" name="accountLocked"  value="NO" required="required" />
                          <span>No</span>
                      </label>
                  </div>
               </div>
              </div>
              <div class="form-cell">
                 <label for="">Last Working Day</label>
                 <form:input path="lastWorkingDay" type="date" required="required" />
             </div>
            <div class="form-cell">
               <label for="">Remarks</label> <br>
               <form:textarea path = "remarks" rows="3" maxlength="1000"/>
           </div>

           </div>
           <div class="button-container">
                <input type="submit" value="Add User">
                <a href="view_users_list"><input type="button" class="clear-filter-btn" value="View User List"></input></a>
            </div>
        </form:form>
    </div>

<jsp:include page="../../footer.jsp" />