<jsp:include page="../../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">
<div class="form-container-wrapper">
    <div class="form-container">
        <h2>Add Sales Partner</h2> <!-- Bold Header -->
        <form:form method="post" action="create_edit_sales_partner" modelAttribute="SALES_PARTNER_OBJ">
            <!-- First Row -->
            <div class="form-row">
                <label for="salesPartner-id">Sales Partner Id:</label>
                <label for="auto-generated"><font color="blue">Auto Generated</font></label>
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
                <label for="city-id">City:</label>
                <%--
                <form:select path="destinationId">
                    <form:option value="" label="-- Select City --" />
                    <form:options items="${cityList}" itemValue="destinationId" itemLabel="cityName"/>
                </form:select>
                --%>
                <font color="red">
                    <%--<form:errors path="cityId" cssClass="error" />--%>
                </font>
            </div>
            <div class="form-row">
                <label for="active-status">Active:</label>
                <form:checkbox path="active" name="active"/>
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
                <input type="submit" value="Add Sales Partner">
                <a href="view_sales_partner_list"><input type="button" class="clear-filter-btn" value="View Sales Partners List"></input></a>
            </div>
        </form:form>
    </div>
</div>

<jsp:include page="../../footer.jsp" />
