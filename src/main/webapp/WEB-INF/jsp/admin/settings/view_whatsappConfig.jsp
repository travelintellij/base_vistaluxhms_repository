<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

            <!-- ===== AI MODIFICATION START ===== -->
            <!-- Change: New dedicated JSP page for WhatsApp Configuration -->
            <!-- Reason: User requested WhatsApp config under Communication Channels dropdown -->
            <!-- Scope: Communication Channels > WhatsApp Config -->
            <!-- ===== AI MODIFICATION END ===== -->

            <html>

            <head>
                <title>WhatsApp Configuration</title>
                <style>
                    body {
                        font-family: 'Segoe UI', Arial, sans-serif;
                        background: #f4f6f8;
                        color: #333;
                        margin: 0;
                        padding: 0;
                    }

                    h2 {
                        text-align: center;
                        margin-top: 20px;
                        font-weight: 600;
                        color: #2c3e50;
                    }

                    .form-container {
                        width: 70%;
                        margin: 20px auto;
                        background: #fff;
                        padding: 25px;
                        border-radius: 8px;
                        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
                    }

                    .form-group {
                        display: grid;
                        grid-template-columns: 30% 70%;
                        align-items: center;
                        margin-bottom: 15px;
                    }

                    .form-group label {
                        font-weight: 500;
                        color: #444;
                        padding-right: 10px;
                    }

                    .input-field {
                        width: 95%;
                        padding: 8px;
                        border: 1px solid #ccc;
                        border-radius: 5px;
                        font-size: 14px;
                    }

                    fieldset {
                        border: 1px solid #ddd;
                        padding: 15px;
                        border-radius: 8px;
                        background: #fdfdfd;
                        margin-bottom: 20px;
                    }

                    fieldset legend {
                        font-weight: 600;
                        font-size: 15px;
                        color: #2c3e50;
                        padding: 0 8px;
                    }

                    .btn-container {
                        text-align: center;
                        margin-top: 20px;
                    }

                    .btn-save {
                        background: #25D366;
                        color: #fff;
                        padding: 10px 18px;
                        border: none;
                        border-radius: 5px;
                        font-size: 15px;
                        cursor: pointer;
                    }

                    .btn-save:hover {
                        background: #1da851;
                    }

                    .info-note {
                        background: #fff3cd;
                        border: 1px solid #ffc107;
                        border-radius: 5px;
                        padding: 10px 15px;
                        margin-bottom: 15px;
                        font-size: 13px;
                        color: #856404;
                    }

                    @media (max-width: 768px) {
                        .form-container {
                            width: 90%;
                        }

                        .form-group {
                            grid-template-columns: 1fr;
                            gap: 5px;
                        }

                        .input-field {
                            width: 100%;
                        }
                    }
                </style>
            </head>

            <body>

                <h2>&#128172; WhatsApp Configuration</h2>
                <div align="center" style="margin:10px 0"><b>
                        <c:if test="${not empty Success}">
                            <div style="color:green; font-weight:bold; margin-bottom:5px;">${Success}</div>
                        </c:if>
                        <c:if test="${not empty Error}">
                            <div style="color:red; font-weight:bold; margin-bottom:5px;">${Error}</div>
                        </c:if>
                    </b></div>

                <div class="form-container">
                    <form:form modelAttribute="WHATSAPP_CONFIG_OBJ" method="post" action="save_whatsapp_config">

                        <!-- API Details -->
                        <fieldset>
                            <legend>API Connection Details</legend>
                            <div class="form-group">
                                <label>WhatsApp API URL</label>
                                <form:input path="whatsAppApiUrl" class="input-field"
                                    placeholder="e.g. https://console.authkey.io/restapi/requestjson.php" />
                            </div>
                            <div class="form-group">
                                <label>Auth Key</label>
                                <form:input path="whatsAppApiKey" class="input-field"
                                    placeholder="Enter your API Auth Key" />
                            </div>
                        </fieldset>

                        <!-- Template IDs -->
                        <fieldset>
                            <legend>Template IDs</legend>


                            <div class="form-group">
                                <label>New Query Registration Template ID</label>
                                <form:input path="whatsAppRegistrationTemplateId" class="input-field"
                                    placeholder="e.g. 25455" />
                            </div>
                            <div class="form-group">
                                <label>Quotation Template ID</label>
                                <!-- ===== AI MODIFICATION START ===== -->
                                <!-- Change: Using whatsAppGuestQuotationTemplateId as the single input for both Stay & Guest quotation -->
                                <!-- Reason: Stay Quotation and Guest Quotation use the same template, so only one input is needed -->
                                <!-- Scope: WhatsApp Config - Template IDs -->
                                <form:input path="whatsAppGuestQuotationTemplateId" class="input-field"
                                    placeholder="e.g. 27614 (used for Stay & Guest Quotation)" />
                                <!-- ===== AI MODIFICATION END ===== -->
                            </div>
                        </fieldset>

                        <div class="btn-container">
                            <button type="submit" class="btn-save">Save WhatsApp Configuration</button>
                        </div>
                    </form:form>
                </div>

            </body>

            </html>