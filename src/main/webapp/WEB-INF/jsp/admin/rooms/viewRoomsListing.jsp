<jsp:include page="../../_menu_builder_header.jsp" />
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
        background-image: url('<%= request.getContextPath() %>/resources/images/roomlist.jpg');
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
       max-width: 95%;
       width: 95%;
       margin: 40px auto;
       padding: 20px;
       background: #fff;
       border-radius: 10px;
       box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
   }


   table {
       width: 100%;
       table-layout: auto;
   }

   th, td {
       text-align: center;
       vertical-align: middle;
       white-space: nowrap;
   }

   /* Room Category column wider and no wrap */
   th:nth-child(2),
   td:nth-child(2) {
       min-width: 220px;
       white-space: nowrap;
   }

   /* Actions column wider */
   th:nth-child(10),
   td:nth-child(10) {
       min-width: 140px;
   }

   .add-btn {
       display: inline-block;
       padding: 10px 22px;
       background-color: #c9a646;
       color: #000;
       text-decoration: none;
       border: 1px solid #b89434;
       border-radius: 6px;
       font-size: 14px;
       font-weight: 600;
       cursor: pointer;
       transition: 0.2s ease-in-out;
   }

   .add-btn:hover {
       background-color: #b89434;
       color: #000;
       text-decoration: none;
   }

</style>
<body>
<div align="center" style="margin:10px 0">
    <b>
        <font color="green">${Success}</font>
        <font color="red">${Error}</font>
    </b>
</div>
    <div class="container">
        <h2 class="text-center mb-4">Room Category List</h2>
        <div class="table-responsive">
        <table class="table table-bordered table-striped">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Room Category</th>
                    <th>Size</th>
                    <th>Max Occupancy</th>
                    <th>Standard Occupancy</th>
                    <th>Extra Bed</th>
                    <th>CWB %</th>
                    <th>Category Level</th>
                    <th>Active</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="room" items="${ACTIVE_ROOMS_LIST}">
                    <tr class="${room.active ? '' : 'row-inactive'}">
                        <td>${room.roomCategoryId}</td>
                        <td>${room.roomCategoryName}</td>
                        <td>${room.size}</td>
                        <td>${room.maxOccupancy}</td>
                        <td>${room.standardOccupancy}</td>
                        <td>${room.extraBed}</td>
                        <td>${room.cwbPercentage}</td>
                        <td>${room.categoryLevel}</td>
                        <td>${room.active}</td>
                        <td class="action-btns">
                            <form action="view_room_category_details" method="POST" style="display:inline;">
                                <input type="hidden" name="roomCategoryId" value="${room.roomCategoryId}" />
                                <button type="submit" class="view-btn">View</button>
                             </form>

                            <form action="view_edit_room_form" method="POST" style="display:inline;">
                                <input type="hidden" name="roomCategoryId" value="${room.roomCategoryId}" />
                                <button type="submit" class="edit-btn">Edit</button>
                             </form>


                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        </div>
        <div class="text-center mt-3">
            <a href="view_add_room_category_form" class="add-btn">Add New Room Category</a>
        </div>
    </div>
</body>
</html>
