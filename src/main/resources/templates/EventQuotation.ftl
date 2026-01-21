<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Event Quotation</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f8fb;
            margin: 0;
            padding: 0;
            color: #2c3e50;

        }

        .header {
            background-image: url('${eventConfig.bannerImageBase64}');
            background-repeat: no-repeat;
            background-size: cover;
            background-position: center;
            color: white;
            padding: 80px 30px 60px 30px;
            text-align: center;
            position: relative;
            min-height: 100px;
        }


        .header h1 {
            font-size: 36px;
            text-shadow: 2px 2px 4px #00000050;
        }

        .logo {
            position: absolute;
            top: 10px;
            left: 30px;
        }

        .logo img {
            height: 200px;
        }

        .section {
            padding: 15px;
            border-bottom: 1px solid #f0b6c5;
        }

        .section h2, .section h3 {
            color: #b4004e;
        }

        .info-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        .info-table td {
            padding: 8px;
            border: 1px solid #f0b6c5;
        }

        .photo-collage {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            justify-content: center;
            margin-top: 10px;
        }

        .photo-collage img {
            width: 180px;
            height: 120px;
            object-fit: cover;
            border-radius: 8px;
            border: 2px solid #f9d2e1;
            box-shadow: 2px 2px 6px #00000020;
        }

      .service-table {
          width: 100%; /* or set a fixed width like 600px */
          table-layout: fixed; /* makes column widths consistent */
          border-collapse: collapse;
          margin-top: 10px;
      }

      .service-table td, .service-table th {
          border: 1px solid #ccc;
          padding: 8px;
          word-wrap: break-word; /* wrap long words */
          white-space: normal;   /* allow text to wrap normally */
          vertical-align: top;
          text-align: left;
      }

      /* Optional: make columns look symmetrical even if there's less text */
      .service-table tr td {
          height: auto;
      }

        .grid-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 15px;
            margin-top: 15px;
        }

        .grid-box {
            background-color: #fff0f5;
            padding: 12px;
            border-radius: 8px;
            box-shadow: 0 2px 5px #00000010;
            text-align: center;
        }

        .footer {
            padding: 20px 25px;
            background-color: #ecf3f8;
            font-size: 14px;
            color: #7a0040;
        }

        .total {
            font-weight: bold;
            text-align: right;
            margin-top: 10px;
        }

        .discount {
            text-align: right;
            color: #c2185b;
            font-weight: bold;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 30px 10px 30px;
            background-color: #ecf3f8;

        }

        .logo img {
            height: 120px;
        }

        .address {
            text-align: right;
            font-size: 16px;
            color: #6a1b3f;
            font-weight: bold;
        }
.social-links {
            text-align: center;
            margin-top: 20px;
        }
        .social-links a {
            margin: 0 10px;
            text-decoration: none;
            color: white;
            padding: 10px 15px;
            border-radius: 5px;
            display: inline-block;
        }
        .facebook { background-color: #3b5998; }
        .instagram { background-color: #e4405f; }
        .linkedin { background-color: #0077b5; }
        .email { background-color: #ff6600; }
        .website { background-color: #000; }
        .twitter {
            background-color: #1DA1F2;
        }
        .whatsapp-button {
            text-align: center;
            margin-top: 20px;
        }
        .whatsapp-button a {
            background-color: #25D366;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            font-size: 16px;
            border-radius: 5px;
            display: inline-block;
        }
    </style>
</head>
<body>

<div class="top-bar">
    <div class="logo">
        <!-- <img src="${centralConfig.logoPath}" alt="Logo" width="200" height="200" style="display: block; margin: 0 auto; width: 200px; height: 200px;"/> -->
        <img src="${centralConfig.logoPath}" alt="Logo" width="100" height="100" />
    </div>
    <div class="address">
        <p>${centralConfig.hotelName}| ${centralConfig.hotelAddress}<br/>${centralConfig.centralNumber} | ${centralConfig.centralizedEmail} </p>
    </div>
</div>


<div class="header">
    <h1>Event Quotation</h1>
</div>

<div class="section">
    <h2>Event Information</h2>
    <table class="info-table">
        <tr><td><strong>Name:</strong></td><td>${guestName}</td></tr>
        <tr><td><strong>Event Dates:</strong></td><td>${eventStartDate} to ${eventEndDate}</td></tr>
        <tr><td><strong>No. of Rooms:</strong></td><td>${numberOfRooms}</td></tr>
        <tr><td><strong>No. of Guests:</strong></td><td>${baseGuestCount}</td></tr>
    </table>
</div>


<div class="section">
   <h2>Venue &amp; Experience Overview</h2>
   ${eventConfig.resortInfo}

   <div class="highlight-box">
           ${eventConfig.celebrationHighlight}
      </div>
<div style="page-break-after: always;"></div>
<div class="section">
    <h2>Photo Gallery</h2>
    <div class="photo-collage">
       <#list eventConfig.galleryImageDataUrls as img>
                  <#if img?? && img?has_content>
                      <img src="${img}" alt="Quotation Image"/>
                  </#if>
              </#list>
    </div>
</div>

 ${eventConfig.testimonial}

    <!-- Additional Testimonial -->


    <!-- Page Break Before Next Section -->
    <div style="page-break-after: always;"></div>
</div>


<#if showBreakup>
    <div class="section">
        <h2>Cost Breakup</h2>
        <table class="service-table">
            <thead>
                <tr><th>Service Name</th><th>Cost Type</th><th>Amount (INR)</th></tr>
            </thead>
            <tbody>
            <#list services as service>
                <tr>
                    <td>${service.name}</td>
                    <td>${service.costType}</td>
                    <td>${service.amount?string["#,##0"]}</td>
                </tr>
            </#list>
            </tbody>
        </table>
        <#if discount &gt; 0>
            <div class="discount">Discount: ₹${discount?string["#,##0"]}</div>
        </#if>
        <div class="total">Total: ₹${(grand_total_cost - discount)?string["#,##0"]}</div>
    </div>
<#else>
    <div class="section">
        <h2>Services Included</h2>

        <#if services?size <= 5>
            <table class="service-table">
                <tbody>
                    <#list services as service>
                        <tr>
                            <td>${service.name}</td>
                        </tr>
                    </#list>
                </tbody>
            </table>
        <#else>
            <table class="service-table">
                <tbody>
                    <#list services?chunk(2) as row>
                        <tr>
                            <#list row as service>
                                <td>${service.name}</td>
                            </#list>
                            <#if row?size < 2>
                                <#list 1..(2 - row?size) as i>
                                    <td></td> <!-- Empty cell for alignment -->
                                </#list>
                            </#if>
                        </tr>
                    </#list>
                </tbody>
            </table>
        </#if>
    <div class="total" style="margin-top:20px;">Total: ₹${(grand_total_cost - discount)?string["#,##0"]}</div>
    </div>
</#if>

<#if remarks?? && remarks?has_content>
    <div class="section" style="margin-top: 30px;">
        <h2>Remarks</h2>
        <p style="font-size: 14px; line-height: 1.6;">
            ${remarks}
        </p>
    </div>
</#if>

<div class="footer">
    <h3>Terms and Conditions</h3>
    <ul>
        <#if gstIncluded>
            <li>All prices are inclusive of GST and other applicable taxes.</li>
        <#else>
            <li>GST and other applicable taxes will be charged extra.</li>
        </#if>
         ${eventConfig.termsConditions}
    </ul>
    <p>For queries, please contact us at <strong>${centralConfig.centralNumber} </strong> or email <strong>${centralConfig.centralizedEmail}</strong></p>
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




</body>
</html>
