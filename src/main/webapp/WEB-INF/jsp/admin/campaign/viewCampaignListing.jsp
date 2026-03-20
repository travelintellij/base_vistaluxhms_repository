<jsp:include page="../../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
                    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">

                    <style>
                        body {
                            background-image: url('<%= request.getContextPath() %>/resources/images/Ads_manager.png');
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
                            background: rgba(15, 52, 96, 0.85);
                            /* 
                             * UI Refinement (listing page):
                             * Darker overlay for better contrast on listing page.
                             * The list is now filtered/sorted by creation date 
                             * and shows active/inactive toggles for campaigns.
                             */
                            z-index: -1;
                        }

                        .campaign-wrapper {
                            max-width: 1100px;
                            margin: 20px auto;
                            padding: 0 15px;
                        }

                        .campaign-header {
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            margin-bottom: 20px;
                        }

                        .campaign-header h2 {
                            color: #fff;
                            font-size: 26px;
                            margin: 0;
                        }

                        .campaign-header .action-buttons a {
                            text-decoration: none;
                            padding: 10px 20px;
                            border-radius: 6px;
                            font-weight: 600;
                            font-size: 14px;
                            margin-left: 10px;
                            display: inline-block;
                            transition: transform 0.2s, box-shadow 0.3s;
                        }

                        .btn-meta {
                            background: linear-gradient(135deg, #0f3460, #e94560);
                            color: white !important;
                        }

                        .btn-google {
                            background: linear-gradient(135deg, #4285f4, #34a853);
                            color: white !important;
                        }

                        .btn-meta:hover,
                        .btn-google:hover {
                            transform: translateY(-2px);
                            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
                        }

                        .campaign-stats {
                            display: flex;
                            gap: 15px;
                            margin-bottom: 20px;
                        }

                        .stat-card {
                            flex: 1;
                            background: rgba(255, 255, 255, 0.1);
                            backdrop-filter: blur(10px);
                            border: 1px solid rgba(255, 255, 255, 0.15);
                            border-radius: 10px;
                            padding: 20px;
                            text-align: center;
                        }

                        .stat-card .stat-number {
                            font-size: 36px;
                            font-weight: 700;
                            color: #fff;
                        }

                        .stat-card .stat-label {
                            font-size: 13px;
                            color: rgba(255, 255, 255, 0.7);
                            margin-top: 5px;
                        }

                        .stat-card.meta {
                            border-top: 3px solid #e94560;
                        }

                        .stat-card.google {
                            border-top: 3px solid #34a853;
                        }

                        .stat-card.total {
                            border-top: 3px solid #f0ad4e;
                        }

                        .campaign-table-wrapper {
                            background: rgba(255, 255, 255, 0.95);
                            border-radius: 12px;
                            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
                            overflow: hidden;
                        }

                        .campaign-table-wrapper table {
                            width: 100%;
                            border-collapse: collapse;
                            margin: 0;
                            box-shadow: none;
                        }

                        .campaign-table-wrapper table thead {
                            background: linear-gradient(135deg, #0f3460, #16213e);
                        }

                        .campaign-table-wrapper table thead th {
                            padding: 14px 16px;
                            color: white;
                            font-size: 14px;
                            font-weight: 600;
                            text-align: left;
                            border-bottom: none;
                        }

                        .campaign-table-wrapper table tbody td {
                            padding: 12px 16px;
                            font-size: 14px;
                            color: #333;
                            border-bottom: 1px solid #eee;
                        }

                        .campaign-table-wrapper table tbody tr:hover {
                            background: #f0f8ff;
                        }

                        .badge-meta {
                            background: linear-gradient(135deg, #0f3460, #e94560);
                            color: white;
                            padding: 4px 12px;
                            border-radius: 20px;
                            font-size: 11px;
                            font-weight: 600;
                        }

                        .badge-google {
                            background: linear-gradient(135deg, #4285f4, #34a853);
                            color: white;
                            padding: 4px 12px;
                            border-radius: 20px;
                            font-size: 11px;
                            font-weight: 600;
                        }

                        .badge-active {
                            background: #28a745;
                            color: white;
                            padding: 3px 10px;
                            border-radius: 20px;
                            font-size: 11px;
                        }

                        .badge-inactive {
                            background: #dc3545;
                            color: white;
                            padding: 3px 10px;
                            border-radius: 20px;
                            font-size: 11px;
                        }

                        .edit-link {
                            color: #0f3460;
                            font-weight: 600;
                            text-decoration: none;
                            padding: 5px 12px;
                            border: 1px solid #0f3460;
                            border-radius: 4px;
                            transition: all 0.2s;
                            font-size: 12px;
                        }

                        .edit-link:hover {
                            background: #0f3460;
                            color: white;
                        }

                        .toggle-link {
                            font-weight: 600;
                            text-decoration: none;
                            padding: 5px 12px;
                            border-radius: 4px;
                            transition: all 0.2s;
                            font-size: 12px;
                            cursor: pointer;
                        }

                        .toggle-deactivate {
                            color: #dc3545;
                            border: 1px solid #dc3545;
                        }

                        .toggle-deactivate:hover {
                            background: #dc3545;
                            color: white;
                        }

                        .toggle-activate {
                            color: #28a745;
                            border: 1px solid #28a745;
                        }

                        .toggle-activate:hover {
                            background: #28a745;
                            color: white;
                        }

                        .delete-link {
                            color: #dc3545;
                            font-weight: 600;
                            text-decoration: none;
                            padding: 5px 12px;
                            border: 1px solid #dc3545;
                            border-radius: 4px;
                            transition: all 0.2s;
                            font-size: 12px;
                            cursor: pointer;
                        }

                        .delete-link:hover {
                            background: #dc3545;
                            color: white;
                        }

                        .empty-state {
                            text-align: center;
                            padding: 60px 20px;
                            color: #888;
                        }

                        .empty-state h3 {
                            font-size: 20px;
                            color: #555;
                            margin-bottom: 10px;
                        }

                        .empty-state p {
                            font-size: 14px;
                        }

                        .success-msg {
                            background: #d4edda;
                            color: #155724;
                            padding: 12px 20px;
                            border-radius: 8px;
                            margin-bottom: 15px;
                            text-align: center;
                            font-weight: 500;
                        }
                    </style>

                    <div class="campaign-wrapper">

                        <c:if test="${not empty Success}">
                            <div class="success-msg">${Success}</div>
                        </c:if>

                        <div class="campaign-header">
                            <h2>Campaign Management</h2>
                            <div class="action-buttons">
                                <a href="view_add_meta_form" class="edit-btn">+ Add Meta Form</a>
                            </div>
                        </div>

                        <div class="campaign-stats">
                            <div class="stat-card total">
                                <div class="stat-number">${fn:length(CAMPAIGN_FORM_LIST)}</div>
                                <div class="stat-label">Total Campaign Forms</div>
                            </div>
                        </div>

                        <div class="campaign-table-wrapper">
                            <c:choose>
                                <c:when test="${empty CAMPAIGN_FORM_LIST}">
                                    <div class="empty-state">
                                        <h3>No Campaign Forms Added Yet</h3>
                                        <p>Click the button above to add your first Meta Form ID.</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Form Name</th>
                                                <th>Form ID</th>
                                                <th>Campaign</th>
                                                <th>Status</th>
                                                <th>Created</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${CAMPAIGN_FORM_LIST}" var="form" varStatus="loop">
                                                <tr>
                                                    <td>${loop.index + 1}</td>
                                                    <td><strong>${form.formName}</strong></td>

                                                    <td style="font-family:monospace;font-size:12px;">
                                                        ${fn:substring(form.formId, 0, 20)}${fn:length(form.formId) > 20
                                                        ? '...' : ''}</td>
                                                    <td>${form.campaignName}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${form.active}">
                                                                <span class="badge-active">Active</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge-inactive">Inactive</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <fmt:formatDate value="${form.createdAt}"
                                                            pattern="dd MMM yyyy" />
                                                    </td>
                                                    <td style="white-space:nowrap;">
                                                        <c:choose>
                                                            <c:when test="${form.active}">
                                                                <a href="toggle_campaign_form_status?campaignFormId=${form.campaignFormId}"
                                                                    class="delete-btn">Deactivate</a>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <a href="toggle_campaign_form_status?campaignFormId=${form.campaignFormId}"
                                                                    class="edit-btn">Activate</a>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <a href="view_edit_campaign_form?campaignFormId=${form.campaignFormId}"
                                                            class="view-btn">Edit</a>
                                                        <a href="delete_campaign_form?campaignFormId=${form.campaignFormId}"
                                                            class="delete-btn"
                                                            onclick="return confirm('Are you sure you want to delete this form?');">Delete</a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <jsp:include page="../../footer.jsp" />