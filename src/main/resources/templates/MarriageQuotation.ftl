<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Wedding Quotation</title>
  <style>

.section {
    margin: 20px 0;
    padding: 0;
    border: none;
    page-break-inside: auto;
}

.section h2 {
    text-align: left;
    font-size: 28px;
    margin-bottom: 18px;
}

.address::after {
    content: "";
    display: block;
    width: 420px;              /* controls line length */
    height: 2px;
    background-color: #8b5a2b; /* brown-gold tone like sample */
    margin-top: 10px;
}

h1, h2, h3,
    strong,
    th,
    .section h2,
    .footer h3,
    .header h1,
    .address,
     p strong {
    color: #1f4d2b !important;
}

.bg-image {
    display: none;
}

.pdf-bg-img {
    position: fixed;
    top: 0;
    left: 0;
    width: 210mm;
    height: 297mm;
    object-fit: cover;
    z-index: -1;
}

@page {
  size: A4;
  margin: 0;
}

html, body {
    margin: 0;
    padding: 0;
    width: 100%;
    height: 100%;
    background: transparent; /* no white background */
}

body {
    background: transparent;
}

.info-table {
    margin: 0 auto;                 /* centers the table */
    border-collapse: collapse;      /* clean borders */
    background: rgba(255,255,255,0.9);
}

.info-table td {
    padding: 10px 16px;
    border: 1px solid #d8cfa5;      /* visible table box */
    white-space: nowrap;            /* keeps text in one line */
    vertical-align: middle;
}

.section, .footer, .top-bar {
    background: transparent;
    border-radius: 0;      /* IMPORTANT */
    box-shadow: none;     /* optional but cleaner */
    border: none;
}

.content {
    margin: 0;
    padding: 0;
}

body {
    margin: 0;
    padding: 0;
    font-family: sans-serif;
}

h1 {
    text-align: center;
}

h2, h3 {
    text-align: left;
}


h1, h2, h3 {
    font-weight: 800;
     color: var(--brand-green);
    text-shadow: none;
}
h1, h2, h3,
strong,
.section h2,
.footer h3,
.header h1 {
    color: var(--brand-green) !important;
}

.info-table td,
.service-table td,
.service-table th {
    color: #2b1b0f;
    font-weight: 600;
}
.top-bar {
    width: 100%;
    padding: 20px 0;
    background: rgba(255,255,255,0.85);
}

.logo {
    text-align: left;
    margin-bottom: 6px;
}

.logo img {
    height: 90px;
}

.address {
    text-align: left;
    font-size: 14px;
    font-weight: 700;
    color: #1f4d2b;
    line-height: 1.4;
}


.header {
    padding: 90px 0 30px;
    text-align: center;
    background: transparent;
}


.header h1 {
    font-size: 42px;
    letter-spacing: 3px;
    text-transform: uppercase;
    color: var(--brand-green);
    font-weight: 900;
    text-shadow: none;
}

.header h1::after {
    content: "✦ ✦ ✦";
    display: block;
    font-size: 16px;
    margin-top: 14px;
    color: #f0d28c;
    letter-spacing: 10px;
}


/* ===== EVENT INFORMATION SPECIAL STYLING ===== */
.section:first-of-type h2 {
    text-align: center;
    margin-left: 0;
    font-size: 34px;
}
.section:first-of-type h2::after {
    content: "";
    display: block;
    width: 320px;               /* line width */
    height: 2px;
    background-color: #8b5a2b;
    margin: 12px auto 0;        /* center the line */
}

.section:first-of-type .info-table {
    margin: 0 auto;              /* center table */
}

.section:first-of-type .info-table td {
    font-size: 16px;             /* bigger text */
    padding: 14px 22px;          /* bigger cells */
}
h1, h2 {
    white-space: normal;
}

.header h1 {
    white-space: nowrap; /* only main title */
}


/* ========== TABLES ========== */
.info-table td,
.service-table td,
.service-table th {
    color: #5a3a1b !important;      /* dark brown text */
    border-color: #5a3a1b;          /* dark brown borders */
}

.total {
    color: #2e6b3f !important;
    font-weight: 800;
}

.footer {
    margin: 25px 0;
    padding: 28px 32px;
    background: rgba(255,255,255,0.9);
    border-radius: 0;
    color: var(--brand-green);
}

.footer ul {
    padding-left: 20px;
    margin: 0;
}

.footer li {
    margin-bottom: 8px;
    line-height: 1.5;
}

