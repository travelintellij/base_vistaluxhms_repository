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
                                                               <button type="submit" class="view-btn" style="height: 25px; padding: 5px 10px;background-color:gray;">View</button>
                                                       </form>
                                                       <form action="view_edit_user_form" method="POST" style="display:inline;">
                                                           <input type="hidden" name="userId" value="${userRec.userId}" />
                                                           <button type="submit" class="edit-btn" style="height: 25px; padding: 5px 10px;">Edit</button>
                                                       </form>

                             </td>
                         </tr>
                     </c:forEach>
                 </tbody>
       </table>
</div>


<jsp:include page="../../footer.jsp" />
