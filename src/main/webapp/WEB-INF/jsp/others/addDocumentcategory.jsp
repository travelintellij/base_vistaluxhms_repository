<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Document Category</title>
    <style>
       body {
           background-image: url('<%= request.getContextPath() %>/resources/images/newlead.jpg');
           background-size: cover;
           background-position: center;
           background-attachment: fixed;
           margin: 0;
           font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
           position: relative;
       }

       body::after {
           content: "";
           position: fixed;
           inset: 0;
           background: rgba(255,255,255,0.3);
           z-index: -1;
       }

       /* SMALL CRM CONTAINER */
       .container {
           width: 35%;
           margin: 40px auto;
       }

       /* CARD STYLE */
       .form-container {
           background: #fff;
           padding: 25px;
           border-radius: 8px;
           box-shadow: 0 4px 15px rgba(0,0,0,0.1);
       }

       /* TITLE */
       h2 {
           text-align: center;
           font-size: 30px;
           color: #000;
           margin-bottom: 25px;
       }

       /* LABELS */
       label {
           font-weight: 600;
           font-size: 14px;
           color: #333;
           display: block;
           margin-bottom: 6px;
       }

       /* INPUTS */
       input {
           width: 100%;
           padding: 10px;
           border: 1px solid #ccc;
           border-radius: 4px;
           font-size: 14px;
           margin-bottom: 15px;
           box-sizing: border-box;
       }

       input:focus {
           border-color: #ff4b2b;
           box-shadow: 0 0 5px rgba(255,75,43,0.3);
           outline: none;
       }

       /* BUTTON */
       button {
           width: 100%;
           background: #ff4b2b;
           color: #fff;
           border: none;
           padding: 10px;
           font-size: 14px;
           border-radius: 4px;
           cursor: pointer;
       }

       button:hover {
           background: #e63e22;
       }

       /* BACK LINK */
       .back-link {
           display: block;
           text-align: center;
           margin-top: 15px;
           color: #555;
           text-decoration: none;
       }

       .back-link:hover {
           color: #ff4b2b;
       }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/_menu_builder_header.jsp"/>
<div class="container form-container">
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

