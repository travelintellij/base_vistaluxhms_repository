<jsp:include page="../../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">

<script src="<c:url value="/resources/core/jquery.1.10.2.min.js" />"></script>
<script src="<c:url value="/resources/core/jquery.autocomplete.min.js" />"></script>

<div class="form-container-wrapper">
    <div class="form-container">
        <h2>Edit Sales Partner</h2> <!-- Bold Header -->
        <form:form method="post" action="edit_edit_sales_partner" modelAttribute="SALES_PARTNER_OBJ">
        <form:hidden path="salesPartnerId" />
            <!-- First Row -->
            <div class="form-row">
                <label for="salesPartner-id">Sales Partner Id:</label>
                <label for="auto-generated"><font color="blue">${SALES_PARTNER_OBJ.salesPartnerId}</font></label>
            </div>
            <div class="form-row">
                <label for="salesPartner-short-name">Short Name:</label>
                <form:input path="salesPartnerShortName" name="salesPartnerShortName" placeholder="Enter Short Name" required="required"/>
                <font color="red">
                    <form:errors path="salesPartnerShortName" cssClass="error" />
                </font>
            </div>
            <div class="form-row">
                <label for="salesPartner-name">Full Name:</label>
                <form:input path="salesPartnerName" name="salesPartnerName" placeholder="Enter Full Name" required="required"/>
                <font color="red">
                    <form:errors path="salesPartnerName" cssClass="error" />
                </font>
            </div>
            <div class="form-row">
                <label for="city-id">Email Id:</label>
                <form:input path="emailId" id="emailId" type="email" placeholder="Enter your email" required="required" />
                <form:errors path="emailId" cssClass="error" />
            </div>
            <div class="form-row">
                <label for="city-id">Mobile:</label>
                 <form:input path="mobile" id="mobile" type="tel" placeholder="Enter your mobile number" required="required" pattern="[0-9]{10}" />
                <form:errors path="mobile" cssClass="error" />
            </div>
            <div class="form-row">
                    <label for="city-id">City:</label>
                <form:input path="cityName" name="cityName" placeholder="Type city name" autocomplete="off" />
                <form:hidden path="cityId" />

            </div>
            <div class="form-row">
                <label for="active-status">Active:</label>
                <form:select path="active" required="required" style="width:100%">
                    <option class="service-small" value="true"<c:if test="${SALES_PARTNER_OBJ.active eq true}">selected</c:if>>Active</option>
                    <option class="service-small" value="false"<c:if test="${SALES_PARTNER_OBJ.active eq false}">selected</c:if>>In-Active</option>
                </form:select>
            </div>
            <div class="form-row">
                <label for="address">Address:</label>
                <form:textarea path="address" maxlength="255" placeholder="Enter Address" cols="68" rows="3"/>
                <font color="red">
                    <form:errors path="address" cssClass="error" />
                </font>
            </div>
            <div class="form-row">
                <label for="reference">Reference:</label>
                <form:input path="reference" name="reference" placeholder="Enter Reference"/>
                <font color="red">
                    <form:errors path="reference" cssClass="error" />
                </font>
            </div>
            <div class="form-row">
                <label for="description">Description:</label>
                <form:textarea path="description" maxlength="255" placeholder="Enter Description" cols="68" rows="5"/>
                <font color="red">
                    <form:errors path="description" cssClass="error" />
                </font>
            </div>

            <!-- Second Row -->
            <div class="button-container">
                <input type="submit" value="Update Sales Partner">
                <a href="view_sales_partner_list"><input type="button" class="clear-filter-btn" value="View Sales Partners List"></input></a>
            </div>
        </form:form>
    </div>
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
