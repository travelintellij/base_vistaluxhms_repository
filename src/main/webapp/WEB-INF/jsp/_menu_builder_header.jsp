<%--=====AI MODIFICATION START=====Change: Complete redesign of header and navigation using Grand Suite theme Reason:
    Upgrading UI to luxury hospitality-grade design Scope: Global header — affects all pages that include this file Old
    code preserved below in JSP comment block --%>
    <!DOCTYPE html>
    <html lang="en">
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
                <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
                    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                        <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
                            <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

                                <c:set var="role" value="${role != null ? role : 'user'}" />
                                <c:set var="username" value="${userName != null ? userName : 'Guest'}" />

                                <head>
                                    <meta charset="UTF-8">
                                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
                                    <meta http-equiv="Pragma" content="no-cache" />
                                    <meta http-equiv="Expires" content="0" />

                                    <title>AxisHMS Pro</title>

                                    <!-- ===== Grand Suite Design System ===== -->
                                    <link rel="stylesheet"
                                        href="<%= request.getContextPath() %>/resources/css/grand-suite.css">
                                    <!-- ===== Legacy styles (kept for backward compatibility, will be phased out) ===== -->
                                    <link rel="stylesheet"
                                        href="<%= request.getContextPath() %>/resources/css/styles.css">
                                </head>

                                <body>

                                    <!-- ===== HEADER ===== -->
                                    <header class="gs-header">
                                        <%-- Back Button Integration: Shows on all pages except the main home dashboard --%>
                                      <c:if test="${not fn:contains(pageContext.request.requestURI, 'view_workloadhome') and not fn:contains(pageContext.request.requestURI, 'resortHomePage')}">
        <a href="javascript:history.back()" class="gs-back-btn" title="Go Back">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                <path d="M19 12H5M12 19l-7-7 7-7"/>
            </svg>
        </a>
    </c:if>
                                        <a href="view_workloadhome" class="gs-header-brand">
                                            <c:choose>
                                                <c:when test="${not empty centralConfig.logoPath}">
                                                    <c:choose>
                                                        <c:when test="${fn:startsWith(centralConfig.logoPath, '/resources')}">
                                                            <c:set var="logoUrl" value="${pageContext.request.contextPath}${centralConfig.logoPath}" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:set var="logoUrl" value="${centralConfig.logoPath}" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:set var="logoUrl"
                                                        value="${pageContext.request.contextPath}/resources/images/ashoka_logo.jpg" />
                                                </c:otherwise>
                                            </c:choose>
                                            <img id="topLogo" src="${logoUrl}" alt="Logo">
                                            <div class="gs-header-title">
                                                <c:choose>
                                                    <c:when test="${not empty centralConfig.hotelName}">
                                                        ${centralConfig.hotelName}
                                                    </c:when>
                                                    <c:otherwise>
                                                        Axis<span>HMS</span> Pro
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </a>

                                        <div class="gs-header-user" style="margin-left: auto;">
                                            <span>Welcome, <strong>
                                                    <sec:authentication property="principal.username" />
                                                </strong></span>
                                            <div class="gs-user-avatar">
                                                <sec:authentication property="principal.username" var="currentUser"
                                                    scope="page" />
                                                ${fn:toUpperCase(fn:substring(currentUser, 0, 1))}
                                            </div>
                                        </div>
                                    </header>

                                    <!-- ===== NAVIGATION ===== -->
                                    <nav class="gs-nav">
                                        <ul class="gs-nav-list">

                                            <%-- Lead Management --%>
                                                <sec:authorize access="hasAnyRole('ADMIN','LEADS_MANAGE')">
                                                    <li class="gs-nav-item">
                                                        <a href="#" class="gs-nav-link">Lead Management</a>
                                                        <ul class="gs-dropdown">
                                                            <li><a href="view_add_lead_form"
                                                                    class="gs-dropdown-item">New Lead</a></li>
                                                            <li><a href="view_filter_leads"
                                                                    class="gs-dropdown-item">Lead Management</a></li>
                                                        </ul>
                                                    </li>
                                                </sec:authorize>

                                                <%-- User Management --%>
                                                    <sec:authorize access="hasAnyRole('ADMIN','USER_MANAGE')">
                                                        <li class="gs-nav-item">
                                                            <a href="#" class="gs-nav-link">User Management</a>
                                                            <ul class="gs-dropdown">
                                                                <li><a href="view_add_user_form"
                                                                        class="gs-dropdown-item">Add User</a></li>
                                                                <li><a href="view_users_list"
                                                                        class="gs-dropdown-item">User Management</a>
                                                                </li>
                                                            </ul>
                                                        </li>
                                                    </sec:authorize>

                                                    <%-- Client Management --%>
                                                        <sec:authorize
                                                            access="hasAnyRole('ADMIN','CLIENT_CREATE','CLIENT_MANAGE')">
                                                            <li class="gs-nav-item">
                                                                <a href="#" class="gs-nav-link">Client Management</a>
                                                                <ul class="gs-dropdown">
                                                                    <li><a href="view_add_client_form"
                                                                            class="gs-dropdown-item">Add Client</a></li>
                                                                    <sec:authorize
                                                                        access="hasAnyRole('ADMIN','CLIENT_MANAGE')">
                                                                        <li><a href="view_clients_list"
                                                                                class="gs-dropdown-item">Clients
                                                                                Management</a></li>
                                                                    </sec:authorize>
                                                                </ul>
                                                            </li>
                                                        </sec:authorize>

                                                        <%-- Others (City) --%>
                                                            <c:if test="${role == 'admin' || role == 'guest'}">
                                                                <li class="gs-nav-item">
                                                                    <a href="#" class="gs-nav-link">Others</a>
                                                                    <ul class="gs-dropdown">
                                                                        <li class="gs-has-submenu">
                                                                            <a href="#"
                                                                                class="gs-dropdown-item">City</a>
                                                                            <ul class="gs-submenu">
                                                                                <li><a href="view_add_city_form"
                                                                                        class="gs-dropdown-item">Add
                                                                                        City</a></li>
                                                                                <li><a href="view_search_city_form"
                                                                                        class="gs-dropdown-item">Manage
                                                                                        Cities</a></li>
                                                                            </ul>
                                                                        </li>
                                                                    </ul>
                                                                </li>
                                                            </c:if>

                                                            <%-- Sales Management --%>
                                                                <li class="gs-nav-item">
                                                                    <a href="#" class="gs-nav-link">Sales Management</a>
                                                                    <ul class="gs-dropdown">
                                                                        <sec:authorize
                                                                            access="hasAnyRole('ADMIN','RATE_TYPE_MANAGE')">
                                                                            <li class="gs-has-submenu">
                                                                                <a href="#"
                                                                                    class="gs-dropdown-item">Rate
                                                                                    Type</a>
                                                                                <ul class="gs-submenu">
                                                                                    <li><a href="view_add_rate_type_form"
                                                                                            class="gs-dropdown-item">Add
                                                                                            Rate Type</a></li>
                                                                                    <li><a href="view_rate_type_list"
                                                                                            class="gs-dropdown-item">Manage
                                                                                            Rate Type</a></li>
                                                                                </ul>
                                                                            </li>
                                                                        </sec:authorize>

                                                                        <sec:authorize
                                                                            access="hasAnyRole('ADMIN','SALES_PARTNER_CREATE','SALES_PARTNER_MANAGE')">
                                                                            <li class="gs-has-submenu">
                                                                                <a href="#"
                                                                                    class="gs-dropdown-item">Sales
                                                                                    Partner</a>
                                                                                <ul class="gs-submenu">
                                                                                    <li><a href="view_add_sales_partner_form"
                                                                                            class="gs-dropdown-item">Add
                                                                                            Sales Partner</a></li>
                                                                                    <sec:authorize
                                                                                        access="hasAnyRole('ADMIN','SALES_PARTNER_MANAGE')">
                                                                                        <li><a href="view_sales_partner_list"
                                                                                                class="gs-dropdown-item">Manage
                                                                                                Sales Partner</a></li>
                                                                                    </sec:authorize>
                                                                                </ul>
                                                                            </li>
                                                                        </sec:authorize>

                                                                        <sec:authorize
                                                                            access="hasAnyRole('ADMIN','ROOMS_MANAGE')">
                                                                            <li class="gs-has-submenu">
                                                                                <a href="#"
                                                                                    class="gs-dropdown-item">Master
                                                                                    Rooms Management</a>
                                                                                <ul class="gs-submenu">
                                                                                    <li><a href="view_add_room_category_form"
                                                                                            class="gs-dropdown-item">Add
                                                                                            Room</a></li>
                                                                                    <li><a href="view_rooms_list"
                                                                                            class="gs-dropdown-item">Manage
                                                                                            Rooms</a></li>
                                                                                </ul>
                                                                            </li>
                                                                        </sec:authorize>
                                                                    </ul>
                                                                </li>

                                                                <%-- Cost Management --%>
                                                                    <sec:authorize
                                                                        access="hasAnyRole('ADMIN','COST_MANAGE')">
                                                                        <li class="gs-nav-item">
                                                                            <a href="#" class="gs-nav-link">Cost
                                                                                Management</a>
                                                                            <ul class="gs-dropdown">
                                                                                <li class="gs-has-submenu">
                                                                                    <a href="#"
                                                                                        class="gs-dropdown-item">Session</a>
                                                                                    <ul class="gs-submenu">
                                                                                        <li><a href="view_add_session_form"
                                                                                                class="gs-dropdown-item">Add
                                                                                                Session</a></li>
                                                                                        <li><a href="view_session_list"
                                                                                                class="gs-dropdown-item">Manage
                                                                                                Sessions</a></li>
                                                                                    </ul>
                                                                                </li>
                                                                            </ul>
                                                                        </li>
                                                                    </sec:authorize>

                                                                    <%-- Campaign Management --%>
                                                                        <sec:authorize
                                                                            access="hasAnyRole('ADMIN','CAMPAIGN_MANAGE')">
                                                                            <li class="gs-nav-item">
                                                                                <a href="#" class="gs-nav-link">Campaign
                                                                                    Management</a>
                                                                                <ul class="gs-dropdown">
                                                                                    <li class="gs-has-submenu">
                                                                                        <a href="#"
                                                                                            class="gs-dropdown-item">Meta
                                                                                            Form ID</a>
                                                                                        <ul class="gs-submenu">
                                                                                            <li><a href="view_add_meta_form"
                                                                                                    class="gs-dropdown-item">Add
                                                                                                    Meta Form</a></li>
                                                                                            <li><a href="view_campaign_list"
                                                                                                    class="gs-dropdown-item">Manage
                                                                                                    Campaigns</a></li>
                                                                                        </ul>
                                                                                    </li>
                                                                                </ul>
                                                                            </li>
                                                                        </sec:authorize>

                                                                        <%-- Quotation Management --%>
                                                                            <li class="gs-nav-item">
                                                                                <a href="#"
                                                                                    class="gs-nav-link">Quotation
                                                                                    Management</a>
                                                                                <ul class="gs-dropdown">
                                                                                    <li><a href="view_add_quotation_form"
                                                                                            class="gs-dropdown-item">New
                                                                                            System Quotation</a></li>
                                                                                    <li><a href="view_add_free_hand_quotation_form"
                                                                                            class="gs-dropdown-item"

                                                                                            font-weight: 500;">New
                                                                                            Free Hand Quotation</a></li>
                                                                                </ul>
                                                                            </li>

                                                                            <%-- Event Management --%>
                                                                                <sec:authorize
                                                                                    access="hasAnyRole('ADMIN','EVENT_MANAGE')">
                                                                                    <li class="gs-nav-item">
                                                                                        <a href="#"
                                                                                            class="gs-nav-link">Event
                                                                                            Management</a>
                                                                                        <ul class="gs-dropdown">
                                                                                            <li class="gs-has-submenu">
                                                                                                <a href="#"
                                                                                                    class="gs-dropdown-item">Event
                                                                                                    Services</a>
                                                                                                <ul class="gs-submenu">
                                                                                                    <li><a href="view_event_quotation_form_wiz1"
                                                                                                            class="gs-dropdown-item">Create
                                                                                                            Event
                                                                                                            Quotation</a>
                                                                                                    </li>
                                                                                                    <li><a href="view_filter_events"
                                                                                                            class="gs-dropdown-item">Manage
                                                                                                            Events</a>
                                                                                                    </li>
                                                                                                </ul>
                                                                                            </li>
                                                                                            <li class="gs-has-submenu">
                                                                                                <a href="#"
                                                                                                    class="gs-dropdown-item">Master
                                                                                                    Service</a>
                                                                                                <ul class="gs-submenu">
                                                                                                    <li><a href="view_add_master_service_form"
                                                                                                            class="gs-dropdown-item">Add
                                                                                                            Master
                                                                                                            Service</a>
                                                                                                    </li>
                                                                                                    <li><a href="view_master_service_list"
                                                                                                            class="gs-dropdown-item">Manage
                                                                                                            Services</a>
                                                                                                    </li>
                                                                                                </ul>
                                                                                            </li>
                                                                                        </ul>
                                                                                    </li>
                                                                                </sec:authorize>

                                                                                <%-- My Claims --%>
                                                                                    <sec:authorize
                                                                                        access="hasAnyRole('SUPERADMIN','EXPENSE_APPROVER','CAN_CLAIM')">
                                                                                        <li class="gs-nav-item">
                                                                                            <a href="#"
                                                                                                class="gs-nav-link">My
                                                                                                Claims</a>
                                                                                            <ul class="gs-dropdown">
                                                                                                <sec:authorize
                                                                                                    access="hasAnyRole('CAN_CLAIM')">
                                                                                                    <li><a href="view_add_travel_claim_form"
                                                                                                            class="gs-dropdown-item">New
                                                                                                            Travel
                                                                                                            Claim</a>
                                                                                                    </li>
                                                                                                </sec:authorize>
                                                                                                <li><a href="view_travel_claim_list?view_travelclaimlist"
                                                                                                        class="gs-dropdown-item">Manage
                                                                                                        Travel
                                                                                                        Claims</a>
                                                                                                </li>
                                                                                            </ul>
                                                                                        </li>
                                                                                    </sec:authorize>

                                                                                    <%-- Asset Management --%>
                                                                                        <sec:authorize
                                                                                            access="hasAnyRole('ADMIN','ASSET_MANAGER','ASSET_ALLOWED')">
                                                                                            <li class="gs-nav-item">
                                                                                                <a href="#"
                                                                                                    class="gs-nav-link">Asset
                                                                                                    Management</a>
                                                                                                <ul class="gs-dropdown">
                                                                                                    <li
                                                                                                        class="gs-has-submenu">
                                                                                                        <a href="#"
                                                                                                            class="gs-dropdown-item">Asset</a>
                                                                                                        <ul
                                                                                                            class="gs-submenu">
                                                                                                            <sec:authorize
                                                                                                                access="hasAnyRole('ADMIN','ASSET_MANAGER')">
                                                                                                                <li><a href="${pageContext.request.contextPath}/add_asset"
                                                                                                                        class="gs-dropdown-item">Add
                                                                                                                        Asset</a>
                                                                                                                </li>
                                                                                                            </sec:authorize>
                                                                                                            <li><a href="${pageContext.request.contextPath}/view_assets_list"
                                                                                                                    class="gs-dropdown-item">Manage
                                                                                                                    Assets</a>
                                                                                                            </li>
                                                                                                        </ul>
                                                                                                    </li>
                                                                                                    <sec:authorize
                                                                                                        access="hasAnyRole('ADMIN','ASSET_MANAGER')">
                                                                                                        <li
                                                                                                            class="gs-has-submenu">
                                                                                                            <a href="#"
                                                                                                                class="gs-dropdown-item">Category</a>
                                                                                                            <ul
                                                                                                                class="gs-submenu">
                                                                                                                <li><a href="${pageContext.request.contextPath}/categories_add"
                                                                                                                        class="gs-dropdown-item">Add
                                                                                                                        Category</a>
                                                                                                                </li>
                                                                                                                <li><a href="${pageContext.request.contextPath}/categories_manage"
                                                                                                                        class="gs-dropdown-item">Manage
                                                                                                                        Categories</a>
                                                                                                                </li>
                                                                                                            </ul>
                                                                                                        </li>
                                                                                                    </sec:authorize>
                                                                                                </ul>
                                                                                            </li>
                                                                                        </sec:authorize>

                                                                                        <%-- Document Repository
                                                                                            (ADMIN/MANAGER) --%>
                                                                                            <sec:authorize
                                                                                                access="hasAnyRole('ADMIN','DOCUMENT_MANAGER')">
                                                                                                <li class="gs-nav-item">
                                                                                                    <a href="#"
                                                                                                        class="gs-nav-link">Document
                                                                                                        Repository</a>
                                                                                                    <ul
                                                                                                        class="gs-dropdown">
                                                                                                        <li
                                                                                                            class="gs-has-submenu">
                                                                                                            <a href="#"
                                                                                                                class="gs-dropdown-item">Documents</a>
                                                                                                            <ul
                                                                                                                class="gs-submenu">
                                                                                                                <li><a href="${pageContext.request.contextPath}/add_document"
                                                                                                                        class="gs-dropdown-item">Add
                                                                                                                        Document</a>
                                                                                                                </li>
                                                                                                                <li><a href="${pageContext.request.contextPath}/view_documents_list"
                                                                                                                        class="gs-dropdown-item">Manage
                                                                                                                        Documents</a>
                                                                                                                </li>
                                                                                                            </ul>
                                                                                                        </li>
                                                                                                        <li
                                                                                                            class="gs-has-submenu">
                                                                                                            <a href="#"
                                                                                                                class="gs-dropdown-item">Category</a>
                                                                                                            <ul
                                                                                                                class="gs-submenu">
                                                                                                                <li><a href="${pageContext.request.contextPath}/add_documentcategory"
                                                                                                                        class="gs-dropdown-item">Add
                                                                                                                        Category</a>
                                                                                                                </li>
                                                                                                                <li><a href="${pageContext.request.contextPath}/manage_documentcategories"
                                                                                                                        class="gs-dropdown-item">Manage
                                                                                                                        Categories</a>
                                                                                                                </li>
                                                                                                            </ul>
                                                                                                        </li>
                                                                                                    </ul>
                                                                                                </li>
                                                                                            </sec:authorize>

                                                                                            <%-- Knowledge Repository
                                                                                                (limited access) --%>
                                                                                                <sec:authorize
                                                                                                    access="hasAnyRole('DOCUMENT_ALLOWED','RESTRICTED_DOC_ACCESS')">
                                                                                                    <li
                                                                                                        class="gs-nav-item">
                                                                                                        <a href="#"
                                                                                                            class="gs-nav-link">Knowledge
                                                                                                            Repository</a>
                                                                                                        <ul
                                                                                                            class="gs-dropdown">
                                                                                                            <li><a href="${pageContext.request.contextPath}/view_documents_list"
                                                                                                                    class="gs-dropdown-item">Manage
                                                                                                                    Documents</a>
                                                                                                            </li>
                                                                                                        </ul>
                                                                                                    </li>
                                                                                                </sec:authorize>

                                                                                                <%-- Logout --%>
                                                                                                    <li class="gs-nav-item gs-nav-logout"
                                                                                                        style="margin-left: auto;">
                                                                                                        <a href="logout"
                                                                                                            class="gs-nav-link">Logout</a>
                                                                                                    </li>

                                                                                                    <%-- Settings --%>
                                                                                                        <li
                                                                                                            class="gs-nav-item gs-nav-settings">
                                                                                                            <a href="view_form_my_profile"
                                                                                                                class="gs-nav-link"
                                                                                                                title="Settings">&#9881;</a>
                                                                                                        </li>
                                        </ul>
                                    </nav>

                                    <%--=====AI MODIFICATION END=====--%>

                                        <%--=====OLD HEADER CODE (preserved for reference)=====<head>
                                            <meta charset="UTF-8">
                                            <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                            <meta http-equiv="Cache-Control"
                                                content="no-cache, no-store, must-revalidate" />
                                            <meta http-equiv="Pragma" content="no-cache" />
                                            <meta http-equiv="Expires" content="0" />
                                            <title>Home</title>
                                            <link rel="stylesheet"
                                                href="<%= request.getContextPath() %>/resources/css/styles.css">
                                            </head>
                                            <script>
                                                function updateLogo() {
                                                    const logo = document.getElementById('topLogo');
                                                    logo.src = '<%= request.getContextPath() %>/resources/images/ashoka_logo.jpg?ts=' + new Date().getTime();
                                                }
                                            </script>
                                            <style>
                                                .gear-icon {
                                                    font-size: 20px;
                                                    background-color: #007bff;
                                                    color: white;
                                                    padding: 6px 8px;
                                                    border-radius: 50%;
                                                    margin-right: 5px;
                                                }
                                            </style>

                                            <body>
                                                <header>
                                                    <div class="logo">
                                                        <a href="view_workloadhome"><img id="topLogo"
                                                                src="<%= request.getContextPath() %>/resources/images/ashoka_logo.jpg"
                                                                alt="Logo"></a>
                                                        <h1>AxisHMS Pro - Perfect Hotel CRM Solution</h1>
                                                    </div>
                                                    <div class="welcome">
                                                        Welcome, <strong>
                                                            <sec:authentication property="principal.username" />
                                                        </strong>
                                                    </div>
                                                </header>
                                                <nav>
                                                    <ul>
                                                        ... (old nav items) ...
                                                        <li><a href="logout" class="logout">Logout</a></li>
                                                        <li>
                                                            <a href="view_form_my_profile">
                                                                <span class="gear-icon">&#9881;</span>
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </nav>
                                                ===== END OLD HEADER CODE ===== --%>