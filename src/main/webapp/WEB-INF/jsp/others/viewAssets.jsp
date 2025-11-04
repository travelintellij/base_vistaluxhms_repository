<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>Assets</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>

    * { margin:0; padding:0; box-sizing:border-box; }
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #43cea2, #185a9d);
        min-height: 100vh;
        color: #333;
        overflow-x: hidden;
        padding: 30px;
    }
    .page-header {
        display:flex;
        justify-content:center;
        align-items:center;
        margin:20px auto 30px auto;
        gap:20px;
        max-width:1200px;
        padding:0 20px;
    }
    .page-header h2 {
        font-size:36px;
        font-weight:bold;
        color:#fff;
        text-align:center;
        text-shadow:2px 2px 6px rgba(0,0,0,0.3);
        margin:0;
    }
    .btn-add {
        padding:10px 18px;
        background:#ff7e5f;
        color:#fff;
        font-weight:bold;
        border-radius:6px;
        text-decoration:none;
        box-shadow:0 4px 8px rgba(0,0,0,0.2);
        transition:0.3s;
    }
    .btn-add:hover { background:#eb5a3c; }
    .table-container {
        width:100%;
        max-width:1200px;
        margin:0 auto 40px auto;
        padding:0 20px;
    }
    table {
        width:100%;
        border-collapse:collapse;
        background:#fff;
        box-shadow:0 4px 12px rgba(0,0,0,0.15);
        border-radius:8px;
        overflow:hidden;
    }
    th, td { padding:12px 15px; text-align:left; }
    thead { background-color:#185a9d; color:#fff; font-weight:bold; }
    tbody tr:nth-child(even) { background-color:#f3f3f3; }
    tbody tr:hover { background-color:#d0eaff; }
    .btn {
        padding:6px 12px;
        margin:2px;
        border:none;
        border-radius:4px;
        color:#fff;
        cursor:pointer;
        font-size:14px;
        text-decoration:none;
    }
    .btn-transfer { background-color:#43cea2; }
    .btn-transfer:hover { background-color:#2bb07f; }
    .btn-history { background-color:#185a9d; }
    .btn-history:hover { background-color:#0f3c6a; }
    .btn-edit { background-color:#ff7e5f; }
    .btn-edit:hover { background-color:#eb5a3c; }
    .btn-danger { background-color:#e74c3c; }
    .btn-danger:hover { background-color:#c0392b; }
    .no-data { text-align:center; font-style:italic; color:#666; }
    .pagination { display:flex; justify-content:center; margin-top:20px; gap:5px; }
    .pagination button {
        padding:6px 12px;
        border:none;
        border-radius:4px;
        background-color:#185a9d;
        color:white;
        cursor:pointer;
    }
    .pagination button:hover { background-color:#0f3c6a; }
    .pagination button.active { background-color:#43cea2; }

    .modal-content {
        background:#fff;
        padding:20px;
        border-radius:8px;
        width:400px;
        text-align:center;
        box-shadow:0 4px 12px rgba(0,0,0,0.25);
    }
    .modal-actions { margin-top:15px; display:flex; justify-content:center; gap:10px; }
    .btn-secondary {
        background-color:#777; color:#fff; border:none; padding:6px 12px; border-radius:4px; cursor:pointer;
    }
    .btn-secondary:hover { background-color:#555; }


    .pagination {
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 6px;
      margin-top: 20px;
      flex-wrap: wrap;
    }

    .pagination .btn {
      background-color: #185a9d;
      color: #fff;
      padding: 8px 14px;
      border-radius: 6px;
      text-decoration: none;
      transition: all 0.2s ease-in-out;
      box-shadow: 0 2px 5px rgba(0,0,0,0.15);
      border: none;
    }

    .pagination .btn:hover {
      background-color: #0f3c6a;
      color: #fff;
      transform: translateY(-1px);
    }

    .pagination .btn.active {
      background-color: #43cea2;
      color: #fff;
      font-weight: bold;
      pointer-events: none;
      box-shadow: 0 2px 6px rgba(0,0,0,0.25);
    }

    .pagination .btn:disabled {
      background-color: #ccc;
      color: #666;
      cursor: not-allowed;
      box-shadow: none;
    }
    </style>
</head>

<body>
<jsp:include page="/WEB-INF/jsp/_menu_builder_header.jsp"/>

<c:if test="${not empty successMessage}">
    <div class="alert alert-success">${successMessage}</div>
</c:if>
<c:if test="${not empty errorMessage}">
    <div class="alert alert-danger">${errorMessage}</div>
</c:if>

<div class="page-header">
    <h2>Asset List</h2>
    <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ASSET_MANAGER')">
    <a href="${pageContext.request.contextPath}/add_asset" class="btn-add">+ Add Asset</a>
    </sec:authorize>
</div>
<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ASSET_MANAGER')">
<div class="container mb-4">
 <form action="view_assets_list" method="get" class="row g-3 bg-light p-3 rounded shadow-sm">
     <div class="col-md-3">
         <input type="text" name="assetCode" class="form-control" placeholder="Asset Code" value="${selectedAssetCode}"/>
     </div>
     <div class="col-md-3">
         <input type="text" name="assetName" class="form-control" placeholder="Asset Name" value="${selectedAssetName}"/>
     </div>
     <div class="col-md-3">
         <select name="categoryId" class="form-select">
              <option value="">Select Category</option>
              <c:forEach var="cat" items="${categories}">
                  <option value="${cat.categoryId}" ${selectedCategory == cat.categoryId ? 'selected' : ''}>
                      ${cat.categoryName}
                  </option>
              </c:forEach>
          </select>
           </div>

          <div class="col-md-3">
              <select name="status" class="form-select">
                  <option value="Active" <c:if test="${param.status == 'Active' || empty param.status}">selected</c:if>>Active</option>
                  <option value="Deactivated" <c:if test="${param.status == 'Deactivated'}">selected</c:if>>Deactivated</option>
              </select>
          </div>


     <div class="col-md-3">
         <select name="ownerId" class="form-select">
             <option value="">-- Owner --</option>
             <c:forEach var="team" items="${ashokaTeamMap}">
                 <option value="${team.key}" ${team.key == selectedOwnerId ? 'selected' : ''}>${team.value}</option>
             </c:forEach>
         </select>
     </div>
        <div class="col-12 text-center mt-2">
            <button type="submit" class="btn btn-primary">Apply</button>
            <a href="${pageContext.request.contextPath}/view_assets_list" class="btn btn-secondary">Clear</a>
        </div>
    </form>
</div>
</sec:authorize>

<div class="table-container">

    <table id="assetTable">
        <thead>
            <tr>
                <th>Asset Code</th>
                <th>Asset Name</th>
                <th>Category</th>
                <th>Cost</th>
                <th>Owner</th>
                <th>Allocated Date</th>
              <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ASSET_MANAGER')">
                <th>Actions</th>
              </sec:authorize>
              <sec:authorize access="hasRole('ASSET_ALLOWED')">
                          <th>History / View</th>
                      </sec:authorize>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="asset" items="${ASSETS_LIST}">
                <tr>
                    <td>${asset.assetCode != null ? asset.assetCode : 'N/A'}</td>
                    <td>${asset.assetName != null ? asset.assetName : 'N/A'}</td>
                  <td>
                   ${asset.category != null ? asset.category.categoryName : 'N/A'}
                 </td>
                 <td>${asset.assetCost != null ? asset.assetCost : '0'}</td>
                    <td>${asset.assetOwnerName != null ? asset.assetOwnerName : 'N/A'}</td>
                    <td><fmt:formatDate value="${asset.allocatedDate}" pattern="dd-MM-yyyy"/></td>

                       <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ASSET_MANAGER')">
                    <td>
                        <a href="${pageContext.request.contextPath}/assets_transfer_form/${asset.assetId}" class="btn btn-transfer">Transfer</a>
                        <a href="${pageContext.request.contextPath}/assets_transfer_history/${asset.assetId}" class="btn btn-history">History</a>
                        <a href="${pageContext.request.contextPath}/edit_asset/${asset.assetId}" class="btn btn-edit">Edit</a>
                        <button type="button" class="btn btn-info viewAssetBtn"
                                data-bs-toggle="modal"
                                data-bs-target="#viewAssetModal"
                                data-code="${asset.assetCode}"
                                data-name="${asset.assetName}"
                          data-category="${asset.category != null ? asset.category.categoryName : 'N/A'}"
                               data-cost="${asset.assetCost}"
                                data-owner="${asset.assetOwnerName}"
                                data-allocated="<fmt:formatDate value='${asset.allocatedDate}' pattern='dd-MM-yyyy'/>"
                               data-description="${fn:escapeXml(asset.description)}">
                           View
                        </button>
                       <c:choose>
                           <c:when test="${asset.active}">
                               <a href="#" class="btn btn-danger btn-sm toggle-status-btn"
                                  data-asset-name="${asset.assetName}"
                                  data-url="${pageContext.request.contextPath}/assets_deactivate/${asset.assetId}"
                                  data-action="Deactivate">
                                  Deactivate
                               </a>
                           </c:when>
                           <c:otherwise>
                               <a href="#" class="btn btn-success btn-sm toggle-status-btn"
                                  data-asset-name="${asset.assetName}"
                                  data-url="${pageContext.request.contextPath}/assets_activate/${asset.assetId}"
                                  data-action="Activate">
                                  Activate
                               </a>
                           </c:otherwise>
                       </c:choose>
                    </td>
                    </sec:authorize>
                    <sec:authorize access="hasRole('ASSET_ALLOWED')">
                                        <td>
                                            <a href="${pageContext.request.contextPath}/assets_transfer_history/${asset.assetId}" class="btn btn-history">History</a>
                                            <button type="button" class="btn btn-info viewAssetBtn"
                                                    data-bs-toggle="modal"
                                                    data-bs-target="#viewAssetModal"
                                                    data-code="${asset.assetCode}"
                                                    data-name="${asset.assetName}"
                                                     data-category="${asset.category != null ? asset.category.categoryName : 'N/A'}"
                                                     data-cost="${asset.assetCost}"
                                                    data-owner="${asset.assetOwnerName}"
                                                    data-allocated="<fmt:formatDate value='${asset.allocatedDate}' pattern='dd-MM-yyyy'/>"
                                                     data-description="${fn:escapeXml(asset.description)}">
                                                View
                                            </button>
                                        </td>
                                    </sec:authorize>
                </tr>
            </c:forEach>

            <c:if test="${empty ASSETS_LIST}">
                <tr>
                    <td colspan="6" class="no-data">No assets found</td>
                </tr>
            </c:if>
        </tbody>
    </table>
<c:if test="${not empty totalPages && totalPages > 0}">
    <div class="pagination">
        <c:if test="${currentPage > 0}">
            <a href="?page=${currentPage - 1}&assetCode=${selectedAssetCode}&assetName=${selectedAssetName}&categoryId=${selectedCategoryId}&ownerId=${selectedOwnerId}&status=${param.status}"
               class="btn">Previous</a>
        </c:if>

        <c:forEach begin="0" end="${totalPages - 1}" var="i">
            <a href="?page=${i}&assetCode=${selectedAssetCode}&assetName=${selectedAssetName}&categoryId=${selectedCategoryId}&ownerId=${selectedOwnerId}&status=${param.status}"
               class="btn ${i eq currentPage ? 'active' : ''}">
               ${i + 1}
            </a>
        </c:forEach>

        <c:if test="${currentPage < totalPages - 1}">
            <a href="?page=${currentPage + 1}&assetCode=${selectedAssetCode}&assetName=${selectedAssetName}&categoryId=${selectedCategoryId}&ownerId=${selectedOwnerId}&status=${param.status}"
               class="btn">Next</a>
        </c:if>
    </div>
</c:if>

<div class="modal fade" id="viewAssetModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-md modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title">Asset Details</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <table class="table table-bordered">
          <tr><th>Asset Code</th><td id="assetCode"></td></tr>
          <tr><th>Asset Name</th><td id="assetName"></td></tr>
          <tr><th>Category</th><td id="assetCategory"></td></tr>
          <tr><th>Cost</th><td id="assetCost"></td></tr>
          <tr><th>Owner</th><td id="assetOwner"></td></tr>
          <tr><th>Allocated Date</th><td id="assetAllocatedDate"></td></tr>
          <tr><th>Description</th><td id="assetDescription"></td></tr>
        </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="statusModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header bg-danger text-white">
        <h5 class="modal-title">Confirm Action</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body" id="deleteText">
        Are you sure you want to delete this asset permanently?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <form id="deleteForm" method="post">
          <button type="submit" class="btn btn-danger">Yes, confirm</button>
        </form>
      </div>
    </div>
  </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {
  var deleteUrl = '';
  var deleteText = document.getElementById('deleteText');
  var deleteForm = document.getElementById('deleteForm');
  var deleteModalEl = document.getElementById('statusModal');
  var deleteModal = new bootstrap.Modal(deleteModalEl);

 document.querySelectorAll('.toggle-status-btn').forEach(function (btn) {
   btn.addEventListener('click', function (e) {
     e.preventDefault();
     var action = btn.getAttribute('data-action');
     var name = btn.getAttribute('data-asset-name');
     var url = btn.getAttribute('data-url');

     document.getElementById('deleteText').textContent =
       'Are you sure you want to ' + action.toLowerCase() + ' "' + name + '"?';
     document.getElementById('deleteForm').action = url;

     var modal = new bootstrap.Modal(document.getElementById('statusModal'));
     modal.show();
   });
 });
});

document.querySelectorAll('.viewAssetBtn').forEach(function (btn) {
  btn.addEventListener('click', function () {
    document.getElementById('assetCode').innerText = btn.getAttribute('data-code') || 'N/A';
    document.getElementById('assetName').innerText = btn.getAttribute('data-name') || 'N/A';
    document.getElementById('assetCategory').innerText = btn.getAttribute('data-category') || 'N/A';
    document.getElementById('assetCost').innerText = btn.getAttribute('data-cost') || '0';
    document.getElementById('assetOwner').innerText = btn.getAttribute('data-owner') || 'N/A';
    document.getElementById('assetAllocatedDate').innerText = btn.getAttribute('data-allocated') || 'N/A';
    document.getElementById('assetDescription').innerText = btn.getAttribute('data-description') || 'N/A';
  });
});

function toggleAssetSidebar() {
    var sidebar = document.getElementById("asset-filter-sidebar");
    var mainContent = document.querySelector(".main-content");
    if(sidebar.style.width === "0px" || sidebar.style.width === "") {
        sidebar.style.width = "320px";
        mainContent.style.marginLeft = "320px";
    } else {
        sidebar.style.width = "0";
        mainContent.style.marginLeft = "0";
    }
}

function clearAssetFilters() {
    document.querySelector("#asset-filter-sidebar form").reset();
}
</script>

<jsp:include page="/WEB-INF/jsp/footer.jsp"/>
</body>
</html>

