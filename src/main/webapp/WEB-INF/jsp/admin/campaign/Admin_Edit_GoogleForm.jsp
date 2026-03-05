<jsp:include page="../../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">

                <style>
                    body {
                        background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
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
                        background: rgba(255, 255, 255, 0.05);
                        z-index: -1;
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
                        margin-bottom: 25px;
                        text-align: center;
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
                        transition: transform 0.2s;
                    }

                    .button-container input[type="submit"]:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 4px 15px rgba(66, 133, 244, 0.4);
                    }
                </style>

                <div class="form-container-wrapper" style="background: transparent !important;">
                    <div class="form-container">
                        <h2>Edit Google Form</h2>
                        <form:form method="post" action="edit_campaign_form" modelAttribute="CAMPAIGN_FORM_OBJ">
                            <form:hidden path="campaignFormId" />
                            <form:hidden path="formType" />

                            <div class="form-row">
                                <label>Form Name:</label>
                                <form:input path="formName" required="required" />
                            </div>
                            <div class="form-row">
                                <label>Google Form ID:</label>
                                <form:input path="formId" required="required" />
                            </div>
                            <div class="form-row">
                                <label>Campaign Name:</label>
                                <form:input path="campaignName" />
                            </div>
                            <div class="form-row">
                                <label>Description:</label>
                                <form:textarea path="description" rows="3" cols="40" maxlength="500" />
                            </div>
                            <div class="form-row">
                                <label>Status:</label>
                                <form:select path="active" style="width:100%">
                                    <option value="true" ${CAMPAIGN_FORM_OBJ.active eq true ? 'selected' : '' }>Active
                                    </option>
                                    <option value="false" ${CAMPAIGN_FORM_OBJ.active eq false ? 'selected' : '' }>
                                        Inactive</option>
                                </form:select>
                            </div>
                            <div class="button-container">
                                <input type="submit" value="Update Google Form">
                                <a href="view_campaign_list"><input type="button" value="Back to List"
                                        style="background:#6c757d;color:white;border:none;padding:12px 30px;border-radius:6px;font-size:16px;cursor:pointer;margin-left:10px;"></a>
                            </div>
                        </form:form>
                    </div>
                </div>
                <jsp:include page="../../footer.jsp" />