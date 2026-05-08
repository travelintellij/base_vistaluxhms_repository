<jsp:include page="../../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />

<script src="<c:url value="/resources/core/jquery.1.10.2.min.js" />"></script>
<script src="<c:url value="/resources/core/jquery.autocomplete.min.js" />"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<style>
    body {
        background-image: url('<%= request.getContextPath() %>/resources/images/clientadd.jpg');
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

    /* Highlight Validation Errors */
    .error {
        display: inline-block;
        background-color: #ffe6e6;   /* Light red background */
        color: #b30000;              /* Dark red text */
        font-weight: bold;           /* Bold text */
        padding: 5px 10px;
        border: 1px solid #ff4d4d;
        border-radius: 4px;
        margin-top: 4px;
        font-size: 13px;
    }
    #salesPartnerSelect {
        width: 100% !important;
    }

    .select2-container {
        width: 100% !important;
    }

    .select2-container .select2-selection--single {
        height: 38px !important;
        border: 1px solid #ccc !important;
        border-radius: 4px !important;
        padding-top: 4px;
    }

    .select2-container--default .select2-selection--single .select2-selection__rendered {
        line-height: 28px !important;
    }

    .select2-container--default .select2-selection--single .select2-selection__arrow {
        height: 36px !important;
    }
    .form-row .select2-container {
        width: 66% !important;
    }

    .form-row .select2-selection--single {
        height: 38px !important;
        padding-top: 4px;
        border: 1px solid #ccc !important;
        border-radius: 4px !important;
    }

    .form-row .select2-selection__rendered {
        line-height: 28px !important;
    }

    .form-row .select2-selection__arrow {
        height: 38px !important;
    }


</style>

<div class="form-container-wrapper" style="background: transparent !important;">
    <div class="form-container">
        <h2>Add Client</h2> <!-- Bold Header -->
        <form:form method="post" action="create_create_client" modelAttribute="CLIENT_OBJ">
            <!-- First Row -->
            <div class="form-row">
                <label for="client-id">Client Id:</label>
                <label for="auto-generated"><font color="blue">Auto Generated</font></label>
            </div>
            <div class="form-row">
                <label for="clientSource">Client Source (Sales Partner):</label>
                <form:select id="salesPartnerSelect" path="salesPartner.salesPartnerId" required="required">
                       <!-- Default placeholder option -->
                       <option value="" selected>-- Please Select --</option>
                       <form:options items="${SALES_PARTNER_MAP}" />
                   </form:select>
            </div>

            <div class="form-row">
                <label for="client-name">Client Name:</label>
                <form:input path="clientName" name="clientName" placeholder="Enter client Name" required="required"/>
                <font color="red">
                    <form:errors path="clientName" cssClass="error" />
                </font>
            </div>
           <div class="form-row">
               <label for="b2b-client">Client Type: <font color="red">*</font></label>
               <div class="radio-group-container">
                   <div class="radio-group">
                       <label>
                           <form:radiobutton path="b2b" value="true" />
                           <span>B2B</span>
                       </label>
                       <label>
                           <form:radiobutton path="b2b" value="false" />
                           <span>B2C</span>
                       </label>
                   </div>
               </div>
               <font color="red">
                   <form:errors path="b2b" cssClass="error" />
               </font>
           </div>



            <div class="form-row">
                <label for="email-id">Email Id:</label>
                <form:input path="emailId" id="emailId" type="email" placeholder="Enter your email" required="required" />
                <form:errors path="emailId" cssClass="error" />
            </div>
            <div class="form-row">
                <label for="mobile">Mobile:</label>
                 <form:input path="mobile" id="mobile" type="tel" placeholder="Enter mobile number" required="required" pattern="[0-9]{10}" />
                <form:errors path="mobile" cssClass="error" />
            </div>
            <div class="form-row">
                 <label for="city-id">City:</label>
                <form:input path="cityName" name="cityName" placeholder="Type city name" autocomplete="off" required="required" />
                <form:hidden id="destinationId" path="city.destinationId" />
                <font color="red">
                    <form:errors path="cityName" cssClass="error" />
                </font>
            </div>
            <div class="form-row">
                <label for="active-status">Active:</label>
               <form:select path="active" required="required" style="width:100%">
                   <form:option value="true">Active</form:option>
                   <form:option value="false">In-Active</form:option>
               </form:select>
            </div>

            <div class="form-row">
                <label for="reference">Reference:</label>
                <form:input path="reference" name="reference" placeholder="Enter Reference"/>
                <font color="red">
                    <form:errors path="reference" cssClass="error" />
                </font>
            </div>
            <div class="form-row">
                <label for="description">Remarks:</label>
                <form:textarea path="remarks" maxlength="255" placeholder="Enter Description" cols="68" rows="5"/>
                <font color="red">
                    <form:errors path="remarks" cssClass="error" />
                </font>
            </div>

            <!-- Second Row -->

            <div class="button-container">
                <input type="submit" value="Add Client">
                <sec:authorize access="hasAnyRole('ADMIN','CLIENT_MANAGE')">
                    <a href="view_clients_list"><input type="button" class="clear-filter-btn" value="View Client List"></input></a>
                </sec:authorize>
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
            var cityID = suggestion.data;
            jQuery("#destinationId").val(cityID);
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

    $(document).ready(function () {
        $('#salesPartnerSelect').select2({
            placeholder: "-- Please Select --",
            allowClear: true,
            width: '66%'
        });
    });


    </script>
<jsp:include page="../../footer.jsp" />
