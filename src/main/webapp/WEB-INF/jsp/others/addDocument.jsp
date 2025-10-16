<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>Add Document</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #6dd5ed, #2193b0);
            min-height: 100vh;
        }

        .page-header-fullwidth {
            width: 100%;
            background-color: #fff;
            padding: 20px 0;
            margin-bottom: 40px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.1);
        }

        .page-header-fullwidth h2 {
            font-size: 36px;
            color: #ff4b2b;
            margin: 0;
            padding-left: 20px;
            text-align: center;
        }

        .container {
            width: 95%;
            max-width: 900px;
            background: #fff;
            border-radius: 20px;
            padding: 50px 60px;
            margin: 50px auto;
            box-shadow: 0 15px 40px rgba(0,0,0,0.3);
        }

        h2 {
            text-align: center;
            font-size: 40px;
            margin-bottom: 40px;
            color: #ff4b2b;
        }

        .form-cell {
            margin-bottom: 30px;
        }

        label {
            display: block;
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 12px;
            color: #333;
        }

        input[type="text"],
        input[type="file"],
        input[type="number"],
        input[type="date"],
        select,
        textarea,
        .form-control {
            width: 100% !important;
            padding: 18px 15px !important;
            font-size: 18px !important;
            border-radius: 12px !important;
            border: 2px solid #ccc !important;
            transition: all 0.3s ease !important;
            box-sizing: border-box !important;
        }

        input[type="text"]:focus,
        input[type="file"]:focus,
        input[type="number"]:focus,
        input[type="date"]:focus,
        select:focus,
        textarea:focus,
        .form-control:focus {
            border-color: #ff4b2b !important;
            box-shadow: 0 0 15px rgba(255,75,43,0.3) !important;
            outline: none !important;
        }

        textarea {
            resize: vertical !important;
            min-height: 120px !important;
        }

        .form-actions {
            text-align: center;
            margin-top: 40px;
        }

        .save-btn {
            background: linear-gradient(90deg, #ff416c, #ff4b2b);
            color: #fff;
            padding: 18px 40px;
            font-size: 22px;
            font-weight: bold;
            border: none;
            border-radius: 15px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-block;
            text-decoration: none;
        }

        .save-btn:hover {
            transform: scale(1.05);
            box-shadow: 0 0 20px rgba(255,75,43,0.5);
        }

        .btn-cancel,
        .cancel-btn {
            background: #ccc;
            color: #333;
            padding: 18px 40px;
            font-size: 22px;
            font-weight: bold;
            border-radius: 15px;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            margin-left: 20px;
        }

        .btn-cancel:hover,
        .cancel-btn:hover {
            background: #999;
            color: #fff;
            transform: scale(1.05);
        }

        .save-btn, .btn-cancel {
            padding: 18px 40px !important;
            font-size: 22px !important;
            font-weight: bold !important;
            border-radius: 15px !important;
        }
    </style>
</head>
<body>
   <jsp:include page="/WEB-INF/jsp/_menu_builder_header.jsp"/>
<div class="page-header-fullwidth">
    <h2>Add New Document</h2>
</div>

<div class="container">
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
            <label for="file">File *</label>
            <input type="file" id="file" name="file" required/>
        </div>

       <div class="form-cell">
           <label for="uploadedBy">Uploaded By *</label>
           <select id="uploadedBy" name="uploadedBy" class="form-control" required>

               <option value="" disabled selected>Select a user</option>
               <c:forEach var="team" items="${ashokaTeams}">
                   <option value="${team.key}">${team.value}</option>
               </c:forEach>
           </select>
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
</body>
</html>

