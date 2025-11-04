<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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

        .table-container {
            overflow-x: auto;
            background: #fff0f5;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
            max-width: 1200px;
            margin: auto;
        }

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

        td.empty {
            text-align: center;
            font-style: italic;
            color: #999;
            padding: 30px;
        }

        @media (max-width: 768px) {
            body { padding: 20px; font-size: 16px; }
            h2 { font-size: 28px; }
            table.styled-table th, table.styled-table td { font-size: 16px; padding: 12px; }
            a.back-btn { font-size: 18px; padding: 14px 28px; width: 220px; }
        }

        .view-btn {
            background: linear-gradient(90deg, #ff9472, #ff6f61);
            color: #fff;
            border: none;
            border-radius: 10px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s ease;
        }
        .view-btn:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 2000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.6);
            overflow: auto;
        }
        .modal-content {
            background: #fff;
            margin: 10% auto;
            padding: 30px;
            border-radius: 20px;
            width: 90%;
            max-width: 600px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2), 0 0 15px rgba(255, 111, 97, 0.4);
            animation: fadeIn 0.3s ease;
        }
        .modal-content h2 {
            color: #ff6f61;
            text-align: center;
            margin-bottom: 20px;
        }
        .modal-content p {
            font-size: 18px;
            margin: 10px 0;
        }
        .close {
            float: right;
            font-size: 24px;
            font-weight: bold;
            color: #fff;
            background: #ff6f61;
            border-radius: 50%;
            width: 35px;
            height: 35px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .close:hover {
            background: #ff3b2e;
            transform: scale(1.1);
        }
        @keyframes fadeIn {
            from {opacity: 0; transform: scale(0.9);}
            to {opacity: 1; transform: scale(1);}
        }

        .modal-content {
            text-align: center;
            background: #fffdfd;
            border: 2px solid #ffb6b6;
        }


        .remarks-text {
            font-size: 18px;
            color: #333;
            text-align: center;
            margin-top: 20px;
            background: #fff5f5;
            padding: 20px;
            border-radius: 12px;
            border: 1px solid #ffd6d6;
            box-shadow: inset 0 2px 5px rgba(0,0,0,0.05);
            line-height: 1.6;
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
${history.fromAshokaTeam.name} (${history.fromAshokaTeam.username})                   </c:when>
                        <c:otherwise>
                            N/A
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${history.toAshokaTeam != null}">
${history.toAshokaTeam.name} (${history.toAshokaTeam.username})              </c:when>
                        <c:otherwise>
                            N/A
                        </c:otherwise>
                    </c:choose>
                </td>
                    <td><fmt:formatDate value="${history.transferDate}" pattern="dd-MM-yyyy"/></td>
  <td>
     <button class="view-btn"
         onclick="openModal('${history.remarks != null ? history.remarks : "-"}')">
         View Details
     </button>
  </td>
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



<div id="detailsModal" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeModal()">&times;</span>
    <h2>Remarks</h2>
<p id="modalRemarks" class="remarks-text"></p>  </div>
</div>

<script>
function openModal(remarks) {
    document.getElementById('modalRemarks').textContent = remarks;
    document.getElementById('detailsModal').style.display = 'block';
}

function closeModal() {
    document.getElementById('detailsModal').style.display = 'none';
}

window.onclick = function(event) {
    const modal = document.getElementById('detailsModal');
    if (event.target === modal) {
        modal.style.display = "none";
    }
}
</script>
</body>
</html>

