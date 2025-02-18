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
            background-image: url('<%= request.getContextPath() %>/resources/images/cityedit.jpg');
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
        </style>

<div class="form-container-wrapper"  style="background: transparent !important;">
    <div class="form-container" style="width: 100%; max-width: 900px;">
        <h2>Edit City</h2> <!-- Bold Header -->
        <form:form method="post" action="edit_edit_city" modelAttribute="CITY_OBJ">
            <form:hidden path="destinationId" />
            <form:hidden path="countryName" />
            <!-- First Row -->
            <div class="form-row">
                <label for="city-name">City Name:</label>
                <form:input path="cityName" name="cityName"  placeholder="Enter city name" required="required" />

&nbsp;&nbsp;<font color="red">
                <form:errors path="cityName" cssClass="error" />
            </font>
                <label for="country">Country:</label>
                <form:select path="countryCode" required="required" id="countryCode" onchange="updateCountryName()">
                    <c:forEach items="${ACTIVE_CTRYCODE_CTRYNAME_LIST}" var="destinationObj">
                        <c:if test="${destinationObj.countryCode eq CITY_OBJ.countryCode }">
                            <option class="service-small" value="${destinationObj.countryCode}" data-name="${destinationObj.countryName}" selected>${destinationObj.countryName}
                            </option>
                        </c:if>
                        <c:if test="${destinationObj.countryCode ne CITY_OBJ.countryCode }">
                            <option class="service-small" value="${destinationObj.countryCode}" data-name="${destinationObj.countryName}">
                                ${destinationObj.countryName}</option>
                        </c:if>
                    </c:forEach>
                </form:select>
                <font color="red">
                    <form:errors path="countryCode" cssClass="error" />
                </font>
               &nbsp;&nbsp; <label for="active">Active:</label>
                <form:select path="active" required="required" style="width:100%">
                    <option class="service-small" value="true"<c:if test="${CITY_OBJ.active eq true}">selected</c:if>>Active</option>
                    <option class="service-small" value="false"<c:if test="${CITY_OBJ.active eq false}">selected</c:if>>In-Active</option>
                </form:select>
            </div>

            <!-- Second Row -->
            <div class="button-container">
                <input type="submit" value="Update City">
               <a href="view_search_city_form"><input type="button" class="clear-filter-btn" value="View City List"></input></a>
            </div>
        </form:form>
    </div>
</div>
<script>
    function updateCountryName() {
    // Get the selected option
    var selectedOption = document.getElementById("countryCode").selectedOptions[0];

    // Get the country name from the data-name attribute of the selected option
    var countryName = selectedOption ? selectedOption.getAttribute("data-name") : "";

    // Set the country name in the input field
    document.getElementById("countryName").value = countryName;
}
</script>
<jsp:include page="../footer.jsp" />