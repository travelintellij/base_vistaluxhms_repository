<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Edit Asset</title>
    <style>
        .page-header-fullwidth {
            width: 100%;
            background-color: #fff;
            padding: 20px 0;
            margin-bottom: 40px;
        }

        .page-header-fullwidth h2 {
            font-size: 36px;
            color: #ff4b2b;
            margin: 0;
            padding-left: 20px;
        }

        body {
            margin: 0;
            padding: 50px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #ff9a9e, #fad0c4);
        }

        .container {
            max-width: 600px;
            margin: auto;
            background: #fff;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }

        h1 { text-align: center; margin-bottom: 30px; }
        label { display: block; font-weight: bold; margin-bottom: 8px; }

        input, select {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 8px;
            border: 1px solid #ccc;
        }

        input[readonly] {
            background: #e9ecef;
            font-weight: bold;
            color: #495057;
        }

        .error {
            color: red;
            font-size: 14px;
            margin-top: -16px;
            margin-bottom: 10px;
        }

        button {
            width: 100%;
            padding: 16px;
            background: #ff7e5f;
            color: #fff;
            font-weight: bold;
            border: none;
            border-radius: 12px;
            cursor: pointer;
        }

        button:hover {
            background: #eb5a3c;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/_menu_builder_header.jsp"/>
    <div class="container">
        <div class="page-header-fullwidth">
            <h1>Edit Asset</h1>
        </div>

        <form:form modelAttribute="asset" method="post" action="${pageContext.request.contextPath}/update_asset">
            <form:hidden path="assetId" />


            <label>Asset Code:</label>
            <input type="text" value="${asset.assetCode}" readonly />
            <form:hidden path="assetCode" />
            <form:errors path="assetCode" cssClass="error" />


            <label>Asset Name:</label>
            <form:input path="assetName" />
            <form:errors path="assetName" cssClass="error" />


            <label>Category:</label>
            <form:select path="category">
                <form:option value="" label="-- Select Category --" />
                <c:forEach var="cat" items="${categories}">
                    <form:option value="${cat.categoryName}"
                          label="${cat.categoryName}" />
                          ${cat.categoryName eq asset.category ? 'selected="selected"' : ''} />
                </c:forEach>
            </form:select>
            <form:errors path="category" cssClass="error" />



            <label>Cost:</label>
            <form:input path="assetCost" type="number" />
            <form:errors path="assetCost" cssClass="error" />

<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ASSET_MANAGER')">
            <button type="submit">Update Asset</button>
            </sec:authorize>
        </form:form>
    </div>
</body>
</html>

