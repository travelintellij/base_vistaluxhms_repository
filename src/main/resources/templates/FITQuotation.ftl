
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
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            position: relative;
        }
        .header {
            text-align: center;
            padding-bottom: 10px;
        }
        .header img {
            max-width: 200px;
        }
        .watermark {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 100px;
            color: rgba(200, 200, 200, 0.2);
            font-weight: bold;
            z-index: 0;
        }
        .content {
            position: relative;
            z-index: 1;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #2c3e50;
            color: white;
        }
        .footer {
            margin-top: 20px;
            text-align: center;
            font-size: 14px;
        }
        @media screen and (max-width: 600px) {
            .watermark {
                font-size: 50px;
            }
            table, th, td {
                font-size: 12px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <img src="https://mcusercontent.com/3ca8771030e566eaeda03585a/images/45f87f1a-20c3-c7bb-4868-b011138e1a46.png" alt="Ashoka Tiger Trail Resort Logo">
        </div>
        <!--<div class="watermark">Ashoka Tiger Trail</div>-->
        <div class="content">
            <h2>Quotation for Your Stay at Ashoka Tiger Trail Resort</h2>
            Dear ${contactName} <p>We are pleased to share the quotation for your stay at Ashoka's Tiger Trail Resort, a perfect destination for weddings, corporate events, and leisure retreats. Nestled in the serene village of Dhela, our resort offers a British-era themed experience with 43 elegantly designed rooms, a swimming pool, spa, kids' zone, restaurant, a sprawling 15,000 sq. ft. lawn, and a 5,000+ sq. ft. banquet hall.</p>
            
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
        </div>
        <div class="footer">
            <p>We look forward to hosting you at Ashoka Tiger Trail Resort!</p>
        </div>
    </div>
</body>
</html>