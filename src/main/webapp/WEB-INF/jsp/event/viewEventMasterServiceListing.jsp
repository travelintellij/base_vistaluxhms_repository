<jsp:include page="../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
    body {
        background-image: url('<%= request.getContextPath() %>/resources/images/service-bg.jpg');
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
<body>

    <div class="container">
        <h2 class="text-center mb-4">Master Service List</h2>
        <div align="center" style="margin: 10px 0;">
            <b>
                <font color="green">${Success}</font>
                <font color="red">${Error}</font>
            </b>
        </div>

        <table class="table table-bordered table-striped">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Service Name</th>
                    <th>ServiceCost Type</th>
                    <th>Description</th>
                    <th>Base Cost</th>
                    <th>Service Cost Type</th>
                    <th>Active</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="masterServiceRec" items="${ACTIVE_MASTER_SERVICE_LIST}">
                    <tr >
                        <td style="${masterServiceRec.active ? '' : 'background-color: #ffcccc;'}">${masterServiceRec.id}</td>
                        <td style="${masterServiceRec.active ? '' : 'background-color: #ffcccc;'}">${masterServiceRec.name}</td>
                        <td style="${masterServiceRec.active ? '' : 'background-color: #ffcccc;'}">${masterServiceRec.eventServiceCostTypeEntity.eventServiceCostTypeName}</td>
                        <td style="${masterServiceRec.active ? '' : 'background-color: #ffcccc;'}">${masterServiceRec.description}</td>
                        <td style="${masterServiceRec.active ? '' : 'background-color: #ffcccc;'}">${masterServiceRec.baseCost}</td>
                        <td style="${masterServiceRec.active ? '' : 'background-color: #ffcccc;'}">${masterServiceRec.eventTypeName}</td>
                        <td style="${masterServiceRec.active ? '' : 'background-color: #ffcccc;'}">${masterServiceRec.active}</td>
                        <td class="action-btns">
                            <form action="view_master_service_details" method="POST" style="display:inline;">
                                <input type="hidden" name="id" value="${masterServiceRec.id}" />
                                <button type="submit" class="btn btn-info btn-sm">View</button>
                             </form>

                            <form action="view_edit_master_service_form" method="POST" style="display:inline;">
                                <input type="hidden" name="id" value="${masterServiceRec.id}" />
                                <button type="submit" class="btn btn-warning btn-sm">Edit</button>
                             </form>


                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="text-center mt-3">
            <a href="view_add_master_service_form" class="btn btn-success">Add New Master Service</a>
        </div>
    </div>
</body>
</html>
