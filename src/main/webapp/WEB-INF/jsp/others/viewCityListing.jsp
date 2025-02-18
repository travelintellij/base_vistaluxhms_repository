<jsp:include page="../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">
     <style>
        body {
            background-image: url('<%= request.getContextPath() %>/resources/images/citylist.jpg');
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

    <div class="form-container filter-container">
          <h2>View Cities</h2>
          <form:form modelAttribute="SEARCH_CITY" action="view_search_city_form">
              <div class="form-row">
                  <div class="form-group">
                      <label for="cityId">City ID:</label>
                      <form:input path="destinationId" name="destinationId" />
                  </div>
                  <div class="form-group">
                      <label for="cityName">City Name:</label>
                      <form:input path="cityName" name="cityName" />
                  </div>
                  <div class="form-group">
                      <label for="country">Country:</label>
                            <form:select path="countryCode" required="required">
                                <c:forEach items="${ACTIVE_CTRYCODE_CTRYNAME_LIST}" var="destinationObj">
                                    <c:if test="${destinationObj.countryCode eq SEARCH_CITY.countryCode}">
                                        <option class="service-small" value="${destinationObj.countryCode}" selected>
                                            ${destinationObj.countryName}
                                        </option>
                                    </c:if>
                                    <c:if test="${destinationObj.countryCode ne SEARCH_CITY.countryCode}">
                                        <option class="service-small" value="${destinationObj.countryCode}">
                                            ${destinationObj.countryName}</option>
                                    </c:if>
                                </c:forEach>
                            </form:select>                  </div>
              </div>
              <div class="form-actions">
                  <button type="submit" class="apply-filter-btn">Apply Filter</button>

                   <a href="view_search_city_form"><input type="button" class="clear-filter-btn" value="Clear Filter"></input></a>
              </div>
          </form:form>
      </div>
<div align="center" style="margin:10px 0"><b>
    <font color="green">${Success} </font>
    <font color="red">${Error}</font>
</b></div>
      <!-- City List Table Section (Second Container) -->
      <div class="form-container city-list-container">
      <c:set value="${CITY_LIST}" var="cityList" />
          <table>
              <thead>
                  <tr>
                      <th>City ID</th>
                      <th>City Name</th>
                      <th>Country Name</th>
                      <th>Status</th>
                      <th>Action</th>
                  </tr>
              </thead>
              <tbody>
                  <!-- Replace this with actual data iteration logic -->
                  <c:forEach items="${cityList}" var="cityRec">
                  <tr>
                      <td>${cityRec.destinationId}</td>
                      <td>${cityRec.cityName }</td>
                      <td>${cityRec.countryName }</td>
                      <td>
                      <c:if test="${cityRec.active eq true}">
                            <input type="button" style="background-color: #32cd32;border:none;outline:none;border-radius:5px;;padding: 4px 5px;pointer-events: none;"  value="Active" />
                        </c:if>
                        <c:if test="${cityRec.active eq false}">
                                <input type="button" style="background-color: red;border:none;outline:none;border-radius:5px;;padding: 4px 5px;pointer-events: none;"  value="In-Active" />
                        </c:if>
                       </td>
                      <td>
                          <form action="view_edit_city_form" method="POST" style="display:inline;">
                              <!-- Hidden field to store destinationId -->
                              <input type="hidden" name="destinationId" value="${cityRec.destinationId}" />
                              <button type="submit" class="edit-btn"  style="height: 25px;  padding: 5px 10px; ">Edit</button>
                          </form>

                      </td>
                  </tr>
                  </c:forEach>
                  <!-- Repeat <tr> block for each city in the list -->
              </tbody>
          </table>
      </div>
     <div class="pagination-container">
      <c:if test="${not empty CITY_LIST}">
              <c:set var="totalRecords" value="${CITY_LIST.size()}" />
              <c:set var="recordsPerPage" value="${pageSize}" /> <!-- You can adjust this value -->

              <!-- Display pagination links -->
              <c:if test="${currentPage > 0}">
                  <a class="pagination-btn" href="view_search_city_form?page=${currentPage-1}&countryCode=${SEARCH_CITY.countryCode}&cityName=${SEARCH_CITY.cityName}">Previous</a>
              </c:if>

              <c:forEach begin="0" end="${totalPages-1}" var="page">
                  <c:choose>
                      <c:when test="${page == currentPage}">
                          <span class="pagination-btn active">${page+1}</span> <!-- Current page is highlighted -->
                      </c:when>
                      <c:otherwise>
                          <a class="pagination-btn" href="view_search_city_form?page=${page}&countryCode=${SEARCH_CITY.countryCode}&cityName=${SEARCH_CITY.cityName}">${page+1} </a>
                      </c:otherwise>
                  </c:choose>
              </c:forEach>

              <c:if test="${currentPage+1 < totalPages}">
                     <a class="pagination-btn" href="view_search_city_form?page=${currentPage+1}&countryCode=${SEARCH_CITY.countryCode}&cityName=${SEARCH_CITY.cityName}">Next</a>
              </c:if>
          </c:if>
      </div>
<jsp:include page="../footer.jsp" />
