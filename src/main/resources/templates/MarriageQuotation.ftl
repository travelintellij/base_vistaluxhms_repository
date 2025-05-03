<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
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
            background-image: url('https://mcusercontent.com/b524536bce55ad238411aa638/images/b0b22964-b8d6-b349-800f-990f03a5ea12.jpg?fit=crop&w=1500&q=80');
	    background-repeat: no-repeat;
            background-size: cover;
            background-position: center;
            color: white;
            padding: 80px 30px 60px 30px;
            text-align: center;
            position: relative;
	    min-height: 200px; /* Ensures enough space for image visibility */

        }

        .header h1 {
            font-size: 36px;
            text-shadow: 2px 2px 4px #00000050;
        }

        .logo {
            position: absolute;
            top: 20px;
            left: 30px;
        }

        .logo img {
            height: 200px;
        }

        .section {
            padding: 30px;
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
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .service-table th, .service-table td {
            border: 1px solid #f0b6c5;
            padding: 10px;
            text-align: left;
        }

        .service-table th {
            background-color: #f9d2e1;
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
    </style>
</head>
<body>

<div class="header">
    <div class="logo">
        <img src="https://mcusercontent.com/3ca8771030e566eaeda03585a/images/45f87f1a-20c3-c7bb-4868-b011138e1a46.png" alt="Resort Logo"/>
    </div>
    <h1>Wedding Quotation</h1>
</div>

<div class="section">
    <h2>Guest Information</h2>
    <table class="info-table">
        <tr><td><strong>Name:</strong></td><td>${guestName}</td></tr>
        <tr><td><strong>Mobile:</strong></td><td>${mobile}</td></tr>
        <tr><td><strong>Email:</strong></td><td>${email}</td></tr>
        <tr><td><strong>Event Dates:</strong></td><td>${eventStartDate?string("dd MMM yyyy")} to ${eventEndDate?string("dd MMM yyyy")}</td></tr>
        <tr><td><strong>No. of Rooms:</strong></td><td>${numberOfRooms}</td></tr>
        <tr><td><strong>No. of Guests:</strong></td><td>${baseGuestCount}</td></tr>
    </table>
</div>

<div class="section">
    <h2>Wedding Photo Inspirations</h2>
    <div class="photo-collage">
        <img src="https://images.unsplash.com/photo-1549057446-9f5c6ac91c71?fit=crop&w=600&q=80" alt="1">
        <img src="https://images.unsplash.com/photo-1589998059171-357d4f5d4c1b?fit=crop&w=600&q=80" alt="2">
        <img src="https://images.unsplash.com/photo-1525382455947-f319bc05f9b9?fit=crop&w=600&q=80" alt="3">
        <img src="https://images.unsplash.com/photo-1555396273-367ea4eb4db5?fit=crop&w=600&q=80" alt="4">
        <img src="https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?fit=crop&w=600&q=80" alt="5">
    </div>
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
        <div class="total">Total: ₹${grand_total_cost?string["#,##0"]}</div>
    </div>
<#else>
    <div class="section">
        <h2>Services Included</h2>
        <div class="grid-container">
            <#list services as service>
                <div class="grid-box">${service.name}</div>
            </#list>
        </div>
        <div class="total" style="margin-top:20px;">Total: ₹${grand_total_cost?string["#,##0"]}</div>
    </div>
</#if>

<div class="footer">
    <h3>Terms & Conditions</h3>
    <ul>
        <li>Rates are subject to availability and change until confirmed.</li>
        <li>Booking is confirmed only upon receiving advance payment.</li>
        <li>Taxes are included as applicable unless specified otherwise.</li>
        <li>Event decor and customizations are chargeable based on requirements.</li>
        <li>Check-in and check-out times are per resort policy.</li>
    </ul>
    <p>For queries, please contact us at <strong>+91-XXXXXXXXXX</strong> or email <strong>reservations@yourresort.com</strong></p>
</div>

</body>
</html>
