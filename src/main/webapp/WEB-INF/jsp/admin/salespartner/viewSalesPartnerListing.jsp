<jsp:include page="../../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">

<div class="form-container filter-container">
    <h2>View Sales Partners</h2>
    <form:form modelAttribute="SEARCH_SALESPARTNER" action="view_search_salespartner_form">
        <div class="form-row">
            <div class="form-group">
                <label for="salesPartnerId">SalesPartner ID:</label>
                <form:input path="salesPartnerId" name="salesPartnerId" />
            </div>
            <div class="form-group">
                <label for="shortName">Short Name:</label>
                <form:input path="shortName" name="shortName" />
            </div>
            <div class="form-group">
                <label for="city">City:</label>
                <form:input path="cityName" name="cityName" />
            </div>
        </div>
        <div class="form-actions">
            <button type="submit" class="apply-filter-btn">Apply Filter</button>
            <a href="view_search_salespartner_form">
                <input type="button" class="clear-filter-btn" value="Clear Filter">
            </a>
        </div>
    </form:form>
</div>

<div align="center" style="margin:10px 0"><b>
    <font color="green">${Success}</font>
    <font color="red">${Error}</font>
</b></div>

<div class="form-container salespartner-list-container">
    <c:set value="${SALESPARTNER_LIST}" var="salesPartnerList" />
    <table>
        <thead>
        <tr>
            <th>SalesPartner ID</th>
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
                <td>${salesPartnerRec.shortName}</td>
                <td>${salesPartnerRec.fullName}</td>
                <td>${salesPartnerRec.cityName}</td>
                <td>
                    <c:if test="${salesPartnerRec.active eq true}">
                        <input type="button" style="background-color: #32cd32; border:none; outline:none; border-radius:5px; padding: 4px 5px; pointer-events: none;" value="Active" />
                    </c:if>
                    <c:if test="${salesPartnerRec.active eq false}">
                        <input type="button" style="background-color: red; border:none; outline:none; border-radius:5px; padding: 4px 5px; pointer-events: none;" value="In-Active" />
                    </c:if>
                </td>
                <td>
                    <form action="view_edit_salespartner_form" method="POST" style="display:inline;">
                        <input type="hidden" name="salesPartnerId" value="${salesPartnerRec.salesPartnerId}" />
                        <button type="submit" class="edit-btn" style="height: 25px; padding: 5px 10px;">Edit</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<jsp:include page="../../footer.jsp" />
