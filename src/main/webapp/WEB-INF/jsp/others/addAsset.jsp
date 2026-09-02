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
        <h2>Add New Asset</h2>

        <form:form modelAttribute="assetDTO" action="${pageContext.request.contextPath}/save_asset" method="post">

            <div class="form-row">
                <label for="assetName">Asset Name *</label>
                <form:input path="assetName" id="assetName" placeholder="Enter Asset Name" required="required" />
                <font color="red">
                    <form:errors path="assetName" cssClass="error" />
                </font>
            </div>

            <div class="form-row">
                <label for="assetCost">Asset Cost:</label>
                <form:input path="assetCost" id="assetCost" type="number" step="0.01" placeholder="Enter Asset Cost"
                            value="${assetDTO.assetCost != null ? assetDTO.assetCost : ''}" />
                <c:if test="${not empty costError}">
                    <span class="error-message">${costError}</span>
                </c:if>
            </div>

            <div class="form-row">
                <label for="categoryId">Category *</label>
                <form:select path="categoryId" id="categoryId" required="required">
                    <form:option value="">-- Select Category --</form:option>
                    <c:forEach var="cat" items="${categories}">
                        <form:option value="${cat.categoryId}" label="${cat.categoryName}" />
                    </c:forEach>
                </form:select>
                <font color="red">
                    <form:errors path="categoryId" cssClass="error" />
                </font>
            </div>

            <div class="form-row">
                <label for="assetOwnerId">Assign Owner:</label>
                <form:select path="assetOwnerId" id="assetOwnerId">
                    <form:option value="">-- Select Employee --</form:option>
                    <c:forEach var="team" items="${ashokaTeams}">
                        <form:option value="${team.userId}" label="${team.name} (${team.username})" />
                    </c:forEach>
                </form:select>
            </div>

            <div class="form-row">
                <label for="description">Description:</label>
                <form:textarea path="description" id="description" maxlength="255" placeholder="Enter asset description..." cols="68" rows="4" />
                <font color="red">
                    <form:errors path="description" cssClass="error" />
                </font>
            </div>

            <div class="button-container">
                <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ASSET_MANAGER')">
                    <input type="submit" value="Save Asset">
                </sec:authorize>
                <a href="${pageContext.request.contextPath}/view_assets_list">
                    <input type="button" class="clear-filter-btn" value="View Assets List">
                </a>
            </div>
        </form:form>
    </div>
</div>

<jsp:include page="../footer.jsp" />

