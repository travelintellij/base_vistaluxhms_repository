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

    <h2>User Details</h2> <!-- Bold Header -->
    <div class="form-container" style="width: 60%; min-width: 60%; max-width: 60%;">
        <form:form method="post" action="view_edit_user_form" modelAttribute="USER_OBJ">
        <form:hidden path="userId" />
            <div class="form-table">
                 <div class="form-cell">
                    <label for="field1">Login Id</label>
                    ${USER_OBJ.userId}
                </div>
                <div class="form-cell">
                    <label for="field1">User Name</label>
                    ${USER_OBJ.username}
                </div>
                 <div class="form-cell" >
                    <label for="field5">User Full Name</label>
                    ${USER_OBJ.name}
                </div>
                <div class="form-cell">
                    <label for="field4">Primary Role:</label>
                    <c:if test="${fn:containsIgnoreCase(USER_OBJ.roles, 'User')}">
                        User
                    </c:if>
                    <c:if test="${fn:containsIgnoreCase(USER_OBJ.roles, 'Admin')}">
                        Admin
                    </c:if>
                </div>

            </div>
                <div class="form-table">

                <div class="form-cell">
                    <label for="field6">Company Email</label>
                    ${USER_OBJ.email}
                </div>
                <div class="form-cell">
                    <label for="field7">Company Mobile</label>
                    ${USER_OBJ.mobile}
                </div>
               <div class="form-cell">
                   <label for="">Date of Birth</label>
                    <fmt:formatDate value="${USER_OBJ.dob}" pattern="dd-MM-yyyy" />
               </div>
                <div class="form-cell">
                    <label for="" >Personal Email</label>
                    ${USER_OBJ.personalEmail}
                </div>
                <div class="form-cell">
                     <label for="" >Personal Phone</label>
                    ${USER_OBJ.personalMobile}
                 </div>
                  <div class="form-cell">
                     <label for="field8">Address</label>
                    ${USER_OBJ.address}
                 </div>
                 <div class="form-cell">
                                     <label for="field8">Designation</label>
                                     ${USER_OBJ.designation}
                 </div>
            </div>

           <div class="form-table">
            <div class="form-cell" >
                    <label for="active-status">Active:</label>
                    ${USER_OBJ.active}
             </div>
             <div class="form-cell">
                   <label for="field4">Account Locked:</label>
                   ${USER_OBJ.accountLocked}
              </div>
              <div class="form-cell">
                 <label for="">Last Working Day</label>
                 ${USER_OBJ.lastWorkingDay}
             </div>
            <div class="form-cell">
               <label for="">Remarks</label> <br>
               ${USER_OBJ.remarks}
           </div>
           </div>
           <div class="button-container">
                <input type="submit" value="Edit User">
                <a href="view_users_list"><input type="button" class="clear-filter-btn" value="View User List"></input></a>
            </div>
        </form:form>
    </div>

<jsp:include page="../../footer.jsp" />