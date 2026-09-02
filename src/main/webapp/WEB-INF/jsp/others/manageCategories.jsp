<jsp:include page="../_menu_builder_header.jsp" />
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">

<style>
    .table-container table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 15px;
    }
    .table-container th, .table-container td {
        border: 1px solid #ddd;
        padding: 10px 12px;
        text-align: left;
    }
    .table-container th {
        background-color: #357abd;
        color: white;
    }
    .table-container tr:nth-child(even) {
        background-color: #f9f9f9;
    }
    .table-container tr:hover {
        background-color: #f1f1f1;
    }
</style>

<div class="form-container filter-container">
    <h2>Manage Categories</h2>
    <form action="categories_manage" method="get">
        <div class="form-row">
            <div class="form-group" style="width: 50%;">
                <label for="statusFilter">Filter by Status:</label>
                <select name="status" id="statusFilter">
                    <option value="Active" ${selectedStatus == 'Active' ? 'selected' : ''}>Active</option>
                    <option value="Inactive" ${selectedStatus == 'Inactive' ? 'selected' : ''}>Inactive</option>
                </select>
            </div>
        </div>
        <div class="form-actions">
            <button type="submit" class="apply-filter-btn">Apply Filter</button>
            <a href="categories_manage"><input type="button" class="clear-filter-btn" value="Clear Filter" /></a>
            <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ASSET_MANAGER')">
                <a href="${pageContext.request.contextPath}/add_category"><input type="button" class="clear-filter-btn" style="background-color: #28a745;" value="+ Add Category" /></a>
            </sec:authorize>
        </div>
    </form>
</div>

<div class="form-container table-container" style="margin-top: 20px;">
    <table>
        <thead>
            <tr>
                <th style="width: 10%;">ID</th>
                <th style="width: 30%;">Name</th>
                <th style="width: 35%;">Description</th>
                <th style="width: 12%;">Status</th>
                <th style="width: 13%;">Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="cat" items="${categories}">
                <tr>
                    <td>${cat.categoryId}</td>
                    <td><strong>${cat.categoryName}</strong></td>
                    <td>${cat.description}</td>
                    <td>
                        <c:choose>
                            <c:when test="${cat.status eq 'Active'}">
                                <input type="button" style="background-color: #32cd32; color: white; border: none; outline: none; border-radius: 4px; padding: 4px 8px; font-size: 12px; pointer-events: none;" value="Active" />
                            </c:when>
                            <c:otherwise>
                                <input type="button" style="background-color: #dc3545; color: white; border: none; outline: none; border-radius: 4px; padding: 4px 8px; font-size: 12px; pointer-events: none;" value="Inactive" />
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${cat.status eq 'Active'}">
                                <form action="${pageContext.request.contextPath}/categories_deactivate/${cat.categoryId}" method="post" style="display:inline;">
                                    <button type="submit" class="btn btn-danger btn-sm" style="padding: 4px 10px; font-size: 12px; background-color: #dc3545; color: white; border: none; border-radius: 4px; cursor: pointer;">Deactivate</button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <form action="${pageContext.request.contextPath}/categories_activate/${cat.categoryId}" method="post" style="display:inline;">
                                    <button type="submit" class="btn btn-success btn-sm" style="padding: 4px 10px; font-size: 12px; background-color: #28a745; color: white; border: none; border-radius: 4px; cursor: pointer;">Activate</button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<jsp:include page="../footer.jsp" />

