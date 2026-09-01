<!DOCTYPE html>
<html lang="en">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>


<c:set var="role" value="${role != null ? role : 'user'}" />
<c:set var="username" value="${userName != null ? userName : 'Guest'}" />



<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="Expires" content="0"/>

    <title>Home</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/styles.css">
</head>
<script>
/*
 function updateLogo() {
     const logo = document.getElementById('topLogo');
     logo.src = '<%= request.getContextPath() %>/resources/images/Axis Pro-Logo.png?ts=' + new Date().getTime();
 } */
</script>
<body>
<header>
    <div class="logo">
        <a href="view_workloadhome"><img id="topLogo" src="<%= request.getContextPath() %>/resources/images/Axis Pro-Logo.png" alt="Logo"></a>
        <h1>AxisHMS Pro - Perfect Hotel CRM Solution</h1>
    </div>
    <div class="welcome">
        <span>Welcome,</span> <strong><sec:authentication property="principal.username"/></strong>
    </div>
</header>
<nav class="main-navbar">
    <ul class="nav-menu">
        <sec:authorize access="hasAnyRole('ADMIN','LEADS_MANAGE')">
            <li class="nav-item">
                <a href="#" class="nav-btn">Leads <span class="nav-arrow">&#9662;</span></a>
                <ul class="submenu">
                    <li><a href="view_add_lead_form">New Lead</a></li>
                    <li><a href="view_filter_leads">Lead Management</a></li>
                </ul>
            </li>
        </sec:authorize>

        <sec:authorize access="hasAnyRole('ADMIN','USER_MANAGE')">
            <li class="nav-item">
                <a href="#" class="nav-btn">Users <span class="nav-arrow">&#9662;</span></a>
                <ul class="submenu">
                    <li><a href="view_add_user_form">Add User</a></li>
                    <li><a href="view_users_list">User Management</a></li>
                </ul>
            </li>
        </sec:authorize>

        <sec:authorize access="hasAnyRole('ADMIN','CLIENT_CREATE','CLIENT_MANAGE')">
            <li class="nav-item">
                <a href="#" class="nav-btn">Clients <span class="nav-arrow">&#9662;</span></a>
                <ul class="submenu">
                    <li><a href="view_add_client_form">Add Client</a></li>
                    <sec:authorize access="hasAnyRole('ADMIN','CLIENT_MANAGE')">
                        <li><a href="view_clients_list">Clients Management</a></li>
                    </sec:authorize>
                </ul>
            </li>
        </sec:authorize>

        <c:if test="${role == 'admin' || role == 'guest'}">
            <li class="nav-item">
                <a href="#" class="nav-btn">Others <span class="nav-arrow">&#9662;</span></a>
                <ul class="submenu">
                    <li>
                        <a href="#">City <span class="sub-arrow">&#8250;</span></a>
                        <ul class="second-level">
                            <li><a href="view_add_city_form">Add City</a></li>
                            <li><a href="view_search_city_form">Manage Cities</a></li>
                        </ul>
                    </li>
                </ul>
            </li>
        </c:if>

        <li class="nav-item">
            <a href="#" class="nav-btn">Sales <span class="nav-arrow">&#9662;</span></a>
            <ul class="submenu">
                <sec:authorize access="hasAnyRole('ADMIN','RATE_TYPE_MANAGE')">
                    <li>
                        <a href="#">Rate Type <span class="sub-arrow">&#8250;</span></a>
                        <ul class="second-level">
                            <li><a href="view_add_rate_type_form">Add Rate Type</a></li>
                            <li><a href="view_rate_type_list">Manage Rate Type</a></li>
                        </ul>
                    </li>
                </sec:authorize>
                <sec:authorize access="hasAnyRole('ADMIN','SALES_PARTNER_CREATE','SALES_PARTNER_MANAGE')">
                    <li>
                        <a href="#">Sales Partner <span class="sub-arrow">&#8250;</span></a>
                        <ul class="second-level">
                            <li><a href="view_add_sales_partner_form">Add Sales Partner</a></li>
                            <sec:authorize access="hasAnyRole('ADMIN','SALES_PARTNER_MANAGE')">
                                <li><a href="view_sales_partner_list">Manage Sales Partner</a></li>
                            </sec:authorize>
                        </ul>
                    </li>
                </sec:authorize>
                <sec:authorize access="hasAnyRole('ADMIN','ROOMS_MANAGE')">
                    <li>
                        <a href="#">Master Rooms Management <span class="sub-arrow">&#8250;</span></a>
                        <ul class="second-level">
                            <li><a href="view_add_room_category_form">Add Room</a></li>
                            <li><a href="view_rooms_list">Manage Rooms</a></li>
                        </ul>
                    </li>
                </sec:authorize>
            </ul>
        </li>

        <sec:authorize access="hasAnyRole('ADMIN','COST_MANAGE')">
            <li class="nav-item">
                <a href="#" class="nav-btn">Costing <span class="nav-arrow">&#9662;</span></a>
                <ul class="submenu">
                    <li>
                        <a href="#">Session <span class="sub-arrow">&#8250;</span></a>
                        <ul class="second-level">
                            <li><a href="view_add_session_form">Add Session</a></li>
                            <li><a href="view_session_list">Manage Sessions</a></li>
                        </ul>
                    </li>
                </ul>
            </li>
        </sec:authorize>

        <li class="nav-item">
            <a href="#" class="nav-btn">Quotations <span class="nav-arrow">&#9662;</span></a>
            <ul class="submenu">
                <li><a href="view_add_quotation_form">New System Quotation</a></li>
                <li><a href="view_add_free_hand_quotation_form" class="badge-highlight">&#9733; New Free Hand Quotation</a></li>
            </ul>
        </li>

        <sec:authorize access="hasAnyRole('ADMIN','EVENT_MANAGE')">
            <li class="nav-item">
                <a href="#" class="nav-btn">Events <span class="nav-arrow">&#9662;</span></a>
                <ul class="submenu">
                    <li>
                        <a href="#">Event Services <span class="sub-arrow">&#8250;</span></a>
                        <ul class="second-level">
                            <li><a href="view_event_quotation_form_wiz1">Create Event Quotation</a></li>
                            <li><a href="view_filter_events">Manage Events</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">Master Service <span class="sub-arrow">&#8250;</span></a>
                        <ul class="second-level">
                            <li><a href="view_add_master_service_form">Add Master Service</a></li>
                            <li><a href="view_master_service_list">Manage Services</a></li>
                        </ul>
                    </li>
                </ul>
            </li>
        </sec:authorize>

        <sec:authorize access="hasAnyRole('SUPERADMIN','EXPENSE_APPROVER','CAN_CLAIM')">
            <li class="nav-item">
                <a href="#" class="nav-btn">My Claims <span class="nav-arrow">&#9662;</span></a>
                <ul class="submenu">
                    <li>
                        <sec:authorize access="hasAnyRole('CAN_CLAIM')">
                            <a href="view_add_travel_claim_form">New Travel Claim</a>
                        </sec:authorize>
                        <a href="view_travel_claim_list?view_travelclaimlist">Manage Travel Claims</a>
                    </li>
                </ul>
            </li>
        </sec:authorize>

        <sec:authorize access="hasAnyRole('ADMIN','ASSET_MANAGER','ASSET_ALLOWED')">
            <li class="nav-item">
                <a href="#" class="nav-btn">Assets <span class="nav-arrow">&#9662;</span></a>
                <ul class="submenu">
                    <li>
                        <a href="#">Asset <span class="sub-arrow">&#8250;</span></a>
                        <ul class="second-level">
                            <sec:authorize access="hasAnyRole('ADMIN','ASSET_MANAGER')">
                                <li><a href="${pageContext.request.contextPath}/add_asset">Add Asset</a></li>
                            </sec:authorize>
                            <li><a href="${pageContext.request.contextPath}/view_assets_list">Manage Assets</a></li>
                        </ul>
                    </li>
                    <sec:authorize access="hasAnyRole('ADMIN','ASSET_MANAGER')">
                        <li>
                            <a href="#">Category <span class="sub-arrow">&#8250;</span></a>
                            <ul class="second-level">
                                <li><a href="${pageContext.request.contextPath}/categories_add">Add Category</a></li>
                                <li><a href="${pageContext.request.contextPath}/categories_manage">Manage Categories</a></li>
                            </ul>
                        </li>
                    </sec:authorize>
                </ul>
            </li>
        </sec:authorize>

        <sec:authorize access="hasAnyRole('ADMIN','DOCUMENT_MANAGER')">
            <li class="nav-item">
                <a href="#" class="nav-btn">Documents <span class="nav-arrow">&#9662;</span></a>
                <ul class="submenu">
                    <li>
                        <a href="#">Documents <span class="sub-arrow">&#8250;</span></a>
                        <ul class="second-level">
                            <li><a href="${pageContext.request.contextPath}/add_document">Add Document</a></li>
                            <li><a href="${pageContext.request.contextPath}/view_documents_list">Manage Documents</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">Category <span class="sub-arrow">&#8250;</span></a>
                        <ul class="second-level">
                            <li><a href="${pageContext.request.contextPath}/add_documentcategory">Add Category</a></li>
                            <li><a href="${pageContext.request.contextPath}/manage_documentcategories">Manage Categories</a></li>
                        </ul>
                    </li>
                </ul>
            </li>
        </sec:authorize>

        <sec:authorize access="hasAnyRole('DOCUMENT_ALLOWED','RESTRICTED_DOC_ACCESS')">
            <li class="nav-item">
                <a href="#" class="nav-btn">Knowledge <span class="nav-arrow">&#9662;</span></a>
                <ul class="submenu">
                    <li><a href="${pageContext.request.contextPath}/view_documents_list">Manage Documents</a></li>
                </ul>
            </li>
        </sec:authorize>

        <li class="nav-item nav-right-actions">
            <a href="logout" class="nav-btn nav-btn-logout">Logout</a>
        </li>
        <li class="nav-item">
            <a href="view_form_my_profile" class="nav-btn nav-btn-profile" title="My Profile">
                <span class="gear-icon">&#9881;</span>
            </a>
        </li>
    </ul>
</nav>

