<jsp:include page="../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">
<div class="form-container-wrapper">
    <div class="form-container">
        <h2>Add City</h2> <!-- Bold Header -->
        <form:form method="post" action="create_create_city" modelAttribute="CITY_OBJ">
            <!-- First Row -->
            <div class="form-row">
                <label for="city-name">City Name:</label>
                <input type="text" id="city-name" name="city-name" placeholder="Enter city name" required>
&nbsp;&nbsp;
                <label for="country">Country:</label>
                <form:select path="countryCode" required="required" id="countryCode">
                    <c:forEach items="${ACTIVE_CTRYCODE_CTRYNAME_LIST}" var="destinationObj">
                        <c:if test="${destinationObj.countryCode eq CITY_OBJ.countryCode }">
                            <option class="service-small" value="${destinationObj.countryCode}"
                                selected>${destinationObj.countryName}
                            </option>
                        </c:if>
                        <c:if test="${destinationObj.countryCode ne CITY_OBJ.countryCode }">
                            <option class="service-small" value="${destinationObj.countryCode}">
                                ${destinationObj.countryName}</option>
                        </c:if>
                    </c:forEach>
                </form:select>
                <font color="red">
                    <form:errors path="countryCode" cssClass="error" />
                </font>
            </div>

            <!-- Second Row -->
            <div class="button-container">
                <button type="submit">Add City</button>
               <a href="view_search_city_form"><input type="button" class="clear-filter-btn" value="View City List"></input></a>
            </div>
        </form:form>
    </div>
</div>
<jsp:include page="../footer.jsp" />