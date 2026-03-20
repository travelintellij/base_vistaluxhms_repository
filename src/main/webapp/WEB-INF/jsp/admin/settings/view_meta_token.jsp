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

                    /* ===== SETUP GUIDE STYLES ===== */
                    .guide-container {
                        width: 70%;
                        margin: 30px auto 40px;
                    }

                    .guide-toggle-btn {
                        width: 100%;
                        background: linear-gradient(135deg, #0f3460 0%, #16213e 100%);
                        color: #fff;
                        border: none;
                        padding: 16px 25px;
                        border-radius: 10px;
                        font-size: 16px;
                        font-weight: 600;
                        cursor: pointer;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        transition: all 0.3s ease;
                        box-shadow: 0 4px 15px rgba(15, 52, 96, 0.3);
                    }

                    .guide-toggle-btn:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 6px 20px rgba(15, 52, 96, 0.4);
                    }

                    .guide-toggle-btn .arrow {
                        font-size: 18px;
                        transition: transform 0.3s ease;
                    }

                    .guide-toggle-btn.active .arrow {
                        transform: rotate(180deg);
                    }

                    .guide-panel {
                        display: none;
                        background: #fff;
                        border-radius: 0 0 10px 10px;
                        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
                        overflow: hidden;
                        margin-top: -5px;
                    }

                    .guide-panel.open {
                        display: block;
                        animation: slideDown 0.3s ease;
                    }

                    @keyframes slideDown {
                        from { opacity: 0; max-height: 0; }
                        to { opacity: 1; max-height: 2000px; }
                    }

                    .guide-inner {
                        padding: 25px 30px 30px;
                    }

                    .step-card {
                        background: #f8f9fb;
                        border: 1px solid #e8ecf1;
                        border-left: 4px solid #0f3460;
                        border-radius: 0 8px 8px 0;
                        padding: 18px 20px;
                        margin-bottom: 16px;
                        position: relative;
                        transition: all 0.2s ease;
                    }

                    .step-card:hover {
                        background: #f0f4f9;
                        border-left-color: #e94560;
                        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
                    }

                    .step-card:last-child {
                        margin-bottom: 0;
                    }

                    .step-number {
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        width: 28px;
                        height: 28px;
                        background: linear-gradient(135deg, #0f3460, #e94560);
                        color: #fff;
                        border-radius: 50%;
                        font-size: 13px;
                        font-weight: 700;
                        margin-right: 10px;
                        flex-shrink: 0;
                    }

                    .step-title {
                        font-weight: 600;
                        color: #2c3e50;
                        font-size: 15px;
                        display: flex;
                        align-items: center;
                        margin-bottom: 10px;
                    }

                    .step-desc {
                        color: #555;
                        font-size: 13.5px;
                        line-height: 1.7;
                        margin-left: 38px;
                    }

                    .step-desc a {
                        color: #0f3460;
                        font-weight: 600;
                        text-decoration: none;
                        border-bottom: 1px dashed #0f3460;
                        transition: all 0.2s;
                    }

                    .step-desc a:hover {
                        color: #e94560;
                        border-bottom-color: #e94560;
                    }

                    .step-desc code {
                        background: #e8ecf1;
                        padding: 2px 7px;
                        border-radius: 4px;
                        font-family: 'Courier New', monospace;
                        font-size: 12.5px;
                        color: #c0392b;
                    }

                    .step-desc ul {
                        margin: 6px 0 0 0;
                        padding-left: 18px;
                    }

                    .step-desc ul li {
                        margin-bottom: 4px;
                    }

                    .guide-warning {
                        background: #fff8e1;
                        border: 1px solid #ffe082;
                        border-radius: 8px;
                        padding: 14px 18px;
                        font-size: 13px;
                        color: #7a6100;
                        margin-top: 18px;
                        display: flex;
                        align-items: flex-start;
                        gap: 10px;
                    }

                    .guide-warning .warn-icon {
                        font-size: 20px;
                        flex-shrink: 0;
                    }

                    .guide-section-title {
                        font-size: 14px;
                        font-weight: 700;
                        color: #0f3460;
                        text-transform: uppercase;
                        letter-spacing: 1px;
                        margin: 0 0 14px 0;
                        padding-bottom: 8px;
                        border-bottom: 2px solid #e8ecf1;
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

                <!-- ===== SETUP GUIDE SECTION ===== -->
                <div class="guide-container">
                    <button type="button" class="guide-toggle-btn" id="guideToggleBtn" onclick="toggleGuide()">
                        <span>&#128218; Setup Guide &mdash; How to Get Page ID, Access Token &amp; Form ID</span>
                        <span class="arrow">&#9660;</span>
                    </button>
                    <div class="guide-panel" id="guidePanel">
                        <div class="guide-inner">

                            <!-- SECTION 1: Page ID -->
                            <div class="guide-section-title">&#9312; Getting Your Page ID</div>

                            <div class="step-card">
                                <div class="step-title"><span class="step-number">1</span> Open your Facebook Page</div>
                                <div class="step-desc">
                                    Go to your Facebook Business Page. Click on <strong>About</strong> or <strong>Page Transparency</strong> in the left sidebar.
                                </div>
                            </div>

                            <div class="step-card">
                                <div class="step-title"><span class="step-number">2</span> Find the Page ID</div>
                                <div class="step-desc">
                                    Scroll down to the <strong>"Page Transparency"</strong> section and click <strong>"See all"</strong>. Your Page ID will be listed at the bottom. Copy it and paste it in the <strong>Page ID</strong> field above.
                                    <br><br>
                                    <strong>Alternative:</strong> Open <a href="https://business.facebook.com/settings/" target="_blank">Meta Business Suite &rarr; Settings</a>, select your page, and the Page ID will be shown next to the page name.
                                </div>
                            </div>

                            <!-- SECTION 2: Permanent Access Token -->
                            <div class="guide-section-title" style="margin-top: 25px;">&#9313; Getting a Permanent Access Token</div>

                            <div class="step-card">
                                <div class="step-title"><span class="step-number">1</span> Open Graph API Explorer</div>
                                <div class="step-desc">
                                    Go to <a href="https://developers.facebook.com/tools/explorer/" target="_blank">Meta Graph API Explorer</a>. Select your <strong>App</strong> from the dropdown at the top right.
                                </div>
                            </div>

                            <div class="step-card">
                                <div class="step-title"><span class="step-number">2</span> Generate a User Token</div>
                                <div class="step-desc">
                                    Click <strong>"Generate Access Token"</strong>. When prompted, grant these permissions:
                                    <ul>
                                        <li><code>pages_show_list</code></li>
                                        <li><code>pages_read_engagement</code></li>
                                        <li><code>leads_retrieval</code></li>
                                        <li><code>pages_manage_ads</code></li>
                                        <li><code>ads_management</code></li>
                                    </ul>
                                    This generates a <strong>short-lived User Access Token</strong> (expires in ~1 hour). We need to convert this to a permanent one.
                                </div>
                            </div>

                            <div class="step-card">
                                <div class="step-title"><span class="step-number">3</span> Exchange for Long-Lived User Token</div>
                                <div class="step-desc">
                                    Open the <a href="https://developers.facebook.com/tools/debug/accesstoken/" target="_blank">Access Token Debugger</a>. Paste your short-lived token and click <strong>"Debug"</strong>. Then click <strong>"Extend Access Token"</strong> at the bottom. Copy the new long-lived token (valid for ~60 days).
                                </div>
                            </div>

                            <div class="step-card">
                                <div class="step-title"><span class="step-number">4</span> Get the Permanent Page Access Token</div>
                                <div class="step-desc">
                                    Go back to <a href="https://developers.facebook.com/tools/explorer/" target="_blank">Graph API Explorer</a>. Paste the long-lived user token in the <strong>Access Token</strong> field. In the query box, type:
                                    <br><br>
                                    <code>me/accounts</code>
                                    <br><br>
                                    Click <strong>Submit</strong>. You will see a list of your pages. Find your page and copy the <code>access_token</code> value &mdash; <strong>this is your Permanent Page Access Token</strong>. It never expires.
                                    <br><br>
                                    You can verify by pasting it in the <a href="https://developers.facebook.com/tools/debug/accesstoken/" target="_blank">Token Debugger</a> &mdash; it should show <strong>"Expires: Never"</strong>.
                                </div>
                            </div>

                            <!-- SECTION 3: Form ID -->
                            <div class="guide-section-title" style="margin-top: 25px;">&#9314; Getting Your Lead Form ID</div>

                            <div class="step-card">
                                <div class="step-title"><span class="step-number">1</span> Query your Page's Lead Forms</div>
                                <div class="step-desc">
                                    In the <a href="https://developers.facebook.com/tools/explorer/" target="_blank">Graph API Explorer</a>, paste your <strong>Permanent Page Access Token</strong>. Then enter:
                                    <br><br>
                                    <code>{your-page-id}/leadgen_forms</code>
                                    <br><br>
                                    Replace <code>{your-page-id}</code> with your actual Page ID. Click <strong>Submit</strong>.
                                    <br><br>
                                    You will see a list of all your lead forms with their <code>id</code> and <code>name</code> fields. Copy the <code>id</code> of the form you want to use.
                                </div>
                            </div>

                            <div class="step-card">
                                <div class="step-title"><span class="step-number">2</span> Add It as a Campaign Form</div>
                                <div class="step-desc">
                                    Go to <strong>Campaign Management</strong> in the menu above and create a new Campaign Form. Paste the Form ID there, give it a name, and set it to <strong>Active</strong>. It will now appear in the "Sync Leads" dropdown on the Leads page.
                                </div>
                            </div>

                            <!-- Warning -->
                            <div class="guide-warning">
                                <span class="warn-icon">&#9888;&#65039;</span>
                                <div>
                                    <strong>Important:</strong> Always use a <strong>Permanent Page Access Token</strong> (not a User or Short-Lived token). Temporary tokens expire and will break lead syncing. If the token ever stops working, repeat steps &#9313;.1 &ndash; &#9313;.4 above to generate a fresh permanent token.
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <script>
                    function toggleGuide() {
                        var btn = document.getElementById('guideToggleBtn');
                        var panel = document.getElementById('guidePanel');
                        btn.classList.toggle('active');
                        panel.classList.toggle('open');
                    }
                </script>

            </body>

            </html>