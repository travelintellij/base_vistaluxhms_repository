<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Manage Categories</title>
  <style>
  #deleteModal {
      display: none;
      position: fixed;
      z-index: 1000;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      overflow: auto;
      background-color: rgba(0,0,0,0.5);
  }

  #deleteModal .modal-content {
      background-color: #fff;
      margin: 15% auto;
      padding: 30px;
      border-radius: 12px;
      max-width: 400px;
      text-align: center;
      box-shadow: 0 10px 25px rgba(0,0,0,0.2);
  }

  #deleteModal .close {
      color: #aaa;
      float: right;
      font-size: 24px;
      font-weight: bold;
      cursor: pointer;
  }

  #deleteModal .close:hover { color: #e74c3c; }

  #deleteModal button {
      padding: 10px 20px;
      margin: 0 10px;
      border: none;
      border-radius: 8px;
      font-size: 14px;
      cursor: pointer;
      transition: background 0.3s;
  }

  #deleteModal .cancel-btn { background-color: #bdc3c7; color: #fff; }
  #deleteModal .cancel-btn:hover { background-color: #95a5a6; }

  #deleteModal .confirm-delete-btn { background-color: #e74c3c; color: #fff; }
  #deleteModal .confirm-delete-btn:hover { background-color: #c0392b; }

      body {
          font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
          background: linear-gradient(135deg, #fdfbfb, #ebedee);
          margin: 0;
      }

      .container {
          width: 95%;
          max-width: 1100px;
          margin: 50px auto;
          background: #fff;
          padding: 50px 40px;
          border-radius: 20px;
          box-shadow: 0 15px 35px rgba(0,0,0,0.2);
      }

      h2 {
          text-align: center;
          color: #2c3e50;
          margin-bottom: 40px;
          font-weight: 800;
          font-size: 32px;
      }

      .add-link {
          display: inline-block;
          margin-bottom: 25px;
          padding: 12px 22px;
          background: #1abc9c;
          color: white;
          border-radius: 10px;
          text-decoration: none;
          font-weight: 700;
          font-size: 17px;
          transition: background 0.3s;
      }

      .add-link:hover {
          background: #16a085;
      }
table {
    width: 100%;
    border-collapse: collapse;
    font-size: 16px;
}

table th, table td {
    padding: 14px;
    border-bottom: 1px solid #ddd;
    text-align: left;
    font-weight: 700;
    color: #2c3e50;
}

table th {
    background: #3498db;
    color: white;
    font-size: 18px;
    text-transform: uppercase;
}

table tr:nth-child(even) {
    background: #f9f9f9;
}

table tr:hover {
    background: #d6eaf8;
}

      .delete-btn {
          background: #e74c3c;
          color: white;
          border: none;
          padding: 8px 16px;
          border-radius: 8px;
          font-size: 16px;
          font-weight: 600;
          cursor: pointer;
          transition: background 0.3s;
      }

      .delete-btn:hover {
          background: #c0392b;
      }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/_menu_builder_header.jsp"/>
<div class="container">
    <h2>Manage Categories</h2>
    <a class="add-link" href="${pageContext.request.contextPath}/categories_add">Add New Category</a>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="cat" items="${categories}">
            <tr>
                <td>${cat.categoryId}</td>
                <td>${cat.categoryName}</td>
                <td>${cat.description}</td>
                <td>
                        <button type="button" class="delete-btn" onclick="openDeleteModal(${cat.categoryId})">Delete</button>


                </td>
            </tr>
        </c:forEach>
    </table>

    <div id="deleteModal" class="modal" style="display:none;">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h3>Confirm Delete</h3>
            <p>Are you sure you want to delete this category?</p>
            <form id="deleteCategoryForm" method="post" action="">
                <button type="submit" class="delete-btn">Yes, Delete</button>
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
        // Set form action dynamically
        deleteForm.action = '${pageContext.request.contextPath}/categories_delete/' + categoryId;
        modal.style.display = "block";
    }

    // Close modal when clicking 'x'
    span.onclick = function() {
        modal.style.display = "none";
    }

    // Close modal when clicking 'Cancel'
    cancelBtn.onclick = function() {
        modal.style.display = "none";
    }


    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
</script>
<jsp:include page="/WEB-INF/jsp/footer.jsp"/>
</body>
</html>

