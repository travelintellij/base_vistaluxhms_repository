<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quotation - Ashoka Tiger Trail Resort</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f8f8f8;
        }
        .container {
            background-color: #ffffff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            position: relative;
        }
        .header {
            text-align: center;
            padding-bottom: 5px;
        }
        .header img {
            max-width: 120px;
            height: auto;
        }
        .content {
            position: relative;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #2c3e50;
            color: white;
        }
        .footer {
            margin-top: 15px;
            text-align: center;
            font-size: 14px;
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
        @media screen and (max-width: 600px) {
            table, th, td {
                font-size: 12px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div style="text-align: center; margin-bottom: 20px;">
        <img
                src="https://mcusercontent.com/3ca8771030e566eaeda03585a/images/45f87f1a-20c3-c7bb-4868-b011138e1a46.png"
                alt="Ashoka's Tiger Trail Resort"
                width="200" height="200"
                style="display: block; margin: 0 auto; width: 200px; height: 200px;"
        />
    </div>
    <div class="content">
        <h2 style="text-align:center">Exclusive Stay Quotation – Ashoka Tiger Trail Resort, Corbett</h2>

        <p>Dear ${contactName},</p>
        <p>We are pleased to share the quotation for your stay at Ashoka's Tiger Trail Resort, a perfect destination for weddings, corporate events, and leisure retreats. Nestled in the serene village of Dhela, our resort offers a British-era themed experience with 43 elegantly designed rooms, a swimming pool, spa, kids' zone, and restaurant.</p>

        <table>
            <tr>
                <th>Room Category</th>
                <th>Meal Plan</th>
                <th>Adults</th>
                <th>Children (with bed)</th>
                <th>Children (no bed)</th>
                <th>Extra Bed (Adult)</th>
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
                <td>${room.checkInDate}</td>
                <td>${room.checkOutDate}</td>
                <td>INR ${room.totalPrice?string(",##0.00")}</td>
            </tr>
            </#list>
              <tr>
                  <td colspan="6">&nbsp;</td>
                  <th style="background-color: maroon;color: white;padding: 10px;text-align: center;border: 1px solid #ddd;" colspan="2">Grand Total :</th>
                    <td><font color="blue"><b> &#8377; ${grandTotalSum} </b></font></td>
               </tr>
               <#if discount?number gt 0>
               <tr>
                    <td colspan="6">&nbsp;</td>
                    <th style="background-color: #1E90FF; color: white; padding: 10px; text-align: center; border: 1px solid #ddd;" colspan="2"> Discount :</th>
                    <td>&#8377; ${discount} </td>
               </tr>

               <tr>
                   <td colspan="6">&nbsp;</td>
                  <th style=" background-color:#4CAF50;color: white;padding: 10px;text-align: center;border: 1px solid #ddd;" colspan="2">Final Price :</th>
                   <td style="font-family: Arial, sans-serif;">&#8377;  <span id="finalPrice" style="font-size: 20px; font-weight: bold; color: blue;"> ${finalPrice}</span></td>
               </tr>
               </#if>
        </table>

        <h3>Terms & Conditions:</h3>
        <ul>
            <li>50% advance payment is required to confirm the booking.</li>
            <li>Booking is refundable if canceled 7 days before check-in; non-refundable thereafter.</li>
            <li>Cancellation policy varies for packages, groups, and special events. Please confirm before booking.</li>
            <li>Prices are inclusive of GST and all applicable taxes.</li>
            <li>Additional extras (e.g., activities, transport) can be arranged at an extra cost.</li>
        </ul>
        <hr/>
        <h3>Payment Details:</h3>
        <p><strong>Bank Name:</strong> Yes Bank</p>
        <p><strong>Account Name:</strong> VISTALUX</p>
        <p><strong>Account Number:</strong> 1058-2690-0000-144</p>
        <p><strong>IFSC Code:</strong> YESB0001058</p>
        <p><strong>Branch Name:</strong> Vishvas Nagar</p>

        <hr/>
        <h3>Resort Contact Details:</h3>
        <p><strong>Address:</strong> Ashoka's Tiger Trail Resort, Dhela, Jim Corbett National Park</p>
        <p><strong>Phone:</strong> +91 9090762424</p>
        <p><strong>Email:</strong> sales@vistaluxhotel.com</p>
        <p><strong>GST No:</strong> 05AAYFV9284F1ZB</p>

        <!-- WhatsApp Chat Button -->
        <div class="whatsapp-button">
            <a href="https://wa.me/${serviceAdvisorMobile}" target="_blank">Chat on WhatsApp</a>
        </div>

        <!-- Social Media Links -->
        <div class="social-links">
            <a href="https://www.facebook.com/AshokaTigerTrail" class="facebook" target="_blank">Facebook</a>
            <a href="https://www.instagram.com/ashoka_tiger_trail" class="instagram" target="_blank">Instagram</a>
            <a href="https://www.linkedin.com/company/ashokastigertrailresort/" class="linkedin" target="_blank">LinkedIn</a>
            <a href="mailto:sales@vistaluxhotel.com" class="email">Email</a>
            <a href="https://www.ashokastigertrail.com" class="website" target="_blank">Website</a>
        </div>
    </div>
    <div class="footer">
        <p>We look forward to hosting you at Ashoka Tiger Trail Resort!</p>
    </div>
</div>
</body>
</html>
