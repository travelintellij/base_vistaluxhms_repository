<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

            <!-- ===== AI MODIFICATION START ===== -->
            <!-- Change: Rewrote Email Config page as an editable form backed by DB -->
            <!-- Reason: Email configuration should be handled via frontend, not hardcoded -->
            <!-- Scope: Communication Channels > Email Config -->
            <!-- ===== AI MODIFICATION END ===== -->

            <html>

            <head>
                <title>Email Configuration</title>
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
                        background: #007bff;
                        color: #fff;
                        padding: 10px 18px;
                        border: none;
                        border-radius: 5px;
                        font-size: 15px;
                        cursor: pointer;
                    }

                    .btn-save:hover {
                        background: #0056b3;
                    }

                    .radio-group {
                        display: flex;
                        gap: 20px;
                        align-items: center;
                    }

                    .radio-group label {
                        font-weight: normal;
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

                <h2>&#9993; Email Configuration</h2>
                <div align="center" style="margin:10px 0"><b>
                        <c:if test="${not empty Success}">
                            <div style="color:green; font-weight:bold; margin-bottom:5px;">${Success}</div>
                        </c:if>
                        <c:if test="${not empty Error}">
                            <div style="color:red; font-weight:bold; margin-bottom:5px;">${Error}</div>
                        </c:if>
                    </b></div>

                <div class="form-container">
                    <form:form modelAttribute="EMAIL_CONFIG_OBJ" method="post" action="save_email_config">

                        <!-- SMTP Settings -->
                        <fieldset>
                            <legend>SMTP Settings</legend>
                            <div class="form-group">
                                <label>SMTP Host</label>
                                <form:input path="emailSmtpHost" class="input-field"
                                    placeholder="e.g. smtp-relay.brevo.com" />
                            </div>
                            <div class="form-group">
                                <label>SMTP Port</label>
                                <form:input path="emailSmtpPort" class="input-field" placeholder="e.g. 587" />
                            </div>
                            <div class="form-group">
                                <label>SMTP Username</label>
                                <form:input path="emailSmtpUsername" class="input-field"
                                    placeholder="Enter SMTP username" />
                            </div>
                            <div class="form-group">
                                <label>SMTP Password</label>
                                <form:password path="emailSmtpPassword" class="input-field"
                                    placeholder="Enter SMTP password" showPassword="true" />
                            </div>
                        </fieldset>

                        <!-- Email Addresses -->
                        <fieldset>
                            <legend>Email Addresses</legend>
                            <div class="form-group">
                                <label>From Address</label>
                                <form:input path="emailFromAddress" class="input-field"
                                    placeholder="e.g. Hotel Name <query@hotel.com>" />
                            </div>
                            <div class="form-group">
                                <label>Reply-To</label>
                                <form:input path="emailReplyTo" class="input-field"
                                    placeholder="e.g. query@hotel.com" />
                            </div>
                            <div class="form-group">
                                <label>Default CC</label>
                                <form:input path="emailDefaultCc" class="input-field"
                                    placeholder="e.g. sales@hotel.com" />
                            </div>
                            <div class="form-group">
                                <label>Notification Email (BCC)</label>
                                <form:input path="emailNotifyTo" class="input-field"
                                    placeholder="e.g. admin@hotel.com" />
                            </div>
                        </fieldset>

                        <!-- Status Flags -->
                        <fieldset>
                            <legend>Email Status</legend>
                            <div class="form-group">
                                <label>Client Email Active</label>
                                <div class="radio-group">
                                    <div>
                                        <form:radiobutton path="emailClientActive" value="true" /> <label>Yes</label>
                                    </div>
                                    <div>
                                        <form:radiobutton path="emailClientActive" value="false" /> <label>No</label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Internal Email Active</label>
                                <div class="radio-group">
                                    <div>
                                        <form:radiobutton path="emailInternalActive" value="true" /> <label>Yes</label>
                                    </div>
                                    <div>
                                        <form:radiobutton path="emailInternalActive" value="false" /> <label>No</label>
                                    </div>
                                </div>
                            </div>
                        </fieldset>

                        <div class="btn-container">
                            <button type="submit" class="btn-save">Save Email Configuration</button>
                        </div>
                    </form:form>
                </div>

            </body>

            </html>