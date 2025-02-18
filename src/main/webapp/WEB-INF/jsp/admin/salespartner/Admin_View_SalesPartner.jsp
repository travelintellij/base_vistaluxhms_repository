<jsp:include page="../../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">

<style>
    body {
        background-image: url('<%= request.getContextPath() %>/resources/images/salespartnerview.jpg');
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



/* Container for each form-row to reduce spacing */
.form-row {
    display: flex;
    margin-bottom: 15px; /* Reduced bottom margin for better spacing */
    align-items: center; /* Align items centrally */
}

/* Label styles */
.form-row label {
    width: 20%; /* Fixed width for labels */
    margin-right: 10px; /* Small gap between label and value */
    font-weight: bold;
    text-align: left; /* Align the label text to the right */
    padding-right: 10px; /* Optional padding for aesthetics */
}

/* Display the data value compactly */
.form-value {
    width: 75%; /* Make the value take up 75% of the space */
    background-color: #f4f4f4;
    border-radius: 5px;
    padding: 5px;
    font-weight: normal;
    word-wrap: break-word; /* Wrap long text to avoid overflow */
}

</style>
<div class="form-container-wrapper" style="background: transparent !important;">
    <div class="form-container">
        <h2>View Sales Partner</h2>
    <form:form method="post" action="view_edit_sales_partner_form" modelAttribute="SALES_PARTNER_OBJ">
        <form:hidden path="salesPartnerId" />
        <div class="form-row">
            <label for="salesPartner-id">Sales Partner Id:</label>
            <div class="form-value">
                <font color="blue">${SALES_PARTNER_OBJ.salesPartnerId}</font>
            </div>
        </div>

        <div class="form-row">
            <label for="salesPartner-short-name">Short Name:</label>
            <div class="form-value">
                ${SALES_PARTNER_OBJ.salesPartnerShortName}
            </div>
        </div>

        <div class="form-row">
            <label for="salesPartner-name">Full Name:</label>
            <div class="form-value">
                ${SALES_PARTNER_OBJ.salesPartnerName}
            </div>
        </div>
        <div class="form-row">
            <label for="salesPartner-name">Email Id:</label>
            <div class="form-value">
                ${SALES_PARTNER_OBJ.emailId}
            </div>
        </div>

        <div class="form-row">
            <label for="salesPartner-name">Mobile:</label>
            <div class="form-value">
                ${SALES_PARTNER_OBJ.mobile}
            </div>
        </div>


        <div class="form-row">
            <label for="city-id">City:</label>
            <div class="form-value">
                ${SALES_PARTNER_OBJ.cityName}
            </div>
        </div>

        <div class="form-row">
            <label for="active-status">Active:</label>
            <div class="form-value">
                <c:choose>
                    <c:when test="${SALES_PARTNER_OBJ.active eq true}">Active</c:when>
                    <c:otherwise>In-Active</c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="form-row">
            <label for="address">Address:</label>
            <div class="form-value">
                ${SALES_PARTNER_OBJ.address}
            </div>
        </div>

        <div class="form-row">
            <label for="reference">Reference:</label>
            <div class="form-value">
                ${SALES_PARTNER_OBJ.reference}
            </div>
        </div>

        <div class="form-row">
            <label for="description">Description:</label>
            <div class="form-value">
                ${SALES_PARTNER_OBJ.description}
            </div>
        </div>

        <div class="button-container">
            <input type="submit" value="Edit Sales Partner">
            <a href="view_sales_partner_list">
                <input type="button" class="clear-filter-btn" value="Back to Sales Partners List" />
            </a>
        </div>
    </div>
    </form:form>
</div>

<jsp:include page="../../footer.jsp" />
