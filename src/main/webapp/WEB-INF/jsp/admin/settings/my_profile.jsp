<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">
<script src="<c:url value="/resources/core/jquery.1.10.2.min.js" />"></script>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<head>
    <meta charset="UTF-8">
    <title>My Profile</title>
    <style>
        .profile-container {
            width: 95%;
            margin: 20px auto;
            font-family: Arial, sans-serif;
        }

        .profile-header {
            text-align: center;
            margin-bottom: 20px;
        }

        .profile-message {
            text-align: center;
            margin-bottom: 20px;
            font-weight: bold;
        }

        .profile-message font[color="green"] {
            color: green;
        }

        .profile-message font[color="red"] {
            color: red;
        }

        .profile-wrapper {
            display: flex;
            gap: 30px;
        }

        .profile-pic {
            flex: 0 0 150px;
        }

        .profile-pic img {
            width: 150px;
            height: 150px;
            border-radius: 8px;
            object-fit: cover;
            border: 1px solid #ccc;
        }

        .profile-details {
            flex: 1;
        }

        table.profile-table {
            width: 70%;
            border-collapse: collapse;
             margin: 0 auto;
        }

        table.profile-table th,
        table.profile-table td {
            text-align: left;
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        table.profile-table th {
            width: 200px;
            background-color: #f5f5f5;
        }
    </style>
</head>
<body style="background: url(<%= request.getContextPath() %>/resources/images/myprofile.jpg);background-size: cover; background-repeat: no-repeat; background-position: center center;background-attachment: fixed;">

<div class="profile-container">
    <div class="profile-header">
        <h2>My Profile</h2>
    </div>

    <div class="profile-message">
        <font color="green">${Success}</font>
        <font color="red">${Error}</font>
    </div>

    <div class="profile-wrapper">
        <!-- User Image -->

        <%--
        <div class="profile-pic">
            <img src="${pageContext.request.contextPath}/resources/images/${USER_OBJ.username}.jpg" alt="User Image">
        </div>
        --%>

        <!-- Profile Details -->
        <div class="profile-details">
            <table class="profile-table">
                <tr>
                    <th>User Name</th>
                    <td>${USER_OBJ.username}</td>
                </tr>
                <tr>
                    <th>Name</th>
                    <td>${USER_OBJ.name}</td>
                </tr>
                <tr>
                    <th>Designation</th>
                    <td>${USER_OBJ.designation}</td>
                </tr>
                <tr>
                    <th>Company Email</th>
                    <td>${USER_OBJ.designation}</td>
                </tr>
                <tr>
                    <th>Company Mobile</th>
                    <td>${USER_OBJ.mobile}</td>
                </tr>
                 <tr>
                    <th>Personal Email</th>
                    <td>${USER_OBJ.personalEmail}</td>
                </tr>
                <tr>
                    <th>Mobile</th>
                    <td>${USER_OBJ.personalMobile}</td>
                </tr>


                <tr>
                    <th>Date of Birth</th>
                    <td><fmt:formatDate value="${USER_OBJ.dob}" pattern="dd-MMM-yyyy" /></td>
                </tr>
                <tr>
                    <th>Date of Joining</th>
                    <td><fmt:formatDate value="${USER_OBJ.doj}" pattern="dd-MMM-yyyy" /></td>
                </tr>
                <tr>
                    <th>Fixed Incentive</th>
                    <td>${USER_OBJ.fixedIncentive}</td>
                </tr>
                <tr>
                    <th>System User</th>
                    <td>
                        <c:if test="${fn:containsIgnoreCase(USER_OBJ.roles, 'User')}">User</c:if>
                        <c:if test="${fn:containsIgnoreCase(USER_OBJ.roles, 'Admin')}">Admin</c:if>
                    </td>
                </tr>
                <tr>
                    <th>Address</th>
                    <td>${USER_OBJ.address}</td>
                </tr>
            </table>
        </div>
    </div>
</div>

</body>
</html>
