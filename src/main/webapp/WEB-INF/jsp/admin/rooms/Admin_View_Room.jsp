<jsp:include page="../../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Room Category</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            font-weight: bold;
        }
        .value-box {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background: #f8f9fa;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="text-center mb-4">Room Category Details</h2>
        <div class="row">
            <div class="col-md-4 form-group">
                <label>ID:</label>
                <div class="value-box">${ROOM_OBJ.roomCategoryId}</div>
            </div>
            <div class="col-md-4 form-group">
                <label>Room Category:</label>
                <div class="value-box">${ROOM_OBJ.roomCategoryName}</div>
            </div>
            <div class="col-md-4 form-group">
                <label>Size:</label>
                <div class="value-box">${ROOM_OBJ.size}</div>
            </div>
            <div class="col-md-4 form-group">
                <label>Max Occupancy:</label>
                <div class="value-box">${ROOM_OBJ.maxOccupancy}</div>
            </div>
            <div class="col-md-4 form-group">
                <label>Standard Occupancy:</label>
                <div class="value-box">${ROOM_OBJ.standardOccupancy}</div>
            </div>
            <div class="col-md-4 form-group">
                <label>Extra Bed:</label>
                <div class="value-box">${ROOM_OBJ.extraBed}</div>
            </div>
            <div class="col-md-4 form-group">
                <label>Child:</label>
                <div class="value-box">${ROOM_OBJ.child}</div>
            </div>
            <div class="col-md-4 form-group">
                <label>Complimentary Child:</label>
                <div class="value-box">${ROOM_OBJ.compChild}</div>
            </div>
            <div class="col-md-4 form-group">
                <label>Category Level:</label>
                <div class="value-box">${ROOM_OBJ.categoryLevel}</div>
            </div>
            <div class="col-md-12 form-group">
                <label>Description:</label>
                <div class="value-box">${ROOM_OBJ.description}</div>
            </div>
            <div class="col-md-12 form-group">
                <label>Active:</label>
                <div class="value-box">${ROOM_OBJ.active}</div>
            </div>
            <div class="col-md-12 text-center mt-3">
                <a href="view_rooms_list" class="btn btn-secondary">Back to List</a>
            </div>
        </div>
    </div>

<jsp:include page="../../footer.jsp" />

