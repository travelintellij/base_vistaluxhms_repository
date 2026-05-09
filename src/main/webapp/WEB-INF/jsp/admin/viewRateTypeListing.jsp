<jsp:include page="../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
    body {
        background-image: url('<%= request.getContextPath() %>/resources/images/ratetypelist.jpg');
        background-size: cover; /* Ensures the image covers the full page */
        background-position: center; /* Centers the image */
        background-attachment: fixed; /* Keeps the background fixed while scrolling */
        height: 100vh; /* Ensures the background covers the full height of the viewport */
        position: relative; /* Required for the overlay */
    }

    /* Create a watermark-like effect using an overlay */
    body::after {
        content: "";  /* Empty content for the overlay */
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;

        background: rgba(255, 255, 255, 0.3); /* Semi-transparent white overlay */
        z-index: -1; /* Place the overlay behind the content */
    }

    /* Optional: If you want to adjust the opacity of the image to make it more subtle */
    body {
        opacity: .98; /* Adjust the opacity for the background image */
    }


    .container {
        max-width: 60%;
        margin: 40px auto;
        padding: 20px;
        background: #fff;
        border-radius: 10px;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    }
    table {
        width: 100%;
    }
    th, td {
        text-align: center;
        vertical-align: middle;
    }
    .action-btns a {
        margin: 3px;
    }

    .action-btns{
        display:flex;
        justify-content:center;
        align-items:center;
        gap:10px;
        flex-wrap:nowrap;
    }

    .action-btns form{
        margin:0;
    }

    .edit-btn{
        background:#c9a227;
        border:none;
        padding:8px 16px;
        border-radius:4px;
        color:#000;
        font-size:14px;
        cursor:pointer;
        white-space:nowrap;
        min-width:140px;
        text-align:center;
    }

    .edit-btn:hover{
        opacity:0.9;
    }
</style>
<div align="center" style="margin:10px 0"><b>
    <font color="green">${Success} </font>
    <font color="red">${Error}</font>
</b></div>
      <!-- City List Table Section (Second Container) -->
      <div class="container">
      <h2>Rate Type List</h2> <!-- Bold Header -->
      <c:set value="${RATE_TYPE_LIST}" var="rateTypeList" />
           <table class="table table-bordered table-striped">
                  <thead class="table-dark">
                  <tr>
                      <th>Rate Type ID</th>
                      <th style="width:25%;">Rate Type Name</th>
                      <th style="width:35%">Description</th>
                      <th>Status</th>
                      <th style="width:28%;">Action</th>
                  </tr>
              </thead>
              <tbody>
                  <!-- Replace this with actual data iteration logic -->
                  <c:forEach items="${rateTypeList}" var="rateTypeRec">
                  <tr>
                      <td>${rateTypeRec.rateTypeId}</td>
                      <td>${rateTypeRec.rateTypeName }</td>
                      <td>${rateTypeRec.description }</td>
                      <td>
                      <c:if test="${rateTypeRec.active eq true}">
                            <input type="button" class="status-badge-active"  value="Active" />
                        </c:if>
                        <c:if test="${rateTypeRec.active eq false}">
                                <input type="button" class="status-badge-inactive"  value="In-Active" />
                        </c:if>
                       </td>
                      <td>
                          <div class="action-btns">

                              <form action="view_edit_rate_type_form" method="POST">
                                  <input type="hidden" name="rateTypeId"
                                         value="${rateTypeRec.rateTypeId}" />

                                  <button type="submit" class="edit-btn">
                                      Edit
                                  </button>
                              </form>

                              <form action="view_rate_type_sessionwise" method="POST">
                                  <input type="hidden" name="rateTypeId"
                                         value="${rateTypeRec.rateTypeId}" />

                                  <button type="submit" class="edit-btn">
                                      &#128197; Check Applicable Dates
                                  </button>
                              </form>

                          </div>
                      </td>
                  </tr>
                  </c:forEach>
                  <!-- Repeat <tr> block for each city in the list -->
              </tbody>
          </table>
      </div>
<jsp:include page="../footer.jsp" />
