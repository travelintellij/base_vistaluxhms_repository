<!DOCTYPE html>
<html lang="en">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<%
// Example roles and username
String role = (String) session.getAttribute("role");
String username = (String) session.getAttribute("username");
if (role == null) {
role = "admin"; // Default role if not logged in
session.setAttribute("role", role);
}
if (username == null) {
username = "Guest";
}
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/styles.css">

</head>
<body>
<header>
    <div class="logo">
        <a href="view_workloadhome"><img src="<%= request.getContextPath() %>/resources/images/ashoka_logo.jpg" alt="Logo"></a>

        <h1>Ashoka Resort - Sales Management System</h1>
    </div>
    <div class="welcome">
        Welcome, <%= username %>!
    </div>
</header>
<nav>
    <ul>
       <c:if test="${role == 'admin' || role == 'guest'}">
             <li>
                 <a href="#">Lead Management</a>
                 <ul class="submenu">
                     <li><a href="view_add_lead_form">New Lead</a></li>
                     <li>
                         <a href="view_filter_leads">Lead Management</a>
                     </li>
                 </ul>
             </li>
         </c:if>
         <c:if test="${role == 'admin' || role == 'guest'}">
                    <li>
                        <a href="#">User Management</a>
                        <ul class="submenu">
                            <li><a href="view_add_user_form">Add User</a></li>
                            <li>
                                <a href="view_users_list">User Management</a>
                            </li>
                        </ul>
                    </li>
                </c:if>
        <c:if test="${role == 'admin' || role == 'guest'}">
            <li>
                <a href="#">Client Management</a>
                <ul class="submenu">
                    <li><a href="view_add_client_form">Add Client</a></li>
                    <li>
                        <a href="view_clients_list">Clients Management</a>
                    </li>
                </ul>
            </li>
        </c:if>
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

        <c:if test="${role == 'admin' || role == 'guest'}">
            <li>
                <a href="#">Sales Management</a>
                <ul class="submenu">
                      <li>
                        <a href="#">Rate Type</a>
                        <ul class="second-level">
                            <li><a href="view_add_rate_type_form">Add Rate Type</a></li>
                            <li><a href="view_rate_type_list">Manage Rate Type</a></li>
                        </ul>
                    </li>
                      <li>
                        <a href="#">Sales Partner</a>
                        <ul class="second-level">
                        <li><a href="view_add_sales_partner_form">Add Sales Partner</a></li>
                        <li><a href="view_sales_partner_list">Manage Sales Partner</a></li>
                    </ul>
                    </li>
                      <li>
                        <a href="#">Master Rooms Management</a>
                        <ul class="second-level">
                        <li><a href="view_add_room_category_form">Add Room</a></li>
                        <li><a href="view_rooms_list">Manage Rooms</a></li>
                    </ul>
                    </li>
                </ul>
            </li>
        </c:if>
         <c:if test="${role == 'admin' || role == 'guest'}">
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
         </c:if>
        <c:if test="${role == 'admin' || role == 'guest'}">
             <li>
                 <a href="#">Quotation Management</a>
                 <ul class="submenu">
                     <li><a href="view_add_quotation_form">New Quotation</a></li>
                     <li>
                         <a href="#">Quotation Management</a>
                     </li>
                 </ul>
             </li>
         </c:if>

        <li><a href="logout" class="logout">Logout</a></li>
    </ul>
</nav>