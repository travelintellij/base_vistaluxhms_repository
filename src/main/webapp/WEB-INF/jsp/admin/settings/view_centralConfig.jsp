<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
    <title>Hotel Central Configuration</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f4f6f8;
            color: #333;
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
            margin-top: 20px;
            font-weight: 600;
            color: #2c3e50;
        }

        .form-container {
            width: 70%;
            margin: 20px auto;
            background: #fff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }

        .form-group {
            display: grid;
            grid-template-columns: 30% 70%;
            align-items: center;
            margin-bottom: 15px;
        }

        .form-group label {
            font-weight: 500;
            color: #444;
            padding-right: 10px;
        }

        .input-field {
            width: 95%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        textarea.input-field {
            min-height: 60px;
        }

        fieldset {
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 8px;
            background: #fdfdfd;
            margin-bottom: 20px;
        }

        fieldset legend {
            font-weight: 600;
            font-size: 15px;
            color: #2c3e50;
            padding: 0 8px;
        }

        .btn-container {
            text-align: center;
            margin-top: 20px;
        }

        .btn-save {
            background: #007bff;
            color: #fff;
            padding: 10px 18px;
            border: none;
            border-radius: 5px;
            font-size: 15px;
            cursor: pointer;
        }

        .btn-save:hover {
            background: #0056b3;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .form-container {
                width: 90%;
            }
            .form-group {
                grid-template-columns: 1fr;
                gap: 5px;
            }
            .input-field {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<h2>Hotel Central Configuration</h2>
<div align="center" style="margin:10px 0"><b>
    <c:if test="${not empty Success}">
        <script>
               if (window.parent && typeof window.parent.updateLogo === 'function') {
                        window.parent.updateLogo();
                    }
        </script>
    </c:if>

    <font color="green">${Success} </font>
    <font color="red">${Error}</font>
</b></div>

<div class="form-container">
<form:form modelAttribute="CENTRAL_CONFIG_OBJ" method="post" enctype="multipart/form-data" action="create_edit_central_config">

    <div class="form-group">
        <label>Logo Upload</label>
        <div>
            <input type="file" id="logoFile" name="logoFile" accept="image/*" />
            <br>
            <img id="logoPreview" style="margin-top: 10px; max-height: 60px; display: none;" />
        </div>
    </div>

    <div class="form-group">
        <label>Hotel Name</label>
        <form:input path="hotelName" class="input-field" />
    </div>

    <div class="form-group">
        <label>Hotel Address</label>
        <form:input path="hotelAddress" class="input-field" />
    </div>

    <div class="form-group">
        <label>Central Number</label>
        <form:input path="centralNumber" class="input-field" />
    </div>

    <div class="form-group">
        <label>Centralized Email</label>
        <form:input path="centralizedEmail" class="input-field" />
    </div>

    <div class="form-group">
        <label>GST Number</label>
        <form:input path="gstNumber" class="input-field" />
    </div>

    <!-- Bank Details -->
    <fieldset>
        <legend>Bank Details</legend>

        <div class="form-group">
            <label>Bank Name</label>
            <form:input path="bankName" class="input-field" />
        </div>

        <div class="form-group">
            <label>Account Number</label>
            <form:input path="accountNumber" class="input-field" />
        </div>

        <div class="form-group">
            <label>IFSC Code</label>
            <form:input path="ifscCode" class="input-field" />
        </div>

        <div class="form-group">
            <label>Branch</label>
            <form:input path="branch" class="input-field" />
        </div>
    </fieldset>

    <div class="form-group">
        <label>Global Watcher Emails</label>
        <form:textarea path="globalWatcherEmails" class="input-field"></form:textarea>
    </div>

    <div class="form-group">
        <label>Global Watcher Enabled</label>
        <div>
            <form:radiobutton path="globalWatcherEnabled" value="true" /> Yes
            <form:radiobutton path="globalWatcherEnabled" value="false" /> No
        </div>
    </div>

    <!-- Social Media Links -->
    <fieldset>
        <legend>Social Media Links</legend>

        <div class="form-group">
            <label>Facebook</label>
            <form:input path="facebookLink" class="input-field" />
        </div>

        <div class="form-group">
            <label>Instagram</label>
            <form:input path="instagramLink" class="input-field" />
        </div>

        <div class="form-group">
            <label>LinkedIn</label>
            <form:input path="linkedinLink" class="input-field" />
        </div>

        <div class="form-group">
            <label>YouTube</label>
            <form:input path="youtubeLink" class="input-field" />
        </div>

        <div class="form-group">
            <label>X (Twitter)</label>
            <form:input path="xLink" class="input-field" />
        </div>
    </fieldset>

    <div class="btn-container">
        <button type="submit" class="btn-save">Save Configuration</button>
    </div>
</form:form>
</div>

<script>
    document.getElementById('logoFile').addEventListener('change', function(event) {
        const preview = document.getElementById('logoPreview');
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                preview.src = e.target.result;
                preview.style.display = 'block';
            }
            reader.readAsDataURL(file);
        } else {
            preview.style.display = 'none';
        }
    });



</script>

</body>
</html>
