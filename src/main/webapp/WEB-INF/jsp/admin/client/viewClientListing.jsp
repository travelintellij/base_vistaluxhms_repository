<jsp:include page="../../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">
<script src="<c:url value="/resources/core/jquery.1.10.2.min.js" />"></script>
<script src="<c:url value="/resources/core/jquery.autocomplete.min.js" />"></script>


<div class="form-container filter-container" style="width: 60%; min-width: 60%; max-width: 60%;">
    <h2>View Clients </h2>
    <form:form modelAttribute="CLIENT_OBJ" action="view_clients_list">
        <div class="form-row" style="display: flex; flex-wrap: wrap; gap: 10px; align-items: center;">
            <div class="form-group" style="flex: 1; min-width: 200px;">
                <label for="clientId">Client ID:</label>
                <form:input path="clientId" name="clientId" style="width:130px;" />
            </div>
            <div class="form-group" style="flex: 1; min-width: 200px;">
                <label for="clientName">Client Name:</label>
                <form:input path="clientName" name="clientName" style="width:180px;" />
            </div>
            <div class="form-group" style="flex: 1; min-width: 200px;">
                <label for="city">City:</label>
                <form:input path="cityName" name="cityName" style="width:200px;" />
            </div>
            <div class="form-group" style="flex: 1; min-width: 200px;">
                <label for="salespartner">Sales Partner:</label>
                <form:select path="salesPartner.salesPartnerId" items="${SALES_PARTNER_MAP}" />
            </div>
            <div class="form-group" style="flex: 1; min-width: 200px;">
                  <label for="active">Active:</label>
                  <form:select path="active" name="active">
                      <option value="">--Select--</option>
                      <option value="true" ${CLIENT_OBJ.active == 'true' ? 'selected' : ''}>Active</option>
                      <option value="false" ${CLIENT_OBJ.active == 'false' ? 'selected' : ''}>Inactive</option>
                  </form:select>
            </div>


        <div class="form-actions" style="flex: 1; min-width: 200px;">
            <button type="submit" class="apply-filter-btn">Apply Filter</button>
            <a href="view_clients_list"><input type="button" class="clear-filter-btn" value="Clear Filter"></input></a>
        </div>
        </div>
    </form:form>
</div>

<div align="center" style="margin:10px 0">
    <b>
        <font color="green">${Success}</font>
        <font color="red">${Error}</font>
    </b>
</div>

<!-- Client List Table Section -->
<div class="form-container client-list-container">
    <c:set value="${CLIENT_FILTERED_LIST}" var="clientList" />
    <table>
        <thead>
            <tr>
                <th>Client ID</th>
                <th>Client Name</th>
                <th>City</th>
                <th>Email</th>
                <th>Mobile</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${clientList}" var="clientRec">
                <tr>
                    <td>${clientRec.clientId}</td>
                    <td>${clientRec.clientName}</td>
                    <td>${clientRec.cityName}</td>
                    <td>
                        <c:if test="${clientRec.active eq true}">
                            <input type="button" style="background-color: #32cd32;border:none;outline:none;border-radius:5px;padding: 4px 5px;pointer-events: none;" value="Active" />
                        </c:if>
                        <c:if test="${clientRec.active eq false}">
                            <input type="button" style="background-color: red;border:none;outline:none;border-radius:5px;padding: 4px 5px;pointer-events: none;" value="Inactive" />
                        </c:if>
                    </td>
                    <td>${clientRec.emailId}</td>
                    <td>${clientRec.mobile}</td>
                    <td>
                        <form action="view_client_details" method="POST" style="display:inline;">
                                <input type="hidden" name="clientId" value="${clientRec.clientId}" />
                                <button type="submit" class="view-btn" style="height: 25px; padding: 5px 10px;background-color:gray;">View</button>
                        </form>
                        <form action="view_edit_client_form" method="POST" style="display:inline;">
                            <input type="hidden" name="clientId" value="${clientRec.clientId}" />
                            <button type="submit" class="edit-btn" style="height: 25px; padding: 5px 10px;">Edit</button>
                        </form>

                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
<script>
    $('#cityName').autocomplete({
        serviceUrl: '${pageContext.request.contextPath}/getCityList',
        paramName: "cityName",
        delimiter: ",",
        onSelect: function (suggestion) {
            cityID = suggestion.data;
            id = cityID;
            jQuery("#destinationId").val(cityID);
            $('input[name=cityId]').val(id);
            return false;
        },
        transformResult: function (response) {
            return {
                suggestions: $.map($.parseJSON(response), function (item) {
                    return { value: item.cityName, data: item.destinationId };
                })

            };
        }
    });


    </script>

<jsp:include page="../../footer.jsp" />
