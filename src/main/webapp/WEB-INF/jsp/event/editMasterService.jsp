<jsp:include page="../_menu_builder_header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<head>
    <title>Update Event Master Service</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">
    <style>
       body {
              background-image: url('<%= request.getContextPath() %>/resources/images/event.jpg');
              background-size: cover; /* Ensures the image covers the full page */
              background-position: center; /* Centers the image */
              background-attachment: fixed; /* Keeps the background fixed while scrolling */
              height: 100vh; /* Ensures the background covers the full height of the viewport */
              position: relative; /* Required for the overlay */
          }

        .form-container {
            background-color: #fff;
            padding: 25px;
            border-radius: 10px;
            max-width: 700px;
            margin: auto;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
        }

        label {
            font-weight: 500;
            margin-top: 10px;
            display: block;
            color: #444;
        }

        input[type="text"], input[type="number"], textarea, select {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
            margin-bottom: 15px;
            font-size: 15px;
        }

        input[type="checkbox"] {
            margin-top: 10px;
        }

        button {
            padding: 10px 20px;
            background-color: #ffc107;
            border: none;
            color: #fff;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #e0a800;
        }
    </style>
</head>
<body>
<h2>Update Event Master Service</h2>

<div class="form-container" >
    <form:form method="post" action="create_edit_master_service" modelAttribute="EVENT_MASTER_SERVICE" autocomplete="off">
        <form:hidden path="id" />
        <label for="name"><b>Service Name:</b></label>
        <form:input path="name" required="required" />

        <label for="description"><b>Description:</b></label>
        <form:textarea path = "description" rows="6" maxlength="1000" style="width: 100%; box-sizing: border-box;" />

        <label for="type"><b>Service Type:</b></label>
        <form:select path="eventServiceCostTypeEntity.eventServiceCostTypeId" required="required" style="width:50%">
                   <form:options items="${SERVICE_TYPE}" itemValue="eventServiceCostTypeId" itemLabel="eventServiceCostTypeName" />
        </form:select>



        <label for="baseCost"><b>Base Cost:</b></label>
        <form:input path="baseCost" type="number" required="required" min="1" />

        <label for="eventType"><b>Event Type:</b></label>
        <form:select path="eventTypeId" required="required" style="width:50%">
           <form:options items="${EVENT_TYPES}" itemValue="eventTypeId" itemLabel="eventTypeName" />
       </form:select>

        <label>
            <form:checkbox path="active" />Active
        </label>

        <br/><br/>

        <div class="button-container">
            <input type="submit" value="Save Service" class="clear-filter-btn">
               <a href="view_master_service_list"><input type="button" class="clear-filter-btn" value="View Master Service List"></input></a>
        </div>

    </form:form>
</div>
</body>
</html>
