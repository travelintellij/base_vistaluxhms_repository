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
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/styles.css">
</head>
<body>
<header>
    <div class="logo">
        <img src="<%= request.getContextPath() %>/resources/images/ashoka_logo.jpg" alt="Logo">
        <h1>Ashoka Resort Management System</h1>
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
                    <li><a href="#">Create Lead</a></li>
                    <li>
                        <a href="#">Lead Management</a>
                        <ul class="second-level">
                            <li><a href="#">Edit Lead</a></li>
                            <li><a href="#">Delete Lead</a></li>
                        </ul>
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
                <a href="#">Quotation</a>
                <ul class="submenu">
                    <li><a href="#">Generate Quotation</a></li>
                    <li><a href="#">View Quotations</a></li>
                </ul>
            </li>
        </c:if>
        <li><a href="#">About Us</a></li>
        <li><a href="#" class="logout">Logout</a></li>
    </ul>
</nav>