<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
    <title>Hotel Central Configuration</title>
  <style>
  .config-table {
      width: 60%;
      margin: 15px auto;
      border-collapse: collapse;
      font-family: Arial, sans-serif;
      background: #f9f9f9;
      border: 1px solid #ddd;
  }

  .config-table th {
      text-align: left;
      padding: 10px;
      background: #efefef;
      width: 35%;
  }

  .config-table td {
      padding: 10px;
  }

  .input-field {
      width: 90%;
      padding: 6px;
      border: 1px solid #ccc;
      border-radius: 4px;
  }

  .fieldset-style {
      width: 64%;
      margin: 20px auto;
      border: 1px solid #aaa;
      padding: 10px;
      border-radius: 5px;
      background: #fefefe;
  }

  .fieldset-style legend {
      font-weight: bold;
      font-size: 14px;
      color: #444;
  }

  .inner-table {
      width: 100%;
      border: none;
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
  </style>

</head>
<body>

<h2 style="text-align:center;">Hotel Central Configuration</h2>

<div class="container">
<form:form modelAttribute="CENTRAL_CONFIG_OBJ" method="post" enctype="multipart/form-data" action="create_edit_central_config">

    <table class="config-table">
        <tr>
            <th>Logo Upload</th>
            <td>
                <input type="file" name="logoFile" accept="image/*" onchange="previewLogo(event)" />
                <br>
                <img id="logoPreview" style="margin-top: 10px; max-height: 60px; display: none;" />
            </td>
        </tr>
        <tr>
            <th>Hotel Name</th>
            <td><form:input path="hotelName" class="input-field" /></td>
        </tr>
        <tr>
            <th>Hotel Address</th>
            <td><form:input path="hotelAddress" class="input-field" /></td>
        </tr>
        <tr>
            <th>Central Number</th>
            <td><form:input path="centralNumber" class="input-field" /></td>
        </tr>
         <tr>
         <th>Centralized Email</th>
            <td><form:input path="centralizedEmail" class="input-field" /></td>
        </tr>
        <tr>
            <th>GST Number</th>
            <td><form:input path="gstNumber" class="input-field" /></td>
        </tr>
    </table>

    <!-- Bank Details Section -->
    <fieldset class="fieldset-style">
        <legend>Bank Details</legend>
        <table class="config-table inner-table">
            <tr>
                <th>Bank Name</th>
                <td><form:input path="bankName" class="input-field" /></td>
            </tr>
            <tr>
                <th>Account Number</th>
                <td><form:input path="accountNumber" class="input-field" /></td>
            </tr>
            <tr>
                <th>IFSC Code</th>
                <td><form:input path="ifscCode" class="input-field" /></td>
            </tr>
            <tr>
                <th>Branch</th>
                <td><form:input path="branch" class="input-field" /></td>
            </tr>
        </table>
    </fieldset>

    <table class="config-table">
        <tr>
            <th>Global Watcher Emails</th>
            <td><form:textarea path="globalWatcherEmails" class="input-field"></form:textarea></td>
        </tr>
        <tr>
            <th>Global Watcher Enabled</th>
            <td>
                <form:radiobutton path="globalWatcherEnabled" value="true" /> Yes
                <form:radiobutton path="globalWatcherEnabled" value="false" /> No
            </td>
        </tr>

    </table>

    <!-- Social Media Section -->
    <fieldset class="fieldset-style">
        <legend>Social Media Links</legend>
        <table class="config-table inner-table">
            <tr><th>Facebook</th><td><form:input path="facebookLink" class="input-field" /></td></tr>
            <tr><th>Instagram</th><td><form:input path="instagramLink" class="input-field" /></td></tr>
            <tr><th>LinkedIn</th><td><form:input path="linkedinLink" class="input-field" /></td></tr>
            <tr><th>YouTube</th><td><form:input path="youtubeLink" class="input-field" /></td></tr>
            <tr><th>X (Twitter)</th><td><form:input path="xLink" class="input-field" /></td></tr>
        </table>
    </fieldset>

    <!-- Center align button -->
    <div style="text-align:center; margin-top:20px;">
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
