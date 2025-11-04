
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Allocate Asset</title>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/_menu_builder_header.jsp"/>
<h2>Allocate Asset to Employee</h2>

<form action="${pageContext.request.contextPath}/allocate_asset" method="post">
    <label>Select Asset:</label>
    <select name="assetId" required>
        <c:forEach items="${assets}" var="asset">
            <option value="${asset.assetId}">${asset.assetName}</option>
        </c:forEach>
    </select>
    <br><br>

    <label>Select Team Member:</label>
    <select name="assetOwnerId" required>
        <c:forEach items="${ashokaTeams}" var="member">
            <option value="${member.userId}">
                ${member.name} (${member.userId})
            </option>
        </c:forEach>
    </select>
    <br><br>

    <input type="submit" value="Allocate">
</form>

<br>
<a href="${pageContext.request.contextPath}/view_assets_list">Back to Asset List</a>
</body>
</html>

