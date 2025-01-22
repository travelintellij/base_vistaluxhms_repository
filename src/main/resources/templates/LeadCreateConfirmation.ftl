<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Query Registration Email</title>
    <style>
        /* Mobile Optimization */
        @media screen and (max-width: 600px) {
            .email-container {
                width: 100% !important;
                padding: 15px !important;
            }
            .header {
                text-align: center;
            }
            .content h2 {
                font-size: 18px !important;
            }
            .content p {
                font-size: 14px !important;
            }
            .details-table {
                font-size: 12px !important;
            }
        }
    </style>
</head>
<body style="margin: 0; padding: 0;">
<!-- Table for Background Image & Container -->
<table width="100%" cellspacing="0" cellpadding="0" style="background: url('https://mcusercontent.com/3ca8771030e566eaeda03585a/images/d57f413e-4b7b-85e7-c767-1e616cd2bc66.jpg') no-repeat center center / cover; padding: 30px 0;">
    <tr>
        <td>
            <!-- Main Container for Email Content -->
            <table width="600" cellspacing="0" cellpadding="25" style="max-width: 600px; margin: 0 auto; background: rgba(255, 255, 255, 0.9); border-radius: 12px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);">
                <!-- Header Section -->
                <tr>
                    <td class="header" style="text-align: center; background-color: #0078D7; color: white; padding: 20px 0; border-radius: 12px 12px 0 0;">
                        <img src="https://mcusercontent.com/3ca8771030e566eaeda03585a/images/45f87f1a-20c3-c7bb-4868-b011138e1a46.png" alt="Vistalux Logo" style="max-width: 150px;">
                    </td>
                </tr>
                <!-- Content Section -->
                <tr>
                    <td class="content" style="color: #333333;">
                        <h2 style="color: #0078D7; font-size: 20px; margin-bottom: 15px; text-align: center;">Query Reference Number: ${leadId}</h2>
                        <p>Dear ${contactName},</p>
                        <p>Vistalux has created and registered a new query in our system. Your unique query reference number is <strong>${leadId}</strong> related to this deal.</p>
                        <!-- Table with Details -->
                        <table class="details-table" style="width: 100%; border-collapse: collapse; margin: 20px 0; font-size: 14px;">
                            <tr>
                                <th style="text-align: left; padding: 10px; background-color: #f4f4f4; font-weight: bold;">Guests</th>
                                <td style="padding: 10px; border: 1px solid #dddddd;">${guestDetails}</td>
                            </tr>
                            <tr>
                                <th style="text-align: left; padding: 10px; background-color: #f4f4f4; font-weight: bold;">Check-In Date</th>
                                <td style="padding: 10px; border: 1px solid #dddddd;">${checkInDate}</td>
                            </tr>
                            <tr>
                                <th style="text-align: left; padding: 10px; background-color: #f4f4f4; font-weight: bold;">Check-Out Date</th>
                                <td style="padding: 10px; border: 1px solid #dddddd;">${checkOutDate}</td>
                            </tr>
                        </table>
                        <p><strong>Your Services Include:</strong></p>
                        <p>${Services}</p>
                        <p><strong>Remarks:</strong> ${clientRemarks}</p>
                        <p>Looking forward to seeing your pleasurable experience with us! You will hear soon from us with the quotation to proceed further.</p>
                        <p>I am <strong>${serviceAdvisor}</strong>, reachable at <strong>${contactNumber}</strong>. Please feel free to talk to us for clarifications.</p>
                        <p>If you face any issues, you can escalate to my manager at <strong><a href="mailto:gm@vistaluxhotel.com" style="color: #0078D7; text-decoration: none;">gm@vistaluxhotel.com</a></strong> or call at <strong>9690735777</strong>.</p>
                        <p>Regards,<br><strong>${serviceAdvisor}</strong><br>Your Query Owner<br>Reservations: 7827962965</p>
                        <a href="http://www.ashokastigertrail.com" class="button" style="display: inline-block; background-color: #0078D7; color: white; padding: 10px 15px; margin: 20px 0; text-align: center; font-size: 16px; border-radius: 8px; text-decoration: none; box-shadow: 0 4px 10px rgba(0, 120, 215, 0.3);">Visit Our Website</a>
                    </td>
                </tr>
                <!-- Footer Section -->
                <tr>
                    <td class="footer" style="text-align: center; margin-top: 30px; color: #777777; font-size: 14px;">
                        <p>| <a href="https://www.facebook.com/AshokaTigerTrail" style="color: #0078D7; text-decoration: none;">Facebook</a> | <a href="https://www.instagram.com/ashoka_tiger_trail/" style="color: #0078D7; text-decoration: none;">Instagram</a> | <a href="https://www.linkedin.com/company/105009430/admin/dashboard/" style="color: #0078D7; text-decoration: none;">LinkedIn</a> |</p>
                        <p>Copyright © 2020 | <a href="https://www.digitalintellij.com" style="color: #0078D7; text-decoration: none;">www.digitalintellij.com</a> | All rights reserved.</p>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>
</html>
