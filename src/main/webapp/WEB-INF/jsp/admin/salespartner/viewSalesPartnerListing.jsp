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
<style>
    body {
        background-image: url('<%= request.getContextPath() %>/resources/images/salespartnerlist.jpg');
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

<div class="form-container filter-container" style="width: 60%; min-width: 60%; max-width: 60%;">
    <h2>View Sales Partners</h2>
    <form:form modelAttribute="SALES_PARTNER_OBJ" action="view_sales_partner_list">
    <form:hidden path="cityId" />
        <div class="form-row" style="display: flex; flex-wrap: wrap; gap: 10px; align-items: center;">
            <div class="form-group" style="flex: 1; min-width: 200px;">
                <label for="salesPartnerId">Sales Partner ID:</label>
                <form:input path="salesPartnerId" name="salesPartnerId" style="width:130px;" />
            </div>
            <div class="form-group" style="flex: 1; min-width: 200px;">
                <label for="salesPartnerShortName">Short Name:</label>
                <form:input path="salesPartnerShortName" name="salesPartnerShortName" style="width:180px;" />
            </div>
            <div class="form-group" style="flex: 1; min-width: 200px;">
                <label for="salesPartnerName">Full Name:</label>
                <form:input path="salesPartnerName" name="salesPartnerName" style="width:250px;" />
            </div>
            <div class="form-group" style="flex: 1; min-width: 200px;">
                <label for="city">City:</label>
                <form:input path="cityName" name="cityName" style="width:200px;" />
            </div>
            <div class="form-group" style="flex: 1; min-width: 200px;">
                          <label for="active">Active:</label>
                          <form:select path="active" name="active">
                              <option value="">--Select--</option>
                              <option value="true" ${SALES_PARTNER_OBJ.active == 'true' ? 'selected' : ''}>Active</option>
                              <option value="false" ${SALES_PARTNER_OBJ.active == 'false' ? 'selected' : ''}>Inactive</option>
                          </form:select>
            </div>

        <div class="form-actions" style="flex: 1; min-width: 200px;">
            <button type="submit" class="apply-filter-btn">Apply Filter</button>
            <a href="view_sales_partner_list"><input type="button" class="clear-filter-btn" value="Clear Filter"></input></a>
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

<!-- Sales Partner List Table Section -->
<div class="form-container sales-partner-list-container">
    <c:set value="${SALES_PARTNER_FILTERED_LIST}" var="salesPartnerList" />
    <table>
        <thead>
            <tr>
                <th>Sales Partner ID</th>
                <th>Short Name</th>
                <th>Full Name</th>
                <th>City</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${salesPartnerList}" var="salesPartnerRec">
                <tr>
                    <td>${salesPartnerRec.salesPartnerId}</td>
                    <td>${salesPartnerRec.salesPartnerShortName}</td>
                    <td>${salesPartnerRec.salesPartnerName}</td>
                    <td>${salesPartnerRec.cityName}</td>
                    <td>
                        <c:if test="${salesPartnerRec.active eq true}">
                            <input type="button" style="background-color: #32cd32;border:none;outline:none;border-radius:5px;padding: 4px 5px;pointer-events: none;" value="Active" />
                        </c:if>
                        <c:if test="${salesPartnerRec.active eq false}">
                            <input type="button" style="background-color: red;border:none;outline:none;border-radius:5px;padding: 4px 5px;pointer-events: none;" value="Inactive" />
                        </c:if>
                    </td>
                    <td>
                        <form action="view_sales_partner_details" method="POST" style="display:inline;">
                                <input type="hidden" name="salesPartnerId" value="${salesPartnerRec.salesPartnerId}" />
                                <button type="submit" class="view-btn" style="height: 25px; padding: 5px 10px;background-color:gray;">View</button>
                        </form>
                        <form action="view_edit_sales_partner_form" method="POST" style="display:inline;">
                            <input type="hidden" name="salesPartnerId" value="${salesPartnerRec.salesPartnerId}" />
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
