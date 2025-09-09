<html>
<head>
    <style>
        body {
            font-family: Arial, sans-serif;
            font-size: 14px;
            line-height: 1.6;
            color: #333;
        }
        table {
            border-collapse: collapse;
            width: 85%;
            font-family: Arial, sans-serif;
            margin-bottom: 30px;
             page-break-inside: avoid;
        }
        th, td {
            border: 1px solid #000;
            padding: 6px;
            text-align: center;
             page-break-inside: avoid;
            page-break-after: auto;
        }
        th {
            background-color: #f2f2f2;
             page-break-inside: avoid;
        page-break-after: auto;
        }
        .rowGroupA {
            background-color: #f9f9f9;
        }
        .rowGroupB {
            background-color: #eaf4fc;
        }
        h3 {
            margin-top: 40px;
        }
        .section {
            margin-top: 40px;
        }
         thead {
            display: table-header-group; /* Ensures header repeats if split */
        }

        tfoot {
            display: table-footer-group;
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
<div style="text-align: center; margin-bottom: 20px;">
    <img src="${centralConfig.logoPath}" alt="Logo" width="200" height="200" style="display: block; margin: 0 auto; width: 200px; height: 200px;" />
    <!--
    <img
            src="https://mcusercontent.com/3ca8771030e566eaeda03585a/images/45f87f1a-20c3-c7bb-4868-b011138e1a46.png"
            alt="Ashoka's Tiger Trail Resort"
            width="200" height="200"
            style="display: block; margin: 0 auto; width: 200px; height: 200px;"
    />
    -->
</div>


<p>Dear <strong>${salesPartnerName?upper_case}</strong>,</p>

<p>We are pleased to share our exclusive B2B rates for the mentioned season, curated specially for our trusted travel partners like you. <br/> These rates have been designed to offer maximum value and flexibility to help you close more bookings with ease.</p>

<#list rateCardList as rateCard>
<div style="page-break-inside: avoid;">
    <h3>Rate Season: ${rateCard.seasonStartDate} to ${rateCard.seasonEndDate}</h3>
    <table>
        <thead>
            <tr>
                <th>Room Category</th>
                <th>Max Occupancy</th>
                <th>Person</th>
                <th>EPAI</th>
                <th>CPAI</th>
                <th>MAPAI</th>
                <th>APAI</th>
            </tr>
        </thead>
        <tbody>
            <#list rateCard.roomCategories as roomCategory>
                <#assign stnOcc = roomCategory.standardOccupancy />
                <#assign maxOcc = roomCategory.maxOccupancy />
                <#assign rowClass = (roomCategory_index % 2 == 0)?then('rowGroupA', 'rowGroupB') />

                <#list 1..stnOcc as i>
                    <tr class="${rowClass}">
                        <#if i == 1>
                            <td rowspan="${stnOcc}">${roomCategory.name}</td>
                            <td rowspan="${stnOcc}">${maxOcc}</td>
                        </#if>
                        <td>${i}</td>

                        <#assign rateMap = {} />
                        <#list roomCategory.mealPlans as mealPlan>
                            <#assign mealPlanId = mealPlan.mealPlanId />
                            <#assign personWiseRates = mealPlan.personWiseRates />
                            <#assign rate = personWiseRates[i?string]! />
                            <#if rate??>
                                <#assign rateMap = rateMap + { (mealPlanId?string): rate } />
                            </#if>
                        </#list>

                        <#list [1, 2, 3, 4] as planId>
                            <td>${rateMap[planId?string]?default('-')}</td>
                        </#list>
                    </tr>
                </#list>
            </#list>
        </tbody>
    </table>
</div>
</#list>

${centralConfig.hotelInfo}



<div class="section">
    <h3>Property Overview &amp; Resources</h3>
    <p>To help you better understand the property and its offerings, we’ve compiled the following resources for your reference:</p>
    <ul>
        <li><strong>📸 Photo Gallery:</strong> Explore high-quality images of the property and its surroundings.
            <br/>
            <a href="https://drive.google.com/drive/folders/15Gs4A8ce2wFKjvoLxo-GSuCD4TD-ClGI?usp=sharing" target="_blank">
                View Property Photographs
            </a>
        </li>
        <li><strong>📄 Property Factsheet:</strong> For detailed specifications, amenities, room configurations, and facilities, please refer to our downloadable factsheet.
            <br/>
            <a href="https://drive.google.com/file/d/1K1JcF89v9YqW4QnP2XNwdfEH7Mv5cqZl/view?usp=sharing" target="_blank">
                Download Factsheet
            </a>
        </li>
        <li><strong>🎥 Introductory Video:</strong> Get a quick walkthrough of the property through our engaging introductory video.
            <br/>
            <a href="https://drive.google.com/file/d/1BxqTpg-X8aBSEqyEvF8UhZuag44IqPks/view?usp=sharing" target="_blank">
                Watch Introductory Video
            </a>
        </li>
    </ul>
</div>

<div class="section">
     ${centralConfig.tnc}
 </div>

<div class="section">
    <h3>Corporate &amp; Group Bookings</h3>
    <p>
        The resort is well-equipped to host <strong>corporate offsites, team retreats, wellness programs</strong>, and <strong>group getaways</strong>. Customized itineraries, curated menus, and team-building activities can be organized on request.
    </p>
</div>

<p>For any clarifications, please reach out to our team.</p>

<p>Warm Regards,<br/>
<strong>Sales Team</strong><br/>

<h3>Resort Contact Details:</h3>
<p><strong>Address:</strong> ${centralConfig.hotelAddress} </p>
<p><strong>Phone:</strong> ${centralConfig.centralNumber} </p>
<p><strong>Email:</strong> ${centralConfig.centralizedEmail} </p>
<p><strong>GST No:</strong> ${centralConfig.gstNumber} </p>

<div class="whatsapp-button">
        <a href="https://wa.me/${serviceAdvisorMobile}" target="_blank">Chat on WhatsApp</a>
 </div>
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
</p>

</body>
</html>
