<jsp:include page="../../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
                    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
                        <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">

                        <style>
                            body {
                                background-image: url('<%= request.getContextPath() %>/resources/images/Google_ads.png');
                                background-size: cover;
                                background-position: center;
                                background-attachment: fixed;
                                min-height: 100vh;
                                position: relative;
                            }

                            body::after {
                                content: "";
                                position: absolute;
                                top: 0;
                                left: 0;
                                right: 0;
                                bottom: 0;
                                background: rgba(255, 255, 255, 0.4);
                                z-index: -1;
                            }

                            .form-container-wrapper {
                                background: transparent !important;
                            }

                            .form-container {
                                background: rgba(255, 255, 255, 0.95);
                                border-radius: 12px;
                                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
                                padding: 30px 40px;
                                max-width: 650px;
                                margin: 30px auto;
                            }

                            .form-container h2 {
                                color: #0f3460;
                                font-size: 24px;
                                margin-bottom: 5px;
                                text-align: center;
                            }

                            .form-subtitle {
                                color: #4285f4;
                                font-size: 13px;
                                text-align: center;
                                margin-bottom: 25px;
                                font-weight: 500;
                            }

                            .form-row {
                                display: flex;
                                align-items: center;
                                margin-bottom: 15px;
                            }

                            .form-row label {
                                width: 180px;
                                font-weight: 600;
                                color: #333;
                                font-size: 14px;
                            }

                            .form-row input,
                            .form-row select,
                            .form-row textarea {
                                flex: 1;
                                padding: 10px;
                                border: 1px solid #ccc;
                                border-radius: 6px;
                                font-size: 14px;
                                transition: border-color 0.3s;
                            }

                            .form-row input:focus,
                            .form-row select:focus,
                            .form-row textarea:focus {
                                border-color: #4285f4;
                                outline: none;
                                box-shadow: 0 0 5px rgba(66, 133, 244, 0.3);
                            }

                            .button-container {
                                text-align: center;
                                margin-top: 25px;
                            }

                            .button-container input[type="submit"] {
                                background: linear-gradient(135deg, #4285f4, #34a853);
                                color: white;
                                border: none;
                                padding: 12px 30px;
                                border-radius: 6px;
                                font-size: 16px;
                                font-weight: 600;
                                cursor: pointer;
                                transition: transform 0.2s, box-shadow 0.3s;
                            }

                            .button-container input[type="submit"]:hover {
                                transform: translateY(-2px);
                                box-shadow: 0 4px 15px rgba(66, 133, 244, 0.4);
                            }

                            .info-badge {
                                background: #e8f5e9;
                                border-left: 4px solid #34a853;
                                padding: 10px 15px;
                                margin-bottom: 20px;
                                border-radius: 0 6px 6px 0;
                                font-size: 13px;
                                color: #333;
                            }
                        </style>

                        <div class="form-container-wrapper" style="background: transparent !important;">
                            <div class="form-container">
                                <h2>Add Google Form ID</h2>
                                <p class="form-subtitle">Connect your Google Form for Lead Collection</p>

                                <div class="info-badge">
                                    <strong>Tip:</strong> Find your Google Form ID from the URL:
                                    <code>https://docs.google.com/forms/d/<strong>FORM_ID</strong>/viewform</code>
                                </div>

                                <c:if test="${not empty Success}">
                                    <div
                                        style="background:#d4edda;color:#155724;padding:10px;border-radius:6px;margin-bottom:15px;text-align:center;">
                                        ${Success}
                                    </div>
                                </c:if>

                                <form:form method="post" action="create_google_form" modelAttribute="CAMPAIGN_FORM_OBJ">
                                    <div class="form-row">
                                        <label>Form Name:</label>
                                        <form:input path="formName" placeholder="e.g. Wedding Inquiry Form"
                                            required="required" />
                                    </div>
                                    <font color="red">
                                        <form:errors path="formName" cssClass="error" />
                                    </font>

                                    <div class="form-row">
                                        <label>Google Form ID:</label>
                                        <form:input path="formId" placeholder="e.g. 1FAIpQLSdJ..."
                                            required="required" />
                                    </div>
                                    <font color="red">
                                        <form:errors path="formId" cssClass="error" />
                                    </font>

                                    <div class="form-row">
                                        <label>Campaign Name:</label>
                                        <form:input path="campaignName" placeholder="e.g. Jaipur Winter Campaign" />
                                    </div>

                                    <div class="form-row">
                                        <label>Description:</label>
                                        <form:textarea path="description"
                                            placeholder="Brief description of this form/campaign" rows="3" cols="40"
                                            maxlength="500" />
                                    </div>

                                    <div class="form-row">
                                        <label>Status:</label>
                                        <form:select path="active" style="width:100%">
                                            <option value="true" ${CAMPAIGN_FORM_OBJ.active eq true ? 'selected' : '' }>
                                                Active</option>
                                            <option value="false" ${CAMPAIGN_FORM_OBJ.active eq false ? 'selected' : ''
                                                }>Inactive</option>
                                        </form:select>
                                    </div>

                                    <div class="button-container">
                                        <input type="submit" value="Save Google Form">
                                        <sec:authorize access="hasAnyRole('ADMIN','CAMPAIGN_MANAGE')">
                                            <a href="view_campaign_list"><input type="button" class="clear-filter-btn"
                                                    value="View All Campaigns"
                                                    style="background:#f0ad4e;color:white;border:none;padding:12px 30px;border-radius:6px;font-size:16px;cursor:pointer;"></input></a>
                                        </sec:authorize>
                                    </div>
                                </form:form>
                            </div>
                        </div>
                        <jsp:include page="../../footer.jsp" />