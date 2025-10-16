<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Asset Transfer History</title>
    <style>
     .asset-header {
         background: linear-gradient(135deg, #fff0f5, #ffe4e1);
         padding: 20px 30px;
         border-radius: 15px;
         max-width: 1200px;
         margin: 20px auto 40px auto;
         box-shadow: 0 8px 20px rgba(0,0,0,0.1);
         text-align: center;
         position: sticky;
         top: 20px;
         z-index: 100;
     }

     .asset-header p {
         font-size: 22px;
         color: #ff6f61;
         margin: 8px 0;
         font-weight: 600;
     }

     .asset-header strong {
         font-weight: 700;
         color: #ff3b2e;
     }

     @media (max-width: 768px) {
         .asset-header {
             padding: 15px 20px;
             top: 10px;
         }
         .asset-header p {
             font-size: 18px;
         }
     }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #ffefba, #ffffff);
            margin: 0;
            padding: 50px 20px;
            color: #333;
            font-size: 18px;
        }

        h2 {
            text-align: center;
            font-size: 38px;
            color: #ff6f61;
            margin-bottom: 40px;
            letter-spacing: 1px;
            text-shadow: 1px 1px rgba(0,0,0,0.1);
        }

        /* Table container */
        .table-container {
            overflow-x: auto;
            background: #fff0f5;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
            max-width: 1200px;
            margin: auto;
        }

        /* Styled table */
        table.styled-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 20px;
            border-radius: 12px;
            overflow: hidden;
        }

        table.styled-table th {
            background: linear-gradient(90deg, #ff6f61, #ff9472);
            color: #fff;
            text-transform: uppercase;
            padding: 18px;
            font-size: 22px;
            text-align: center;
        }

        table.styled-table td {
            padding: 18px;
            border: 1px solid #ffd6dc;
            text-align: center;
            font-size: 20px;
            color: #444;
            transition: transform 0.2s ease;
        }

        table.styled-table tr:nth-child(even) {
            background-color: #ffe4e1;
        }

        table.styled-table tr:hover {
            background: linear-gradient(to right, #ffe4e1, #fff0f5);
            transform: scale(1.02);
        }

        /* Back button */
        a.back-btn {
            display: block;
            margin: 40px auto 0;
            padding: 18px 36px;
            background: linear-gradient(90deg, #ff9472, #ff6f61);
            color: #fff;
            border-radius: 16px;
            text-decoration: none;
            font-size: 22px;
            text-align: center;
            font-weight: bold;
            width: 300px;
            transition: all 0.3s ease;
        }

        a.back-btn:hover {
            background: linear-gradient(90deg, #ff6f61, #ff3b2e);
            transform: scale(1.05);
            box-shadow: 0 6px 20px rgba(0,0,0,0.2);
        }

        /* Empty row */
        td.empty {
            text-align: center;
            font-style: italic;
            color: #999;
            padding: 30px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            body { padding: 20px; font-size: 16px; }
            h2 { font-size: 28px; }
            table.styled-table th, table.styled-table td { font-size: 16px; padding: 12px; }
            a.back-btn { font-size: 18px; padding: 14px 28px; width: 220px; }
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/_menu_builder_header.jsp"/>

<h2>Asset Transfer History</h2>
<div class="asset-header">
<p><strong>Asset Name:</strong> ${asset.assetName}</p>
<p><strong>Asset Code:</strong> ${asset.assetCode}</p>
</div>
<hr/>

<div class="table-container">
    <table class="styled-table">
        <thead>
            <tr>
                <th>From Employee</th>
                <th>To Employee</th>
                <th>Transfer Date</th>
                <th>Remarks</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="history" items="${historyList}">
                <tr>
                    <td>
                        <c:choose>
                            <c:when test="${history.fromAshokaTeam != null}">
                                ${history.fromAshokaTeam.name}
                            </c:when>
                            <c:otherwise>
                                N/A
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${history.toAshokaTeam.name}</td>
                    <td><fmt:formatDate value="${history.transferDate}" pattern="dd-MM-yyyy"/></td>
                    <td><c:out value="${history.remarks}" default="-" /></td>
                </tr>
            </c:forEach>
            <c:if test="${empty historyList}">
                <tr>
                    <td colspan="4" class="empty">No transfer records found.</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>

<a href="${pageContext.request.contextPath}/view_assets_list" class="back-btn">Back to Assets</a>

</body>
</html>

