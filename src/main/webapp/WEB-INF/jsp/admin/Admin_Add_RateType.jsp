<jsp:include page="../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">
<style>
    body {
        background-image: url('<%= request.getContextPath() %>/resources/images/ratetypeadd.jpg');
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

</style>
<div class="form-container-wrapper" style="background: transparent !important;">
    <div class="form-container">
        <h2>Add Rate Type</h2> <!-- Bold Header -->
        <form:form method="post" action="create_edit_rate_type" modelAttribute="RATE_TYPE_OBJ">
            <!-- First Row -->
            <div class="form-row">
                <label for="rateType-name">Rate Type Id:</label> <label for="auto-generated"><font color="blue">Auto Generated</font></label>
            </div>
            <div class="form-row">
                <label for="rateType-name">Rate Type Name:</label>
                <form:input path="rateTypeName" name="rateTypeName"  placeholder="Enter Rate Type name" required="required"/>
            <font color="red">
                <form:errors path="rateTypeName" cssClass="error" />
            </font>
            </div>
            <div class="form-row">
                <label for="Description">Description:</label>
                <form:textarea path="description" maxlength="500" name="" id="" cols="68" rows="5" />
                <font color="red">
                    <form:errors path="description" cssClass="error" />
                </font>
            </div>

            <!-- Second Row -->
            <div class="button-container">
                <input type="submit" value="Add Rate Type">
               <a href="view_rate_type_list"><input type="button" class="clear-filter-btn" value="View Rate Types List"></input></a>
            </div>
        </form:form>
    </div>
</div>

<jsp:include page="../footer.jsp" />