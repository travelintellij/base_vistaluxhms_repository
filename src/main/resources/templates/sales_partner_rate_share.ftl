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
        }
        th, td {
            border: 1px solid #000;
            padding: 6px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
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
    </style>
</head>
<body>
<div style="text-align: center; margin-bottom: 20px;">
    <img src="https://mcusercontent.com/3ca8771030e566eaeda03585a/images/45f87f1a-20c3-c7bb-4868-b011138e1a46.png" alt="Ashoka's Tiger Trail Resort" style="height: 80px;">
</div>

<p>Dear <strong>${salesPartnerName?upper_case}</strong>,</p>

<p>Please find below the updated room category-wise person rates for the selected date range:</p>

<#list rateCardList as rateCard>
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
</#list>

<div class="section">
    <h3>About the Resort</h3>
    <p>
        Ashoka's Tiger Trail Resort at Jim Corbett National Park offers a British-era themed wilderness retreat with rooms and cottages inspired by colonial forest accommodations of the Dhikala Range. Nestled in the serene village of Dhela on the southern edge of the park, our resort is ideally situated for wildlife enthusiasts and nature explorers.
    </p>
    <p>
        Spread across 4.5 acres and secured with electrified fencing, the property overlooks a scenic pebbled riverbed on one side and offers uninterrupted views of the park’s core zone on the other. Every corner of the resort has been artfully crafted to reflect the jungle spirit, helping guests reconnect with nature in its purest form.
    </p>
</div>

<div class="section">
    <h3>Terms & Conditions</h3>
    <ul>
        <li>All rates are <strong>NETT and non-commissionable</strong>.</li>
        <li>Rates are inclusive of <strong>GST</strong>.</li>
        <li>Rates vary according to selected <strong>meal plans</strong> (EPAI, CPAI, MAPAI, APAI).</li>
        <li><strong>Extra Bed Charges:</strong> 35% of double occupancy rate.</li>
        <li><strong>Child Charges (6–11 years):</strong> 25% of double occupancy rate.</li>
        <li><strong>Advance Payment:</strong> 50% of total booking amount required to confirm reservation.</li>
        <li><strong>Cancellation Policy:</strong> Free cancellation allowed up to 10 days prior to check-in. No refund for cancellations within 10 days of check-in.</li>
    </ul>
</div>

<div class="section">
    <h3>Corporate & Group Bookings</h3>
    <p>
        The resort is well-equipped to host <strong>corporate offsites, team retreats, wellness programs</strong>, and <strong>group getaways</strong>. Customized itineraries, curated menus, and team-building activities can be organized on request.
    </p>
</div>

<p>For any clarifications, please reach out to our team.</p>

<p>Warm Regards,<br/>
<strong>Sales Team</strong><br/>
Ashoka's Tiger Trail Resort<br/>
📞 <strong>+91-9090762424</strong><br/>
✉️ <a href="mailto:sales@vistaluxhotel.com">sales@vistaluxhotel.com</a><br/>
🌐 <a href="https://www.ashokastigertail.com" target="_blank">www.ashokastigertail.com</a><br/>
📍 Dhela, Ramnagar, Jim Corbett, Uttarakhand<br/>
<a href="https://wa.me/919090762424" target="_blank" style="display: inline-block; margin-top: 8px; padding: 6px 12px; background-color: #25D366; color: white; border-radius: 4px; text-decoration: none; font-weight: bold;">
    Chat on WhatsApp
</a></p>

</body>
</html>
