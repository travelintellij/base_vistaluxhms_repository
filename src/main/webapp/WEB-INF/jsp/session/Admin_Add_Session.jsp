<jsp:include page="../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Season Rates Management</title>

    <!-- Bootstrap CSS for a clean and modern look -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <style>
    body {
        background-image: url('<%= request.getContextPath() %>/resources/images/sessionadd.jpg');
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

    textarea {
        width: 70%;
        height: 50px;
        padding: 12px 20px;
        box-sizing: border-box;
        border: 2px solid #ccc;
        border-radius: 4px;
        background-color: #f8f8f8;
        font-size: 16px;
        resize: none;
      }

    /* Optional: If you want to adjust the opacity of the image to make it more subtle */
    body {
        opacity: .98; /* Adjust the opacity for the background image */
    }

    body {
        background-color: #f8f9fa;
    }
    .container {
        margin-top: 30px;
        max-width: 90%;
    }
    .table {
        background-color: white;
    }
    .meal-header {
        background-color: #007bff;
        color: white;
    }
    .input-box {
        width: 120px;
        text-align: center;
    }
th:first-child, td:first-child {
    background-color: #28a745; /* Green */
    color: white;
    text-align: center;
    font-weight: bold;
}

th:not(:first-child), td:not(:first-child) {
    background-color: #f8f9fa; /* Light Gray */
    text-align: center;
    padding: 8px;
}


    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center mb-4">Seasonal Room Rates</h2>

    <!-- Form to Submit Rates -->


        <!-- Date Range Selection -->
       <form:form action="create_create_session_master" modelAttribute="SESSION_MASTER_OBJ" method="post">
   <div class="container d-flex justify-content-center">
       <div class="w-50"> <!-- Adjust width as needed -->
           <div class="row mb-4 align-items-center">
               <div class="col-sm-4">
                   <label class="col-form-label"><b>Session Name:</b></label>
               </div>
               <div class="col-sm-8">
                   <form:input path="sessionName" placeholder="Session Name" class="form-control" required="required" />
               </div>
           </div>

           <div class="row mb-4 align-items-center">
               <div class="col-sm-4">
                   <label class="col-form-label"><b>Remarks:</b></label>
               </div>
               <div class="col-sm-8">
                   <textarea name="remarks" class="form-control large-textarea"></textarea>
               </div>
           </div>

           <div class="row">
               <div class="col-12 text-center mt-3">
                   <button type="submit" class="btn btn-primary px-4">Save Session Master</button>
               </div>
           </div>
       </div>
   </div>


       </form:form>


<!-- Bootstrap JS for responsiveness -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<jsp:include page="../footer.jsp" />