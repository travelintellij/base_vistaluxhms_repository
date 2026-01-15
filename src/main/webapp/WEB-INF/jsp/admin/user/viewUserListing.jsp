<jsp:include page="../../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">
<script src="<c:url value="/resources/core/jquery.1.10.2.min.js" />"></script>
<script src="<c:url value="/resources/core/jquery.autocomplete.min.js" />"></script>
<style>
    body {
        background-image: url('<%= request.getContextPath() %>/resources/images/userlisting.jpg');
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

    <h2>View Users </h2>
<!-- Client List Table Section -->
<div class="form-container client-list-container" style="width: 60%; min-width: 60%; max-width: 60%;">
    <c:set value="${USER_FILTERED_LIST}" var="userList" />
       <table>
           <thead>
               <tr>
                   <th>User ID</th>
                   <th>User Name</th>
                   <th>Full Name</th>
                   <th>Email</th>
                   <th>Mobile</th>
                   <th>Active</th>
                   <th>Account Locked</th>
                   <th>Action</th>
               </tr>
           </thead>
           <tbody>
                     <c:forEach items="${userList}" var="userRec">
                           <c:set var="hasAdmin" value="false"/>
                           <c:set var="hasUser" value="false"/>
                            <c:forEach var="role" items="${userRec.roles}">
                                    <c:if test="${role.roleName eq 'ADMIN'}">
                                        <c:set var="hasAdmin" value="true"/>
                                    </c:if>
                                    <c:if test="${role.roleName eq 'USER'}">
                                        <c:set var="hasUser" value="true"/>
                                    </c:if>
                              </c:forEach>


                         <tr>
                             <td>${userRec.userId}</td>
                             <td>${userRec.username}</td>
                             <td>${userRec.name}</td>
                             <td>${userRec.email}</td>
                             <td>${userRec.mobile}</td>
                             <td>
                                 <c:if test="${userRec.active eq true}">
                                   <input type="button" style="background-color: #32cd32;border:none;outline:none;border-radius:5px;padding: 4px 5px;pointer-events: none;" value="Active" />
                               </c:if>
                               <c:if test="${userRec.active eq false}">
                                   <input type="button" style="background-color: red;border:none;outline:none;border-radius:5px;padding: 4px 5px;pointer-events: none;" value="Inactive" />
                               </c:if>
                             </td>
                              <td>
                                 <c:if test="${userRec.accountLocked eq true}">
                                    <input type="button" style="background-color: red;border:none;outline:none;border-radius:5px;padding: 4px 5px;pointer-events: none;" value="True" />
                                  </c:if>
                                  <c:if test="${userRec.accountLocked eq false}">
                                      <input type="button" style="background-color: #32cd32;border:none;outline:none;border-radius:5px;padding: 4px 5px;pointer-events: none;" value="False" />
                                  </c:if>
                             </td>
                             <td>
                                    <form action="view_view_user" method="POST" style="display:inline;">
                                           <input type="hidden" name="userId" value="${userRec.userId}" />
                                           <c:if test="${LOGGED_IN_ROLE eq 'SUPERADMIN'}">
                                                <button type="submit" class="view-btn" style="height: 25px; padding: 5px 10px;background-color:gray;">View</button>
                                           </c:if>
                                           <c:if test="${LOGGED_IN_ROLE ne 'SUPERADMIN'}">
                                                <c:if test="${not userRec.superAdmin}">
                                                    <button type="submit" class="view-btn" style="height: 25px; padding: 5px 10px;background-color:gray;">View</button>
                                                </c:if>
                                           </c:if>
                                   </form>
                                   <form action="view_edit_user_form" method="POST" style="display:inline;">
                                       <input type="hidden" name="userId" value="${userRec.userId}" />
                                       <c:if test="${LOGGED_IN_ROLE eq 'SUPERADMIN'}">
                                            <button type="submit" class="edit-btn" style="height: 25px; padding: 5px 10px;">Edit</button>
                                       </c:if>
                                       <c:if test="${LOGGED_IN_ROLE ne 'SUPERADMIN'}">
                                           <c:if test="${not userRec.superAdmin}">
                                               <button type="submit" class="edit-btn" style="height: 25px; padding: 5px 10px;">Edit</button>
                                           </c:if>
                                      </c:if>
                                   </form>


                             </td>
                         </tr>
                     </c:forEach>
                 </tbody>
       </table>
</div>


<jsp:include page="../../footer.jsp" />
