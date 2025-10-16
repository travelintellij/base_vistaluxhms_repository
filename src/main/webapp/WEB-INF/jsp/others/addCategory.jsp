<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Category</title>
  <style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #e0f7fa, #f1f8e9);
    margin: 0;
}

.container {
    max-width: 600px;
    margin: 60px auto;
    background: #fff;
    padding: 50px 40px;
    border-radius: 15px;
    box-shadow: 0 12px 25px rgba(0,0,0,0.15);
}

h2 {
    text-align: center;
    color: #34495e;
    margin-bottom: 35px;
    font-weight: 800;
    font-size: 28px;
}

form label {
    display: block;
    margin-bottom: 10px;
    font-weight: 700;
    color: #2c3e50;
    font-size: 16px;
}

form input {
    width: 100%;
    padding: 12px 15px;
    margin-bottom: 25px;
    border-radius: 10px;
    border: 1px solid #bdc3c7;
    font-size: 16px;
}

form input:focus {
    border-color: #3498db;
    outline: none;
}

form button {
    width: 100%;
    padding: 14px;
    background: #3498db;
    color: white;
    border: none;
    border-radius: 10px;
    cursor: pointer;
    font-size: 18px;
    font-weight: 700;
}

form button:hover {
    background: #2980b9;
}

.back-link {
    display: block;
    text-align: center;
    margin-top: 25px;
    color: #e67e22;
    text-decoration: none;
    font-weight: 700;
    font-size: 16px;
}

  </style>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/_menu_builder_header.jsp"/>
<div class="container">
    <h2>Add Category</h2>
    <form action="${pageContext.request.contextPath}/categories_save" method="post">
        <input type="hidden" name="categoryId" value="${category.categoryId}" />
        <label>Name:</label>
        <input type="text" name="categoryName" value="${category.categoryName}" required />
        <label>Description:</label>
        <input type="text" name="description" value="${category.description}" />
        <button type="submit">Add Category</button>
    </form>
    <a class="back-link" href="${pageContext.request.contextPath}/categories_manage">Manage Categories</a>
</div>
<jsp:include page="/WEB-INF/jsp/footer.jsp"/>
</body>
</html>

