<jsp:include page="../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">

<script src="<c:url value="/resources/core/jquery.1.10.2.min.js" />"></script>
<script src="<c:url value="/resources/core/jquery.autocomplete.min.js" />"></script>
<style>
    body {
        background-image: url('<%= request.getContextPath() %>/resources/images/expenses-claim.jpg');
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
.date-input {
    height: 40px; /* taller than default (~20px) */
    padding: 5px 10px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 4px;
    outline: none;
    width: 220px;
    box-sizing: border-box;
    transition: border-color 0.3s;
  }

  .date-input:focus {
    border-color: #3399ff;
    box-shadow: 0 0 3px rgba(51, 153, 255, 0.5);
  }
</style>
<div class="form-container-wrapper" style="background: transparent !important;">
    <div class="form-container">
        <h2>Add My Claim</h2> <!-- Bold Header -->
        <form:form method="post" action="create_create_my_claim" modelAttribute="MY_CLAIMS_OBJ">
            <!-- First Row -->
            <div class="form-row">
                <label for="salesPartner-id">My Claim Id:</label>
                <label for="auto-generated"><font color="blue">Auto Generated</font></label>
            </div>
            <div class="form-row">
                <label for="salesPartner-short-name">Claim Type:</label>
                <form:select path="claimtype" required="required" style="width:20%">
                    <form:options items="${CLAIM_TYPE_MAP}" />
                </form:select>
            </div>
            <div class="form-row">
                <label for="salesPartner-short-name">Claim Detail:</label>
                <form:input path="claimdetails" name="claimdetails" placeholder="Enter Details" required="required"/>
                <font color="red">
                    <form:errors path="claimdetails" cssClass="error" />
                </font>
            </div>
            <div class="form-row">
                <label for="salesPartner-name">Claim Amount:</label>
                <form:input path="claimamount" name="claimamount" type="number" required="required"/>
                <font color="red">
                    <form:errors path="claimamount" cssClass="error" />
                </font>
            </div>
            <div class="form-row">
                <label for="salesPartner-name">Expense Start Date:</label>
                <form:input path="expensestartdate" type="date" required="required" class="date-input" />
                <font color="red">
                    <form:errors path="expensestartdate" cssClass="error" />
                </font>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <label for="salesPartner-name">Expense End Date:</label>
                <form:input path="expenseenddate" type="date" required="required" class="date-input" />
                <font color="red">
                    <form:errors path="expenseenddate" cssClass="error" />
                </font>

            </div>


        </form:form>
    </div>
</div>

<jsp:include page="../footer.jsp" />
