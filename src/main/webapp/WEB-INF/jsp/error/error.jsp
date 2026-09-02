<%@ page isErrorPage="true" contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error - Ashoka CRM</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            text-align: center;
            padding-top: 100px;
        }
        .error-box {
            background: #ffffff;
            width: 500px;
            margin: auto;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.1);
        }
        h2 {
            color: #d9534f;
            margin-bottom: 20px;
        }
        p {
            color: #555;
            font-size: 16px;
        }
        .home-btn {
            display: inline-block;
            margin-top: 25px;
            padding: 10px 20px;
            background-color: #007bff;
            color: #ffffff;
            text-decoration: none;
            border-radius: 4px;
        }
        .home-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="error-box">
    <h2>Something Went Wrong</h2>

    <p>
        ${errorMessage != null ? errorMessage :
        "An unexpected error occurred. Please contact the administrator."}
    </p>

    <a href="${pageContext.request.contextPath}/login" class="home-btn">
        Go Back to Home
    </a>
</div>

</body>
</html>