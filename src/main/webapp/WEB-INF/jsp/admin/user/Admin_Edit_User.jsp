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
<style>
    body {
        background-image: url('<%= request.getContextPath() %>/resources/images/useredit.jpg');
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
    <h2>Edit User</h2> <!-- Bold Header -->
    <div class="form-container" style="width: 60%; min-width: 60%; max-width: 60%;">
        <form:form method="post" action="edit_edit_user" modelAttribute="USER_OBJ">
        <form:hidden path="userId" />
        <form:hidden path="username" />
            <div class="form-table">
                <div class="form-cell">
                    <label for="field1">User Name</label>
                     ${USER_OBJ.username}
                </div>
                <div class="form-cell">
                    <label for="field2" style="font-weight:600">Password</label>
                    <form:password path="password" showPassword="true" required="required" />
                    <font color="red">
                        <form:errors path="password" cssClass="error"  />
                    </font>
                </div>
                <div class="form-cell">
                    <label for="field3" style="font-weight:600">Confirm Password</label>
                    <form:password path="passwordConfirm" showPassword="true" required="required"  />
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
                    <form:input path="name" required="required" /> <br>
                    <font color="red">
                        <form:errors path="name" cssClass="error" />
                    </font>
                </div>
                <div class="form-cell">
                    <label for="field6">Company Email</label>
                    <form:input path="email" required="required" />
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
                   <form:input path="dob" type="date" />
               </div>
                <div class="form-cell">
                    <label for="" >Personal Email</label>
                    <form:input path="personalEmail" type="email" required="required"  />
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
                 <label for="">Date Of Joining</label>
                 <form:input path="doj" type="date" />
             </div>
              <div class="form-cell">
                 <label for="">Last Working Day</label>
                 <form:input path="lastWorkingDay" type="date" />
             </div>
            <div class="form-cell">
               <label for="">Remarks</label> <br>
               <form:textarea path = "remarks" rows="3" maxlength="1000"/>
           </div>

           </div>
           <div class="button-container">
                <input type="submit" value="Update User">
                <a href="view_users_list"><input type="button" class="clear-filter-btn" value="View User List"></input></a>
            </div>
        </form:form>
    </div>

<jsp:include page="../../footer.jsp" />