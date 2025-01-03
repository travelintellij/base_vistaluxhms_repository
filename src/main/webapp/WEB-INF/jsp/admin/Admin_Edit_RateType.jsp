<jsp:include page="../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">
<div class="form-container-wrapper">
    <div class="form-container">
        <h2>Edit Rate Type</h2> <!-- Bold Header -->
        <form:form method="post" action="create_edit_rate_type" modelAttribute="RATE_TYPE_OBJ">
            <form:hidden path="rateTypeId" />
            <!-- First Row -->
            <div class="form-row">
                <label for="rateType-name">Rate Type Id:</label> <label for="auto-generated"><font color="blue">${RATE_TYPE_OBJ.rateTypeId}</font></label>
            </div>
            <div class="form-row">
                <label for="rateType-name">Rate Type Name:</label>
                <form:input path="rateTypeName" name="rateTypeName"  placeholder="Enter Rate Type name" required="required"/>
            <font color="red">
                <form:errors path="rateTypeName" cssClass="error" />
            </font>
            </div>
            <div class="form-row">
                <label for="Description">Description:</label>
                <form:textarea path="description" maxlength="500" name="" id="" cols="68" rows="5" />
                <font color="red">
                    <form:errors path="description" cssClass="error" />
                </font>
            </div>
            <div class="form-row">
            <label for="active">Active:</label>
                <form:select path="active" required="required" style="width:100%">
                    <option class="service-small" value="true"<c:if test="${RATE_TYPE_OBJ.active eq true}">selected</c:if>>Active</option>
                    <option class="service-small" value="false"<c:if test="${RATE_TYPE_OBJ.active eq false}">selected</c:if>>In-Active</option>
                </form:select>
            </div>

            <!-- Second Row -->
            <div class="button-container">
               <input type="submit" value="Edit Rate Type" class="clear-filter-btn">
               <a href="view_rate_type_list"><input type="button" class="clear-filter-btn" value="View Rate Types List"></input></a>
            </div>
        </form:form>
    </div>
</div>

<jsp:include page="../footer.jsp" />