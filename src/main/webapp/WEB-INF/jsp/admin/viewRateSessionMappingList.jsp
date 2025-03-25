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
</style>
<div align="center" style="margin:10px 0"><b>
    <font color="green">${Success} </font>
    <font color="red">${Error}</font>
</b></div>
      <!-- City List Table Section (Second Container) -->
      <div class="container">
      <h2>Rate Type List</h2> <!-- Bold Header -->
      <c:set value="${RATE_SESSION_MAPPING_LIST}" var="rateTypeSessionMapping" />
           <table class="table table-bordered table-striped">
                  <thead class="table-dark">
                  <tr>
                      <th>Rate Type ID</th>
                      <th style="width:25%;">Rate Type Name</th>
                      <th style="width:35%">Session Name</th>
                      <th>Start Date</th>
                      <th>End Date</th>
                  </tr>
              </thead>
              <tbody>
                  <!-- Replace this with actual data iteration logic -->
                  <c:forEach items="${rateTypeSessionMapping}" var="rateTypeSessionMappingRec">
                  <tr>
                      <td>${rateTypeSessionMappingRec.rateTypeEntity.rateTypeId}</td>
                      <td>${rateTypeSessionMappingRec.rateTypeEntity.rateTypeName }</td>
                      <td>
                          <a href="view_edit_session_detail_form?sessionId=${rateTypeSessionMappingRec.sessionEntity.sessionId}">
                              ${rateTypeSessionMappingRec.sessionEntity.sessionName}
                          </a>
                      </td>
                      <td>${rateTypeSessionMappingRec.formattedStartDate}</td>
                      <td>${rateTypeSessionMappingRec.formattedEndDate}</td>
                  </tr>
                  </c:forEach>
                  <!-- Repeat <tr> block for each city in the list -->
              </tbody>
          </table>
      </div>
<jsp:include page="../footer.jsp" />
