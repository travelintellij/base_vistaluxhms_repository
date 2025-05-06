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
            background-image: url('https://mcusercontent.com/b524536bce55ad238411aa638/images/5e424e73-2127-47ee-3a6c-f98219f37551.jpg?fit=crop&amp;w=1500&amp;q=80');
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

    </style>
</head>
<body>

<div class="top-bar">
    <div class="logo">
        <img src="https://mcusercontent.com/3ca8771030e566eaeda03585a/images/45f87f1a-20c3-c7bb-4868-b011138e1a46.png" alt="Resort Logo" />
    </div>
    <div class="address">
        <p>Ashoka's Tiger Trail Resort | Corbett, Uttarakhand<br/>9090762424 | sales@vistaluxhotel.com </p>
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
    <p>
        Thank you for considering <strong>Ashoka’s Tiger Trail Resort</strong> for your upcoming corporate event. Our resort offers a serene and focused environment ideal for strategic meetings, team-building sessions, workshops, or offsite retreats.
    </p>
    <p>
        We are committed to delivering a seamless experience with the right mix of comfort, professionalism, and personalized service to ensure your event is impactful and productive.
    </p>

   <div class="highlight-box">
          <h3>Event Highlights &amp; Offerings</h3>
          <ul>
              <li>42 well-appointed rooms with modern amenities</li>
              <li>Indoor conference hall with AV equipment</li>
              <li>Breakout spaces and outdoor lawns for team activities</li>
              <li>Customizable meal plans (veg/non-veg)</li>
              <li>Bonfire, wildlife safari &amp; nature walks for leisure</li>
              <li>Dedicated event coordinator &amp; on-site support</li>
          </ul>
      </div>

<div class="section">
    <h2>Photo Gallery</h2>
    <div class="photo-collage">
        <img src="https://mcusercontent.com/b524536bce55ad238411aa638/images/89e9c291-2a41-cb74-5abc-40cd8bf54a78.jpeg?fit=crop&amp;w=600&amp;q=80" alt="5" />
        <img src="https://mcusercontent.com/b524536bce55ad238411aa638/images/93a3c3c9-b2c3-2b41-15d2-50f7aad8a631.jpeg?fit=crop&amp;w=600&amp;q=80" alt="Team Meeting" />
        <img src="https://images.unsplash.com/photo-1557804506-669a67965ba0?fit=crop&amp;w=600&amp;q=80" alt="Conference" />
        <img src="https://mcusercontent.com/b524536bce55ad238411aa638/images/a6f572c5-8eb7-106b-ecab-4197919c936a.png?fit=crop&amp;w=600&amp;q=80" alt="Team Building" />
        <img src="https://mcusercontent.com/b524536bce55ad238411aa638/images/43c37228-758e-fc5d-335a-f89fa80f2fef.jpeg?fit=crop&amp;w=600&amp;q=80" alt="Networking" />
        <img src="https://mcusercontent.com/b524536bce55ad238411aa638/images/8928c72a-cfa1-eebd-7881-0d2563bd4627.jpeg?fit=crop&amp;w=600&amp;q=80" alt="Networking" />
    </div>
</div>

    <!-- Additional Testimonial -->
    <div style="margin-top: 30px; font-style: italic; border-left: 4px solid #ccc; padding-left: 15px; color: #555;">
        "Ashoka's Tiger Trail Resort provided the perfect setting for our corporate retreat. The serene atmosphere helped our team stay focused, while the modern amenities and impeccable service ensured that our meetings were productive. The venue was spacious and well-equipped, and the team went above and beyond to tailor every aspect to our needs. Highly recommend for any corporate event!"<br/>
        <strong>– Confidential, Ahmedabad</strong>
    </div>

    <div style="margin-top: 30px; font-style: italic; border-left: 4px solid #ccc; padding-left: 15px; color: #555;">
        "We hosted our annual leadership meeting at Ashoka's Tiger Trail Resort, and it was an incredible experience. The combination of state-of-the-art conference facilities and the beautiful natural surroundings made it the ideal venue for our team-building exercises and strategic sessions. The staff was professional, accommodating, and ensured everything went smoothly. It was a memorable event that enhanced both productivity and morale."<br/>
        <strong>–  From a Recent MICE Event,  Delhi NCR</strong>
    </div>

    <div style="margin-top: 30px; font-style: italic; border-left: 4px solid #ccc; padding-left: 15px; color: #555;">
        "Ashoka Tiger Trail Resort provided the perfect setting for our corporate offsite. The serene surroundings and state-of-the-art conference facilities enabled us to focus on strategic planning and team-building activities. The staff was incredibly professional, ensuring every detail was handled seamlessly. A truly memorable experience that fostered collaboration and innovation among our team!"<br/>
        <strong>– Sushil, Delhi NCR </strong>
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
