<jsp:include page="../_menu_builder_header.jsp" />
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">

<style>
    .error-message, .error {
        display: inline-block;
        background-color: #ffe6e6;
        color: #b30000;
        font-weight: bold;
        padding: 5px 10px;
        border: 1px solid #ff4d4d;
        border-radius: 4px;
        margin-top: 4px;
        font-size: 13px;
    }
</style>

<div class="form-container-wrapper" style="background: transparent !important;">
    <div class="form-container">
        <h2>Edit Asset</h2>

        <form:form modelAttribute="asset" method="post" action="${pageContext.request.contextPath}/update_asset">
            <form:hidden path="assetId" />

            <div class="form-row">
                <label for="assetCode">Asset Code:</label>
                <input type="text" value="${asset.assetCode}" readonly style="background: #e9ecef; font-weight: bold; color: #495057;" />
                <form:hidden path="assetCode" />
                <font color="red">
                    <form:errors path="assetCode" cssClass="error" />
                </font>
            </div>

            <div class="form-row">
                <label for="assetName">Asset Name *</label>
                <form:input path="assetName" id="assetName" required="required" />
                <font color="red">
                    <form:errors path="assetName" cssClass="error" />
                </font>
            </div>

            <div class="form-row">
                <label for="category">Category *</label>
                <form:select path="category.categoryId" required="required">
                    <form:option value="" label="-- Select Category --" />
                    <c:forEach var="cat" items="${categories}">
                        <form:option value="${cat.categoryId}" label="${cat.categoryName}" />
                    </c:forEach>
                </form:select>
            </div>

            <div class="form-row">
                <label for="assetCost">Asset Cost:</label>
                <form:input path="assetCost" type="number" step="0.01"
                            value="${asset.assetCost != null ? asset.assetCost : ''}" />
                <c:if test="${not empty costError}">
                    <span class="error-message">${costError}</span>
                </c:if>
            </div>

            <div class="form-row">
                <label for="description">Description:</label>
                <form:textarea path="description" id="description" maxlength="255" placeholder="Enter description..." cols="68" rows="4" />
                <font color="red">
                    <form:errors path="description" cssClass="error" />
                </font>
            </div>

            <div class="button-container">
                <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ASSET_MANAGER')">
                    <input type="submit" value="Update Asset">
                </sec:authorize>
                <a href="${pageContext.request.contextPath}/view_assets_list">
                    <input type="button" class="clear-filter-btn" value="Back to Assets List">
                </a>
            </div>
        </form:form>
    </div>
</div>

<jsp:include page="../footer.jsp" />




