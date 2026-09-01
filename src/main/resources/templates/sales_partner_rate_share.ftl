<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>B2B Seasonal Rate Card</title>
    <style>
        /* <![CDATA[ */
        @page {
            size: A4 portrait;
            margin: 12mm 10mm 12mm 10mm;
        }

        body {
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            font-size: 12px;
            line-height: 1.45;
            color: #2d3748;
            margin: 0;
            padding: 5px 10px;
            background-color: #ffffff;
        }

        /* Header and Logo */
        .header-container {
            text-align: center;
            margin-bottom: 18px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e2e8f0;
        }

        .resort-logo {
            display: block;
            margin: 0 auto 8px auto;
            max-height: 70px;
            max-width: 200px;
            width: auto;
            height: auto;
        }

        .b2b-header-title {
            font-size: 16px;
            font-weight: 700;
            color: #1e3a8a;
            letter-spacing: 0.5px;
            margin: 0 0 3px 0;
            text-transform: uppercase;
        }

        .b2b-header-subtitle {
            font-size: 12px;
            font-weight: 500;
            color: #718096;
            margin: 0;
        }

        .gold-divider {
            width: 50px;
            height: 3px;
            background: #d97706;
            margin: 6px auto 0 auto;
            border-radius: 2px;
        }

        /* Greeting and Partner Box */
        .partner-box {
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            border-left: 4px solid #1e3a8a;
            border-radius: 6px;
            padding: 10px 14px;
            margin-bottom: 20px;
        }

        .partner-box p {
            margin: 3px 0;
            font-size: 12px;
        }

        .partner-name-highlight {
            color: #1e3a8a;
            font-weight: 700;
            font-size: 13px;
        }

        /* Season Card and Table Styling */
        .season-block {
            margin-bottom: 22px;
            page-break-inside: avoid;
            background: #ffffff;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }

        .season-header {
            background: #1e3a8a;
            color: #ffffff;
            padding: 8px 14px;
            border-bottom: 2px solid #d97706;
        }

        .season-title {
            font-size: 14px;
            font-weight: 700;
            color: #ffffff;
            letter-spacing: 0.3px;
            margin-bottom: 4px;
            text-transform: uppercase;
        }

        .season-dates-container {
            font-size: 11.5px;
            color: #e2e8f0;
        }

        .date-chip {
            display: inline-block;
            background: rgba(255, 255, 255, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.35);
            border-radius: 4px;
            padding: 2px 6px;
            margin: 2px 4px 2px 0;
            font-weight: 600;
            color: #ffffff;
        }

        /* Rates Table */
        table.rates-table {
            border-collapse: collapse;
            width: 100%;
            font-size: 11.5px;
            text-align: center;
            background-color: #ffffff;
        }

        table.rates-table th {
            background-color: #2b4c7e;
            color: #ffffff;
            font-weight: 600;
            padding: 7px 5px;
            border: 1px solid #1e3a8a;
            font-size: 11px;
        }

        table.rates-table th small {
            display: block;
            font-weight: 400;
            font-size: 9.5px;
            color: #cbd5e1;
            margin-top: 1px;
        }

        table.rates-table td {
            border: 1px solid #cbd5e1;
            padding: 6px 5px;
            vertical-align: middle;
        }

        .row-group-a {
            background-color: #ffffff;
        }

        .row-group-b {
            background-color: #f8fafc;
        }

        .room-title-cell {
            font-weight: 700;
            color: #1e3a8a;
            text-align: left;
            padding-left: 10px !important;
            font-size: 12px;
            background-color: #f1f5f9;
        }

        .occ-cell {
            font-weight: 600;
            color: #475569;
            background-color: #f8fafc;
        }

        .pax-cell {
            font-weight: 500;
            color: #334155;
        }

        .rate-cell {
            font-weight: 700;
            color: #0f172a;
            font-size: 11.5px;
        }

        .extra-bed-tag {
            font-size: 9.5px;
            color: #b45309;
            font-weight: 500;
            display: block;
            margin-top: 2px;
        }

        .meal-legend-bar {
            background-color: #f8fafc;
            border-top: 1px solid #e2e8f0;
            padding: 5px 10px;
            font-size: 10px;
            color: #64748b;
            text-align: left;
        }

        /* Section Cards */
        .info-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            padding: 12px 16px;
            margin-top: 16px;
            page-break-inside: avoid;
        }

        .info-card h3 {
            margin: 0 0 6px 0;
            font-size: 13px;
            font-weight: 700;
            color: #1e3a8a;
            border-bottom: 1px solid #e2e8f0;
            padding-bottom: 3px;
            text-transform: uppercase;
        }

        .info-card ul {
            margin: 4px 0 0 0;
            padding-left: 18px;
        }

        .info-card li {
            margin-bottom: 5px;
        }

        .info-card a {
            color: #2563eb;
            text-decoration: none;
            font-weight: 600;
        }

        /* Contact Details Card */
        .contact-box {
            background: #f8fafc;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            padding: 12px 16px;
            margin-top: 16px;
            page-break-inside: avoid;
        }

        .contact-box h3 {
            margin: 0 0 8px 0;
            font-size: 13px;
            font-weight: 700;
            color: #1e3a8a;
            text-transform: uppercase;
        }

        .contact-grid {
            width: 100%;
            border-collapse: collapse;
            font-size: 12px;
        }

        .contact-grid td {
            padding: 2px 0;
            vertical-align: top;
            border: none;
        }

        .contact-label {
            width: 100px;
            font-weight: 600;
            color: #475569;
        }

        .contact-val {
            color: #1e293b;
        }

        /* Actions and Social Links */
        .connect-actions {
            text-align: center;
            margin: 18px 0 10px 0;
            page-break-inside: avoid;
        }

        .whatsapp-btn {
            background-color: #25D366;
            color: #ffffff !important;
            padding: 7px 16px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 700;
            border-radius: 18px;
            display: inline-block;
            margin-bottom: 10px;
        }

        .social-bar {
            text-align: center;
            margin-top: 6px;
        }

        .social-bar a {
            margin: 0 3px;
            text-decoration: none;
            color: #ffffff !important;
            padding: 4px 10px;
            border-radius: 4px;
            font-size: 10.5px;
            font-weight: 600;
            display: inline-block;
        }

        .facebook { background-color: #3b5998; }
        .instagram { background-color: #e4405f; }
        .linkedin { background-color: #0077b5; }
        .twitter { background-color: #1DA1F2; }
        .email-btn { background-color: #ea580c; }
        .website-btn { background-color: #0f172a; }

        .signature-text {
            margin-top: 14px;
            font-size: 12px;
            color: #475569;
        }
        /* ]]> */
    </style>
</head>
<body>

    <!-- Header Section -->
    <div class="header-container">
        <#if logoUrl?? && logoUrl?has_content>
            <img src="${logoUrl}" alt="Logo" class="resort-logo" />
        <#elseif centralConfig?? && centralConfig.logoPath?? && centralConfig.logoPath?has_content>
            <img src="${centralConfig.logoPath}" alt="Logo" class="resort-logo" />
        </#if>
        <div class="b2b-header-title">Exclusive B2B Tariff &amp; Seasonal Rate Card</div>
        <div class="b2b-header-subtitle">Confidential Contracted Partner Pricing</div>
        <div class="gold-divider"></div>
    </div>

    <!-- Partner Greeting Box -->
    <div class="partner-box">
        <p>Dear <span class="partner-name-highlight">${salesPartnerName?upper_case}</span>,</p>
        <p>We are delighted to share our exclusive B2B seasonal tariff sheet, specially curated for our valued travel and trade partners. These special rates are designed to offer maximum value and seamless flexibility to help you confirm bookings with ease.</p>
    </div>

    <!-- Rate Cards Grouped by Season -->
    <#if rateCardList?? && rateCardList?size gt 0>
        <#list rateCardList as rateCard>
            <div class="season-block">
                <!-- Season Header with Grouped Dates -->
                <div class="season-header">
                    <div class="season-title">
                        &#9733; ${rateCard.seasonName!"Season Rates"}
                    </div>
                    <div class="season-dates-container">
                        <strong>Applicable Validity / Period(s):</strong>
                        <#if rateCard.applicableDates?? && rateCard.applicableDates?size gt 0>
                            <#list rateCard.applicableDates as dt>
                                <span class="date-chip">&#128197; ${dt}</span>
                            </#list>
                        <#else>
                            <span class="date-chip">&#128197; ${rateCard.seasonStartDate} to ${rateCard.seasonEndDate}</span>
                        </#if>
                    </div>
                </div>

                <!-- Rates Table -->
                <table class="rates-table">
                    <thead>
                        <tr>
                            <th style="width: 25%; text-align: left; padding-left: 10px;">Room Category</th>
                            <th style="width: 11%;">Max Occ.</th>
                            <th style="width: 10%;">Pax</th>
                            <th style="width: 13.5%;">EPAI<small>(Room Only)</small></th>
                            <th style="width: 13.5%;">CPAI<small>(With Breakfast)</small></th>
                            <th style="width: 13.5%;">MAPAI<small>(Breakfast + Meal)</small></th>
                            <th style="width: 13.5%;">APAI<small>(All Meals)</small></th>
                        </tr>
                    </thead>
                    <tbody>
                        <#if rateCard.roomCategories??>
                            <#list rateCard.roomCategories as roomCategory>
                                <#assign stnOcc = roomCategory.standardOccupancy />
                                <#assign maxOcc = roomCategory.maxOccupancy />
                                <#assign rowClass = (roomCategory_index % 2 == 0)?then('row-group-a', 'row-group-b') />

                                <#list 1..stnOcc as i>
                                    <tr class="${rowClass}">
                                        <#if i == 1>
                                            <td rowspan="${stnOcc}" class="room-title-cell">
                                                ${roomCategory.name}
                                                <#if roomCategory.extraBed gt 0>
                                                    <span class="extra-bed-tag">+ Extra Bed Available</span>
                                                </#if>
                                            </td>
                                            <td rowspan="${stnOcc}" class="occ-cell">${maxOcc} Pax</td>
                                        </#if>
                                        <td class="pax-cell">${i} Pax</td>

                                        <#assign rateMap = {} />
                                        <#if roomCategory.mealPlans??>
                                            <#list roomCategory.mealPlans as mealPlan>
                                                <#assign mealPlanId = mealPlan.mealPlanId />
                                                <#assign personWiseRates = mealPlan.personWiseRates />
                                                <#assign rate = personWiseRates[i?string]! />
                                                <#if rate??>
                                                    <#assign rateMap = rateMap + { (mealPlanId?string): rate } />
                                                </#if>
                                            </#list>
                                        </#if>

                                        <#list [1, 2, 3, 4] as planId>
                                            <#assign planRate = rateMap[planId?string]! />
                                            <td class="rate-cell">
                                                <#if planRate?? && planRate?is_number>
                                                    <#if planRate gt 0>
                                                        &#8377; ${planRate}
                                                    <#else>
                                                        -
                                                    </#if>
                                                <#elseif planRate?? && planRate?is_string && planRate?has_content && planRate != '-' && planRate != '0'>
                                                    &#8377; ${planRate}
                                                <#else>
                                                    -
                                                </#if>
                                            </td>
                                        </#list>
                                    </tr>
                                </#list>
                            </#list>
                        </#if>
                    </tbody>
                </table>

                <div class="meal-legend-bar">
                    <strong>Meal Plan Guide:</strong> EPAI = Room Only | CPAI = Room with Breakfast | MAPAI = Room with Breakfast &amp; Lunch/Dinner | APAI = All Major Meals (Breakfast, Lunch &amp; Dinner) | Rates are Per Room Per Night on specified sharing basis.
                </div>
            </div>
        </#list>
    </#if>

    <!-- Hotel Information (if available) -->
    <#if centralConfig?? && centralConfig.hotelInfo?? && centralConfig.hotelInfo?has_content>
        <div class="info-card">
            ${centralConfig.hotelInfo}
        </div>
    </#if>

    <!-- Property Overview and Resources -->
    <div class="info-card">
        <h3>Property Overview &amp; Sales Resources</h3>
        <p style="margin: 3px 0 6px 0;">To assist you in promoting and selling our resort to your guests, please access the following resources:</p>
        <ul>
            <li>
                <strong>High-Resolution Photo Gallery:</strong> Access high-definition images of rooms, resort amenities, dining, and scenic landscapes.
                <#if centralConfig?? && centralConfig.website?? && centralConfig.website?has_content>
                    <br/>
                    <a href="${centralConfig.website}" target="_blank">
                        View Resort Photographs &amp; Virtual Tour &#8594;
                    </a>
                <#else>
                    <br/>
                    <a href="https://vanchhavi.in/" target="_blank">
                        View Resort Photographs &amp; Virtual Tour &#8594;
                    </a>
                </#if>
            </li>
            <li>
                <strong>Property Factsheet &amp; Amenities:</strong> Complete specifications, room layouts, activities, and banquet facilities.
                <#if centralConfig?? && centralConfig.website?? && centralConfig.website?has_content>
                    <br/>
                    <a href="${centralConfig.website}" target="_blank">
                        Visit Official Resort Website &#8594;
                    </a>
                <#else>
                    <br/>
                    <a href="https://vanchhavi.in/" target="_blank">
                        Visit Official Resort Website &#8594;
                    </a>
                </#if>
            </li>
        </ul>
    </div>

    <!-- Terms and Conditions (if available) -->
    <#if centralConfig?? && centralConfig.tnc?? && centralConfig.tnc?has_content>
        <div class="info-card">
            <h3>Terms &amp; Booking Conditions</h3>
            ${centralConfig.tnc}
        </div>
    </#if>

    <!-- Corporate and Group Events -->
    <div class="info-card">
        <h3>Corporate Offsites, Weddings &amp; Group Bookings</h3>
        <p style="margin: 3px 0;">
            Our property is fully equipped to host <strong>corporate offsites, team conferences, destination weddings</strong>, and <strong>family gatherings</strong>. Customized conference setups, themed gala dinners, adventure activities, and curated menus are available on request.
        </p>
    </div>

    <!-- Contact Details Card -->
    <div class="contact-box">
        <h3>Resort &amp; Central Reservations Contact</h3>
        <table class="contact-grid">
            <#if centralConfig?? && centralConfig.hotelAddress?? && centralConfig.hotelAddress?has_content>
                <tr>
                    <td class="contact-label">Address:</td>
                    <td class="contact-val">${centralConfig.hotelAddress}</td>
                </tr>
            </#if>
            <#if centralConfig?? && centralConfig.centralNumber?? && centralConfig.centralNumber?has_content>
                <tr>
                    <td class="contact-label">Reservations:</td>
                    <td class="contact-val">${centralConfig.centralNumber}</td>
                </tr>
            </#if>
            <#if centralConfig?? && centralConfig.centralizedEmail?? && centralConfig.centralizedEmail?has_content>
                <tr>
                    <td class="contact-label">Email:</td>
                    <td class="contact-val">${centralConfig.centralizedEmail}</td>
                </tr>
            </#if>
            <#if centralConfig?? && centralConfig.gstNumber?? && centralConfig.gstNumber?has_content>
                <tr>
                    <td class="contact-label">GSTIN:</td>
                    <td class="contact-val">${centralConfig.gstNumber}</td>
                </tr>
            </#if>
        </table>
    </div>

    <!-- Signature -->
    <div class="signature-text">
        <p>For instant confirmations, group queries, or customized packages, please feel free to connect with our dedicated reservations desk.</p>
        <p>Warm Regards,<br/>
        <strong>Sales &amp; Revenue Management Team</strong></p>
    </div>

    <!-- Connect and Social Buttons -->
    <div class="connect-actions">
        <#if serviceAdvisorMobile?? && serviceAdvisorMobile?has_content>
            <div>
                <a href="https://wa.me/${serviceAdvisorMobile}" class="whatsapp-btn" target="_blank">Chat with Reservations on WhatsApp</a>
            </div>
        </#if>

        <div class="social-bar">
            <#if centralConfig?? && centralConfig.facebookLink?? && centralConfig.facebookLink?has_content>
                <a href="${centralConfig.facebookLink}" class="facebook" target="_blank">Facebook</a>
            </#if>
            <#if centralConfig?? && centralConfig.instagramLink?? && centralConfig.instagramLink?has_content>
                <a href="${centralConfig.instagramLink}" class="instagram" target="_blank">Instagram</a>
            </#if>
            <#if centralConfig?? && centralConfig.linkedinLink?? && centralConfig.linkedinLink?has_content>
                <a href="${centralConfig.linkedinLink}" class="linkedin" target="_blank">LinkedIn</a>
            </#if>
            <#if centralConfig?? && centralConfig.xLink?? && centralConfig.xLink?has_content>
                <a href="${centralConfig.xLink}" class="twitter" target="_blank">Twitter</a>
            </#if>
            <#if centralConfig?? && centralConfig.centralizedEmail?? && centralConfig.centralizedEmail?has_content>
                <a href="mailto:${centralConfig.centralizedEmail}" class="email-btn">Email Us</a>
            </#if>
            <#if centralConfig?? && centralConfig.website?? && centralConfig.website?has_content>
                <a href="${centralConfig.website}" class="website-btn" target="_blank">Visit Website</a>
            </#if>
        </div>
    </div>

</body>
</html>
