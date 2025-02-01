<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Query Update Email</title>
    <style>
        /* General Styling */
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }
        /* Mobile Optimization */
        @media screen and (max-width: 600px) {
            .email-container {
                width: 100% !important;
                padding: 20px !important;
            }
            .header img {
                width: 120px !important;
            }
            .content h2 {
                font-size: 18px !important;
            }
            .details-table th, .details-table td {
                font-size: 12px !important;
                padding: 8px !important;
            }
        }

        /* Container Styling */
        .email-container {
            width: 600px;
            max-width: 100%;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            padding: 25px;
        }

        /* Header Section */
        .header {
            text-align: center;
            background-color: #2C3E50;
            padding: 20px;
            border-radius: 12px 12px 0 0;
        }
        .header img {
            max-width: 150px;
        }

        /* Content Section */
        .content {
            color: #333;
        }
        .content h2 {
            color: #2980B9;
            font-size: 24px;
            margin-bottom: 15px;
            text-align: center;
        }
        .content p {
            font-size: 16px;
            line-height: 1.5;
        }
        .details-table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 14px;
        }
        .details-table th, .details-table td {
            padding: 12px;
            border: 1px solid #ddd;
        }
        .details-table th {
            background-color: #f8f8f8;
            font-weight: bold;
            text-align: left;
        }
        .button {
            display: inline-block;
            background-color: #2980B9;
            color: white;
            padding: 12px 20px;
            text-align: center;
            font-size: 16px;
            border-radius: 6px;
            text-decoration: none;
            margin-top: 20px;
            box-shadow: 0 4px 10px rgba(41, 128, 185, 0.3);
        }

        /* Footer Section */
        .footer {
            text-align: center;
            margin-top: 30px;
            font-size: 14px;
            color: #7F8C8D;
        }
        .footer a {
            color: #2980B9;
            text-decoration: none;
        }
    </style>
</head>
<body>
<!-- Table for Background Image & Container -->
<table width="100%" cellspacing="0" cellpadding="0" style="background: url('https://mcusercontent.com/3ca8771030e566eaeda03585a/images/d57f413e-4b7b-85e7-c767-1e616cd2bc66.jpg') no-repeat center center / cover; padding: 30px 0;">
    <tr>
        <td>
            <!-- Main Container for Email Content -->
            <table class="email-container" cellspacing="0" cellpadding="25">
                <!-- Header Section -->
                <tr>
                    <td class="header">
                        <img src="https://mcusercontent.com/3ca8771030e566eaeda03585a/images/45f87f1a-20c3-c7bb-4868-b011138e1a46.png" alt="Vistalux Logo">
                    </td>
                </tr>
                <!-- Content Section -->
                <tr>
                    <td class="content">
                        <h2>Query Reference Number: ${leadId}</h2>
                        <p>Dear ${contactName},</p>
                        <p>Vistalux has updated your query in our system with original query reference number is <strong>${leadId}</strong> related to this deal.</p>

                        <!-- Table with Details -->
                        <table class="details-table">
                            <tr>
                                <th>Guests</th>
                                <td>${guestDetails}</td>
                            </tr>
                            <tr>
                                <th>Check-In Date</th>
                                <td>${checkInDate}</td>
                            </tr>
                            <tr>
                                <th>Check-Out Date</th>
                                <td>${checkOutDate}</td>
                            </tr>
                        </table>
                        <p><strong>Your Services Include:</strong></p>
                        <p>${Services}</p>
                        <p><strong>Remarks:</strong> ${clientRemarks}</p>
                        <p>Looking forward to seeing your pleasurable experience with us! You will hear soon from us with the quotation to proceed further.</p>
                        <p>I am <strong>${serviceAdvisor}</strong>, reachable at <strong>${contactNumber}</strong>. Please feel free to talk to us for clarifications.</p>
                        <p>If you face any issues, you can escalate to my manager at <strong><a href="mailto:gm@vistaluxhotel.com">gm@vistaluxhotel.com</a></strong> or call at <strong>9690735777</strong>.</p>
                        <p>Regards,<br><strong>${serviceAdvisor}</strong><br>Your Query Owner<br>Reservations: 7827962965</p>

                        <!-- Button to Visit Website -->
                        <a href="http://www.ashokastigertrail.com" class="button">Visit Our Website</a>
                    </td>
                </tr>
                <!-- Footer Section -->
                <tr>
                    <td class="footer">
                        <p>| <a href="https://www.facebook.com/AshokaTigerTrail">Facebook</a> | <a href="https://www.instagram.com/ashoka_tiger_trail/">Instagram</a> | <a href="https://www.linkedin.com/company/105009430/admin/dashboard/">LinkedIn</a> |</p>
                        <p>Copyright © 2020 | <a href="https://www.digitalintellij.com">www.digitalintellij.com</a> | All rights reserved.</p>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>
</html>
