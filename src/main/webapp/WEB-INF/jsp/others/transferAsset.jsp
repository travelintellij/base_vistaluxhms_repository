<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Transfer Asset</title>
    <style>

        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
background: linear-gradient(to bottom, #2196F3, #64B5F6);
            min-height: 100vh;
            display: flex;
         flex-direction:column;
            align-items: center;
        }
        .header{
        width: 100%;
        flex-shrink: 0;
        }


        .container {
            width: 95%;
            max-width: 800px;
            background: #fff;
            border-radius: 20px;
            padding: 50px 60px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.25);
            margin-top: 20px;
        }


        h1 {
            text-align: center;
            font-size: 38px;
            color: #ff416c;
            margin-bottom: 40px;
        }


        .form-section {
            margin-bottom: 30px;
        }

        label {
            display: block;
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 12px;
            color: #333;
        }

        select, input, textarea {
            width: 100%;
            font-size: 18px;
            padding: 16px;
            border-radius: 12px;
            border: 2px solid #ccc;
            background: #f9f9f9;
            transition: all 0.3s ease;
        }

        select:focus, input:focus, textarea:focus {
            border-color: #ff416c;
            background: #fff;
            box-shadow: 0 0 15px rgba(255,65,108,0.3);
            outline: none;
        }

        input[readonly] {
            background: #e9ecef;
            font-weight: bold;
            color: #495057;
        }

.button-container {
    display: flex;
    justify-content: center;
    align-items: stretch;
    gap: 20px;
    margin-top: 25px;
}

.equal-btn {
    flex: 1;
    text-align: center;
    padding: 14px 0;
    font-size: 16px;
    border-radius: 8px;
    font-weight: 600;
    border: none;
    cursor: pointer;
    text-decoration: none;
    color: #222;
    transition: all 0.3s ease;
    box-sizing: border-box;
    display: inline-block;
    position: relative;
    overflow: hidden;
}

/* Bright green Transfer button */
.transfer-btn {
    background: linear-gradient(90deg, #00FF66, #00CC44);
    color: #000;
    box-shadow: 0 0 12px rgba(0, 255, 100, 0.8);
}

.transfer-btn:hover {
    background: linear-gradient(90deg, #00CC44, #00FF66);
    box-shadow: 0 0 20px rgba(0, 255, 100, 1);
}

/* Glitter red Back button */
.back-button {
    background: linear-gradient(135deg, #FF4C4C, #FF1C1C, #FF6666);
    background-size: 300% 300%;
    color: #fff;
    animation: glitter 3s infinite linear;
    box-shadow: 0 0 15px rgba(255, 50, 50, 0.8);
}

.back-button:hover {
    background: linear-gradient(135deg, #FF1C1C, #FF4C4C, #FF8080);
    box-shadow: 0 0 25px rgba(255, 30, 30, 1);
}

/* Glitter shimmer animation */
@keyframes glitter {
    0% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
}

        @media (max-width: 768px) {
            body { padding: 20px; }
            .container { padding: 30px; }
            h1 { font-size: 28px; }
            label, select, input, textarea, button { font-size: 16px; padding: 12px; }
        }
    </style>
</head>
<body>
<div class="header">
<jsp:include page="/WEB-INF/jsp/_menu_builder_header.jsp"/></div>
<div class="main">
<div class="container">


   <h1>
       Transfer Asset - <c:out value="${asset.assetName}" />
       <c:if test="${not empty categoryName}">
           (<c:out value="${categoryName}" />)
       </c:if>
   </h1>
    <div class="asset-header">
        <p><strong>Asset Name:</strong> <input type="text" id="assetName" name="assetName" readonly /></p>
        <p><strong>Asset Code:</strong> <input type="text" id="assetCode" name="assetCode" readonly /></p>
    </div>

    <form:form modelAttribute="transferDTO" method="post" action="${pageContext.request.contextPath}/assets_transfer">
        <form:hidden path="assetId" />


        <div class="form-section">
            <label>Previous Owner:</label>
          <input type="text" value="${previousOwnerName}" readonly />
          <form:hidden path="fromAshokaTeamId" />
        </div>


        <div class="form-section">
            <label>New Owner:</label>
            <form:select path="toAshokaTeamId">
                <form:option value="" label="-- Select New Owner --" />
                <form:options items="${ownerMap}" />
            </form:select>
        </div>


        <div class="form-section">
            <label>Remarks:</label>
            <form:input path="remarks" placeholder="Enter remarks (optional)" />
        </div>


        <div class="form-section">
            <label>Transfer Date:</label>
         <form:input path="transferDate" type="date" required="required"/>
        </div>

        <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ASSET_MANAGER')">
     <div class="button-container">
         <button type="submit" class="transfer-btn equal-btn">Transfer Asset</button>
         <a href="${pageContext.request.contextPath}/view_assets_list" class="back-button equal-btn">Back to Assets</a>
     </div>
    </form:form>
</div>
<script>
    document.getElementById('assetName').value = '${asset.assetName}';
    document.getElementById('assetCode').value = '${asset.assetCode}';
</script>

</body>
</html>
