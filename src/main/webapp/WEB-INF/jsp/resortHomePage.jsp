<%--=====AI MODIFICATION START=====Change: Complete dashboard redesign with lead analytics charts Reason: Dashboard now
    shows graphical lead analytics with role-based data. Admin/Lead Manager sees ALL leads data. Normal user sees only
    THEIR leads. Uses Chart.js (CDN) for doughnut chart and bar chart. Scope: resortHomePage.jsp — the main dashboard
    after login --%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
            <jsp:include page="_menu_builder_header.jsp" />

            <!-- Chart.js CDN — lightweight charting library -->
            <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>

            <style>
                /* ===== Dashboard Styles ===== */
                .gs-dashboard {
                    max-width: 1100px;
                    margin: 0 auto;
                    padding: var(--gs-space-6, 24px);
                    animation: gsPageFadeIn 0.4s ease;
                }

                @keyframes gsPageFadeIn {
                    from {
                        opacity: 0;
                        transform: translateY(8px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                /* Welcome Card */
                .gs-welcome-card {
                    background: linear-gradient(135deg, var(--gs-charcoal, #1B2A3D) 0%, var(--gs-charcoal-light, #243447) 100%);
                    color: #F0EDE8;
                    border-radius: var(--gs-radius-lg, 12px);
                    padding: 36px 32px;
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    position: relative;
                    overflow: hidden;
                    box-shadow: var(--gs-shadow-elevated, 0 4px 12px rgba(27, 42, 61, 0.08));
                    margin-bottom: 28px;
                }

                .gs-welcome-card::before {
                    content: '';
                    position: absolute;
                    top: -30%;
                    right: -10%;
                    width: 250px;
                    height: 250px;
                    background: radial-gradient(circle, rgba(201, 168, 76, 0.08) 0%, transparent 70%);
                    pointer-events: none;
                }

                .gs-welcome-left h1 {
                    font-family: var(--gs-font-heading, 'Playfair Display', serif);
                    font-size: 1.6rem;
                    color: #FFFFFF;
                    margin-bottom: 6px;
                    font-weight: 600;
                }

                .gs-welcome-left h1 span {
                    color: var(--gs-gold, #C9A84C);
                }

                .gs-welcome-subtitle {
                    font-size: 0.9rem;
                    color: var(--gs-beige, #E8E4DE);
                    font-weight: 300;
                    opacity: 0.85;
                }

                .gs-welcome-right {
                    text-align: right;
                    z-index: 1;
                }

                .gs-welcome-hotel {
                    font-family: var(--gs-font-heading, 'Playfair Display', serif);
                    font-size: 1.1rem;
                    color: var(--gs-gold-light, #D4B96A);
                    font-weight: 500;
                }

                .gs-welcome-role {
                    font-size: 0.75rem;
                    color: var(--gs-beige, #E8E4DE);
                    opacity: 0.7;
                    margin-top: 4px;
                    text-transform: uppercase;
                    letter-spacing: 0.08em;
                }

                /* Stats Cards Row */
                .gs-stats-row {
                    display: grid;
                    grid-template-columns: repeat(3, 1fr);
                    gap: 16px;
                    margin-bottom: 28px;
                }

                .gs-stat-card {
                    background: var(--gs-white, #FFFFFF);
                    border: 1px solid var(--gs-beige, #E8E4DE);
                    border-radius: var(--gs-radius-md, 8px);
                    padding: 20px;
                    display: flex;
                    align-items: center;
                    gap: 16px;
                    transition: all 0.25s ease;
                    border-left: 3px solid transparent;
                }

                .gs-stat-card:hover {
                    box-shadow: var(--gs-shadow-elevated, 0 4px 12px rgba(27, 42, 61, 0.08));
                    border-left-color: var(--gs-gold, #C9A84C);
                }

                .gs-stat-icon {
                    width: 48px;
                    height: 48px;
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 1.3rem;
                    flex-shrink: 0;
                }

                .gs-stat-icon-total {
                    background: rgba(201, 168, 76, 0.12);
                }

                .gs-stat-icon-qualified {
                    background: rgba(61, 139, 110, 0.12);
                }

                .gs-stat-icon-flagged {
                    background: rgba(184, 68, 68, 0.1);
                }

                .gs-stat-value {
                    font-size: 1.8rem;
                    font-weight: 700;
                    color: var(--gs-charcoal, #1B2A3D);
                    line-height: 1.1;
                }

                .gs-stat-label {
                    font-size: 0.75rem;
                    color: var(--gs-text-muted, #8C8A87);
                    text-transform: uppercase;
                    letter-spacing: 0.06em;
                    margin-top: 2px;
                }

                /* Charts Row */
                .gs-charts-row {
                    display: grid;
                    grid-template-columns: 1fr 1.5fr;
                    gap: 20px;
                    margin-bottom: 28px;
                }

                .gs-chart-card {
                    background: var(--gs-white, #FFFFFF);
                    border: 1px solid var(--gs-beige, #E8E4DE);
                    border-radius: var(--gs-radius-md, 8px);
                    padding: 24px;
                    box-shadow: var(--gs-shadow-card, 0 1px 3px rgba(27, 42, 61, 0.06));
                }

                .gs-chart-title {
                    font-family: var(--gs-font-heading, 'Playfair Display', serif);
                    font-size: 1rem;
                    font-weight: 600;
                    color: var(--gs-charcoal, #1B2A3D);
                    margin-bottom: 16px;
                    padding-bottom: 10px;
                    border-bottom: 1px solid var(--gs-beige, #E8E4DE);
                }

                .gs-chart-container {
                    position: relative;
                    width: 100%;
                    max-height: 260px;
                }

                .gs-chart-container canvas {
                    max-height: 260px;
                }

                /* Quick Actions Row */
                .gs-actions-title {
                    font-family: var(--gs-font-heading, 'Playfair Display', serif);
                    font-size: 1.1rem;
                    color: var(--gs-charcoal, #1B2A3D);
                    margin-bottom: 16px;
                    font-weight: 600;
                }

                .gs-quick-actions {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
                    gap: 14px;
                }

                .gs-action-card {
                    background: var(--gs-white, #FFFFFF);
                    border: 1px solid var(--gs-beige, #E8E4DE);
                    border-radius: var(--gs-radius-md, 8px);
                    padding: 20px 16px;
                    text-align: center;
                    text-decoration: none;
                    color: var(--gs-text-primary, #2D3748);
                    transition: all 0.25s ease;
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    gap: 10px;
                    border-left: 3px solid transparent;
                }

                .gs-action-card:hover {
                    border-left-color: var(--gs-gold, #C9A84C);
                    box-shadow: var(--gs-shadow-elevated, 0 4px 12px rgba(27, 42, 61, 0.08));
                    transform: translateY(-2px);
                    color: var(--gs-text-primary, #2D3748);
                }

                .gs-action-icon {
                    width: 42px;
                    height: 42px;
                    background: rgba(201, 168, 76, 0.1);
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 1.2rem;
                    transition: all 0.25s ease;
                }

                .gs-action-card:hover .gs-action-icon {
                    background: var(--gs-gold, #C9A84C);
                    transform: scale(1.08);
                }

                .gs-action-title {
                    font-weight: 500;
                    font-size: 0.85rem;
                }

                .gs-action-desc {
                    font-size: 0.72rem;
                    color: var(--gs-text-muted, #8C8A87);
                    line-height: 1.3;
                }

                .gs-no-data {
                    text-align: center;
                    padding: 40px;
                    color: var(--gs-text-muted, #8C8A87);
                    font-size: 0.9rem;
                }

                /* Responsive */
                @media (max-width: 768px) {
                    .gs-dashboard {
                        padding: 16px;
                    }

                    .gs-welcome-card {
                        flex-direction: column;
                        text-align: center;
                        padding: 24px;
                    }

                    .gs-welcome-right {
                        text-align: center;
                        margin-top: 12px;
                    }

                    .gs-stats-row {
                        grid-template-columns: 1fr;
                    }

                    .gs-charts-row {
                        grid-template-columns: 1fr;
                    }

                    .gs-quick-actions {
                        grid-template-columns: 1fr 1fr;
                    }
                }
            </style>

            <div class="gs-dashboard">

                <!-- Welcome Card -->
                <div class="gs-welcome-card">
                    <div class="gs-welcome-left">
                        <h1>Welcome, <span>${empty userDisplayName ? userName : userDisplayName}</span></h1>
                        <p class="gs-welcome-subtitle">
                            <c:choose>
                                <c:when test="${empty hotelName}">AxisHMS Pro Dashboard</c:when>
                                <c:otherwise>${hotelName} - Dashboard</c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                    <div class="gs-welcome-right">
                        <c:if test="${not empty hotelName}">
                            <p class="gs-welcome-hotel">${hotelName}</p>
                        </c:if>
                        <p class="gs-welcome-role">
                            <c:choose>
                                <c:when test="${showAllLeads}">&#9733; Administrator View</c:when>
                                <c:otherwise>&#128100; My Dashboard</c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>

                <!-- Stats Cards -->
                <div class="gs-stats-row">
                    <div class="gs-stat-card">
                        <div class="gs-stat-icon gs-stat-icon-total">&#128203;</div>
                        <div>
                            <div class="gs-stat-value">${totalLeads}</div>
                            <div class="gs-stat-label">${showAllLeads ? 'Total Leads' : 'My Leads'}</div>
                        </div>
                    </div>
                    <div class="gs-stat-card">
                        <div class="gs-stat-icon gs-stat-icon-qualified">&#10003;</div>
                        <div>
                            <div class="gs-stat-value">${qualifiedLeads}</div>
                            <div class="gs-stat-label">Qualified</div>
                        </div>
                    </div>
                    <div class="gs-stat-card">
                        <div class="gs-stat-icon gs-stat-icon-flagged">&#9873;</div>
                        <div>
                            <div class="gs-stat-value">${flaggedLeads}</div>
                            <div class="gs-stat-label">Flagged</div>
                        </div>
                    </div>
                </div>

                <!-- Charts Row -->
                <div class="gs-charts-row">

                    <!-- Doughnut Chart — Lead Status Distribution -->
                    <div class="gs-chart-card">
                        <div class="gs-chart-title">Lead Status Distribution</div>
                        <div class="gs-chart-container">
                            <canvas id="statusDoughnutChart"></canvas>
                        </div>
                    </div>

                    <!-- Bar Chart — Leads by Status -->
                    <div class="gs-chart-card">
                        <div class="gs-chart-title">${showAllLeads ? 'All Leads' : 'My Leads'} - Status Breakdown</div>
                        <div class="gs-chart-container">
                            <canvas id="statusBarChart"></canvas>
                        </div>
                    </div>

                </div>

                <!-- Quick Actions -->
                <h3 class="gs-actions-title">Quick Actions</h3>
                <div class="gs-quick-actions">
                    <a href="view_add_lead_form" class="gs-action-card">
                        <div class="gs-action-icon">&#128100;</div>
                        <div class="gs-action-title">New Lead</div>
                        <div class="gs-action-desc">Create a new guest lead</div>
                    </a>
                    <a href="view_filter_leads" class="gs-action-card">
                        <div class="gs-action-icon">&#128269;</div>
                        <div class="gs-action-title">Manage Leads</div>
                        <div class="gs-action-desc">View & filter all leads</div>
                    </a>
                    <a href="view_add_quotation_form" class="gs-action-card">
                        <div class="gs-action-icon">&#128196;</div>
                        <div class="gs-action-title">System Quotation</div>
                        <div class="gs-action-desc">Create a system quotation</div>
                    </a>
                    <a href="view_add_free_hand_quotation_form" class="gs-action-card">
                        <div class="gs-action-icon">&#9997;</div>
                        <div class="gs-action-title">Freehand Quotation</div>
                        <div class="gs-action-desc">Create a freehand quotation</div>
                    </a>
                    <sec:authorize access="hasAnyRole('ADMIN')">
                        <a href="view_central_config" class="gs-action-card">
                            <div class="gs-action-icon">&#9881;</div>
                            <div class="gs-action-title">Settings</div>
                            <div class="gs-action-desc">Central configuration</div>
                        </a>
                    </sec:authorize>
                </div>

            </div>

            <!-- Chart.js Scripts -->
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    // Data from server
                    var statusLabels = ${ statusLabels };
                    var statusCounts = ${ statusCounts };

                    // Grand Suite color palette for charts
                    var chartColors = [
                        '#C9A84C', // Gold
                        '#1B2A3D', // Charcoal
                        '#3D8B6E', // Sage Green
                        '#7C2D3E', // Burgundy
                        '#3B82A0', // Teal blue
                        '#D4932A', // Amber
                        '#8B5CF6', // Violet
                        '#B84444', // Muted red
                        '#E8E4DE', // Beige
                        '#5A6577'  // Grey
                    ];

                    var chartBorderColors = chartColors.map(function (c) { return c; });

                    // Only render charts if there is data
                    if (statusLabels.length > 0 && statusCounts.some(function (v) { return v > 0; })) {

                        // ===== Doughnut Chart =====
                        var doughnutCtx = document.getElementById('statusDoughnutChart').getContext('2d');
                        new Chart(doughnutCtx, {
                            type: 'doughnut',
                            data: {
                                labels: statusLabels,
                                datasets: [{
                                    data: statusCounts,
                                    backgroundColor: chartColors.slice(0, statusLabels.length),
                                    borderColor: '#FFFFFF',
                                    borderWidth: 2,
                                    hoverBorderWidth: 3,
                                    hoverOffset: 6
                                }]
                            },
                            options: {
                                responsive: true,
                                maintainAspectRatio: false,
                                cutout: '55%',
                                plugins: {
                                    legend: {
                                        position: 'bottom',
                                        labels: {
                                            padding: 12,
                                            usePointStyle: true,
                                            pointStyle: 'circle',
                                            font: { family: "'DM Sans', sans-serif", size: 11 }
                                        }
                                    },
                                    tooltip: {
                                        backgroundColor: '#1B2A3D',
                                        titleFont: { family: "'DM Sans', sans-serif" },
                                        bodyFont: { family: "'DM Sans', sans-serif" },
                                        cornerRadius: 6,
                                        padding: 10
                                    }
                                }
                            }
                        });

                        // ===== Bar Chart =====
                        var barCtx = document.getElementById('statusBarChart').getContext('2d');
                        new Chart(barCtx, {
                            type: 'bar',
                            data: {
                                labels: statusLabels,
                                datasets: [{
                                    label: 'Leads',
                                    data: statusCounts,
                                    backgroundColor: chartColors.slice(0, statusLabels.length).map(function (c) {
                                        return c + '99'; // Add transparency
                                    }),
                                    borderColor: chartColors.slice(0, statusLabels.length),
                                    borderWidth: 1.5,
                                    borderRadius: 4,
                                    borderSkipped: false
                                }]
                            },
                            options: {
                                responsive: true,
                                maintainAspectRatio: false,
                                scales: {
                                    y: {
                                        beginAtZero: true,
                                        ticks: {
                                            stepSize: 1,
                                            font: { family: "'DM Sans', sans-serif", size: 11 }
                                        },
                                        grid: { color: 'rgba(232, 228, 222, 0.5)' }
                                    },
                                    x: {
                                        ticks: {
                                            font: { family: "'DM Sans', sans-serif", size: 10 },
                                            maxRotation: 45
                                        },
                                        grid: { display: false }
                                    }
                                },
                                plugins: {
                                    legend: { display: false },
                                    tooltip: {
                                        backgroundColor: '#1B2A3D',
                                        titleFont: { family: "'DM Sans', sans-serif" },
                                        bodyFont: { family: "'DM Sans', sans-serif" },
                                        cornerRadius: 6,
                                        padding: 10
                                    }
                                }
                            }
                        });

                    } else {
                        // No data — show message
                        document.getElementById('statusDoughnutChart').parentElement.innerHTML =
                            '<div class="gs-no-data">No lead data available yet.</div>';
                        document.getElementById('statusBarChart').parentElement.innerHTML =
                            '<div class="gs-no-data">No lead data available yet.</div>';
                    }
                });
            </script>

            <%--=====AI MODIFICATION END=====--%>

                <jsp:include page="footer.jsp" />