/* ===== FINAL SOCIAL BUTTON FIX ===== */

.social-links {
    width: 100%;
    text-align: center;
    white-space: normal !important;   /* allow wrapping */
}

.social-links a {
    display: inline-block;
    margin: 6px 6px;
    padding: 8px 14px;
}

/* Position on menu page */
.menu-page .social-links {
    position: absolute;
    bottom: 10mm;
    left: 0;
    right: 0;
    z-index: 100 !important;
}

.social-links a {
    display: inline-block;
    margin: 5px 6px;
    padding: 8px 14px;
    font-size: 12px;
    font-weight: 700;
    border-radius: 18px;
    text-decoration: none;
    letter-spacing: 0.4px;
    box-shadow: 0 3px 8px rgba(0,0,0,0.25);
    line-height: 1;
}

.address {

    font-size: 14px;
    text-align:left;
 color: #5a3a1b !important;
    font-weight: 700;
}

.content-area {
    padding: 0;
    margin: 0;
    background: rgba(255,255,255,0.96);
}

.footer,
.social-links {
    page-break-inside: avoid;
}

.photo-table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 10px;   /* space between photos */
    table-layout: fixed;
}

.photo-table td {
    width: 50%;
    height: 120px;          /* smaller */
    padding: 6px;           /* inner breathing */
}

.photo-table img {
    width: 100%;
    height: 120px;
    object-fit: cover;
    border-radius: 8px;
}
.content-box {
    max-width: 100%;
    margin-left: auto;
    margin-right: auto;
}

.facebook {
    background-color: #3b5998;
    color: #ffffff;
}

.instagram {
    background-color: #e4405f;
    color: #ffffff;
}

.linkedin {
    background-color: #0077b5;
    color: #ffffff;
}

.twitter {
    background-color: #1DA1F2;
    color: #ffffff;
}

.email {
    background-color: #f4e1a1;
    color: #5a3a1b;   /* dark text for light bg */
}

.website {
    background-color: #333333;
    color: #ffffff;
}

/* FORCE SOCIAL BUTTON TEXT TO STAY LIGHT */
.social-links a.facebook,
.social-links a.instagram,
.social-links a.linkedin,
.social-links a.twitter,
.social-links a.website {
    color: #ffffff !important;
}

/* Email button exception (light background) */
.social-links a.email {
    color: #5a3a1b !important;
}
.section:not(.event-info),
.section:not(.event-info) h2,
.section:not(.event-info) p,
.section:not(.event-info) table,
.footer,
.footer p,
.footer li {
    text-align: left;
}


.welcome-heading {
    text-align: left;
    font-size: 18px;          /* readable, fits one line */
    font-weight: 800;
    white-space: nowrap;     /* keep one line */
    letter-spacing: 0.5px;   /* tighter */
}


/* ===== EVENT INFORMATION CENTER (PDF SAFE) ===== */
.event-info {
    text-align: center;
}

.event-info h2 {
    text-align: center;
}

.event-info table {
    margin-left: auto;
    margin-right: auto;
}

/* ===== KEEP WELCOME SECTION ON ONE PAGE ===== */
.welcome-section,
.welcome-content {
    page-break-inside: avoid;
    break-inside: avoid;
}

/* If PDF engine is aggressive */
.welcome-section {
    page-break-before: auto;
    page-break-after: auto;
}
/* ===== WELCOME SECTION COLOR ===== */
.welcome-section,
.welcome-section p,
.welcome-section div,
.welcome-section span,
.welcome-section li {
    color: #5a3a1b !important;
}
/* ===== FORCE WELCOME HEADING + CONTENT ON SAME PAGE ===== */
.welcome-block {
    page-break-inside: avoid !important;
    break-inside: avoid !important;
}

/* Prevent heading orphaning */
.welcome-heading {
    page-break-after: avoid !important;
    break-after: avoid !important;
}
.celebration-highlight {
    page-break-inside: auto;
}

.section.cost-breakup {
    page-break-inside: auto !important;
}


.section.cost-breakup h2 {
    page-break-after: avoid !important;
}

.service-table,
.service-table tr,
.service-table td {
    page-break-inside: auto !important;
}

.photo-block {
    display: inline-block;
    text-align: center;
    width: 100%;
}

.photo-section {
    page-break-inside: avoid;
    text-align: center;
    padding: 40px 0;
}

.photo-section h2 {
    text-align: center !important;
    margin-bottom: 20px;
}

.photo-block {
    display: inline-block;
    text-align: center;
    width: 100%;
}


