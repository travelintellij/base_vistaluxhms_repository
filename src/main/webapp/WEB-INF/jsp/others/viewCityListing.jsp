<jsp:include page="../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">
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
                        <a href="view_edit_city_form?destinationId=${cityRec.destinationId }"><button class="edit-btn">Edit</button></a>
                      </td>
                  </tr>
                  </c:forEach>
                  <!-- Repeat <tr> block for each city in the list -->
              </tbody>
          </table>
      </div>
<jsp:include page="../footer.jsp" />
