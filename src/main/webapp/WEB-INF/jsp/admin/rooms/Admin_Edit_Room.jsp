<jsp:include page="../../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}

.container {
    width: 60%;
    margin: 40px auto;
    background: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
}

h2 {
    text-align: center;
    color: #333;
}

form {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
}

.form-group {
    width: 30%;
    margin-bottom: 15px;
}

.form-group.full-width {
    width: 100%;
}

label {
    font-weight: bold;
    display: block;
    margin-bottom: 5px;
}

.form-control {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 5px;
    height: 30px;
    font-size: 16px;
}

.large-textarea {
    height: 80px;
}

.button-group {
    text-align: center;
    margin-top: 20px;
    width: 100%;
}

.submit-btn, .cancel-btn {
    padding: 10px 20px;
    text-decoration: none;
    border-radius: 5px;
    font-size: 16px;
}

.submit-btn {
    background: #28a745;
    color: white;
    border: none;
    cursor: pointer;
}

.cancel-btn {
    background: #dc3545;
    color: white;
    padding: 9px 18px;
    display: inline-block;
}

.submit-btn:hover, .cancel-btn:hover {
    opacity: 0.8;
}

.radio-group-container {
    display: flex;
    flex: 2; /* Matches width of input fields in .form-row */
    gap: 10px; /* Space between radio button options */
    align-items: center;
     border: 2px solid #007BFF;
        border-radius: 8px;
        padding: 10px 20px;
        background-color: #f8f9fa;
         width: auto;
}

/* Style individual radio button options */
.radio-group label {
    display: inline-flex; /* Inline with other labels */
    align-items: left;
    margin-right: 10px; /* Spacing between Yes/No buttons */
    cursor: pointer;
    font-size: 14px;
}

/* Hide the default radio buttons */
.radio-group input[type="radio"] {
    display: none;
}

/* Custom radio button appearance */
.radio-group input[type="radio"] + span {
    display: inline-block;
    padding: 6px 12px;
    border: 1px solid #ccc;
    border-radius: 4px;
    background-color: #ffffff;
    transition: all 0.3s ease;
}

/* Selected radio button appearance */
.radio-group input[type="radio"]:checked + span {
    background-color: #007BFF;
    color: white;
    border-color: #007BFF;
}

/* Focus effect for radio buttons */
.radio-group input[type="radio"]:focus + span {
    outline: 2px solid #007BFF;
}
</style>

 <div class="container">
        <h2>Edit Room Category</h2>
        <form:form action="edit_edit_room" modelAttribute="ROOM_OBJ" method="post">
            <form:hidden path="roomCategoryId" />
            <div class="form-group">
                <label>Room Category:</label>
                <form:input path="roomCategoryName" cssClass="form-control" required="true"/>
            </div>

            <div class="form-group">
                <label>Size (Sq. Ft.): </label>
                <form:input path="size" cssClass="form-control"/>
            </div>

            <div class="form-group">
                <label>Max Occupancy:</label>
                <form:input path="maxOccupancy" type="number" min="1" cssClass="form-control" required="true"/>
            </div>

            <div class="form-group">
                <label>Standard Occupancy (Without Extrabed):</label>
                <form:input path="standardOccupancy" type="number" min="1" cssClass="form-control" required="true"/>
            </div>

            <div class="form-group">
                <label>Extra Bed:</label>
                <form:input path="extraBed" type="number" min="0" cssClass="form-control"/>
            </div>

            <div class="form-group">
                <label>Child (Without Extrabed but 5yr +):</label>
                <form:input path="child" type="number" min="0" cssClass="form-control"/>
            </div>

            <div class="form-group">
                <label>Comp. Child (Child Below 5 years):</label>
                <form:input path="compChild" type="number" min="0" cssClass="form-control"/>
            </div>

            <div class="form-group">
                <label>Category Level:</label>
                <form:input path="categoryLevel" type="number" min="1" cssClass="form-control"/>
            </div>

            <div class="form-group">
                <div class="radio-group-container">
                      <label for="field4">Active:</label>
                      <div class="radio-group">
                         <label>
                             <form:radiobutton path="active" name="accountLocked" value="YES" required="required" />
                             <span>Yes</span>
                         </label>
                         <label>
                             <form:radiobutton path="active" name="accountLocked"  value="NO" required="required" />
                             <span>No</span>
                         </label>
                     </div>
                   </div>
            </div>

            <div class="form-group full-width">
                <label>Description:</label>
                <form:textarea path="description" cssClass="form-control large-textarea"/>
            </div>

            <div class="button-group">
                <button type="submit" class="submit-btn">Update</button>
                <a href="view_rooms_list" class="cancel-btn">Cancel</a>
            </div>

        </form:form>
    </div>


<jsp:include page="../../footer.jsp" />
