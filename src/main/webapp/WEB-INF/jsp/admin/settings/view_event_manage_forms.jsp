<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="eventType" value="${
  not empty param.eventType ? param.eventType :
  (not empty eventForm.eventType ? eventForm.eventType : 'wedding')
}"/>

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
   <a class="tab ${eventType == 'wedding' ? 'active' : ''}"
      href="<c:url value='/view_form_manage_event_forms'><c:param name='eventType' value='wedding'/></c:url>">
     Wedding Configuration
   </a>

   <a class="tab ${eventType == 'GROUP_EVENT' ? 'active' : ''}"
      href="<c:url value='/view_form_manage_event_forms'><c:param name='eventType' value='GROUP_EVENT'/></c:url>">
     Other Group Configuration
   </a>
 </div>


  <!-- Form 1 -->
  <div id="form1" class="form-container ${eventType == 'wedding' ? 'active' : ''}"  background-color: lightblue;>
 <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

 <form:form method="post" modelAttribute="eventForm"  action="view_form_save_event_config_forms" enctype="multipart/form-data">
     <div align="center" style="margin:10px 0"><b>
         <font color="green">${Success} </font>
         <font color="red">${Error}</font>
     </b></div>

     <h3>Wedding Event Form</h3>
      <input type="hidden" name="eventType" value="wedding"/>
     <!-- Banner Image -->
     <label for="bannerImage">Banner Image</label>
     <form:input path="bannerImage" type="file" accept="image/*" onchange="previewImage(this)" />
     <div class="image-slot">
        <img id="preview-banner1" src="${eventForm.bannerImageBase64}" alt="No Image">

     </div>

     <!-- Gallery Images -->
     <label>Upload up to 6 Images (For PDF Quotation) </label>
 <div class="image-upload-group">
    <c:forEach var="i" begin="1" end="6">
        <div class="image-slot">
            <c:choose>
                <c:when test="${not empty eventForm.galleryImageDataUrls[i-1]}">
                    <img id="preview${i}" src="${eventForm.galleryImageDataUrls[i-1]}" alt="Image ${i}" />
                     <button type="button" class="delete-btn" onclick="deleteImageById(${eventForm.galleryImageIds[i-1]}, ${i})"">&times;</button>
                </c:when>
                <c:otherwise>
                    <img id="preview${i}" src="" alt="No Image" />
                </c:otherwise>
            </c:choose>
            <input type="file" name="image${i}" accept="image/*" onchange="previewImage(this)">
        </div>
    </c:forEach>
 </div>
 <p><h3>Image URL is required for emails embedding.</h3></p>
<c:forEach var="i" begin="1" end="6">
    Image ${i} : <form:input path="imageUrl${i}" name="imageUrl${i}"  placeholder="image${i}-url" style="width:250px;"/> <br>
</c:forEach>



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
  <div id="form2" class="form-container ${eventType == 'GROUP_EVENT' ? 'active' : ''}">
   <form:form method="post" modelAttribute="eventForm"  action="view_form_save_event_config_forms" enctype="multipart/form-data">
        <input type="hidden" name="eventType" value="GROUP_EVENT"/>
        <div align="center" style="margin:10px 0"><b>
            <font color="green">${Success} </font>
            <font color="red">${Error}</font>
        </b></div>

        <h3>Wedding Event Form</h3>

        <!-- Banner Image -->
        <label for="bannerImage">Banner Image</label>
        <form:input path="bannerImage" type="file" accept="image/*" onchange="previewImageForm2(this)" />
        <div class="image-slot">
           <img id="preview-banner2" src="${eventForm.bannerImageBase64}" alt="No Image">
        </div>

        <!-- Gallery Images -->
        <label>Upload up to 6 Images (For PDF Quotation) </label>
    <div class="image-upload-group">
       <c:forEach var="i" begin="1" end="6">
           <div class="image-slot">
               <c:choose>
                   <c:when test="${not empty eventForm.galleryImageDataUrls[i-1]}">
                       <img id="preview2-${i}" src="${eventForm.galleryImageDataUrls[i-1]}" alt="Image ${i}" />
                        <button type="button" class="delete-btn" onclick="deleteImageByIdForm2(${eventForm.galleryImageIds[i-1]}, ${i})"">&times;</button>
                   </c:when>
                   <c:otherwise>
                       <img id="preview2-${i}" src="" alt="No Image" />
                   </c:otherwise>
               </c:choose>
               <input type="file" name="image${i}" accept="image/*" onchange="previewImageForm2(this)">
           </div>
       </c:forEach>
    </div>
    <p><h3>Image URL is required for emails embedding.</h3></p>
   <c:forEach var="i" begin="1" end="6">
       Image ${i} : <form:input path="imageUrl${i}" name="imageUrl${i}"  placeholder="image${i}-url" style="width:250px;"/> <br>
   </c:forEach>



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

    function previewImageForm2(input) {
        if (input.files && input.files[0]) {
            let reader = new FileReader();
            reader.onload = function (e) {
                // Banner
                if (input.name === 'bannerImage') {
                    document.getElementById('preview-banner2').src = e.target.result;
                }
                // Gallery (image1..image6)
                else if (input.name.startsWith("image")) {
                    let index = input.name.replace("image", "");
                    document.getElementById("preview2-" + index).src = e.target.result;
                }
            };
            reader.readAsDataURL(input.files[0]);
        }
    }

     function deleteImageById(imageId, index) {
            if (!confirm("Are you sure you want to delete this image?")) {
                return;
            }

            fetch('<c:url value="/event/deleteImage"/>' + '?id=' + imageId, {
                method: 'DELETE'
            })
            .then(response => {
                if (response.ok) {
                    // Clear preview and file input
                    document.getElementById('preview' + index).src = '';
                    document.querySelector('input[name="image' + index + '"]').value = '';
                } else {
                    alert('Failed to delete image.');
                }
            })
            .catch(err => {
                console.error('Error deleting image:', err);
                alert('An error occurred while deleting the image.');
            });
        }

        function deleteImageByIdForm2(imageId, index) {
          if (!confirm("Are you sure you want to delete this image?")) return;
          fetch('<c:url value="/event/deleteImage"/>' + '?id=' + imageId, { method: 'DELETE' })
            .then(r => { if (!r.ok) throw 0;
              const img = document.getElementById('preview2-' + index);
              if (img) img.src = '';
              const input = document.querySelector(`#form2 input[name="image${index}"]`) || document.querySelector(`input[name="image${index}"]`);
              if (input) input.value = '';
            })
            .catch(() => alert('Failed to delete image.'));
        }
  </script>
</body>
</html>
