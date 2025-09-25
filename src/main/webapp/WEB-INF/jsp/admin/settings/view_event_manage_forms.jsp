<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">
<script src="<c:url value="/resources/core/jquery.1.10.2.min.js" />"></script>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Switch Forms</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
      background: #f4f6f9;
    }
    .tabs {
      display: flex;
      margin-bottom: 20px;
    }
    .tab {
      flex: 1;
      padding: 12px;
      text-align: center;
      cursor: pointer;
      border: 1px solid #ccc;
      background: #e9ecef;
      transition: background 0.3s, color 0.3s;
    }
    .tab.active {
      background: #007bff;
      color: white;
      font-weight: bold;
    }
    .form-container {
      display: none;
      background: #fff;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    }
    .form-container.active {
      display: block;
    }
    h3 {
      margin-top: 0;
      color: #333;
    }
    label {
      display: block;
      margin: 12px 0 6px;
      font-weight: bold;
      color: #555;
    }
    textarea {
      width: 100%;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 6px;
      resize: vertical;
    }
    .image-upload-group {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
    }
    .image-slot {
      width: 120px;
      text-align: center;
    }
    .image-slot img {
      width: 100%;
      height: 80px;
      object-fit: cover;
      border: 1px solid #ccc;
      border-radius: 6px;
      margin-bottom: 6px;
    }
    .submit-btn {
      margin-top: 20px;
      padding: 10px 20px;
      background: #28a745;
      border: none;
      color: white;
      border-radius: 6px;
      cursor: pointer;
      font-size: 16px;
    }
    .submit-btn:hover {
      background: #218838;
    }

 .image-wrapper {
     position: relative;   /* parent for absolute positioning */
     display: inline-block;
 }


  </style>
</head>
<body>
  <!-- Tabs -->
  <div class="tabs">
    <div class="tab active" onclick="switchForm(1)">Wedding Configuration</div>
    <div class="tab" onclick="switchForm(2)">Other Group Configuration</div>
  </div>

  <!-- Form 1 -->
  <div id="form1" class="form-container active"  background-color: lightblue;>
 <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

 <form:form method="post" modelAttribute="eventForm"  action="view_form_save_event_config_forms" enctype="multipart/form-data">
     <h3>Wedding Event Form</h3>
      <input type="hidden" name="eventType" value="wedding"/>
     <!-- Banner Image -->
     <label for="bannerImage">Banner Image</label>
     <form:input path="bannerImage" type="file" accept="image/*" onchange="previewImage(this)" />
     <div class="image-slot">
        <img id="preview-banner1" src="${eventForm.bannerImageBase64}" alt="No Image">
     </div>

     <!-- Gallery Images -->
     <label>Upload up to 6 Images</label>
 <div class="image-upload-group">
    <c:forEach var="i" begin="1" end="6">
        <div class="image-slot">
            <c:choose>
                <c:when test="${not empty eventForm.galleryImageDataUrls[i-1]}">
                    <img id="preview${i}" src="${eventForm.galleryImageDataUrls[i-1]}" alt="Image ${i}" />
                     <button type="button" class="delete-btn" onclick="deleteImage(${i})">&times;</button>
                </c:when>
                <c:otherwise>
                    <img id="preview${i}" src="" alt="No Image" />
                </c:otherwise>
            </c:choose>
            <input type="file" name="image${i}" accept="image/*" onchange="previewImage(this)">
        </div>
    </c:forEach>
 </div>



     <!-- Text Fields -->
     <label for="resortInfo">Event Resort Information</label>
     <form:textarea path="resortInfo" rows="4" cssClass="form-control"/>

     <label for="celebrationHighlight">Celebration Highlights</label>
     <form:textarea path="celebrationHighlight" rows="3" cssClass="form-control"/>

     <label for="testimonial">Testimonial Section</label>
     <form:textarea path="testimonial" rows="3" cssClass="form-control"/>

     <label for="termsConditions">Terms and Conditions</label>
     <form:textarea path="termsConditions" rows="3" cssClass="form-control"/>

     <!-- Submit -->
     <button type="submit" class="submit-btn">Submit Wedding Event</button>
 </form:form>

  </div>

  <!-- Form 2 -->
  <div id="form2" class="form-container">
    <form>
      <h3>Form 2</h3>

      <label>Banner Image</label>
      <input type="file" name="banner2" accept="image/*" onchange="previewImage(this)">
      <div class="image-slot"><img id="preview-banner2" src="" alt="No Image"></div>

      <label>Upload up to 6 Images</label>
      <div class="image-upload-group">
        <div class="image-slot">
          <img id="preview2-1" src="" alt="No Image">
          <input type="file" name="image2-1" accept="image/*" onchange="previewImage(this)">
        </div>
        <div class="image-slot">
          <img id="preview2-2" src="" alt="No Image">
          <input type="file" name="image2-2" accept="image/*" onchange="previewImage(this)">
        </div>
        <div class="image-slot">
          <img id="preview2-3" src="" alt="No Image">
          <input type="file" name="image2-3" accept="image/*" onchange="previewImage(this)">
        </div>
        <div class="image-slot">
          <img id="preview2-4" src="" alt="No Image">
          <input type="file" name="image2-4" accept="image/*" onchange="previewImage(this)">
        </div>
        <div class="image-slot">
          <img id="preview2-5" src="" alt="No Image">
          <input type="file" name="image2-5" accept="image/*" onchange="previewImage(this)">
        </div>
        <div class="image-slot">
          <img id="preview2-6" src="" alt="No Image">
          <input type="file" name="image2-6" accept="image/*" onchange="previewImage(this)">
        </div>
      </div>

      <label>Event Resort Information</label>
      <textarea rows="4"></textarea>

      <label>Celebration Highlights</label>
      <textarea rows="3"></textarea>

      <label>Testimonial Section</label>
      <textarea rows="3"></textarea>

      <label>Terms and Conditions</label>
      <textarea rows="3"></textarea>

      <button type="submit" class="submit-btn">Submit Form 2</button>
    </form>
  </div>

  <script>
    function switchForm(formNumber) {
      document.querySelectorAll('.tab').forEach(tab => tab.classList.remove('active'));
      document.querySelectorAll('.form-container').forEach(form => form.classList.remove('active'));

      document.querySelector('.tab:nth-child(' + formNumber + ')').classList.add('active');
      document.getElementById('form' + formNumber).classList.add('active');
    }

/*
    function previewImage(input) {
      const file = input.files[0];
      if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
          const img = input.parentNode.querySelector("img");
          img.src = e.target.result;
        }
        reader.readAsDataURL(file);
      }
    }
    */
    function previewImage(input) {
        if (input.files && input.files[0]) {
            let reader = new FileReader();
            reader.onload = function (e) {
                // Case 1: Banner
                if (input.name === 'bannerImage') {
                    document.getElementById('preview-banner1').src = e.target.result;
                }
                // Case 2: Gallery images (image1..image6)
                else if (input.name.startsWith("image")) {
                    let index = input.name.replace("image", ""); // e.g. "image3" → "3"
                    document.getElementById("preview" + index).src = e.target.result;
                }
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
  </script>
</body>
</html>
