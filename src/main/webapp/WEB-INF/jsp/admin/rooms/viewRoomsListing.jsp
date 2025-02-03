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
<div align="center" style="margin:10px 0">
    <b>
        <font color="green">${Success}</font>
        <font color="red">${Error}</font>
    </b>
</div>
    <div class="container">
        <h2 class="text-center mb-4">Room Category List</h2>
        <table class="table table-bordered table-striped">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Room Category</th>
                    <th>Size</th>
                    <th>Standard Occupancy</th>
                    <th>Max Occupancy</th>
                    <th>Extra Bed</th>
                    <th>Category Level</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="room" items="${ACTIVE_ROOMS_LIST}">
                    <tr>
                        <td>${room.id}</td>
                        <td>${room.roomCategory}</td>
                        <td>${room.size}</td>
                        <td>${room.standardOccupancy}</td>
                        <td>${room.maxOccupancy}</td>
                        <td>${room.extraBed}</td>
                        <td>${room.categoryLevel}</td>
                        <td class="action-btns">
                            <a href="viewRoomCategory?id=${room.id}" class="btn btn-info btn-sm">View</a>
                            <a href="editRoomCategory?id=${room.id}" class="btn btn-warning btn-sm">Edit</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="text-center mt-3">
            <a href="addRoomCategory" class="btn btn-success">Add New Room Category</a>
        </div>
    </div>
</body>
</html>
