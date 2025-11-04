<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Manage Categories</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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

      form.form-inline {
          display: flex;
          align-items: center;
          justify-content: flex-start;
          margin-bottom: 25px;
      }

      form.form-inline .form-control {
          min-width: 180px;
      }

      .btn-primary {
          background-color: #3498db;
          border: none;
          font-weight: 600;
          padding: 8px 18px;
      }

      .btn-primary:hover {
          background-color: #2980b9;
      }

      .btn-secondary {
          background-color: #95a5a6;
          border: none;
          font-weight: 600;
          padding: 8px 18px;
      }

      .btn-secondary:hover {
          background-color: #7f8c8d;
      }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/_menu_builder_header.jsp"/>
<div class="container">
    <h2>Manage Categories</h2>

  <form action="categories_manage" method="get" class="form-inline mb-4">
      <div class="form-group mr-3">
          <label for="statusFilter" class="mr-2 font-weight-bold">Filter by Status:</label>
          <select name="status" id="statusFilter" class="form-control">
              <option value="Active" ${selectedStatus == 'Active' ? 'selected' : ''}>Active</option>
              <option value="Inactive" ${selectedStatus == 'Inactive' ? 'selected' : ''}>Inactive</option>
          </select>
      </div>

      <button type="submit" class="btn btn-primary mr-2">Apply</button>

      <a href="categories_manage" class="btn btn-secondary">Clear</a>
  </form>
  <table>
      <tr>
          <th>ID</th>
          <th>Name</th>
          <th>Description</th>
          <th>Status</th>
          <th>Action</th>
      </tr>
      <c:forEach var="cat" items="${categories}">
          <tr>
              <td>${cat.categoryId}</td>
              <td>${cat.categoryName}</td>
              <td>${cat.description}</td>

              <td>
                  <span style="padding:6px 12px; border-radius:8px; color:white;
                        background-color:${cat.status eq 'Active' ? '#28a745' : '#dc3545'};">
                      ${cat.status}
                  </span>
              </td>

            <td>
                <c:choose>
                    <c:when test="${cat.status eq 'Active'}">
                        <form action="${pageContext.request.contextPath}/categories_deactivate/${cat.categoryId}" method="post" style="display:inline;">
                            <button type="submit" class="btn btn-danger btn-sm">Deactivate</button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <form action="${pageContext.request.contextPath}/categories_activate/${cat.categoryId}" method="post" style="display:inline;">
                            <button type="submit" class="btn btn-success btn-sm">Activate</button>
                        </form>
                    </c:otherwise>
                </c:choose>
            </td>
          </tr>
      </c:forEach>
  </table>


<jsp:include page="/WEB-INF/jsp/footer.jsp"/>
</body>
</html>

