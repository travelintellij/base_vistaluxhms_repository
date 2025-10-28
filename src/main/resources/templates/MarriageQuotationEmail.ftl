<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Wedding Quotation</title>
    <style>
        body {
            font-family: Georgia, serif;
            background-color: #fff7f9;
            margin: 0;
            padding: 0;
            color: #6a1b3f;
        }

        .container {
            width: 100%;
            max-width: 600px;
            margin: 0 auto;
            background-color: #ffffff;
        }

        .top-bar {
            padding: 20px 30px 10px 30px;
            background-color: #fff7f9;
            overflow: hidden;
        }

        .logo {
            float: left;
        }

        .logo img {
            height: 120px;
            display: block;
        }

        .address {
            float: right;
            text-align: right;
            font-size: 16px;
            color: #6a1b3f;
            font-weight: bold;
        }

        .header {
            background-image: url('https://www.dropbox.com/scl/fi/es1lvnryfcb3d3edi3iy3/banner_image.jpg?rlkey=n1c83omswor5v7thtct9xu212&st=dnvnvkhu&raw=1');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            color: white;
            text-align: center;
            padding: 60px 20px;
        }

        .header h1 {
            font-size: 32px;
            margin: 0;
            text-shadow: 2px 2px 4px #00000050;
        }

        .section {
            padding: 15px 30px;
            border-bottom: 1px solid #f0b6c5;
        }

        .section h2, .section h3 {
            color: #b4004e;
        }

        .info-table, .service-table {
            width: 100%;
            border-collapse: collapse;
        }

        .info-table td, .service-table td, .service-table th {
            border: 1px solid #f0b6c5;
            padding: 8px;
            text-align: left;
        }

        .photo-collage {
            text-align: center;
        }

        .photo-collage img {
            width: 180px;
            height: 120px;
            object-fit: cover;
            border-radius: 8px;
            margin: 5px;
            border: 2px solid #f9d2e1;
        }

        .footer {
            padding: 25px 30px;
            background-color: #fde9ef;
            font-size: 14px;
            color: #7a0040;
            text-align: center;
        }

        .highlight-box {
            background-color: #fff0f5;
            border-radius: 8px;
            padding: 12px;
            margin-top: 20px;
        }

        ul {
            padding-left: 20px;
            margin: 0;
        }

        .testimonial {
            margin-top: 30px;
            font-style: italic;
            border-left: 4px solid #ccc;
            padding-left: 15px;
            color: #555;
        }

        @media only screen and (max-width: 600px) {
            .top-bar {
                display: block;
                text-align: center;
            }
            .logo, .address {
                float: none;
                text-align: center;
            }
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
<div class="container">
    <div class="top-bar">
        <div class="logo">
            <img src="${centralConfig.logoPath}" alt="Ashoka"/>
        </div>
        <div class="address">
            <p>${centralConfig.hotelName}| ${centralConfig.hotelAddress}<br/>${centralConfig.centralNumber} | ${centralConfig.centralizedEmail} </p>
        </div>
        <div style="clear: both;"></div>
    </div>

    <div class="header">
        <h1>Wedding Quotation</h1>
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
  <h2>Wedding Photo Inspirations</h2>
  <div class="photo-collage">
    <#if eventConfig.imageUrl1?? && eventConfig.imageUrl1?has_content>
      <img src="${eventConfig.imageUrl1}" alt="Quotation Image 1"/>
    </#if>
    <#if eventConfig.imageUrl2?? && eventConfig.imageUrl2?has_content>
      <img src="${eventConfig.imageUrl2}" alt="Quotation Image 2"/>
    </#if>
    <#if eventConfig.imageUrl3?? && eventConfig.imageUrl3?has_content>
      <img src="${eventConfig.imageUrl3}" alt="Quotation Image 3"/>
    </#if>
    <#if eventConfig.imageUrl4?? && eventConfig.imageUrl4?has_content>
      <img src="${eventConfig.imageUrl4}" alt="Quotation Image 4"/>
    </#if>
    <#if eventConfig.imageUrl5?? && eventConfig.imageUrl5?has_content>
      <img src="${eventConfig.imageUrl5}" alt="Quotation Image 5"/>
    </#if>
    <#if eventConfig.imageUrl6?? && eventConfig.imageUrl6?has_content>
      <img src="${eventConfig.imageUrl6}" alt="Quotation Image 6"/>
    </#if>
  </div>
</div>




<div class="section">
    <h2 style="text-align: center; color: #2e6c80;">Welcome to ${centralConfig.hotelName}</h2>
    ${eventConfig.resortInfo}

    <!-- Highlights Box with Floral Background -->
       <div style="border: 1px solid #ccc; border-radius: 8px; padding: 10px 15px; margin-top: 20px; background-image: url('flower-bg.jpg'); background-size: cover; background-position: center; color: #2e2e2e;">
           <div style="background-color: rgba(255,255,255,0.85); padding: 10px 12px; border-radius: 6px;">
              ${eventConfig.celebrationHighlight}
           </div>
       </div>

    ${eventConfig.testimonial}
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
            <#if discount &gt; 0>
                <tr>
                    <td>&nbsp;</td>
                    <td colspan="2"><div class="discount">Discount: ₹${discount?string["#,##0"]}</div></td>
                </tr>
            </#if>
            <tr>
                <td>&nbsp;</td>
                <td colspan="2"><div class="total">Total: ₹${(grand_total_cost - discount)?string["#,##0"]}</div></td>
            </tr>
            </tbody>
        </table>
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

        <div class="total">Total: ₹${(grand_total_cost - discount)?string["#,##0"]}</div>
    </div>
</#if>

<#if remarks?? && remarks?has_content>
    <div class="section" style="margin-top: 30px;">
        <h2 style="background-color: #f0f0f0; padding: 10px; border-radius: 5px;">Remarks</h2>
        <p style="font-size: 14px; line-height: 1.6;">
            ${remarks}
        </p>
    </div>
</#if>

    <div style="border: 1px solid #ccc; border-radius: 8px; padding: 10px 15px; margin-top: 20px; background-image: url('flower-bg.jpg'); background-size: cover; background-position: center; color: #2e2e2e;">
        <div style="background-color: rgba(255,255,255,0.85); padding: 10px 12px; border-radius: 6px;">
            <h3 style="color: #2e6c80; margin-bottom: 10px; margin-top: 0;">Terms and Conditions</h3>
            <ul style="margin: 0 0 0 18px; font-size: 14px; line-height: 1.6;">
                <#if gstIncluded>
                            <li>All prices are inclusive of GST and other applicable taxes.</li>
                        <#else>
                            <li>GST and other applicable taxes will be charged extra.</li>
                        </#if>
                       ${eventConfig.termsConditions}
                    </ul>
                    <p>For queries, please contact us at <strong>+91-9090762424</strong> or email <strong>sales@vistaluxhotel.com</strong></p>
            </ul>
        </div>
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
