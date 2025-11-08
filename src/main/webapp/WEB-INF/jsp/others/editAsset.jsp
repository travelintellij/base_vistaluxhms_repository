<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Edit Asset</title>
<style>
    body {
        margin: 0;
        padding: 0;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(to bottom, #2196F3, #64B5F6);
        min-height: 100vh;
    }

    .page-wrapper {
        display: flex;
        justify-content: center;
        align-items: flex-start;
        padding-top: 40px;
        min-height: 100vh;
    }

    .container {
        width: 95%;
        max-width: 800px;
        background: #fff;
        border-radius: 15px;
        padding: 10px 20px;
        margin-top: 5px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.2);
    }

    h2 {
        text-align: center;
        font-size: 32px;
        font-weight: 700;
        color: #ff4b2b;
        margin-bottom: 30px;
    }

    label {
        display: block;
        font-size: 16px;
        font-weight: 600;
        margin-bottom: 8px;
        color: #333;
    }

    input, select, textarea {
        width: 100%;
        padding: 12px;
        margin-bottom: 20px;
        border-radius: 8px;
        border: 1px solid #ccc;
        background: #f9f9f9;
        transition: 0.3s;
    }

    input:focus, select:focus, textarea:focus {
        border-color: #66a6ff;
        background: #fff;
        box-shadow: 0 0 10px rgba(102, 166, 255, 0.3);
        outline: none;
    }

    input[readonly] {
        background: #e9ecef;
        font-weight: bold;
        color: #495057;
    }

    .button-container {
        display: flex;
        justify-content: center;
        gap: 15px;
        margin-top: 10px;
    }

    .btn {
        flex: 1;
        text-align: center;
        padding: 12px 0;
        font-size: 16px;
        border-radius: 8px;
        font-weight: 600;
        border: none;
        cursor: pointer;
        text-decoration: none;
        transition: 0.3s ease;
    }

    .save-btn {
        background: linear-gradient(90deg, #ff416c, #ff4b2b);
        color: #fff;
        padding: 18px 40px;
        font-size: 22px;
        font-weight: bold;
        border: none;
        border-radius: 15px;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .save-btn:hover {
        transform: scale(1.05);
        box-shadow: 0 0 20px rgba(255,75,43,0.5);
    }

    .btn-cancel {
        background: #ccc;
        color: #333;
        padding: 18px 40px;
        font-size: 22px;
        font-weight: bold;
        border-radius: 15px;
        text-decoration: none;
        display: inline-block;
        transition: all 0.3s ease;
        border: none;
        cursor: pointer;
        margin-left: 20px;
    }

    .btn-cancel:hover {
        background: #999;
        color: #fff;
        transform: scale(1.05);
    }
</style>
    </head>
    <body>
    <jsp:include page="/WEB-INF/jsp/_menu_builder_header.jsp"/>

    <div class="page-wrapper">
    <div class="container ">
      <h2 style="text-align: center; font-size: 40px; margin-bottom: 40px; color: #ff4b2b;">
          Edit Asset
      </h2>
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
            <form:select path="category.categoryId">
                <form:option value="" label="-- Select Category --" />
                <c:forEach var="cat" items="${categories}">
                <form:option value="${cat.categoryId}" label="${cat.categoryName}" />
             </c:forEach>
            </form:select>



           <label>Cost:</label>
           <form:input path="assetCost" type="number" step="0.01"
                       value="${asset.assetCost != null ? asset.assetCost : ''}" />

           <c:if test="${not empty costError}">
               <span class="error-message">${costError}</span>
           </c:if>

            <label>Description:</label>
            <form:textarea path="description" rows="4" cssClass="form-control" placeholder="Enter description"></form:textarea>
            <form:errors path="description" cssClass="error" />

            <div class="form-actions">
                <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ASSET_MANAGER')">
                    <button type="submit" class="save-btn">Update Asset</button>
                </sec:authorize>
                <a href="${pageContext.request.contextPath}/view_assets_list" class="btn-cancel">Back to Assets</a>
            </div>


        </form:form>
    </div>
    </div>
</body>
</html>




