<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>Add Document</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
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
          width: 45%;
          margin: 40px auto;
      }

      /* CARD STYLE */
      .form-container {
          background: #fff;
          padding: 25px;
          border-radius: 8px;
          box-shadow: 0 4px 15px rgba(0,0,0,0.1);
      }

      /* TITLE LIKE LEADS (but neutral) */
      h2 {
          text-align: center;
          font-size: 36px;
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
      input[type="text"],
      input[type="file"],
      select,
      textarea {
          width: 100%;
          padding: 10px;
          border: 1px solid #ccc;
          border-radius: 4px;
          font-size: 14px;
          box-sizing: border-box;
      }

      input:focus,
      select:focus,
      textarea:focus {
          border-color: #ff4b2b;
          box-shadow: 0 0 5px rgba(255,75,43,0.3);
          outline: none;
      }

      /* FORM ROW SPACING */
      .form-cell {
          margin-bottom: 15px;
      }

      /* BUTTON AREA */
      .form-actions {
          text-align: center;
          margin-top: 20px;
      }

      .save-btn {
          background: #ff4b2b;
          color: #fff;
          border: none;
          padding: 10px 18px;
          font-size: 14px;
          border-radius: 4px;
          cursor: pointer;
      }

      .save-btn:hover {
          background: #e63e22;
      }

      .btn-cancel {
          background: #ccc;
          color: #333;
          padding: 10px 18px;
          font-size: 14px;
          border-radius: 4px;
          text-decoration: none;
          margin-left: 10px;
          display: inline-block;
      }

      .btn-cancel:hover {
          background: #aaa;
      }
    </style>
</head>
<body>
   <jsp:include page="/WEB-INF/jsp/_menu_builder_header.jsp"/>

</div>

<div class="container form-container">
   <h2>Add New Document</h2>
<c:if test="${not empty errorMessage}">
        <div style="color: red; font-weight: bold; margin-bottom: 20px; text-align:center;">
            ${errorMessage}
        </div>
    </c:if>

    <form action="<c:url value='/save_document'/>" method="post" enctype="multipart/form-data">
        <div class="form-cell">
            <label for="categoryId">Category Name *</label>
            <select id="categoryId" name="categoryId" class="form-control" required>
                <option value="" disabled selected>-- Select Category --</option>
                <c:forEach var="cat" items="${categories}">
                    <option value="${cat.id}">${cat.categoryName}</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-cell">
            <label for="documentName">Document Name *</label>
            <input type="text" id="documentName" name="documentName"
                   class="form-control" required placeholder="Enter Document Name"/>
        </div>



        <div class="form-cell">
            <label for="file">File *</label>
            <input type="file" id="file" name="file" required/>
            <!-- Inline error message -->
            <div id="fileError" style="color: red; font-weight: bold; margin-top: 8px;"></div>
        </div>


        <c:if test="${fn:contains(userRoles,'ROLE_ADMIN') || fn:contains(userRoles,'DOCUMENT_MANAGER')}">
            <div class="form-cell">
                <label>
                    <input type="checkbox" name="restricted" value="true" />
                    Restricted
                </label>
            </div>
        </c:if>

        <div class="form-actions">
            <input type="submit" class="save-btn" value="Upload Document"/>
            <a href="<c:url value='/view_documents_list'/>" class="btn-cancel">Cancel</a>
        </div>


    </form>
</div>

<script>
document.getElementById("file").addEventListener("change", function() {
    const file = this.files[0];
    const errorDiv = document.getElementById("fileError");
    errorDiv.textContent = ""; // clear previous error

    if (file && file.size > 5 * 1024 * 1024) { // 5 MB limit
        errorDiv.textContent = "File size should not exceed 5 MB";
        this.value = ""; // clear the file input
    }
});
</script>
</body>
</html>

