<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>Documents List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            padding: 30px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #43cea2, #185a9d);
            min-height: 100vh;
            color: #333;
        }

        .page-header-fullwidth {
            width: 100%;
            background-color: #fff;
            padding: 25px 0;
            margin-bottom: 40px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.2);
            text-align: center;
        }
        .page-header-fullwidth h2 {
            font-size: 36px;
            color: #222;
            margin: 0;
        }

       .filter-item {
            min-width: 250px;
        }
       .filter-item select, form .form-select {
           height: 38px;
           font-size: 16px;
       }


        .filter-buttons button,
        .filter-buttons a {
            padding: 12px 25px;
            font-size: 1.1rem;
            border-radius: 8px;
        }
        .reset-btn {
            background-color: #6c757d;
            color: #fff;
            border: none;
        }
        .reset-btn:hover { background-color: #5a6268; }

        .container {
            width: 95%;
            max-width: 1100px;
            background: #fff;
            border-radius: 20px;
            padding: 30px 40px;
            margin: 0 auto 50px auto;
            box-shadow: 0 15px 40px rgba(0,0,0,0.3);
        }

        .add-btn {
            display: inline-block;
            background: #ff7e5f;
            color: #fff;
            font-size: 25px;
            padding: 15px 30px;
            border-radius: 12px;
            font-weight: bold;
            text-decoration: none;
            margin-bottom: 10px;
            transition: all 0.3s ease;
        }
        .add-btn:hover { background: #eb5a3c; transform: scale(1.05); }

        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        table th, table td {
            padding: 12px 15px;
            text-align: left;
            font-size: 18px;
            border-bottom: 1px solid #ddd;
        }
        table.table th {
            background-color: #FFEB3B !important;
            color: #000; !important;
            font-weight: bold;
            border-bottom: 2px solid #ccc;
        }

        table tr:nth-child(even) { background-color: #f3f3f3; }
        table tr:hover { background-color: #d0eaff; }

        .view-btn, .download-btn, .delete-btn {
            display: inline-block;
            color: #fff;
            border-radius: 6px;
            font-size: 14px;
            padding: 8px 14px;
            font-weight: bold;
            text-decoration: none;
            margin-right: 5px;
            transition: all 0.3s ease;
        }
        .view-btn { background: #43cea2; }
        .view-btn:hover { background: #2bb07f; }
        .download-btn { background: #185a9d; }
        .download-btn:hover { background: #0f3c6a; }
        .delete-btn { background: #e74c3c; }
        .delete-btn:hover { background: #c0392b; }


        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
        }
        .modal-content {
            background-color: #fff;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 400px;
            text-align: center;
            border-radius: 10px;
        }
        .modal button {
            padding: 10px 20px;
            margin: 10px;
            font-size: 14px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }
        .confirm-btn { background: #e74c3c; color: #fff; }
        .confirm-btn:hover { background: #c0392b; }
        .cancel-btn { background: #6c757d; color: #fff; }
        .cancel-btn:hover { background: #5a6268; }

        .text-bright {
            color: #ffeb3b;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.3);
        }


        .category-card {
            background: #fff;
            border-radius: 15px;
            margin-bottom: 40px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            overflow: hidden;
        }

        .category-header {
            background: linear-gradient(90deg, #ffeb3b, #ffd54f);
            color: #222;
            font-size: 24px;
            font-weight: bold;
            padding: 15px 25px;
            border-bottom: 2px solid #f0c000;
        }

        table.category-table {
            width: 100%;
            border-collapse: collapse;
        }

        table.category-table th, table.category-table td {
            padding: 12px 18px;
            font-size: 17px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        table.category-table th {
            background-color: #f9f9f9;
            font-weight: bold;
            color: #333;
        }

        table.category-table tr:hover {
            background-color: #f1faff;
        }

        .doc-actions a {
            padding: 7px 12px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: bold;
            color: #fff;
            text-decoration: none;
            margin-right: 5px;
            transition: all 0.3s ease;
        }

        .doc-actions .view-btn { background: #43cea2; }
        .doc-actions .view-btn:hover { background: #2bb07f; }
        .doc-actions .download-btn { background: #185a9d; }
        .doc-actions .download-btn:hover { background: #0f3c6a; }
        .doc-actions .delete-btn { background: #e74c3c; }
        .doc-actions .delete-btn:hover { background: #c0392b; }


    </style>
</head>
<body>

<jsp:include page="/WEB-INF/jsp/_menu_builder_header.jsp"/>


<div class="d-flex justify-content-center align-items-center mb-4" style="gap:20px;">
    <h2 style="color:#fff; font-weight:bold; font-size:42px; margin:0;">Documents</h2>
    <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_DOCUMENT_MANAGER')">
        <a href="<c:url value='/add_document'/>" class="add-btn"
           style="font-size:14px; padding:6px 12px; margin:0;">Add New Document</a>
    </sec:authorize>
</div>

<div class="container mb-4" style="max-width:600px; background:#fff; padding:3px 10px; border-radius:15px; box-shadow:0 10px 30px rgba(0,0,0,0.2);">
    <form method="get" action="<c:url value='/view_documents_list'/>" class="row g-3 justify-content-center align-items-end mb-0">
        <div class="col-md-12">
            <select name="categoryId" class="form-select">
                <option value="">-- Category --</option>
                <c:forEach var="cat" items="${categories}">
                    <option value="${cat.id}" <c:if test="${cat.id == param.categoryId}">selected</c:if>>
                        ${cat.categoryName}
                    </option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-12 text-center">
            <button type="submit" class="btn btn-primary me-2">Apply</button>
            <a href="<c:url value='/view_documents_list'/>" class="btn btn-secondary">Reset</a>
        </div>
    </form>
</div>

<div class="container mb-4" style="max-width:1000px;">

    <c:forEach var="entry" items="${groupedDocs}">
        <div class="category-card">
            <div class="category-header">
                ${entry.key}
            </div>

            <table class="category-table">
                <thead>
                    <tr>
                        <th style="width:10%;">ID</th>
                        <th style="width:35%;">Document Name</th>
                        <th style="width:35%;">File Name</th>
                        <th style="width:20%;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="doc" items="${entry.value}">
                        <c:if test="${!doc.restricted || fn:contains(userRoles,'ROLE_ADMIN') || fn:contains(userRoles,'ROLE_RESTRICTED_DOC_ACCESS') || fn:contains(userRoles,'ROLE_DOCUMENT_MANAGER')}">
                            <tr>
                                <td>${doc.documentId}</td>
                                <td>${doc.documentName}</td>
                                <td>${doc.fileName}</td>
                                <td class="doc-actions">
                                    <a href="<c:url value='/download_document/${doc.documentId}'/>" class="download-btn">Download</a>
                                    <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_DOCUMENT_MANAGER')">
                                        <a href="#" class="delete-btn" onclick="openDeleteModal(${doc.documentId})">Delete</a>
                                    </sec:authorize>
                                    <a href="<c:url value='/view_document/${doc.documentId}'/>" target="_blank" class="view-btn">View</a>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:forEach>
</div>

<div id="deleteModal" class="modal">
    <div class="modal-content">
        <h3>Confirm Delete</h3>
        <p>Are you sure you want to delete this document?</p>
        <form id="deleteForm" method="get">
            <button type="submit" class="confirm-btn">Delete</button>
            <button type="button" class="cancel-btn" onclick="closeDeleteModal()">Cancel</button>
        </form>
    </div>
</div>

<script>
    function openDeleteModal(id) {
        document.getElementById('deleteForm').action = '<c:url value="/delete_document/"/>' + id;
        document.getElementById('deleteModal').style.display = 'block';
    }
    function closeDeleteModal() {
        document.getElementById('deleteModal').style.display = 'none';
    }
    window.onclick = function(event) {
        if (event.target === document.getElementById('deleteModal')) {
            closeDeleteModal();
        }
    }
</script>
</body>
</html>

