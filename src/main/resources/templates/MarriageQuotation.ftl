<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Wedding Quotation</title>
    <style>
        body {
            font-family: 'Georgia', serif;
            background-color: #fff7f9;
            margin: 0;
            padding: 0;
            color: #6a1b3f;
        }

        .header {
            background-image: url('${eventConfig.bannerImageBase64}');
            background-size: cover;
            background-position: center;
	        background-repeat: no-repeat;
            background-size: cover;
            background-position: center;
            color: white;
            padding: 80px 30px 60px 30px;
            text-align: center;
            position: relative;
	    min-height: 100px; /* Ensures enough space for image visibility */

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
            width: 180px;        /* fixed width */
            height: 120px;       /* fixed height */
            object-fit: cover;   /* maintains aspect ratio, crops extra */
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
            padding: 25px 30px;
            background-color: #fde9ef;
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
            background-color: #fff7f9;
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

    </style>
</head>
<body>

<div class="top-bar">
    <div class="logo">
        <!--<img src="https://mcusercontent.com/3ca8771030e566eaeda03585a/images/45f87f1a-20c3-c7bb-4868-b011138e1a46.png" alt="Resort Logo" />-->
        <img src="${centralConfig.logoPath}" alt="Logo" width="100" height="100" />
    </div>
    <div class="address">
        <p>${centralConfig.hotelName}| ${centralConfig.hotelAddress}<br/>${centralConfig.centralNumber} | ${centralConfig.centralizedEmail} </p>
    </div>
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
       <#list eventConfig.galleryImageDataUrls as img>
           <#if img?? && img?has_content>
               <img src="${img}" alt="Quotation Image"/>
           </#if>
       </#list>
    </div>


    <div style="page-break-after: always;"></div>
</div>

<div class="section">
    <h2 style="text-align: center; color: #2e6c80;">Welcome to Ashoka's Tiger Trail Resort – Corbett</h2>

    <p style="font-size: 14px; line-height: 1.6;">
        We are delighted to present our proposal for hosting your upcoming marriage celebration at <strong>Ashoka’s Tiger Trail Resort</strong>, nestled in the pristine wilderness of Jim Corbett National Park. Our resort, spread across lush landscapes and surrounded by nature, offers an ideal setting for a destination wedding that blends elegance with the tranquility of the forest.
    </p>

    <p style="font-size: 14px; line-height: 1.6;">
        Whether you envision an intimate gathering or a grand celebration, our experienced hospitality team is committed to ensuring that every moment is seamlessly executed — from the décor to gourmet dining, from themed functions to personalized experiences.
    </p>

    <p style="font-size: 14px; line-height: 1.6;">
        This proposal outlines the accommodations, event venues, services, and arrangements we would be honored to provide for your special occasion. Our aim is to offer a memorable, comfortable, and joyful experience for you and your guests.
    </p>

    <p style="font-size: 14px; line-height: 1.6;">
        We look forward to being part of your most cherished celebration and delivering an event that is both unique and unforgettable.
    </p>

    <!-- Highlights Box with Floral Background -->
    <div style="border: 1px solid #ccc; border-radius: 8px; padding: 10px 15px; margin-top: 20px; background-image: url('flower-bg.jpg'); background-size: cover; background-position: center; color: #2e2e2e;">
        <div style="background-color: rgba(255,255,255,0.85); padding: 10px 12px; border-radius: 6px;">
            <h3 style="color: #2e6c80; margin-bottom: 10px; margin-top: 0;">Wedding Celebration Highlights</h3>
            <ul style="margin: 0 0 0 18px; font-size: 14px; line-height: 1.6;">
                <li>42 spacious rooms and luxury suites with modern amenities</li>
                <li>Open-air lawns for Mehendi, Haldi, and Sangeet ceremonies</li>
                <li>Indoor banquet hall ideal for formal functions or receptions</li>
                <li>Scenic forest backdrops for couple photoshoots</li>
                <li>Custom floral décor, mandap setups &amp; lighting themes</li>
                <li>Dedicated bridal preparation suite &amp; guest hospitality desk</li>
                <li>Live food counters, customizable veg/non-veg menus</li>
                <li>Bonfire arrangements, wildlife safaris &amp; local experiences</li>
            </ul>
        </div>
    </div>

    <!-- Additional Testimonial -->
    <div style="margin-top: 30px; font-style: italic; border-left: 4px solid #ccc; padding-left: 15px; color: #555;">
        “The tranquil forest vibe added such uniqueness to our wedding. Our guests still talk about it!”<br/>
        <strong>– Mr. Tiwari and Family, Delhi NCR</strong>
    </div>

    <div style="margin-top: 30px; font-style: italic; border-left: 4px solid #ccc; padding-left: 15px; color: #555;">
        “Every detail was handled with care — from the decor to the food. The resort staff made us feel like royalty and our families were truly impressed.”<br/>
        <strong>–  From a Recent Wedding Party,  Delhi NCR</strong>
    </div>

    <div style="margin-top: 30px; font-style: italic; border-left: 4px solid #ccc; padding-left: 15px; color: #555;">
        "Organizing a destination wedding at Ashoka’s Tiger Trail Resort was an absolute delight. The resort team was proactive, professional, and handled every request with efficiency and grace. Our clients were extremely happy, and the event went off without a hitch. It’s rare to find a venue that combines natural beauty with such high standards of service."<br/>
        <strong>–  Mr. Gopi, Corbett</strong>
    </div>

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
        <li>Rates are subject to availability and change until confirmed.</li>
        <li>Booking is confirmed only upon receiving advance payment.</li>
        <li>Event decor and customizations are chargeable based on requirements.</li>
        <li>Final guest count must be confirmed at least 10 days prior to the event.</li>
        <li>Outdoor events are subject to weather; backup arrangements may be made if required.</li>
        <li>Liquor services require valid permits, to be arranged separately.</li>
        <li>External vendors are subject to resort approval.</li>
        <li>Check-in and check-out times are as per resort policy.</li>
        <li>The resort is not responsible for any personal loss or damage during the event.</li>
    </ul>
    <p>For queries, please contact us at <strong>+91-9090762424</strong> or email <strong>sales@vistaluxhotel.com</strong></p>
</div>

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



</body>
</html>
