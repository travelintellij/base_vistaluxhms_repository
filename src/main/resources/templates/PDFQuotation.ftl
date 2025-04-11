<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Quotation - Ashoka Tiger Trail Resort</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            font-size: 10px;
            margin: 0;
            padding: 15px;
            background-color: #f8f8f8;
            color: #333;
        }
        .container {
            background-color: #ffffff;
            padding: 10px;
            border-radius: 5px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }
        .header {
            text-align: center;
            padding-bottom: 5px;
        }
        .header img {
            max-width: 150px;
            height: 150;
        }
        .content h2, h3 {
            font-size: 12px;
            color: #2c3e50;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            font-size: 9px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 4px;
            text-align: left;
        }
        th {
            background-color: #2c3e50;
            color: white;
        }
        .footer {
            margin-top: 10px;
            text-align: center;
            font-size: 9px;
        }
        .whatsapp-button {
            text-align: center;
            margin-top: 10px;
        }

        .page-break {
            page-break-before: always;
        }

    .whatsapp-button a {
        display: inline-block;
        background-color: #25D366;
        color: white;
        padding: 8px 12px;
        text-decoration: none;
        border-radius: 5px;
        font-weight: bold;
    }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <img src="https://mcusercontent.com/3ca8771030e566eaeda03585a/images/45f87f1a-20c3-c7bb-4868-b011138e1a46.png" alt="Ashoka Tiger Trail Resort Logo" style="width: 200px; height: 200px;" />
    </div>
    <div class="content">
        <h2 style="text-align: center;">Quotation for Your Stay at Ashoka Tiger Trail Resort</h2>
        <p>Dear ${contactName},</p>
        <p>We are pleased to share the quotation for your stay at our resort, a 43-room property located in a prime location at Dhela.
            Our resort offers a perfect blend of luxury, comfort, and nature, ensuring a memorable experience for our guests. </p>

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
                <td>${room.formattedCheckInDate}</td>
                <td>${room.formattedCheckOutDate}</td>
                <td>INR ${room.totalPrice?string(",##0.00")}</td>
            </tr>
        </#list>
        </table>

        <h3>Grand Total: INR ${grandTotalSum?string(",##0.00")}</h3>
        <#if discount?number != 0>
            <h3>Discount: INR ${discount?string(",##0.00")}</h3>
            <h3>Final Price: INR ${finalPrice?string(",##0.00")}</h3>
        </#if>
    </div>

    <h3>Why Choose Us?</h3>
    <ul>
        <ul>
            <li><b><span style="color: green;">Prime Location:</span></b> Nestled in Dehala, our resort offers seamless access to Corbett’s wildlife and nature experiences.</li>
            <li><b><span style="color: green;">Gourmet Dining:</span></b> Enjoy a delightful culinary journey with our exclusive chef’s specialties at our multi-cuisine restaurant.</li>
            <li><b><span style="color: green;">Luxury Stay Options:</span></b> Choose from our Deluxe rooms or cozy cottages, designed for comfort and an immersive nature experience.</li>
            <li><b><span style="color: green;">Exclusive Experiences:</span></b> Make the most of your stay with nature walks, bonfire nights, and thrilling adventure activities.</li>
            <li><b><span style="color: green;">Eco-Friendly and Sustainable:</span></b> We believe in responsible tourism, ensuring a sustainable and green retreat for our guests.</li>
        </ul>
    </ul>
    <h3>Terms and Conditions:</h3>
    <ul>
        <li>50% advance payment is required to confirm the booking.</li>
        <li>Booking is refundable if canceled 7 days before check-in; non-refundable thereafter.</li>
        <li>Cancellation policy varies for packages, groups, and special events. Please confirm before booking.</li>
        <li>Prices are inclusive of GST and all applicable taxes.</li>
        <li>Additional extras (e.g. activities, transport) can be arranged at an extra cost.</li>
    </ul>

<table border="1" cellspacing="0" cellpadding="8" width="100%" style="border-collapse: collapse; text-align: left;">
    <thead>
    <tr>
        <th colspan="5" style="text-align: center;">Payment and Contact Details</th>
    </tr>
    </thead>
    <tbody>
    <!-- First Row: Bank Details -->
    <tr>
        <td><strong>Bank Name:</strong> Yes Bank</td>
        <td><strong>Account Name:</strong> VISTALUX</td>
        <td><strong>Account Number:</strong> 1058-2690-0000-144</td>
        <td><strong>IFSC Code:</strong> YESB0001058</td>
        <td><strong>Branch Name:</strong> Vishvas Nagar</td>
    </tr>
    <!-- Second Row: Contact Details -->
    <tr>
        <td><strong>Phone:</strong> +91 9090762424</td>
        <td><strong>Address</strong> Dhela, Ramnagar, Jim Corbett, Uttarakhand</td>
        <td><strong>Email:</strong> <a href="mailto:sales@vistaluxhotel.com">sales@vistaluxhotel.com</a></td>
        <td colspan="2" style="text-align: center;">
            <a href="https://wa.me/${serviceAdvisorMobile}" target="_blank" style="display: inline-block; background-color: #25D366; color: white; padding: 8px 12px; text-decoration: none; border-radius: 5px; font-weight: bold;">
                Chat on WhatsApp
            </a>
        </td>
    </tr>
    </tbody>
</table>

    <div class="footer">
        <p>We look forward to hosting you at Ashoka Tiger Trail Resort!</p>
    </div>
</div>
</body>
</html>