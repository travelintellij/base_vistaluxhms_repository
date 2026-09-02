<jsp:include page="../_menu_builder_header.jsp" />
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">

<style>
    .error-message, .error, .text-danger {
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
        <h2>Transfer Asset - <c:out value="${asset.assetName}" /><c:if test="${not empty categoryName}"> (<c:out value="${categoryName}" />)</c:if></h2>

        <form:form modelAttribute="transferDTO" method="post" action="${pageContext.request.contextPath}/assets_transfer">
            <form:hidden path="assetId" />

            <div class="form-row">
                <label for="assetCode">Asset Code:</label>
                <input type="text" value="${asset.assetCode}" readonly style="background: #e9ecef; font-weight: bold; color: #495057;" />
            </div>

            <div class="form-row">
                <label for="assetName">Asset Name:</label>
                <input type="text" value="${asset.assetName}" readonly style="background: #e9ecef; font-weight: bold; color: #495057;" />
            </div>

            <div class="form-row">
                <label for="previousOwner">Previous Owner:</label>
                <input type="text" value="${previousOwnerName}" readonly style="background: #e9ecef; font-weight: bold; color: #495057;" />
                <form:hidden path="fromAshokaTeamId" />
            </div>

            <div class="form-row">
                <label for="toAshokaTeamId">New Owner *:</label>
                <form:select path="toAshokaTeamId" required="required">
                    <form:option value="" label="-- Select New Owner --" />
                    <form:options items="${ownerMap}" />
                </form:select>
            </div>

            <div class="form-row">
                <label for="transferDate">Transfer Date *:</label>
                <form:input path="transferDate" type="date" required="required" />
                <font color="red">
                    <form:errors path="transferDate" cssClass="error" />
                </font>
            </div>

            <div class="form-row">
                <label for="remarks">Remarks:</label>
                <form:input path="remarks" placeholder="Enter remarks (optional)" />
            </div>

            <div class="button-container">
                <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ASSET_MANAGER')">
                    <input type="submit" value="Transfer Asset">
                </sec:authorize>
                <a href="${pageContext.request.contextPath}/view_assets_list">
                    <input type="button" class="clear-filter-btn" value="Back to Assets List">
                </a>
            </div>
        </form:form>
    </div>
</div>

<jsp:include page="../footer.jsp" />