/* ===== COST BREAKUP TABLE – FINAL FIX ===== */
.service-table {
    width: 100%;
    border-collapse: collapse;
    background: rgba(255,255,255,0.95);
    table-layout: auto; /* IMPORTANT: let browser decide width */
}

.service-table th,
.service-table td {
    border: 1px solid #5a3a1b;
    padding: 10px 14px;
    font-size: 14px;
    vertical-align: middle;
}

.service-table th {
    background: rgba(245,235,200,0.95);
    font-weight: 800;
    text-align: left;
}

/* Column specific alignment */
.service-table td:nth-child(3),
.service-table th:nth-child(3) {
    text-align: right;
    white-space: nowrap;
}

/* Prevent ugly word breaking */
.service-table td:nth-child(2) {
    white-space: nowrap;
}

.footer,
.footer ul,
.footer li,
.footer p,
.footer strong {
    color: #5a3a1b !important;   /* dark brown */
}

/* ===== CONTENT CONTAINER (PDF SAFE) ===== */
.content-box {
    background: rgba(255,255,255,0.85);
    border: 2px solid #d8cfa5;
    border-radius: 14px;
    padding: 14px 18px;
    margin-top: 12px;
    color: #5a3a1b;
}

.content-box ul {
    margin: 0;
    padding-left: 18px;
}

.content-box li {
    margin-bottom: 6px;
    line-height: 1.5;
}

.content-box {
    page-break-inside: avoid;
    break-inside: avoid;
}
.celebration-highlight {
    page-break-inside: avoid !important;
    break-inside: avoid !important;
    page-break-before: always !important;
}

.celebration-highlight .content-box {
    min-height: 180px;
}

.celebration-highlight h2 {
    page-break-after: avoid !important;
    break-after: avoid !important;
}

.header {
    text-align: center;
}

.header h1 {
    display: inline-block;
    margin: 0 auto;
}
.photo-table {
    margin: 0 auto;
}
.page-content {
    position: relative;
    width: 170mm;
    margin: 20mm auto;
    padding-left: 30px;
    padding-right: 30px;
    padding-bottom: 30px;   /* ✅ IMPORTANT */
    box-sizing: border-box;
}

.footer {
    page-break-inside: avoid;
}


.photo-section {
    text-align: center;
}

.photo-table {
    width: 100%;
    max-width: 100%;
    margin: 0 auto;
}

.welcome-section {
    margin: 0 auto;
}

.welcome-block {
    max-width: 100%;
}

/* ===== FULL PAGE MENU IMAGE ===== */
.menu-page {
    page-break-before: always;
    width: 210mm;
    height: 297mm;   /* full page */
    position: relative;
    overflow: hidden;
    margin: 0;
    padding: 0;
}

.menu-page img {
    width: 100%;
    height: calc(100% - 22mm);
    object-fit: cover;   /* fills page */
    display: block;
}
.social-links {
    page-break-before: auto;
}

.menu-page {
    position: relative;
}


/* ===== DISABLE BACKGROUND ON MENU PAGES ONLY ===== */
.menu-page,
.menu-page * {
    background: transparent !important;
}

/* Hide fixed background when menu appears */
.menu-page ~ .pdf-bg-img,
.menu-page .pdf-bg-img {
    display: none !important;
}

/* Kill background behind menu pages */
body:has(.menu-page) .pdf-bg-img {
    display: none !important;
}
/* Hide background when menu section starts */
.menu-section ~ .pdf-bg-img {
    display: none !important;
}

/* ===== FIX SOCIAL LINKS VISIBILITY ON MENU PAGE ===== */

.menu-page {

    background: rgb(255,255,255) !important;
    position: relative;
    z-index: 1;   /* lower */
}

/* Put menu image above white bg */
.menu-page img {
    position: relative;
    z-index: 5;
}


/* Restore button colors */
.menu-page .social-links a {
    opacity: 1 !important;
    filter: none !important;
}

/* ===== FINAL SOCIAL BUTTON FORCE FIX ===== */

.menu-page .social-links {
    position: absolute;
    bottom: 12mm;
    left: 0;
    right: 0;
    text-align: center;
    z-index: 999 !important;
}

.social-links {
    width: 100%;
    white-space: normal !important;
}

.social-links a {
    display: inline-block !important;
    min-width: 90px;
    margin: 6px 6px;
    padding: 8px 14px;
    border-radius: 18px;
    font-size: 12px;
    font-weight: 700;
    text-align: center;
    color: #fff !important;
}

