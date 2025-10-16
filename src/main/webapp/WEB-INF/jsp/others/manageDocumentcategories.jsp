<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Manage Document Categories</title>
    <style>
        /* Container & table styling */
        body { font-family: 'Segoe UI', sans-serif; background: #f0f3f5; margin: 0; }
        .container { max-width: 1100px; margin: 50px auto; background: #fff; padding: 50px; border-radius: 15px; }
        h2 { text-align: center; margin-bottom: 30px; color: #2c3e50; }
        .add-link { display: inline-block; margin-bottom: 20px; padding: 12px 20px; background: #1abc9c; color: white; border-radius: 8px; text-decoration: none; }
        .add-link:hover { background: #16a085; }
        table { width: 100%; border-collapse: collapse; }
        table th, table td { padding: 12px; border-bottom: 1px solid #ddd; text-align: left; }
        table th { background: #3498db; color: white; text-transform: uppercase; }
        table tr:hover { background: #d6eaf8; }
        .delete-btn { background: #e74c3c; color: white; border: none; padding: 8px 16px; border-radius: 6px; cursor: pointer; }
        .delete-btn:hover { background: #c0392b; }

        /* Modal styling */
        #deleteModal { display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.5); }
        #deleteModal .modal-content { background-color: #fff; margin: 15% auto; padding: 30px; border-radius: 12px; max-width: 400px; text-align: center; }
        #deleteModal .close { float: right; font-size: 24px; cursor: pointer; }
        #deleteModal button { padding: 10px 20px; margin: 0 10px; border: none; border-radius: 8px; cursor: pointer; }
        #deleteModal .cancel-btn { background: #bdc3c7; color: #fff; }
        #deleteModal .confirm-delete-btn { background: #e74c3c; color: #fff; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/_menu_builder_header.jsp"/>
<div class="container">
    <h2>Manage Document Categories</h2>
    <a class="add-link" href="${pageContext.request.contextPath}/add_documentcategory">Add New Category</a>
    <table>
        <tr>
            <th>ID</th>
            <th>Category Name</th>
            <th>Description</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="cat" items="${documentCategories}">
            <tr>
                <td>${cat.id}</td>
                <td>${cat.categoryName}</td>
                <td>${cat.description}</td>
                <td>
                    <button type="button" class="delete-btn" onclick="openDeleteModal(${cat.id})">Delete</button>
                </td>
            </tr>
        </c:forEach>
    </table>

    <!-- Delete Modal -->
    <div id="deleteModal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h3>Confirm Delete</h3>
            <p>Are you sure you want to delete this category?</p>
            <form id="deleteCategoryForm" method="post" action="">
                <button type="submit" class="confirm-delete-btn">Yes, Delete</button>
                <button type="button" class="cancel-btn">Cancel</button>
            </form>
        </div>
    </div>
</div>

<script>
    const modal = document.getElementById("deleteModal");
    const span = modal.querySelector(".close");
    const cancelBtn = modal.querySelector(".cancel-btn");
    const deleteForm = document.getElementById("deleteCategoryForm");

    function openDeleteModal(categoryId) {
        deleteForm.action = '${pageContext.request.contextPath}/delete_documentcategory/' + categoryId;
        modal.style.display = "block";
    }

    span.onclick = cancelBtn.onclick = function() { modal.style.display = "none"; }
    window.onclick = function(event) { if (event.target == modal) modal.style.display = "none"; }
</script>
<jsp:include page="/WEB-INF/jsp/footer.jsp"/>
</body>
</html>

