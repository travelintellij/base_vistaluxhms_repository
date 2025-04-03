<jsp:include page="../../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
    body {
        background-image: url('<%= request.getContextPath() %>/resources/images/ratetypelist.jpg');
        background-size: cover;
        background-position: center;
        background-attachment: fixed;
        height: 100vh;
        position: relative;
    }

    body::after {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: rgba(255, 255, 255, 0.3);
        z-index: -1;
    }

    body {
        opacity: .98;
    }

    .container {
        max-width: 60%;
        margin: 40px auto;
        padding: 20px;
        background: #fff;
        border-radius: 10px;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    }

    table {
        width: 100%;
    }

    th, td {
        text-align: center;
        vertical-align: middle;
    }

    .action-btns a {
        margin: 3px;
    }

    /* Stylish checkbox */
    .checkbox-wrapper {
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .form-check-input {
        width: 20px;
        height: 20px;
        cursor: pointer;
    }

    .submit-btn {
        margin-top: 10px;
        display: flex;
        justify-content: center;
    }
</style>

<div align="center" style="margin:10px 0"><b>
    <font color="green">${Success} </font>
    <font color="red">${Error}</font>
</b></div>

<!-- City List Table Section -->
<div class="container">
    <form:form modelAttribute="SALES_PARTNER_OBJ" action="review_sales_partner_rate_share_form">
    <form:hidden path="salesPartnerId" />
    <h3 style="text-align: center; font-family: Arial, sans-serif; font-size: 24px; font-weight: bold;">
        Available Session List for
        <span style="color: #007bff; font-size: 26px; font-weight: bold; text-transform: uppercase;">
            ${SALES_PARTNER_OBJ.salesPartnerName}
        </span>
    </h3>

    <c:set value="${RATE_SESSION_MAPPING_LIST}" var="rateTypeSessionMapping" />
        <table class="table table-bordered table-striped">
            <thead class="table-dark">
                <tr>
                    <th>Select</th>
                    <th>Rate Type ID</th>
                    <th style="width:25%;">Rate Type Name</th>
                    <th style="width:35%">Session Name</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${rateTypeSessionMapping}" var="rateTypeSessionMappingRec">
                    <tr>
                        <td class="checkbox-wrapper">
                            <input class="form-check-input" type="checkbox" name="selectedSessions" value="${rateTypeSessionMappingRec.sessionRateTypeId}">
                        </td>
                        <td>${rateTypeSessionMappingRec.rateTypeEntity.rateTypeId}</td>
                        <td>${rateTypeSessionMappingRec.rateTypeEntity.rateTypeName }</td>
                        <td>
                            <a href="view_edit_session_detail_form?sessionId=${rateTypeSessionMappingRec.sessionEntity.sessionId}">
                                ${rateTypeSessionMappingRec.sessionEntity.sessionName}
                            </a>
                        </td>
                        <td>${rateTypeSessionMappingRec.formattedStartDate}</td>
                        <td>${rateTypeSessionMappingRec.formattedEndDate}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Submit button to process selected sessions -->
        <div class="submit-btn">
            <button type="submit" class="btn btn-primary">Process Selected Sessions</button>
        </div>
    </form:form>
</div>

<jsp:include page="../../footer.jsp" />
