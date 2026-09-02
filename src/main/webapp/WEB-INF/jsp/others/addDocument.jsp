<jsp:include page="../_menu_builder_header.jsp" />
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
        <h2>Add New Document</h2>

        <c:if test="${not empty errorMessage}">
            <div style="color: red; font-weight: bold; margin-bottom: 20px; text-align:center;">
                ${errorMessage}
            </div>
        </c:if>

        <form action="<c:url value='/save_document'/>" method="post" enctype="multipart/form-data">
            <div class="form-row">
                <label for="categoryId">Category Name *</label>
                <select id="categoryId" name="categoryId" required="required">
                    <option value="" disabled selected>-- Select Category --</option>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat.id}">${cat.categoryName}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-row">
                <label for="documentName">Document Name *</label>
                <input type="text" id="documentName" name="documentName" required="required" placeholder="Enter Document Name" />
            </div>

            <div class="form-row">
                <label for="file">File *</label>
                <input type="file" id="file" name="file" required="required" />
                <div id="fileError" class="error-message" style="display:none;"></div>
            </div>

            <c:if test="${fn:contains(userRoles,'ROLE_ADMIN') || fn:contains(userRoles,'DOCUMENT_MANAGER')}">
                <div class="form-row">
                    <label for="restricted">Restricted:</label>
                    <div style="flex: 2; display: flex; align-items: center; gap: 8px;">
                        <input type="checkbox" id="restricted" name="restricted" value="true" style="width: 20px; height: 20px; cursor: pointer; accent-color: #007bff;" />
                        <span style="font-size: 14px; color: #555;">Check to restrict access to this document</span>
                    </div>
                </div>
            </c:if>

            <div class="button-container">
                <input type="submit" value="Upload Document" />
                <a href="<c:url value='/view_documents_list'/>">
                    <input type="button" class="clear-filter-btn" value="View Documents List" />
                </a>
            </div>
        </form>
    </div>
</div>

<script>
document.getElementById("file").addEventListener("change", function() {
    const file = this.files[0];
    const errorDiv = document.getElementById("fileError");
    errorDiv.textContent = "";
    errorDiv.style.display = "none";

    if (file && file.size > 5 * 1024 * 1024) { // 5 MB limit
        errorDiv.textContent = "File size should not exceed 5 MB";
        errorDiv.style.display = "inline-block";
        this.value = ""; // clear the file input
    }
});
</script>

<jsp:include page="../footer.jsp" />

