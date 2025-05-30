<jsp:include page="../_menu_builder_header.jsp" />
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
        body {
            background-image: url('<%= request.getContextPath() %>/resources/images/roomview.jpg');
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
            max-width: 1000px;
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
        <h2 class="text-center mb-4">Event Master Service Details</h2>
        <div class="row">
            <div class="col-md-4 form-group">
                <label>ID:</label>
                <div class="value-box">${EVENT_MASTER_SERVICE.id}</div>
            </div>
            <div class="col-md-4 form-group">
                <label>Service Name:</label>
                <div class="value-box">${EVENT_MASTER_SERVICE.name}</div>
            </div>
            <div class="col-md-4 form-group">
                <label>Service Cost Type:</label>
                <div class="value-box">${EVENT_MASTER_SERVICE.eventServiceCostTypeEntity.eventServiceCostTypeName}</div>
            </div>
            <div class="col-md-4 form-group">
                <label>Description:</label>
                <div class="value-box">${EVENT_MASTER_SERVICE.description}</div>
            </div>
            <div class="col-md-4 form-group">
                <label>Event Type:</label>
                <div class="value-box">${EVENT_MASTER_SERVICE.eventTypeName}</div>
            </div>
            <div class="col-md-4 form-group">
                <label>Base Cost:</label>
                <div class="value-box">${EVENT_MASTER_SERVICE.baseCost}</div>
            </div>
            <div class="col-md-4 form-group">
                <label>Active:</label>
                <div class="value-box">${EVENT_MASTER_SERVICE.active}</div>
            </div>
            <div class="col-md-12 text-center mt-3">
                <a href="view_master_service_list" class="btn btn-secondary">Back to List</a>
            </div>
        </div>
    </div>

<jsp:include page="../footer.jsp" />