/* Button colors (force) */
.social-links a.facebook  { background: #3b5998 !important; }
.social-links a.instagram { background: #e4405f !important; }
.social-links a.linkedin  { background: #0077b5 !important; }
.social-links a.twitter   { background: #1DA1F2 !important; }
.social-links a.website   { background: #333333 !important; }
.social-links a.email     { background: #f4e1a1 !important; color:#5a3a1b !important; }

/* ===== LETTERHEAD ADDRESS FORMAT ===== */

.address p {
    margin: 0;
    line-height: 1.4;
}

.address p::first-line {
    font-weight: 800;     /* Bold hotel name */
    font-size: 16px;
}

/* Align logo + address side by side */

.top-bar {
    display: flex;
    align-items: center;
    gap: 16px;
}

.logo {
    flex-shrink: 0;
}

.address {
    flex-grow: 1;
}


/* ===== FORCE LETTERHEAD LOOK WITHOUT HTML CHANGE ===== */

.address {
    font-size: 13px !important;
    line-height: 1.4 !important;
    text-align: left !important;
    max-width: 500px;
}

/* Make first part (hotel name) look like heading */
.address p {
    font-weight: 600;
}

/* Enlarge first line (hotel name part) */
.address p::first-line {
    font-size: 20px !important;
    font-weight: 900 !important;
    letter-spacing: 1px;
    text-transform: uppercase;
    color: #1f4d2b !important;
}

/* Improve spacing with logo */
.top-bar {
    display: flex !important;
    align-items: center !important;
    gap: 20px !important;
    padding: 18px 20px !important;
}

/* ===== FIX LETTERHEAD SIZE + COLOR ===== */

.address p::first-line {
    font-size: 14px !important;      /* small heading */
    font-weight: 700 !important;
    letter-spacing: 0.5px !important;
    text-transform: none !important;
    color: #1f3c88 !important;       /* blue color */
}

.address {
    max-width: 420px !important;     /* prevent full width */
    white-space: normal !important; /* allow proper wrapping */
    font-size: 12px !important;
    line-height: 1.3 !important;
}

/* Reduce header height */
.top-bar {
    padding: 10px 20px !important;
}

/* ===== FINAL LETTERHEAD OVERRIDE (DO NOT REMOVE) ===== */

.address {
    color: #5a3a1b !important;      /* brown */
    font-size: 12px !important;
    line-height: 1.4 !important;
    max-width: 480px !important;
    white-space: normal !important;
}

/* Reset paragraph */
.address p {
    margin: 0 !important;
    font-weight: 500 !important;
    white-space: normal !important;
}

/* Hotel name = first line */
.address p::first-line {
    font-size: 15px !important;
    font-weight: 800 !important;
    color: #5a3a1b !important;      /* brown */
    letter-spacing: 0.4px !important;
    text-transform: none !important;
}

/* Keep address + pin in one line */
.address p br + * {
    display: block;
    white-space: nowrap !important;
}

/* Keep phone + email in one line */
.address p br + * + * {
    display: block;
    white-space: nowrap !important;
}

/* Fix header spacing */
.top-bar {
    padding: 10px 18px !important;
    align-items: center !important;
}

/* ===== FIX EXTRA GAP BETWEEN ADDRESS LINES ===== */
.address p {
    line-height: 1.4 !important;   /* tighter lines */
}

.address br {
    display: block;
    content: "";
    margin: 0;
    line-height: 0;
}
/* ===== EXTRA STRONG HOTEL NAME BOLD ===== */
.address p::first-line {
    font-weight: 900 !important;
    font-size: 17px !important;

    /* Fake bold effect */
    text-shadow:
        0.4px 0 #5a3a1b,
       -0.4px 0 #5a3a1b,
        0 0.4px #5a3a1b,
        0 -0.4px #5a3a1b;

    letter-spacing: 0.6px;
}
</style>
</head>

<body>
    <div class="content-area">


     <div class="page-content">
             <img src="${bgImageBase64}" class="pdf-bg-img" alt="background"/>

<div class="top-bar">
    <div class="logo">
        <!--<img src="https://mcusercontent.com/3ca8771030e566eaeda03585a/images/45f87f1a-20c3-c7bb-4868-b011138e1a46.png" alt="Resort Logo" />-->
        <img src="${centralConfig.logoPath}" alt="Logo" width="100" height="100" />
    </div>
   <div class="address">
       <p>
           ${centralConfig.hotelName}<br/>
           ${centralConfig.hotelAddress}<br/>
           ${centralConfig.centralNumber} ${centralConfig.centralizedEmail}
       </p>
   </div>

<div class="header">
    <h1>Wedding Quotation</h1>
</div>

<div class="section event-info">
  <h2>Event Information</h2>
    <table class="info-table">
        <tr><td><strong>Name:</strong></td><td>${guestName}</td></tr>
        <tr><td><strong>Event Dates:</strong></td><td>${eventStartDate} to ${eventEndDate}</td></tr>
        <tr><td><strong>No. of Rooms:</strong></td><td>${numberOfRooms}</td></tr>
        <tr><td><strong>No. of Guests:</strong></td><td>${baseGuestCount}</td></tr>
    </table>
</div>
<#-- SHOW PHOTO SECTION ONLY IF AT LEAST ONE IMAGE EXISTS -->
<#if eventConfig.galleryImageDataUrls?? && eventConfig.galleryImageDataUrls?size gt 0>

    <#assign hasValidImage = false />
    <#list eventConfig.galleryImageDataUrls as img>
        <#if img?? && img?has_content>
            <#assign hasValidImage = true />
            <#break>
        </#if>
    </#list>

    <#if hasValidImage>
        <div class="section photo-section">
            <div class="photo-block">
                <div class="content-box">
                    <h2>Wedding Photo Inspirations</h2>

                <table class="photo-table">
                    <#list eventConfig.galleryImageDataUrls?chunk(2) as row>
                        <tr>
                            <#list row as img>
                                <td>
                                    <#if img?? && img?has_content>
                                        <img src="${img}" alt="Quotation Image"/>
                                    </#if>
                                </td>
                            </#list>

                            <#-- Fill empty cell if odd number of images -->
                            <#if row?size < 2>
                                <td></td>
                            </#if>
                        </tr>
                    </#list>
                </table>

                </div>
            </div>
        </div>
    </#if>
</#if>
</div>

<#if eventConfig.resortInfo?has_content || eventConfig.testimonial?has_content>
<div class="section welcome-section">
    <div class="welcome-block">
      <#if eventConfig.resortInfo?has_content>
      <h2 class="welcome-heading">
            Welcome to ${centralConfig.hotelName}
        </h2>
      </#if>
     <div class="content-box">
        <#if eventConfig.resortInfo?has_content>
        <p style="font-size: 14px; line-height: 1.6;">${eventConfig.resortInfo?html?replace("\\r?\\n", "<br/>", "r")}</p>
        </#if>
        <#if eventConfig.testimonial?has_content>
            <div style="margin-top: 20px; font-style: italic; border-left: 4px solid #ccc; padding-left: 15px; color: #555;">
                ${eventConfig.testimonial?html?replace("\\r?\\n", "<br/>", "r")}
            </div>
        </#if>
    </div>
      </div>
</div>
</#if>

<#if eventConfig.celebrationHighlight?has_content>
  <div class="section celebration-highlight">

      <!-- Heading OUTSIDE container -->
      <h2>Wedding Celebration Highlights</h2>

      <!-- Content INSIDE container -->
      <div class="content-box">
          <ul style="margin: 0; padding-left: 18px;">
              <#list eventConfig.celebrationHighlight?split("\\r?\\n", "r") as highlight>
                  <#if highlight?trim?has_content>
                      <li>${highlight?replace(r"(?is)<h2.*?>.*?</h2>", "", "r")?html}</li>
                  </#if>
              </#list>
          </ul>
      </div>
  </div>
</#if>

<#-- ================= COST DISPLAY LOGIC ================= -->

<#-- CASE 1 : Show Breakup -->
<#if showBreakup?? && showBreakup>

<div class="section cost-breakup">
    <h2>Cost Breakup</h2>

    <table class="service-table">
        <thead>
        <tr>
            <th>Service Name</th>
            <th>Cost Type</th>
            <th>Amount (INR)</th>
        </tr>
        </thead>

        <tbody>
        <#list services as service>
            <tr>
                <td>${service.name!"N/A"}</td>
                <td>${service.costType!"N/A"}</td>
                <td>
                    ₹ ${(service.amount!0)?string["#,##0"]}
                </td>
            </tr>
        </#list>
        </tbody>
    </table>

    <#if discount gt 0>
        <div class="discount">
            Discount: ₹${discount?string["#,##0"]}
        </div>
    </#if>

    <div class="total">
        Total: ₹${(grand_total_cost - discount)?string["#,##0"]}
    </div>

</div>


<#-- CASE 2 : Hide Cost -->
<#elseif hideCost?? && hideCost>

<div class="section">
    <h2>Services Included</h2>

    <table class="service-table">
        <tbody>
        <#list services as service>
            <tr>
                <td>${service.name!"N/A"}</td>
            </tr>
        </#list>
        </tbody>
    </table>

</div>


<#-- CASE 3 : Default (Only Total) -->
<#else>

<div class="section">
    <h2>Services Included</h2>

    <table class="service-table">
        <tbody>
        <#list services as service>
            <tr>
                <td>${service.name!"N/A"}</td>
            </tr>
        </#list>
     </tbody>
    </table>

    <div class="total" style="margin-top:20px;">
        Total: ₹${(grand_total_cost - discount)?string["#,##0"]}
    </div>

</div>

</#if>

<#-- ================= END COST LOGIC ================= -->


<#if remarks?? && remarks?has_content>
    <div class="section" style="margin-top: 30px;">
        <h2>Remarks</h2>
        <p style="font-size: 14px; line-height: 1.6;">
            ${remarks}
        </p>
    </div>
</#if>

<#if eventConfig.termsConditions?has_content>
<div class="footer after-menu" style="page-break-before: always;">
    <h3>Terms and Conditions</h3>
<div class="content-box">
    <ul>
        <#if gstIncluded>
            <li>All prices are inclusive of GST and other applicable taxes.</li>
        <#else>
            <li>GST and other applicable taxes will be charged extra.</li>
        </#if>
        <#list eventConfig.termsConditions?split("\\r?\\n", "r") as term>
            <#if term?trim?has_content>
                <li>${term?html}</li>
            </#if>
        </#list>
    </ul>
    <p>For queries, please contact us at <strong>${centralConfig.centralNumber} </strong> or email <strong>${centralConfig.centralizedEmail}</strong></p>
</div>
</div>
</#if>

</div> <!-- END page-content -->


<#-- ===== MENU IMAGES (AFTER TERMS) ===== -->


<div class="menu-section">
<#list menuImages as img>

        <div class="menu-page">
            <img src="${img}" alt="Menu Page"/>

<#if img_index == (menuImages?size - 1)>

<!--
<div class="social-media" style="text-align: center; margin-top: 20px;">
    <h3>Connect With Us</h3>
    <p>
        <a href="https://www.facebook.com/ashokatigertrail" target="_blank" style="margin: 0 10px;">
            <img src="https://img.icons8.com/color/48/facebook-new.png" alt="Facebook" width="24" height="24" />
        </a>
        <a href="https://www.instagram.com/ashoka_tiger_trail" target="_blank" style="margin: 0 10px;">
            <img src="https://img.icons8.com/color/48/instagram-new.png" alt="Instagram" width="24" height="24" />
        </a>
        <a href="https://www.linkedin.com/company/ashokastigertrailresort/" target="_blank" style="margin: 0 10px;">
            <img src="https://img.icons8.com/color/48/linkedin.png" alt="LinkedIn" width="24" height="24" />
        </a>
        <a href="https://ashokastigertrail.com/" target="_blank" style="margin: 0 10px;">
            <img src="https://img.icons8.com/fluency/48/domain.png" alt="Website" width="24" height="24" />
        </a>
    </p>
</div>

-->
  <div class="social-links">
            <#if centralConfig.facebookLink?has_content>
                <a href="${centralConfig.facebookLink}" class="facebook" target="_blank">Facebook</a>
            </#if>

            <#if centralConfig.instagramLink?has_content>
                <a href="${centralConfig.instagramLink}" class="instagram" target="_blank">Instagram</a>
            </#if>

            <#if centralConfig.linkedinLink?has_content>
                <a href="${centralConfig.linkedinLink}" class="linkedin" target="_blank">LinkedIn</a>
            </#if>

            <#if centralConfig.xLink?has_content>
                <a href="${centralConfig.xLink}" class="twitter" target="_blank">Twitter</a>
            </#if>

             <#if centralConfig.centralizedEmail?has_content>
                <a href="mailto:${centralConfig.centralizedEmail}" class="email">Email</a>
            </#if>

            <#if centralConfig.website?has_content>
                <a href="${centralConfig.website}" class="website" target="_blank">Website</a>
            </#if>
     </div>
  </#if>
 </div>
</#list>
</div>



</div> <!-- END content-area -->
</body>
</html>
