<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Quotation - Winsome Resorts & Spa</title>

    <style>
        @page {
            size: A4 portrait;
            margin: 0;
        }
        body {
            font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
            font-size: 11.5px;
            line-height: 1.5;
            font-weight: bold;
            margin: 0;
            padding: 0;
            background-color: transparent;
            color: #0f2b46;
        }
        .pdf-bg-img {
            position: fixed;
            top: 0;
            left: 0;
            width: 210mm;
            height: 297mm;
            z-index: -1000;
            opacity: 0.08;
        }

        .container {
            background-color: transparent;
            padding: 0;
            width: 100%;
        }

        .header {
            text-align: center;
            padding-bottom: 5px;
        }

        .header img {
            max-width: 120px;
            height: auto;
        }

        .quotation-header {
            text-align: center;
            font-size: 18px;
            color: #0f2b46;
            font-family: 'Georgia', serif;
            font-weight: bold;
            margin-bottom: 15px;
            text-transform: uppercase;
            letter-spacing: 1px;
            border-bottom: 2px solid #c5a880;
            padding-bottom: 6px;
        }

        .text-block {
            font-size: 11.5px;
            line-height: 1.6;
            color: #0f2b46;
            margin-bottom: 15px;
            font-weight: bold;
        }

        .section-title {
            font-size: 12px;
            color: #0f2b46;
            font-weight: bold;
            text-transform: uppercase;
            background-color: #f1f5f9;
            border-left: 4px solid #c5a880;
            padding: 5px 10px;
            margin-top: 20px;
            margin-bottom: 8px;
            letter-spacing: 0.5px;
        }

        table.room-table {
            width: 100%;
            table-layout: fixed;
            border-collapse: collapse;
            margin-top: 10px;
            margin-bottom: 15px;
            font-size: 10.5px;
        }

        table.room-table th {
            background-color: #0f2b46;
            color: #ffffff;
            font-weight: bold;
            text-transform: uppercase;
            padding: 6px 4px;
            text-align: left;
            border: 1px solid #cbd5e1;
            font-size: 9.5px;
        }
        
        table.room-table td {
            padding: 6px 4px;
            text-align: left;
            border: 1px solid #e2e8f0;
            color: #334155;
            word-wrap: break-word;
            overflow-wrap: break-word;
        }

        table.room-table tr:nth-child(even) {
            background-color: #f8fafc;
        }

        .card {
            border: 1px solid #e2e8f0;
            background-color: #f8fafc;
            border-radius: 6px;
            padding: 12px;
            margin-top: 12px;
            margin-bottom: 12px;
        }

        .remarks-box {
            border-left: 4px solid #c5a880;
            background-color: #fdfbf7;
        }

        .remarks-title {
            color: #8c765c;
            font-weight: bold;
            margin: 0 0 6px 0;
            font-size: 11.5px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .bullet-list {
            margin: 6px 0;
            padding-left: 15px;
            list-style-type: disc;
        }

        .bullet-list li {
            margin-bottom: 4px;
            font-size: 11px;
            line-height: 1.4;
            font-weight: bold;
            color: #0f2b46;
        }

        .footer-group {
            page-break-inside: avoid;
            break-inside: avoid;
            margin-top: 20px;
        }

        .whatsapp-button {
            text-align: center;
            margin-top: 10px;
            margin-bottom: 10px;
        }

        .whatsapp-button a {
            display: inline-block;
            background-color: #25D366;
            color: #ffffff;
            padding: 6px 15px;
            text-decoration: none;
            border-radius: 15px;
            font-weight: bold;
            font-size: 12px;
            vertical-align: middle;
            text-shadow: 0 0 2px rgba(255,255,255,0.7);
        }

        .social-links {
            text-align: center;
            margin-top: 10px;
            margin-bottom: 10px;
            white-space: nowrap;
        }

        .social-links a {
            display: inline-block;
            width: 80px;
            height: 26px;
            line-height: 26px;
            text-align: center;
            text-decoration: none;
            color: #ffffff;
            border-radius: 4px;
            font-size: 11px;
            font-weight: bold;
            margin: 0 3px;
            vertical-align: middle;
            text-shadow: 0 0 2px rgba(255,255,255,0.7);
        }

        .facebook { background-color: #3b5998; }
        .instagram { background-color: #e4405f; }
        .linkedin { background-color: #0077b5; }
        .email { background-color: #ff6600; }
        .website { background-color: #0f2b46; }
        .twitter { background-color: #1DA1F2; }

        .footer {
            margin-top: 15px;
            text-align: center;
            font-size: 10px;
            color: #64748b;
        }
    </style>
</head>

<body>
<img src="${bgImageBase64}" class="pdf-bg-img" alt="background"/>
<table style="width: 210mm; table-layout: fixed; border-collapse: collapse; border: none; margin: 0; padding: 0;">
    <colgroup>
        <col style="width: 15mm;" />
        <col style="width: 180mm;" />
        <col style="width: 15mm;" />
    </colgroup>
    <thead>
        <tr><td colspan="3" style="height: 35mm; border: none;"></td></tr>
    </thead>
    <tfoot>
        <tr><td colspan="3" style="height: 35mm; border: none;"></td></tr>
    </tfoot>
    <tbody>
        <tr>
            <td style="border: none;"></td>
            <td style="border: none; vertical-align: top;">
                <div class="container">
                    <div class="header">
                        <img src="${centralConfig.logoPath}" alt="Logo" width="120" style="display: block; margin: 0 auto; max-width: 120px; height: auto;"/>
                    </div>
                    <div class="content">
                        <h2 class="quotation-header">Exclusive Stay Quotation – ${centralConfig.hotelName}</h2>
                        <p style="font-size: 12px; color: #1e293b; font-weight: bold; margin-bottom: 10px;">Dear ${contactName},</p>
                        <#if centralConfig.quotationTopCover?has_content>
                            <div class="text-block">
                                ${centralConfig.quotationTopCover?replace("\n","<br/>")}
                            </div>
                        </#if>

                        <table class="room-table">
                            <colgroup>
                                <col style="width: 38mm;" />
                                <col style="width: 14mm;" />
                                <col style="width: 12mm;" />
                                <col style="width: 16mm;" />
                                <col style="width: 16mm;" />
                                <col style="width: 16mm;" />
                                <col style="width: 20mm;" />
                                <col style="width: 20mm;" />
                                <col style="width: 28mm;" />
                            </colgroup>
                            <tr>
                                <th>Room Category</th>
                                <th>Meal Plan</th>
                                <th>Adults</th>
                                <th>Child (W/ bed)</th>
                                <th>Child (No bed)</th>
                                <th>Extra Bed</th>
                                <th>Check-in</th>
                                <th>Check-out</th>
                                <th>Total Price</th>
                            </tr>
                            <#list roomDetails as room>
                            <tr>
                                <td>${room.roomCategoryName}</td>
                                <td>${room.mealPlanName}</td>
                                <td>${room.adults}</td>
                                <td>${room.childWithBed}</td>
                                <td>${room.childNoBed}</td>
                                <td>${room.extraBed}</td>
                                <td>${room.formattedCheckInDate}</td>
                                <td>${room.formattedCheckOutDate}</td>
                                <td style="font-weight: bold;">INR ${room.totalPrice?string(",##0.00")}</td>
                            </tr>
                            </#list>
                        </table>

                        <#if remarks?? && (remarks?trim?length > 0)>
                            <div class="remarks-box card" style="page-break-inside: avoid;">
                                <h3 class="remarks-title">Remarks</h3>
                                <p style="margin: 0; font-size: 11.5px; color: #334155; font-weight: normal;">
                                    ${remarks?replace("\n","<br/>")}
                                </p>
                            </div>
                        </#if>

                        <!-- Totals Card -->
                        <div class="card" style="page-break-inside: avoid; margin-top: 15px; margin-bottom: 15px;">
                            <table style="width: 100%; border-collapse: collapse; border: none; margin-top: 0;">
                                <tr style="border: none;">
                                    <td style="border: none; padding: 4px 0; font-size: 11.5px; color: #475569; font-weight: normal;">Grand Total:</td>
                                    <td style="border: none; padding: 4px 0; text-align: right; font-size: 13px; color: #0f2b46; font-weight: bold;">INR ${grandTotalSum?string(",##0.00")}</td>
                                </tr>
                                <#if discount?number != 0>
                                <tr style="border: none;">
                                    <td style="border: none; padding: 4px 0; font-size: 11.5px; color: #dc2626; font-weight: normal;">Discount:</td>
                                    <td style="border: none; padding: 4px 0; text-align: right; font-size: 13px; color: #dc2626; font-weight: bold;">INR ${discount?string(",##0.00")}</td>
                                </tr>
                                <tr style="border: none; border-top: 1px solid #e2e8f0;">
                                    <td style="border: none; padding: 6px 0 0 0; font-size: 12.5px; color: #0f2b46; font-weight: bold; text-transform: uppercase;">Final Price:</td>
                                    <td style="border: none; padding: 6px 0 0 0; text-align: right; font-size: 14.5px; color: #0f2b46; font-weight: bold;">INR ${finalPrice?string(",##0.00")}</td>
                                </tr>
                                <#else>
                                <tr style="border: none; border-top: 1px solid #e2e8f0;">
                                    <td style="border: none; padding: 6px 0 0 0; font-size: 12.5px; color: #0f2b46; font-weight: bold; text-transform: uppercase;">Final Price:</td>
                                    <td style="border: none; padding: 6px 0 0 0; text-align: right; font-size: 14.5px; color: #0f2b46; font-weight: bold;">INR ${finalPrice?string(",##0.00")}</td>
                                </tr>
                                </#if>
                            </table>
                        </div>

                        <p style="font-size: 11px; color: #64748b; margin-top: 10px; margin-bottom: 20px; font-weight: normal;">
                            <strong>Meal Plans:</strong> EP – No Meals | CPAI – Breakfast Only | MAPI – Breakfast + Lunch/Dinner | APAI – All Meals
                        </p>

                        <#if centralConfig.inclusions?has_content>
                            <div class="rover" style="page-break-inside: avoid;">
                                <h3 class="section-title">Inclusions</h3>
                                <ul class="bullet-list">
                                    <#list centralConfig.inclusions?split("\\r?\\n", "r") as line>
                                        <#assign cleanLine = line?trim>
                                        <#if cleanLine?length gt 0>
                                            <#if cleanLine?starts_with("- ")><#assign cleanLine = cleanLine?substring(2)>
                                            <#elseif cleanLine?starts_with("* ")><#assign cleanLine = cleanLine?substring(2)>
                                            <#elseif cleanLine?starts_with("• ")><#assign cleanLine = cleanLine?substring(2)>
                                            <#elseif cleanLine?starts_with("•")><#assign cleanLine = cleanLine?substring(1)>
                                            </#if>
                                            <li>${cleanLine?html}</li>
                                        </#if>
                                    </#list>
                                </ul>
                            </div>
                        </#if>

                        <#if centralConfig.usp?has_content>
                            <div class="rover" style="page-break-inside: avoid;">
                                <h3 class="section-title">Why Choose Us?</h3>
                                <ul class="bullet-list">
                                    <#list centralConfig.usp?split("\\r?\\n", "r") as line>
                                        <#assign cleanLine = line?trim>
                                        <#if cleanLine?length gt 0>
                                            <#if cleanLine?starts_with("- ")><#assign cleanLine = cleanLine?substring(2)>
                                            <#elseif cleanLine?starts_with("* ")><#assign cleanLine = cleanLine?substring(2)>
                                            <#elseif cleanLine?starts_with("• ")><#assign cleanLine = cleanLine?substring(2)>
                                            <#elseif cleanLine?starts_with("•")><#assign cleanLine = cleanLine?substring(1)>
                                            </#if>
                                            <li>${cleanLine?html}</li>
                                        </#if>
                                    </#list>
                                </ul>
                            </div>
                        </#if>

                        <#if centralConfig.tnc?has_content>
                            <div class="rover" style="page-break-inside: avoid;">
                                <h3 class="section-title">Terms &amp; Conditions</h3>
                                <ul class="bullet-list">
                                    <#list centralConfig.tnc?split("\\r?\\n", "r") as line>
                                        <#assign cleanLine = line?trim>
                                        <#if cleanLine?length gt 0>
                                            <#if cleanLine?starts_with("- ")><#assign cleanLine = cleanLine?substring(2)>
                                            <#elseif cleanLine?starts_with("* ")><#assign cleanLine = cleanLine?substring(2)>
                                            <#elseif cleanLine?starts_with("• ")><#assign cleanLine = cleanLine?substring(2)>
                                            <#elseif cleanLine?starts_with("•")><#assign cleanLine = cleanLine?substring(1)>
                                            </#if>
                                            <li>${cleanLine?html}</li>
                                        </#if>
                                    </#list>
                                </ul>
                            </div>
                        </#if>

                        <!-- Details Grid -->
                        <table style="width: 100%; border: none; margin-top: 20px; border-collapse: collapse; page-break-inside: avoid;">
                            <tr>
                                <td style="width: 48%; border: none; vertical-align: top; padding-right: 4%;">
                                    <h3 class="section-title">Payment Details</h3>
                                    <div class="card" style="margin-top: 0; padding: 10px 12px;">
                                        <p style="margin: 3px 0; font-size: 11px; color: #334155; font-weight: normal;"><strong>Bank Name:</strong> ${centralConfig.bankName}</p>
                                        <p style="margin: 3px 0; font-size: 11px; color: #334155; font-weight: normal;"><strong>Account Name:</strong> ${centralConfig.accountName}</p>
                                        <p style="margin: 3px 0; font-size: 11px; color: #334155; font-weight: normal;"><strong>Account Number:</strong> ${centralConfig.accountNumber}</p>
                                        <p style="margin: 3px 0; font-size: 11px; color: #334155; font-weight: normal;"><strong>IFSC Code:</strong> ${centralConfig.ifscCode}</p>
                                        <p style="margin: 3px 0; font-size: 11px; color: #334155; font-weight: normal;"><strong>Branch Name:</strong> ${centralConfig.branch}</p>
                                    </div>
                                </td>
                                <td style="width: 48%; border: none; vertical-align: top;">
                                    <h3 class="section-title">Resort Contact Details</h3>
                                    <div class="card" style="margin-top: 0; padding: 10px 12px;">
                                        <p style="margin: 3px 0; font-size: 11px; color: #334155; font-weight: normal;"><strong>Address:</strong> ${centralConfig.hotelAddress}</p>
                                        <p style="margin: 3px 0; font-size: 11px; color: #334155; font-weight: normal;"><strong>Phone:</strong> ${centralConfig.centralNumber}</p>
                                        <p style="margin: 3px 0; font-size: 11px; color: #334155; font-weight: normal;"><strong>Email:</strong> ${centralConfig.centralizedEmail}</p>
                                        <p style="margin: 3px 0; font-size: 11px; color: #334155; font-weight: normal;"><strong>GST No:</strong> ${centralConfig.gstNumber}</p>
                                    </div>
                                </td>
                            </tr>
                        </table>

                        <!-- Footer and Social Links Grouped to Prevent Page Break -->
                        <div class="footer-group">
                            <div class="whatsapp-button">
                                <a href="https://wa.me/${serviceAdvisorMobile}" target="_blank">Chat on WhatsApp</a>
                            </div>

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

                            <div class="footer">
                                <p style="margin: 0; font-weight: normal;">We look forward to hosting you at ${centralConfig.hotelName} !</p>
                            </div>
                        </div>
                    </div>
                </div>
            </td>
            <td style="border: none;"></td>
        </tr>
    </tbody>
</table>
</body>
</html>
