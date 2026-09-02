
<jsp:include page="../_menu_builder_header.jsp" />
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">

<div class="form-container-wrapper" style="background: transparent !important;">
    <div class="form-container">
        <h2>Allocate Asset to Employee</h2>

        <form action="${pageContext.request.contextPath}/allocate_asset" method="post">
            <div class="form-row">
                <label for="assetId">Select Asset *:</label>
                <select name="assetId" id="assetId" required="required">
                    <option value="">-- Select Asset --</option>
                    <c:forEach items="${assets}" var="asset">
                        <option value="${asset.assetId}">${asset.assetName}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-row">
                <label for="assetOwnerId">Select Team Member *:</label>
                <select name="assetOwnerId" id="assetOwnerId" required="required">
                    <option value="">-- Select Employee --</option>
                    <c:forEach items="${ashokaTeams}" var="member">
                        <option value="${member.userId}">
                            ${member.name} (${member.userId})
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="button-container">
                <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ASSET_MANAGER')">
                    <input type="submit" value="Allocate Asset">
                </sec:authorize>
                <a href="${pageContext.request.contextPath}/view_assets_list">
                    <input type="button" class="clear-filter-btn" value="Back to Assets List">
                </a>
            </div>
        </form>
    </div>
</div>

<jsp:include page="../footer.jsp" />

