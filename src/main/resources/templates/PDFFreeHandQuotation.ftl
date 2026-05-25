<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Quotation - Winsome Resorts & Spa</title>
    <style>
        @page {
            size: A4;
            margin: 0;
        }
        body {
            font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
            font-size: 16px;
            line-height: 1.6;
            font-weight: bold;
            margin: 0;
            padding: 0;
            background-color: transparent;
            color: #000000;
        }
        .pdf-bg-img {
            position: fixed;
            top: 0;
            left: 0;
            width: 210mm;
            height: 297mm;
            z-index: -1000;
            opacity: 0.10;
        }

        .container {
            background-color: transparent;
            padding: 10px;
            border-radius: 5px;
            box-shadow: none;
        }

        .header {
            text-align: center;
            padding-bottom: 5px;
        }

        .header img {
            max-width: 150px;
            height: 150px;
        }

        table.room-table {
            width: 130mm;
            table-layout: fixed;
            border-collapse: collapse;
            margin-top: 10px;
            font-size: 12px;
        }

        table.room-table, table.room-table th, table.room-table td {
            border: 1px solid #cbd5e1;
        }

        table.room-table th, table.room-table td {
            padding: 6px 8px;
            text-align: left;
        }

        table.room-table th {
            background-color: #0f2b46;
            color: white;
            font-weight: bold;
        }
        
        table.room-table tr:nth-child(even) {
            background-color: #f8fafc;
        }

        .footer {
            margin-top: 25px;
            text-align: center;
            font-size: 9px;
            color: #000000;
        }

        .whatsapp-button {
            text-align: center;
            margin-top: 20px;
        }

        .whatsapp-button a {
            display: inline-block;
            background-color: #25D366;
            color: white;
            padding: 8px 16px;
            text-decoration: none;
            border-radius: 4px;
            font-weight: bold;
            font-size: 15.5px;
        }

        .quotation-header {
            text-align: center;
            font-size: 18px;
            color: #0f2b46;
            font-family: 'Georgia', serif;
            font-weight: bold;
            margin-bottom: 20px;
            text-transform: uppercase;
            letter-spacing: 1px;
            border-bottom: 2px solid #0f2b46;
            padding-bottom: 6px;
        }

        .social-links {
            text-align: center;
            margin-top: 20px;
        }

        .social-links a {
            margin: 0 5px;
            text-decoration: none;
            color: white;
            padding: 6px 12px;
            border-radius: 4px;
            display: inline-block;
            font-size: 12px;
            font-weight: bold;
        }

        .facebook { background-color: #3b5998; }
        .instagram { background-color: #e4405f; }
        .linkedin { background-color: #0077b5; }
        .email { background-color: #ff6600; }
        .website { background-color: #0f2b46; }
        .twitter { background-color: #1DA1F2; }

        .rover {
            page-break-inside: avoid;
            break-inside: avoid;
            margin-top: 15px;
        }
        
        .section-title {
            font-size: 15.5px;
            color: #0f2b46;
            font-weight: bold;
            text-transform: uppercase;
            border-bottom: 1.5px solid #cbd5e1;
            padding-bottom: 4px;
            margin-top: 20px;
            margin-bottom: 10px;
        }
        
        .remarks-box {
            margin-top: 20px;
            padding: 12px 16px;
            border-left: 4px solid #10b981;
            background-color: #f0fdf4;
            border-top: 1px solid #cbd5e1;
            border-right: 1px solid #cbd5e1;
            border-bottom: 1px solid #cbd5e1;
            border-radius: 4px;
        }
        .remarks-title {
            color: #047857;
            font-weight: bold;
            margin: 0 0 6px 0;
            font-size: 15.5px;
            text-transform: uppercase;
        }
    </style>
</head>
<body>
<img src="data:image/jpeg;base64,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" class="pdf-bg-img" alt="background"/>
<table style="width: 210mm; table-layout: fixed; border-collapse: collapse; border: none; margin: 0; padding: 0;">
    <colgroup>
        <col style="width: 40mm;" />
        <col style="width: 130mm;" />
        <col style="width: 40mm;" />
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
        <!--<img src="https://mcusercontent.com/3ca8771030e566eaeda03585a/images/45f87f1a-20c3-c7bb-4868-b011138e1a46.png" alt="Ashoka Tiger Trail Resort Logo" style="width: 200px; height: 200px;" />-->
        <img src="${centralConfig.logoPath}" alt="Logo" width="200" height="200" style="display: block; margin: 0 auto; width: 200px; height: 200px;"/>
    </div>
    <div class="content">
        <h2 style="text-align: center;">Exclusive Stay Quotation – ${centralConfig.hotelName}</h2>
        <p>Dear ${contactName},</p>
       <#if centralConfig.quotationTopCover?has_content>
           ${centralConfig.quotationTopCover?html?replace("\\r?\\n", "<br/>", "r")}
       </#if>

        <table class="room-table">
            <colgroup>
                <col style="width: 28mm;" />
                <col style="width: 12mm;" />
                <col style="width: 12mm;" />
                <col style="width: 10mm;" />
                <col style="width: 14mm;" />
                <col style="width: 18mm;" />
                <col style="width: 18mm;" />
                <col style="width: 18mm;" />
            </colgroup>
            <tr>
                <th>Room Details</th>
                <th>Meal Plan</th>
                <th>No. of Rooms</th>
                <th>Adults</th>
                <th>Child(ren)</th>
                <th>Check-in</th>
                <th>Check-out</th>
                <th>Total Price</th>
            </tr>
            <#list roomDetails as room>
            <tr>
                <td>${room.roomCategoryName}</td>
                <td>${room.mealPlanName}</td>
                <td>${room.noOfRooms}</td>
                <td>${room.adults}</td>
                <td>${room.noOfChild}</td>
                <td>${room.formattedCheckInDate}</td>
                <td>${room.formattedCheckOutDate}</td>
                <td>INR ${room.totalPrice?string(",##0.00")}</td>
            </tr>
        </#list>
        </table>
    <#if remarks?? && (remarks?trim?length > 0)>
        <div class="remarks-box">
            <h3 class="remarks-title">Remarks</h3>
            <p style="margin: 0; font-size: 13px;">
                ${remarks?html}
            </p>
        </div>
    </#if>

        <div style="margin-top:20px;padding:12px;border:1px solid #cbd5e1;background:#f8fafc;border-radius:6px;width:100%;">
            <table style="width:100%;border-collapse:collapse;border:none;margin-top:0;">
                <tr style="border:none;">
                    <td style="border:none;padding:4px 0;font-size: 13px;color:#000000;font-weight:bold;">Grand Total:</td>
                    <td style="border:none;padding:4px 0;text-align:right;font-size: 15.5px;color:#0f2b46;font-weight:bold;">INR ${grandTotalSum?string(",##0.00")}</td>
                </tr>
                <#if discount?number != 0>
                <tr style="border:none;">
                    <td style="border:none;padding:4px 0;font-size: 13px;color:#d32f2f;font-weight:bold;">Discount:</td>
                    <td style="border:none;padding:4px 0;text-align:right;font-size: 15.5px;color:#d32f2f;font-weight:bold;">INR ${discount?string(",##0.00")}</td>
                </tr>
                <tr style="border:none;border-top:1.5px solid #cbd5e1;">
                    <td style="border:none;padding:8px 0 0 0;font-size: 14.5px;color:#0f2b46;font-weight:bold;">Final Price:</td>
                    <td style="border:none;padding:8px 0 0 0;text-align:right;font-size: 15.5px;color:#0f2b46;font-weight:bold;">INR ${finalPrice?string(",##0.00")}</td>
                </tr>
                </#if>
            </table>
        </div>
     </div>

          <#if centralConfig.inclusions?has_content>
      <div class="rover">
             <h3 class="section-title">Inclusions</h3>
             <ul class="bullet-list">
                 <#list centralConfig.inclusions?split("\\r?\\n", "r") as line>
                     <#assign cleanLine = line?trim>
                     <#if cleanLine?length > 0>
                         <#if cleanLine?starts_with("- ")><#assign cleanLine = cleanLine?substring(2)>
                         <#elif cleanLine?starts_with("* ")><#assign cleanLine = cleanLine?substring(2)>
                         <#elif cleanLine?starts_with("• ")><#assign cleanLine = cleanLine?substring(2)>
                         <#elif cleanLine?starts_with("•")><#assign cleanLine = cleanLine?substring(1)>
                         </#if>
                         <li>${cleanLine?html}</li>
                     </#if>
                 </#list>
             </ul>
      </div>
     </#if>

          <#if centralConfig.usp?has_content>
      <div class="rover">
             <h3 class="section-title">Why Choose Us?</h3>
             <ul class="bullet-list">
                 <#list centralConfig.usp?split("\\r?\\n", "r") as line>
                     <#assign cleanLine = line?trim>
                     <#if cleanLine?length > 0>
                         <#if cleanLine?starts_with("- ")><#assign cleanLine = cleanLine?substring(2)>
                         <#elif cleanLine?starts_with("* ")><#assign cleanLine = cleanLine?substring(2)>
                         <#elif cleanLine?starts_with("• ")><#assign cleanLine = cleanLine?substring(2)>
                         <#elif cleanLine?starts_with("•")><#assign cleanLine = cleanLine?substring(1)>
                         </#if>
                         <li>${cleanLine?html}</li>
                     </#if>
                 </#list>
             </ul>
      </div>
     </#if>

        <#if centralConfig.tnc?has_content>
     <div class="rover">
            <h3 class="section-title">Terms &amp; Conditions</h3>
            <ul class="bullet-list">
                <#list centralConfig.tnc?split("\\r?\\n", "r") as line>
                    <#assign cleanLine = line?trim>
                    <#if cleanLine?length > 0>
                        <#if cleanLine?starts_with("- ")><#assign cleanLine = cleanLine?substring(2)>
                        <#elif cleanLine?starts_with("* ")><#assign cleanLine = cleanLine?substring(2)>
                        <#elif cleanLine?starts_with("• ")><#assign cleanLine = cleanLine?substring(2)>
                        <#elif cleanLine?starts_with("•")><#assign cleanLine = cleanLine?substring(1)>
                        </#if>
                        <li>${cleanLine?html}</li>
                    </#if>
                </#list>
            </ul>
       </div>
    </#if>

    <table style="width: 100%; border: none; margin-top: 20px; border-collapse: collapse;">
        <tr>
            <td style="width: 48%; border: none; vertical-align: top; padding-right: 4%;">
                <h3 class="section-title">Payment Details</h3>
                <p style="margin: 4px 0; font-size: 13px; color:#000000;"><strong>Bank Name:</strong> ${centralConfig.bankName}</p>
                <p style="margin: 4px 0; font-size: 13px; color:#000000;"><strong>Account Name:</strong> ${centralConfig.accountName}</p>
                <p style="margin: 4px 0; font-size: 13px; color:#000000;"><strong>Account Number:</strong> ${centralConfig.accountNumber}</p>
                <p style="margin: 4px 0; font-size: 13px; color:#000000;"><strong>IFSC Code:</strong> ${centralConfig.ifscCode}</p>
                <p style="margin: 4px 0; font-size: 13px; color:#000000;"><strong>Branch Name:</strong> ${centralConfig.branch}</p>
            </td>
            <td style="width: 48%; border: none; vertical-align: top;">
                <h3 class="section-title">Resort Contact Details</h3>
                <p style="margin: 4px 0; font-size: 13px; color:#000000;"><strong>Address:</strong> ${centralConfig.hotelAddress}</p>
                <p style="margin: 4px 0; font-size: 13px; color:#000000;"><strong>Phone:</strong> ${centralConfig.centralNumber}</p>
                <p style="margin: 4px 0; font-size: 13px; color:#000000;"><strong>Email:</strong> ${centralConfig.centralizedEmail}</p>
                <p style="margin: 4px 0; font-size: 13px; color:#000000;"><strong>GST No:</strong> ${centralConfig.gstNumber}</p>
            </td>
        </tr>
    </table>

        <!-- WhatsApp Chat Button -->
        <div class="whatsapp-button">
            <a href="https://wa.me/${serviceAdvisorMobile}" target="_blank">Chat on WhatsApp</a>
        </div>

        <!-- Social Media Links -->
        <!-- <div class="social-links">
            <a href="${centralConfig.facebookLink}" class="facebook" target="_blank">Facebook</a>
            <a href="${centralConfig.instagramLink}" class="instagram" target="_blank">Instagram</a>
            <a href="${centralConfig.linkedinLink}" class="linkedin" target="_blank">LinkedIn</a>
            <a href="${centralConfig.xLink}" class="twitter" target="_blank">Twitter</a>
            <a href="mailto:${centralConfig.centralizedEmail}" class="email">Email</a>
            <a href="${centralConfig.website}" class="website" target="_blank">Website</a>
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
    <div class="footer">
        <p>We look forward to hosting you at ${centralConfig.hotelName} !</p>
    </div>
                </div>
            </td>
            <td style="border: none;"></td>
        </tr>
    </tbody>
</table>
</body>
</html>
