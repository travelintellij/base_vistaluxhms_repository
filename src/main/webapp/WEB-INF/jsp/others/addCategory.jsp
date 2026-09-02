<jsp:include page="../_menu_builder_header.jsp" />
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">

<div class="form-container-wrapper" style="background: transparent !important;">
    <div class="form-container">
        <h2>Add Category</h2>

        <form action="${pageContext.request.contextPath}/categories_save" method="post">
            <input type="hidden" name="categoryId" value="${category.categoryId}" />

            <div class="form-row">
                <label for="categoryName">Category Name *</label>
                <input type="text" id="categoryName" name="categoryName" value="${category.categoryName}" placeholder="Enter Category Name" required="required" />
            </div>

            <div class="form-row">
                <label for="description">Description:</label>
                <textarea id="description" name="description" maxlength="255" placeholder="Enter Category Description..." cols="68" rows="4">${category.description}</textarea>
            </div>

            <div class="button-container">
                <input type="submit" value="Add Category">
                <a href="${pageContext.request.contextPath}/categories_manage">
                    <input type="button" class="clear-filter-btn" value="Manage Categories">
                </a>
            </div>
        </form>
    </div>
</div>

<jsp:include page="../footer.jsp" />

