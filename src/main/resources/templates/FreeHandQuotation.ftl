<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quotation -Ashoka's Tiger Trail Resort</title>
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
            background-color: #f1f1f1;
            color: black;
            font-weight: bold;
        }
        .footer {
            margin-top: 15px;
            text-align: center;
            font-size: 14px;
        }
        h2, h3 {
            font-weight: bold;
            color: black;
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
        .rover {
            page-break-inside: avoid;
            break-inside: avoid;
        }
    </style>
</head>
<body>
<div class="container">
    <div style="text-align: center; margin-bottom: 20px;">
        <!-- <img src="https://mcusercontent.com/3ca8771030e566eaeda03585a/images/45f87f1a-20c3-c7bb-4868-b011138e1a46.png" alt="Ashoka's Tiger Trail Resort" width="200" height="200" style="display: block; margin: 0 auto; width: 200px; height: 200px;"/> -->
        <img src="${centralConfig.logoPath}" alt="Logo" width="200" height="200" style="display: block; margin: 0 auto; width: 200px; height: 200px;"/>
    </div>
    <div class="content">
        <h2 style="text-align:center">Exclusive Stay Quotation – ${centralConfig.hotelName}</h2>

        <p>Dear ${contactName},</p>
        <#if centralConfig.quotationTopCover?has_content>
            ${centralConfig.quotationTopCover?html?replace("\\r?\\n", "<br/>", "r")}
        </#if>

        <table>
            <tr>
                <th>Room</th>
                <th>Meal Plan</th>
                <th>No. of Rooms</th>
                <th>Adults</th>
                <th>No. of Child(ren) </th>
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
              <tr>
                  <td colspan="5">&nbsp;</td>
                  <th style="background-color: #f1f1f1; color: black; padding: 10px; text-align: center; border: 1px solid #ddd; font-weight: bold;" colspan="2">Grand Total :</th>
                    <td style="color: black; font-weight: bold;"> &#8377; ${grandTotalSum} </td>
               </tr>
               <#if discount?number gt 0>
               <tr>
                    <td colspan="5">&nbsp;</td>
                    <th style="background-color: #1E90FF; color: white; padding: 10px; text-align: center; border: 1px solid #ddd;" colspan="2"> Discount :</th>
                    <td>&#8377; ${discount} </td>
               </tr>

               <tr>
                   <td colspan="5">&nbsp;</td>
                  <th style=" background-color: #f1f1f1; color: black; padding: 10px; text-align: center; border: 1px solid #ddd; font-weight: bold;" colspan="2">Final Price :</th>
                   <td style="font-family: Arial, sans-serif; color: black; font-weight: bold;">&#8377;  <span id="finalPrice" style="font-size: 20px; font-weight: bold; color: black;"> ${finalPrice}</span></td>
               </tr>
               </#if>
        </table>

        <#if remarks?? && (remarks?trim?length > 0)>
            <br/>
            <div style="margin-top: 20px; padding: 10px; background-color: #f9f9f9; border: 1px solid #ccc; border-radius: 5px;">
                <h3 style="margin: 0 0 10px 0; color: #333;">Remarks:</h3>
                <p style="margin: 0; font-size: 14px; color: #555;">${remarks?html}</p>
            </div>
        </#if>


    <#if centralConfig.inclusions?has_content>
    <div class="rover">
           <h3 style="color: black; font-weight: bold; margin-bottom: 5px;">Inclusions</h3>
           ${centralConfig.inclusions?html?replace("\\r?\\n", "<br/>", "r")}
    </div>
    </#if>
    <#if centralConfig.usp?has_content>
    <div class="rover">
           <h3 style="color: black; font-weight: bold; margin-bottom: 5px;">Why Choose Us?</h3>
           ${centralConfig.usp?html?replace("\\r?\\n", "<br/>", "r")}
    </div>
    </#if>
    <#if centralConfig.tnc?has_content>
    <div class="rover">
           <h3 style="color: black; font-weight: bold; margin-bottom: 5px;">Terms &amp; Conditions</h3>
                  ${centralConfig.tnc?html?replace("\\r?\\n", "<br/>", "r")}
    </div>
    </#if>

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
