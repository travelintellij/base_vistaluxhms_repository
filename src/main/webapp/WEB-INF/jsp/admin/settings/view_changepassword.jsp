<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">
<script src="<c:url value="/resources/core/jquery.1.10.2.min.js" />"></script>

<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        margin: 0;
        background-size: cover;
    }



    .view_changepassword.container {
        padding: 40px;
        background-color: rgba(255, 255, 255, 0.95);
        min-height: 100vh;
    }

    .page-heading {
        font-size: 28px;
        margin-bottom: 20px;
        text-align: center;
    }

    table.password-table {
        width: 60%;
        margin: 0 auto;
        border-collapse: separate;
        border-spacing: 15px 10px;
    }

    table.password-table td {
        vertical-align: top;
    }

    table.password-table label {
        font-weight: bold;
    }

    table.password-table input[type="password"] {
        width: 100%;
        padding: 8px 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }

    .submit-btn-container {
        text-align: center;
        margin-top: 20px;
    }

    input[type="submit"] {
        background-color: #28a745;
        color: white;
        border: none;
        padding: 10px 25px;
        font-size: 16px;
        border-radius: 4px;
        cursor: pointer;
    }

    input[type="submit"]:hover {
        background-color: #218838;
    }

    .error {
        color: red;
        font-size: 12px;
    }

</style>

<body style="background: url(<%= request.getContextPath() %>/resources/images/changepassword.jpg);background-size: cover; background-repeat: no-repeat; background-position: center center;background-attachment: fixed;">
 <div class="view_changepassword container">
        <form:form action="update_update_password" modelAttribute="USER_OBJ">
            <h1 class="page-heading">Reset Password</h1>

            <div align="center">
                <b>
                    <font color="green">${Success}</font>
                    <font color="red">${Error}</font>
                </b>
            </div>

            <table class="password-table">
                <tr>
                    <td>
                        <label>Current Password</label><br>
                        <input type="password" name="currentPassword" maxlength="20" placeholder="Current Password" required />
                        <form:errors path="currentPassword" cssClass="error" />
                    </td>
                    <td>
                        <label>New Password</label><br>
                        <input type="password" name="changedPassword" minlength="8" maxlength="20" placeholder="New Password" required />
                        <form:errors path="changedPassword" cssClass="error" />
                    </td>
                    <td>
                        <label>Confirm Password</label><br>
                        <input type="password" name="passwordConfirm" minlength="8" maxlength="20" placeholder="Confirm Password" required />
                    </td>
                </tr>
            </table>

            <div class="submit-btn-container">
                <input type="submit" value="Change Password" />
            </div>
        </form:form>
    </div>

</body>
</html>
