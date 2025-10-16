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
            background: linear-gradient(135deg, #ff9a9e, #fad0c4);
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


        button {
            width: 100%;
            padding: 18px;
            font-size: 22px;
            font-weight: bold;
            letter-spacing: 1px;
            color: #fff;
            border: none;
            border-radius: 15px;
            cursor: pointer;
            background: linear-gradient(90deg, #ff416c, #ff4b2b);
            transition: all 0.3s ease;
        }

        button:hover {
            transform: scale(1.05);
            box-shadow: 0 0 20px rgba(255,75,43,0.5);
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


    <h1>Transfer Asset - <c:out value="${asset.assetName}" /></h1>
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
        <button type="submit">Transfer Asset</button>
        </sec:authorize>
    </form:form>
</div>
<script>
    document.getElementById('assetName').value = '${asset.assetName}';
    document.getElementById('assetCode').value = '${asset.assetCode}';
</script>

</body>
</html>
