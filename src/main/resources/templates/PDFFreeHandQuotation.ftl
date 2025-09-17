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
         .quotation-header {
            text-align: center;
            font-size: 20px;
            color: #003366;
            font-family: 'Georgia', serif;
            margin-bottom: 20px;
            text-transform: uppercase;
            letter-spacing: 1px;
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
                 .rover {
                     break-inside: auto;
                     break-before: avoid;
                     break-after: auto;
                 }

    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <!--<img src="https://mcusercontent.com/3ca8771030e566eaeda03585a/images/45f87f1a-20c3-c7bb-4868-b011138e1a46.png" alt="Ashoka Tiger Trail Resort Logo" style="width: 200px; height: 200px;" />-->
        <img src="${centralConfig.logoPath}" alt="Logo" width="200" height="200" style="display: block; margin: 0 auto; width: 200px; height: 200px;"/>
    </div>
    <div class="content">
        <h2 style="text-align: center;">Exclusive Stay Quotation – ${centralConfig.hotelName}</h2>
        <p>Dear ${contactName},</p>
       ${centralConfig.quotationTopCover}

        <table>
            <tr>
                <th>Room Details</th>
                <th>Meal Plan</th>
                <th>No. of Rooms</th>
                <th>Adults</th>
                <th>Child(ren)</th>
                <th>Check-in</th>
                <th>Check-out</th>
                <th>Total Price</th>
            </tr>
            <#list roomDetails as room>
            <tr>
                <td>${room.roomCategoryName}</td>
                <td>${room.mealPlanName}</td>
                <td>${room.noOfRooms}</td>
                <td>${room.adults}</td>
                <td>${room.noOfChild}</td>
                <td>${room.formattedCheckInDate}</td>
                <td>${room.formattedCheckOutDate}</td>
                <td>INR ${room.totalPrice?string(",##0.00")}</td>
            </tr>
        </#list>
        </table>

   <#if remarks?? && (remarks?trim?length > 0)>
       <div style="margin-top: 20px; padding: 12px; border: 2px dashed #4CAF50; border-radius: 8px; background-color: #f9f9f9;">
           <h3 style="margin: 0 0 10px 0; color: #4CAF50; font-size: 18px;">Remarks</h3>
           <p style="margin: 0; font-size: 14px; color: #333;">
               ${remarks?html}
           </p>
       </div>
   </#if>



        <h3>Grand Total: INR ${grandTotalSum?string(",##0.00")}</h3>
        <#if discount?number != 0>
            <h3 style="color: #d32f2f; margin: 0;">Discount: INR ${discount?string(",##0.00")}</h3>
            <h3>Final Price: INR ${finalPrice?string(",##0.00")}</h3>
        </#if>
    </div>

    <div class="rover">
           ${centralConfig.usp}
   </div>

   <div class="rover">
           ${centralConfig.tnc}
      </div>

<hr/>
  <h3>Payment Details:</h3>
        <p><strong>Bank Name:</strong> ${centralConfig.bankName}</p>
        <p><strong>Account Name:</strong> ${centralConfig.accountName}</p>
        <p><strong>Account Number:</strong> ${centralConfig.accountNumber} </p>
        <p><strong>IFSC Code:</strong> ${centralConfig.ifscCode}</p>
        <p><strong>Branch Name:</strong> ${centralConfig.branch}</p>

        <hr/>
        <h3>Resort Contact Details:</h3>
        <p><strong>Address:</strong> ${centralConfig.hotelAddress} </p>
        <p><strong>Phone:</strong> ${centralConfig.centralNumber} </p>
        <p><strong>Email:</strong> ${centralConfig.centralizedEmail} </p>
        <p><strong>GST No:</strong> ${centralConfig.gstNumber} </p>

        <!-- WhatsApp Chat Button -->
        <div class="whatsapp-button">
            <a href="https://wa.me/${serviceAdvisorMobile}" target="_blank">Chat on WhatsApp</a>
        </div>

        <!-- Social Media Links -->
        <!-- <div class="social-links">
            <a href="${centralConfig.facebookLink}" class="facebook" target="_blank">Facebook</a>
            <a href="${centralConfig.instagramLink}" class="instagram" target="_blank">Instagram</a>
            <a href="${centralConfig.linkedinLink}" class="linkedin" target="_blank">LinkedIn</a>
            <a href="${centralConfig.xLink}" class="twitter" target="_blank">Twitter</a>
            <a href="mailto:${centralConfig.centralizedEmail}" class="email">Email</a>
            <a href="${centralConfig.website}" class="website" target="_blank">Website</a>
        </div>
        -->
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
    <div class="footer">
        <p>We look forward to hosting you at ${centralConfig.hotelName} !</p>
    </div>
</div>
</body>
</html>