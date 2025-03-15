<jsp:include page="../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">

<script src="<c:url value="/resources/core/jquery.1.10.2.min.js" />"></script>
<script src="<c:url value="/resources/core/jquery.autocomplete.min.js" />"></script>
<style>
    body {
        background-image: url('<%= request.getContextPath() %>/resources/images/clientadd.jpg');
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


/* Modal Background */
.modal {
    display: none; /* Hidden by default */
    position: fixed;
    z-index: 1050;
    left: 0;
    top: 0;
    width: 100vw;
    height: 100vh;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
}

/* Modal Content */
.modal-content {
    position: relative;
    background-color: #fff;
    width: 60%;
    max-width: 800px;
    min-height: 300px;
    max-height: 80vh;
    overflow-y: auto;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
    padding: 20px;
    margin: auto; /* Ensures centering */
}

/* Header with Close Button on Right */
.modal-header {
    padding: 15px;
    font-size: 18px;
    font-weight: bold;
    background-color: #007bff;
    color: white;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
    position: relative;
}

/* Close Button - Properly Positioned */
.close {
    color: white;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
    transition: color 0.3s;
    margin-left: auto; /* Forces it to the right */
}

.close:hover {
    color: #000;
}

/* Modal Body */
.modal-body {
    padding: 20px;
    font-size: 16px;
    line-height: 1.5;
}

/* Modal Footer */
.modal-footer {
    padding: 10px;
    background-color: #f1f1f1;
    border-bottom-left-radius: 10px;
    border-bottom-right-radius: 10px;
    text-align: right;
}

#filter-sidebar {
    width: 1000px; /* Increase width as needed */
}

</style>


<div class="page-container" style="display: flex; height: 100vh; overflow: hidden;">
    <!-- Sidebar -->
    <div id="filter-sidebar" class="filter-sidebar" style="width: 0; transition: 0.3s; overflow-x: hidden; background: #f4f4f4; height: calc(100% - 140px); position: fixed; z-index: 1000; left: 0; top: 90px; box-shadow: 2px 0px 5px rgba(0, 0, 0, 0.3);">
        <div style="padding: 15px; display: flex; flex-direction: column; gap: 15px;">
            <button onclick="toggleSidebar()" style="align-self: flex-end;">&times;</button>
            <h2>Existing Session Mapping</h2>
                <!-- Your existing filters -->
                <!-- Example: -->
               <table style="width: 100%; border-collapse: collapse;">
                       <thead>
                           <tr>
                               <th style="padding: 8px; border: 1px solid #ccc;text-align: center;">Session Name</th>
                               <th style="padding: 8px; border: 1px solid #ccc;text-align: center;">Rate Type</th>
                               <th style="padding: 8px; border: 1px solid #ccc;text-align: center;">Start Date</th>
                               <th style="padding: 8px; border: 1px solid #ccc;text-align: center;">End Date</th>
                               <th style="padding: 8px; border: 1px solid #ccc;text-align: center;">Action</th>
                           </tr>
                       </thead>
                       <tbody>
                           <c:forEach items="${EXISTING_SESSION_RATE_MAPPING}" var="sessionRateMapRec">
                         <tr>
                                   <td style="padding: 8px; border: 1px solid #ccc;">${sessionRateMapRec.sessionName}</td>
                                   <td style="padding: 8px; border: 1px solid #ccc;">${sessionRateMapRec.rateTypeName}</td>
                                   <td style="padding: 8px; border: 1px solid #ccc;">${sessionRateMapRec.startDate}</td>
                                   <td style="padding: 8px; border: 1px solid #ccc;cursor: default !important; text-decoration: none !important; font-weight: normal !important;">
                                       <span>${sessionRateMapRec.endDate}</span>
                                   </td>
                                    <td>
                                        <form:form action="manage_sessionmap" method="post">
                                            <input type="hidden" name="sessionRateTypeId" value="${sessionRateMapRec.sessionRateTypeId}" />
                                            <button type="submit" class="btn btn-primary w-100" name="View" value="View">View</button>
                                            <button type="submit" class="btn btn-primary w-100" style="background-color:red;" name="Delete" value="Delete">Delete</button>
                                        </form:form>
                                    </td>
                               </tr>
                         </c:forEach>
                       </tbody>
                   </table>
                   <a href="view_session_rate_mapping_form?sessionId=${SESSION_ID}">
                   <center><button style="background-color: #007bff; color: white; border: none; padding: 10px 20px; font-size: 16px; cursor: pointer; border-radius: 5px;">
                                  Create Mapping
                   </button></center>
                   </a>

          </div>
     </div>

 <!-- Main Content -->
    <div class="main-content" style="margin-left: 0; flex: 1; padding: 15px; overflow-y: auto; transition: 0.3s;">
        <button onclick="toggleSidebar()" style="margin-bottom: 15px;">Existing Session Mapping</button>
    <div class="container mt-5">
     <div align="center" style="margin:10px 0">
         <b>
             <font color="green">${Success}</font>
             <font color="red">${Error}</font>
         </b>
     </div>
    <h2 class="text-center">View Session Rate Mapping</h2>

<div class="form-container sales-partner-list-container" style="width: 100%;max-width: 700px;margin: auto;">
   <form:form action="create_create_session_rate_mapping" method="post" modelAttribute="SESSION_RATE_MAP_OBJ">

          <div class="form-row" style="flex: 1; min-width: 100px;">
             <label for="rateTypeId" class="form-label">Session Name:</label>
             <font color="maroon"><b>${SESSION_RATE_MAP_OBJ.sessionName}</b></font>
          </div>
         <div class="form-row" style="flex: 1; min-width: 100px;">
            <label for="rateTypeId" class="form-label">Rate Type:</label>
            ${SESSION_RATE_MAP_OBJ.rateTypeName}
         </div>

        <!-- Start Date -->



     <!-- Start Date -->
     <div class="form-table">
            <div class="form-cell" >
                    <label for="startDate">Start Date:</label>
                     ${SESSION_RATE_MAP_OBJ.startDate}
                </div>
                <div class="form-cell" >
                    <label for="endDate" class="form-label">End Date:</label>
                     ${SESSION_RATE_MAP_OBJ.endDate}
                </div>

                    <!-- Submit Button -->
                    <a href="view_session_list">
                         <center><button type="button" style="background-color: #007bff; color: white; border: none; padding: 10px 20px; font-size: 16px; cursor: pointer; border-radius: 5px;">
                                        Session List
                         </button></center>
                    </a>

                 </div>
            </div>
     </div>

</form:form>
</div>
</div>
<script>
    function toggleSidebar() {
        var sidebar = document.getElementById("filter-sidebar");
        var mainContent = document.querySelector(".main-content");

        if (sidebar.style.width === "1000px") {  // Change width to 400px
            sidebar.style.width = "0";
            mainContent.style.marginLeft = "0";
        } else {
            sidebar.style.width = "1000px";
            mainContent.style.marginLeft = "1000px";
        }
    }
</script>

<jsp:include page="../footer.jsp" />
