<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Manage Document Categories</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: linear-gradient(135deg, #43cea2, #185a9d); margin: 0; }
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

         #deleteModal { display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.5); }
        #deleteModal .modal-content { background-color: #fff; margin: 15% auto; padding: 30px; border-radius: 12px; max-width: 400px; text-align: center; }
        #deleteModal .close { float: right; font-size: 24px; cursor: pointer; }
        #deleteModal button { padding: 10px 20px; margin: 0 10px; border: none; border-radius: 8px; cursor: pointer; }
        #deleteModal .cancel-btn { background: #bdc3c7; color: #fff; }
        #deleteModal .confirm-delete-btn { background: #e74c3c; color: #fff; }

        .deactivate-btn { background: #e74c3c; color: white; border: none; padding: 8px 16px; border-radius: 6px; cursor: pointer; }
        .deactivate-btn:hover { background: #c0392b; }

        .activate-btn { background: #2ecc71; color: white; border: none; padding: 8px 16px; border-radius: 6px; cursor: pointer; }
        .activate-btn:hover { background: #27ae60; }

               .filter-toolbar {
                       display: flex;
                       align-items: center;
                       margin-bottom: 20px;
                       gap: 12px;
                       flex-wrap: wrap;
                   }

                   .filter-toolbar label {
                       font-weight: bold;
                       font-size: 17px;
                   }

                   .status-select {
                       padding: 12px 16px;
                       font-size: 18px;
                       border-radius: 8px;
                       border: 1px solid #ccc;
                       min-width: 180px;
                   }

                   .filter-btn {
                       padding: 12px 22px;
                       font-size: 17px;
                       border-radius: 8px;
                       text-decoration: none;
                       cursor: pointer;
                       border: none;
                       color: white;
                       transition: background 0.3s;
                   }

                   .apply-btn {
                       background-color: #1abc9c;
                   }

                   .apply-btn:hover {
                       background-color: #16a085;
                   }

                   .clear-btn {
                       background-color: #bdc3c7;
                   }

                   .clear-btn:hover {
                       background-color: #95a5a6;
                   }

                   .modal-overlay {
                       display: none;
                       position: fixed;
                       top: 0;
                       left: 0;
                       width: 100%;
                       height: 100%;
                       background: rgba(0,0,0,0.6);
                       justify-content: center;
                       align-items: center;
                       z-index: 2000;
                   }

                   .modal-box {
                       background: #fff;
                       padding: 25px 35px;
                       border-radius: 10px;
                       width: 400px;
                       box-shadow: 0 5px 20px rgba(0,0,0,0.3);
                       text-align: left;
                   }

                   .modal-box h3 {
                       text-align: center;
                       color: #2c3e50;
                       margin-bottom: 20px;
                   }

                   .modal-box label {
                       display: block;
                       font-weight: bold;
                       margin: 10px 0 5px;
                   }

                   .modal-box input {
                       width: 100%;
                       padding: 8px 10px;
                       margin-bottom: 10px;
                       border: 1px solid #ccc;
                       border-radius: 6px;
                   }

                   .modal-buttons {
                       display: flex;
                       justify-content: flex-end;
                       gap: 10px;
                       margin-top: 15px;
                   }

                   .save-btn {
                       background: #1abc9c;
                       color: white;
                       border: none;
                       padding: 8px 16px;
                       border-radius: 6px;
                       cursor: pointer;
                   }

                   .save-btn:hover {
                       background: #16a085;
                   }

                   .cancel-btn {
                       background: #bdc3c7;
                       color: white;
                       border: none;
                       padding: 8px 16px;
                       border-radius: 6px;
                       cursor: pointer;
                   }

                   .cancel-btn:hover {
                       background: #95a5a6;
                   }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/_menu_builder_header.jsp"/>


<div class="container">
    <h2>Manage Document Categories</h2>
    <a class="add-link" href="${pageContext.request.contextPath}/add_documentcategory">Add New Category</a>
    <table>
    <form method="get" action="${pageContext.request.contextPath}/manage_documentcategories" class="filter-toolbar">
        <label for="status">Filter by Status:</label>
        <select name="status" id="status" class="status-select">
            <option value="Active" ${selectedStatus == 'Active' ? 'selected' : ''}>Active</option>
            <option value="Inactive" ${selectedStatus == 'Inactive' ? 'selected' : ''}>Inactive</option>
        </select>
        <button type="submit" class="filter-btn apply-btn">Apply</button>
        <a href="${pageContext.request.contextPath}/manage_documentcategories" class="filter-btn clear-btn">Clear</a>
    </form>
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

                <button type="button"
                        style="background:#f39c12; color:white; border:none; padding:8px 16px; border-radius:6px; cursor:pointer;"
                        onclick="openEditModal('${cat.id}', '${cat.categoryName}', '${cat.description}')">
                    Edit
                </button>

                   <c:choose>
                       <c:when test="${cat.status == 'Active'}">
                           <form action="${pageContext.request.contextPath}/doc_categories_deactivate/${cat.id}" method="post" style="display:inline">
                               <button type="submit" class="deactivate-btn">Deactivate</button>
                           </form>
                       </c:when>
                       <c:otherwise>
                           <form action="${pageContext.request.contextPath}/doc_categories_activate/${cat.id}" method="post" style="display:inline">
                               <button type="submit" class="activate-btn">Activate</button>
                           </form>
                       </c:otherwise>
                   </c:choose>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>

<div id="editModal" class="modal-overlay">
    <div class="modal-box">
        <h3>Edit Category</h3>
        <form id="editForm">
            <input type="hidden" id="editId">

            <label for="editName">Category Name:</label>
            <input type="text" id="editName" required>

            <label for="editDescription">Description:</label>
            <input type="text" id="editDescription">

            <div id="successMessage" style="
                display:none;
                background:#e8f9f1;
                color:#1abc9c;
                font-weight:600;
                text-align:center;
                margin-top:10px;
                padding:10px;
                border-radius:6px;
                transition:opacity 0.5s ease;
            ">
                ✅ Category updated successfully!
            </div>

            <div class="modal-buttons">
                <button type="button" id="cancelEdit" class="cancel-btn">Cancel</button>
                <button type="submit" class="save-btn">Save</button>
            </div>
        </form>
    </div>
</div>

<script>
document.getElementById("editForm").addEventListener("submit", function(e) {
    e.preventDefault();

    const id = document.getElementById("editId").value;
    const name = document.getElementById("editName").value;
    const description = document.getElementById("editDescription").value;

    fetch("${pageContext.request.contextPath}/update_document_category", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "id=" + id +
              "&categoryName=" + encodeURIComponent(name) +
              "&description=" + encodeURIComponent(description)
    })
    .then(response => {
        if (!response.ok) throw new Error("Server error");
        return response.text();
    })
    .then(message => {
        const msgBox = document.getElementById("successMessage");
        msgBox.style.display = "block";
        msgBox.style.opacity = "1";
        msgBox.textContent = "✅ " + message;

        setTimeout(() => {
            msgBox.style.opacity = "0"; // fade out smoothly
            setTimeout(() => {
                msgBox.style.display = "none";
                document.getElementById("editModal").style.display = "none";
                location.reload();
            }, 500); // wait for fade-out to complete
        }, 1200); // show for 1.2 seconds
    })
});
function openEditModal(id, name, description) {
    document.getElementById("editId").value = id;
    document.getElementById("editName").value = name;
    document.getElementById("editDescription").value = description;
    document.getElementById("editModal").style.display = "flex";
}

document.getElementById("cancelEdit").addEventListener("click", function() {
    document.getElementById("editModal").style.display = "none";
});
</script>

<jsp:include page="/WEB-INF/jsp/footer.jsp"/>
</body>
</html>

