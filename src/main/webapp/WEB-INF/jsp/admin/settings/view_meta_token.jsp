<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

            <html>

            <head>
                <title>Meta Token Configuration</title>
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

                    textarea.input-field {
                        min-height: 80px;
                        font-family: monospace;
                        font-size: 12px;
                    }

                    .info-badge {
                        background: #e8f4fd;
                        border-left: 4px solid #0f3460;
                        padding: 10px 15px;
                        margin-bottom: 20px;
                        border-radius: 0 6px 6px 0;
                        font-size: 13px;
                        color: #333;
                    }

                    .btn-container {
                        text-align: center;
                        margin-top: 20px;
                    }

                    .btn-save {
                        background: linear-gradient(135deg, #0f3460, #e94560);
                        color: #fff;
                        padding: 10px 25px;
                        border: none;
                        border-radius: 5px;
                        font-size: 15px;
                        font-weight: 600;
                        cursor: pointer;
                        transition: transform 0.2s, box-shadow 0.3s;
                    }

                    .btn-save:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 4px 15px rgba(233, 69, 96, 0.4);
                    }
                </style>
            </head>

            <body>

                <h2>Meta Token Configuration</h2>

                <div align="center" style="margin:10px 0"><b>
                        <c:if test="${not empty Success}">
                            <div style="color:green; font-weight:bold; margin-bottom:5px;">${Success}</div>
                        </c:if>
                        <c:if test="${not empty Error}">
                            <div style="color:red; font-weight:bold; margin-bottom:5px;">${Error}</div>
                        </c:if>
                    </b></div>

                <div class="form-container">
                    <div class="info-badge">
                        <strong>Permanent Token:</strong> This is your Meta Page Access Token. Once set, it will be used
                        for all lead syncing across all campaign forms. You only need to update this if the token is
                        revoked or regenerated.
                    </div>

                    <form method="post" action="save_meta_token">
                        <div class="form-group">
                            <label>Page ID:</label>
                            <input type="text" name="metaPageId" class="input-field" value="${metaPageId}"
                                placeholder="e.g. 914727961939176" />
                        </div>

                        <div class="form-group">
                            <label>Access Token:</label>
                            <textarea name="metaPageAccessToken" class="input-field" rows="4"
                                placeholder="Paste your Permanent Page Access Token here">${metaPageAccessToken}</textarea>
                        </div>

                        <!-- ===== START: ADDED FOR LEAD SYNC - LEAD IMPORT SETTINGS ===== -->
                        <div class="form-group"
                            style="padding-top: 15px; border-top: 1px dotted #ccc; margin-top: 25px;">
                            <label>Default Lead Owner:</label>
                            <div>
                                <select name="defaultLeadOwnerId" class="input-field" style="width:100%">
                                    <option value="">-- Select Lead Owner --</option>
                                    <c:forEach items="${ACTIVE_USERS_MAP}" var="userMap">
                                        <c:choose>
                                            <c:when test="${defaultLeadOwnerId eq userMap.key}">
                                                <option value="${userMap.key}" selected>${userMap.value}</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="${userMap.key}">${userMap.value}</option>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </select>
                                <div style="margin-top: 6px;">
                                    <small style="color: #6c757d; font-style: italic;">All leads imported from Social
                                        Media (Instagram/Facebook) will be assigned to this user and they will be
                                        notified via email.</small>
                                </div>
                            </div>
                        </div>
                        <!-- ===== END: ADDED FOR LEAD SYNC ===== -->

                        <div class="btn-container">
                            <button type="submit" class="btn-save">Save Token</button>
                        </div>
                    </form>
                </div>

            </body>

            </html>