<jsp:include page="../../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
                    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
                        <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">
                        <script src="<c:url value=" /resources/core/jquery.1.10.2.min.js" />"></script>
                        <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

                            <head>
                                <meta charset="UTF-8">
                                <title>Settings Panel</title>
                                <style>
                                    body {
                                        margin: 0;
                                        font-family: Arial, sans-serif;
                                    }

                                    /* Layout container */
                                    .main-container {
                                        display: flex;
                                        height: calc(100vh - 50px);
                                        /* Full height minus top menu */
                                    }

                                    /* Left Sidebar */
                                    .sidebar {
                                        width: 220px;
                                        background-color: #f8f9fa;
                                        padding: 20px 10px;
                                        border-right: 1px solid #ccc;
                                    }

                                    .sidebar a {
                                        display: block;
                                        padding: 10px 15px;
                                        margin-bottom: 10px;
                                        background-color: #e9ecef;
                                        color: #000;
                                        text-decoration: none;
                                        border-radius: 4px;
                                    }

                                    .sidebar a:hover {
                                        background-color: #ced4da;
                                    }

                                    /* Content area */
                                    .content-frame {
                                        flex-grow: 1;
                                        border: none;
                                        width: 100%;
                                    }

                                    /* ===== AI MODIFICATION START ===== */
                                    /* Change: Added styles for dropdown toggle in sidebar */
                                    /* Reason: Communication Channels menu needs a collapsible dropdown */
                                    /* Scope: Settings sidebar - Communication Channels feature */
                                    .dropdown-toggle {
                                        display: block;
                                        padding: 10px 15px;
                                        margin-bottom: 2px;
                                        background-color: #d6e0f0;
                                        color: #000;
                                        text-decoration: none;
                                        border-radius: 4px;
                                        cursor: pointer;
                                        font-weight: bold;
                                    }

                                    .dropdown-toggle:hover {
                                        background-color: #c0cfe0;
                                    }

                                    .dropdown-toggle::after {
                                        content: ' \25BC';
                                        font-size: 10px;
                                        float: right;
                                    }

                                    .dropdown-content {
                                        display: none;
                                        padding-left: 15px;
                                    }

                                    .dropdown-content.show {
                                        display: block;
                                    }

                                    .dropdown-content a {
                                        font-size: 13px;
                                        padding: 8px 12px;
                                        margin-bottom: 4px;
                                    }

                                    /* ===== AI MODIFICATION END ===== */
                                </style>
                            </head>

                            <body>
                                <!-- Main Layout -->
                                <div class="main-container">
                                    <!-- Left Sidebar -->
                                    <div class="sidebar">
                                        <a href="settings_my_profile" target="contentFrame">My Profile</a>
                                        <a href="view_form_change_password" target="contentFrame">Change Password</a>
                                        <sec:authorize access="hasAnyRole('ADMIN')">
                                            <a href="view_form_manage_permissions" target="contentFrame">Permissions</a>
                                        </sec:authorize>
                                        <sec:authorize access="hasRole('ROLE_SUPERADMIN')">
                                            <a href="view_form_manage_central_config" target="contentFrame">Central
                                                Config</a>
                                        </sec:authorize>
                                        <sec:authorize access="hasAnyRole('ADMIN')">
                                            <a href="view_form_manage_event_forms?eventType=wedding"
                                                target="contentFrame">Event Config</a>
                                        </sec:authorize>

                                        <!-- ===== AI MODIFICATION START ===== -->
                                        <!-- Change: Added Communication Channels dropdown menu -->
                                        <!-- Reason: User requested a separate dropdown for Email and WhatsApp config -->
                                        <!-- Scope: Settings sidebar - Communication Channels feature -->
                                        <sec:authorize access="hasRole('ROLE_SUPERADMIN')">
                                            <div class="dropdown-toggle"
                                                onclick="toggleDropdown('commChannelsDropdown', this)">Communication
                                                Channels</div>
                                            <div id="commChannelsDropdown" class="dropdown-content">
                                                <a href="view_form_email_config" target="contentFrame">Email Config</a>
                                                <a href="view_form_whatsapp_config" target="contentFrame">WhatsApp
                                                    Config</a>
                                            </div>
                                        </sec:authorize>
                                        <!-- ===== AI MODIFICATION END ===== -->
                                    </div>

                                    <!-- Right Content -->
                                    <iframe name="contentFrame" class="content-frame"
                                        src="settings_my_profile"></iframe>
                                </div>

                                <!-- ===== AI MODIFICATION START ===== -->
                                <!-- Change: Added JavaScript for dropdown toggle -->
                                <!-- Reason: Enables collapsible dropdown behavior for Communication Channels -->
                                <!-- Scope: Settings sidebar - Communication Channels feature -->
                                <script>
                                    function toggleDropdown(id, toggleEl) {
                                        var content = document.getElementById(id);
                                        content.classList.toggle('show');
                                    }
                                </script>
                                <!-- ===== AI MODIFICATION END ===== -->

                            </body>

                            </html>