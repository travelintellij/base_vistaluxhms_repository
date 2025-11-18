<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Document Category</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background:  linear-gradient(135deg, #43cea2, #185a9d); }
        .container { max-width: 600px; margin: 60px auto; background: #fff; padding: 50px; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
        h2 { text-align: center; margin-bottom: 30px; color: #34495e; }
        form label { display: block; margin-bottom: 10px; font-weight: 700; }
        form input { width: 100%; padding: 12px; margin-bottom: 20px; border-radius: 8px; border: 1px solid #bdc3c7; }
        form button { width: 100%; padding: 14px; background: #3498db; color: #fff; border: none; border-radius: 8px; cursor: pointer; font-weight: 700; }
        form button:hover { background: #2980b9; }
        .back-link { display: block; text-align: center; margin-top: 20px; color: #e67e22; font-weight: 700; text-decoration: none; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/_menu_builder_header.jsp"/>
<div class="container">
    <h2>Add Document Category</h2>
    <form action="${pageContext.request.contextPath}/save_documentcategory" method="post">
        <input type="hidden" name="id" value="${category.id}" />
        <label>Category Name:</label>
        <input type="text" name="categoryName" value="${category.categoryName}" required />
        <label>Description:</label>
        <input type="text" name="description" value="${category.description}" />
        <button type="submit">Save Category</button>
    </form>
    <a class="back-link" href="${pageContext.request.contextPath}/manage_documentcategories">Back to Categories</a>
</div>
<jsp:include page="/WEB-INF/jsp/footer.jsp"/>
</body>
</html>

