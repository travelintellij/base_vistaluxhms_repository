<jsp:include page="../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<div align="center" style="margin:10px 0"><b>
    <font color="green">${Success} </font>
    <font color="red">${Error}</font>
</b></div>
      <!-- City List Table Section (Second Container) -->
      <div class="form-container city-list-container">
      <h2>Rate Type List</h2> <!-- Bold Header -->
      <c:set value="${RATE_TYPE_LIST}" var="rateTypeList" />
          <table>
              <thead>
                  <tr>
                      <th>Rate Type ID</th>
                      <th style="width:25%;">Rate Type Name</th>
                      <th style="width:35%;">Description</th>
                      <th>Status</th>
                      <th>Action</th>
                  </tr>
              </thead>
              <tbody>
                  <!-- Replace this with actual data iteration logic -->
                  <c:forEach items="${rateTypeList}" var="rateTypeRec">
                  <tr>
                      <td>${rateTypeRec.rateTypeId}</td>
                      <td>${rateTypeRec.rateTypeName }</td>
                      <td>${rateTypeRec.description }</td>
                      <td>
                      <c:if test="${rateTypeRec.active eq true}">
                            <input type="button" style="background-color: #32cd32;border:none;outline:none;border-radius:5px;;padding: 4px 5px;pointer-events: none;"  value="Active" />
                        </c:if>
                        <c:if test="${rateTypeRec.active eq false}">
                                <input type="button" style="background-color: red;border:none;outline:none;border-radius:5px;;padding: 4px 5px;pointer-events: none;"  value="In-Active" />
                        </c:if>
                       </td>
                      <td>
                          <form action="view_edit_rate_type_form" method="POST" style="display:inline;">
                              <!-- Hidden field to store destinationId -->
                              <input type="hidden" name="rateTypeId" value="${rateTypeRec.rateTypeId}" />
                              <button type="submit" class="edit-btn"  style="height: 25px;  padding: 5px 10px; ">Edit</button>
                          </form>

                      </td>
                  </tr>
                  </c:forEach>
                  <!-- Repeat <tr> block for each city in the list -->
              </tbody>
          </table>
      </div>
<jsp:include page="../footer.jsp" />
