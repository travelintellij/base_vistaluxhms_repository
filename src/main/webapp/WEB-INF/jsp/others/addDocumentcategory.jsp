<jsp:include page="../_menu_builder_header.jsp" />
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">

<div class="form-container-wrapper" style="background: transparent !important;">
    <div class="form-container">
        <h2>Add Document Category</h2>

        <form action="${pageContext.request.contextPath}/save_documentcategory" method="post">
            <input type="hidden" name="id" value="${category.id}" />

            <div class="form-row">
                <label for="categoryName">Category Name *:</label>
                <input type="text" id="categoryName" name="categoryName" value="${category.categoryName}" placeholder="Enter Category Name" required="required" />
            </div>

            <div class="form-row">
                <label for="description">Description:</label>
                <textarea id="description" name="description" maxlength="255" placeholder="Enter Category Description..." cols="68" rows="4">${category.description}</textarea>
            </div>

            <div class="button-container">
                <input type="submit" value="Save Category">
                <a href="${pageContext.request.contextPath}/manage_documentcategories">
                    <input type="button" class="clear-filter-btn" value="Manage Categories">
                </a>
            </div>
        </form>
    </div>
</div>

<jsp:include page="../footer.jsp" />

