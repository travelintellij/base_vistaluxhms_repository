<!DOCTYPE html>
<html lang="en">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>


<c:set var="role" value="${role != null ? role : 'user'}" />
<c:set var="username" value="${userName != null ? userName : 'Guest'}" />



<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="Expires" content="0"/>

    <title>Home</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/styles.css">
</head>
<script>
/*
 function updateLogo() {
     const logo = document.getElementById('topLogo');
     logo.src = '<%= request.getContextPath() %>/resources/images/ashoka_logo.jpg?ts=' + new Date().getTime();
 } */
</script>
<style>
 .gear-icon {
     font-size: 20px;
     background-color: #007bff; /* Blue background */
     color: white;              /* Icon color */
     padding: 6px 8px;
     border-radius: 50%;        /* Makes it circular */
     margin-right: 5px;
</style>
<body>
<header>
    <div class="logo">
        <a href="view_workloadhome"><img id = "topLogo" src="<%= request.getContextPath() %>/resources/images/ashoka_logo.jpg" alt="Logo"></a>
        <h1>AxisHMS Pro - Perfect Hotel CRM Solution</h1>
    </div>
  <div class="welcome">
      Welcome, <strong><sec:authentication property="principal.username"/></strong>
  </div>

</header>
<nav>
    <ul>
       <sec:authorize access="hasAnyRole('ADMIN','LEADS_MANAGE')">
             <li>
                 <a href="#">Lead Management</a>
                 <ul class="submenu">
                     <li><a href="view_add_lead_form">New Lead</a></li>
                     <li>
                         <a href="view_filter_leads">Lead Management</a>
                     </li>
                 </ul>
             </li>
        </sec:authorize>
        <sec:authorize access="hasAnyRole('ADMIN','USER_MANAGE')">
                    <li>
                        <a href="#">User Management</a>
                        <ul class="submenu">
                            <li><a href="view_add_user_form">Add User</a></li>
                            <li>
                                <a href="view_users_list">User Management</a>
                            </li>
                        </ul>
                    </li>
        </sec:authorize>
        <sec:authorize access="hasAnyRole('ADMIN','CLIENT_CREATE','CLIENT_MANAGE')">
            <li>
                <a href="#">Client Management</a>
                <ul class="submenu">
                    <li><a href="view_add_client_form">Add Client</a></li>
                    <sec:authorize access="hasAnyRole('ADMIN','CLIENT_MANAGE')">
                    <li>
                        <a href="view_clients_list">Clients Management</a>
                    </li>
                    </sec:authorize>
                </ul>
            </li>
        </sec:authorize>
        <c:if test="${role == 'admin' || role == 'guest'}">
                    <li>
                        <a href="#">Others</a>
                        <ul class="submenu">
                            <li>
                                <a href="#">City</a>
                                <ul class="second-level">
                                    <li><a href="view_add_city_form">Add City</a></li>
                                    <li><a href="view_search_city_form">Manage Cities</a></li>
                                </ul>
                            </li>
                        </ul>
                    </li>
         </c:if>
            <li>
                <a href="#">Sales Management</a>
                <ul class="submenu">
                    <sec:authorize access="hasAnyRole('ADMIN','RATE_TYPE_MANAGE')">
                      <li>
                            <a href="#">Rate Type</a>
                            <ul class="second-level">
                                <li><a href="view_add_rate_type_form">Add Rate Type</a></li>
                                <li><a href="view_rate_type_list">Manage Rate Type</a></li>
                            </ul>
                       </li>
                    </sec:authorize>
                    <sec:authorize access="hasAnyRole('ADMIN','SALES_PARTNER_CREATE','SALES_PARTNER_MANAGE')">
                      <li>
                            <a href="#">Sales Partner</a>
                            <ul class="second-level">
                                <li><a href="view_add_sales_partner_form">Add Sales Partner</a></li>
                                <sec:authorize access="hasAnyRole('ADMIN','SALES_PARTNER_MANAGE')">
                                    <li><a href="view_sales_partner_list">Manage Sales Partner</a></li>
                                </sec:authorize>
                            </ul>
                        </li>
                      </sec:authorize>

                    <sec:authorize access="hasAnyRole('ADMIN','ROOMS_MANAGE')">
                      <li>
                        <a href="#">Master Rooms Management</a>
                        <ul class="second-level">
                        <li><a href="view_add_room_category_form">Add Room</a></li>
                        <li><a href="view_rooms_list">Manage Rooms</a></li>
                    </ul>
                    </li>
                   </sec:authorize>
                </ul>
            </li>
             <sec:authorize access="hasAnyRole('ADMIN','COST_MANAGE')">
                    <li>
                        <a href="#">Cost Management</a>
                        <ul class="submenu">
                            <li>
                                <a href="#">Session</a>
                                <ul class="second-level">
                                    <li><a href="view_add_session_form">Add Session</a></li>
                                    <li><a href="view_session_list">Manage Sessions</a></li>
                                </ul>
                            </li>
                        </ul>
                    </li>
         </sec:authorize>
         <li>
                 <a href="#">Quotation Management</a>
                 <ul class="submenu">
                     <li><a href="view_add_quotation_form">New System Quotation</a></li>
                     <li><a href="view_add_free_hand_quotation_form" style="color: yellow;">New Free Hand Quotation</a></li>
                 </ul>
             </li>
        <sec:authorize access="hasAnyRole('ADMIN','EVENT_MANAGE')">
            <li>
                <a href="#">Event Management</a>
                <ul class="submenu">
                      <li>
                        <a href="#">Event Services </a>
                        <ul class="second-level">
                            <li><a href="view_event_quotation_form_wiz1">Create Event Quotation</a></li>
                            <li><a href="view_filter_events">Manage Events</a></li>
                        </ul>
                    </li>


                    <li>
                        <a href="#">Master Service </a>
                        <ul class="second-level">
                            <li><a href="view_add_master_service_form">Add Master Service</a></li>
                            <li><a href="view_master_service_list">Manage Services</a></li>
                        </ul>
                    </li>
                </ul>
            </li>
        </sec:authorize>
        <sec:authorize access="hasAnyRole('SUPERADMIN','EXPENSE_APPROVER','CAN_CLAIM')">
            <li>
                <a href="#">My Claims</a>
                <ul class="submenu">
                    <li>
                        <sec:authorize access="hasAnyRole('CAN_CLAIM')">
                            <a href="view_add_travel_claim_form">New Travel Claim</a>
                        </sec:authorize>
                        <a href="view_travel_claim_list?view_travelclaimlist">Manage Travel Claims</a>
                        <!--
                        <a href="view_add_claim_form">New Claim</a>
                        <a href="#">Claim Reports</a>
                        -->
                    </li>
                </ul>
            </li>
        </sec:authorize>
       <sec:authorize access="hasAnyRole('ADMIN','ASSET_MANAGER','ASSET_ALLOWED')">
           <li>
               <a href="#">Asset Management</a>
               <ul class="submenu">
                   <li>
                       <a href="#">Asset</a>
                       <ul class="second-level">
                           <!-- Add Asset only for ADMIN or ASSET_MANAGER -->
                           <sec:authorize access="hasAnyRole('ADMIN','ASSET_MANAGER')">
                               <li><a href="${pageContext.request.contextPath}/add_asset">Add Asset</a></li>
                           </sec:authorize>
                           <!-- Manage Assets visible for everyone -->
                           <li><a href="${pageContext.request.contextPath}/view_assets_list">Manage Assets</a></li>
                       </ul>
                   </li>


                   <sec:authorize access="hasAnyRole('ADMIN','ASSET_MANAGER')">
                       <li>
                           <a href="#">Category</a>
                           <ul class="second-level">
                               <li><a href="${pageContext.request.contextPath}/categories_add">Add Category</a></li>
                               <li><a href="${pageContext.request.contextPath}/categories_manage">Manage Categories</a></li>
                           </ul>
                       </li>
                   </sec:authorize>
               </ul>
           </li>
       </sec:authorize>

<sec:authorize access="hasAnyRole('ADMIN','DOCUMENT_MANAGER')">
    <li>
        <a href="#">Document Repository</a>
        <ul class="submenu">

            <li>
                <a href="#">Documents</a>
                <ul class="second-level">
                    <li><a href="${pageContext.request.contextPath}/add_document">Add Document</a></li>
                    <li><a href="${pageContext.request.contextPath}/view_documents_list">Manage Documents</a></li>
                </ul>
            </li>


            <li>
                <a href="#">Category</a>
                <ul class="second-level">
                    <li><a href="${pageContext.request.contextPath}/add_documentcategory">Add Category</a></li>
                    <li><a href="${pageContext.request.contextPath}/manage_documentcategories">Manage Categories</a></li>
                </ul>
            </li>
        </ul>
    </li>
</sec:authorize>
       <sec:authorize access="hasAnyRole('DOCUMENT_ALLOWED','RESTRICTED_DOC_ACCESS')">
          <li>
              <a href="#">Knowledge Repository</a>
              <ul class="submenu">
                  <li><a href="${pageContext.request.contextPath}/view_documents_list">Manage Documents</a></li>
              </ul>
          </li>
       </sec:authorize>


        <li><a href="logout" class="logout">Logout</a></li>
        <li>
          <a href="view_form_my_profile">
            <span class="gear-icon" >&#9881;</span>
          </a>
        </li>
    </ul>
</nav>

