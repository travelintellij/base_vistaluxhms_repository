<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">
<script src="<c:url value="/resources/core/jquery.1.10.2.min.js" />"></script>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<style>
body {
  font-family: "Lato", sans-serif;
}

.main {
  font-size: 15px; /* Increased text to enable scrolling */
  padding: 0px 10px;
  position: absolute;
}

@media screen and (max-height: 450px) {
  .sidenav {padding-top: 15px;}
  .sidenav a {font-size: 18px;}
}
a:hover, a:active {
  background-color: lightblue;
}
table {
  width: 100%;
  height: 60px;
  border-collapse: collapse;
  border: 1px solid #38678f;
  //margin: 5px auto;
  background: white;
}

th {
  background: #7B68EE;
  height: 30px;
  font-weight: heavy;
  text-shadow: 0 1px 0 #38678f;
  color: white;
  border: 1px solid #38678f;
  box-shadow: inset 0px 1px 2px #568ebd;
  transition: all 0.2s;
  font-size: 15px;
}
tr {
  border-bottom: 1px solid #cccccc;
}

td {
  border-right: 1px solid #cccccc;
  height: 30px;
  padding: 5px;
  transition: all 0.2s;
  text-align: center;
  font-size: 15px;
}

.search-slt{
    display: block;
    width: 50%;
    font-size: 0.875rem;
    line-height: 1.5;
    color: #55595c;
    background-color: #fff;
    background-image: none;
    border: 1px solid #ccc;
    height: 45px !important;
    border-radius:0;
}
select {
	appearance: none;
	outline: 0;
	background: lightgreen;
	background-image: none;
	width: 100%;
	height: 100%;
	color: black;
	cursor: pointer;
	border: 1px solid black;
	border-radius: 3px;
	text-indent: 2px;
}

.select {
	position: relative;
	display: block;
	height: 2.5em;
	line-height: 3;
	overflow: hidden;
	border-radius: .25em;
	padding-bottom: 10px;
	padding-top: 10px;
}
.select option.service-small {
	font-size: 20px;
	padding: 25px;
	background: lightgreen;
}
input[type=button], input[type=submit], input[type=reset] {
  background-color: #4CAF50;
  border: none;
  color: white;
  padding: 10px 20px;
  text-decoration: none;
  margin: 4px 2px;
  cursor: pointer;
}
   .profile-header {
    text-align: center;
    margin-bottom: 10px;
    }
</style>
</head>
<body>
<div class="main">
<div align="center"><b><font color="green" > ${Success} </font><font color="red"> ${Error}</font> </b></div>
	
		<c:forEach items="${ROLE_OBJ}" var="roleMap">
			<sec:authorize access="hasRole('ROLE_SUPERADMIN')">
			         <c:if test="${roleMap.key ne 'PRIV' and fn:substring(roleMap.key, fn:length(roleMap.key)-4, fn:length(roleMap.key)) eq '-SAR'}">
                    				<div class="profile-header">
                    				<h2>${roleMap.key}</h2>
                    				</div>
                    				<table style="width: 90%;">
                    					<tr>
                    						<th style="background-color:green;width:12%;">User</th>
                    						<c:forEach var="roleList" items="${roleMap.value}">
                    							<th style="width:9%;">${roleList.roleName}</th>
                    						</c:forEach>

                    						<c:forEach var = "i" begin = "${roleMap.value.size()}" end = "8">
                            					 <th style="width:9%;">&nbsp;</th>
                          					</c:forEach>



                    						<th>Action</th>
                    					</tr>

                    						<c:forEach var="user" items="${ACTIVE_USERS_LIST}">
                    								<form:form action="update_update_user_permissions" modelAttribute="USER_OBJ">
                    								<input type="hidden" name="userId" value="${user.userId}" />
                    								<input type="hidden" name="roleName" value="${roleMap.key}" />
                    								<tr>
                    										<td style="width:9%;">${user.username}</td>
                    										<c:forEach var="roleList" items="${roleMap.value}">

                    											<c:if test = "${fn:containsIgnoreCase(user.roles, roleList.roleName)}">
                    												<td style="width:9%;">
                    												 	<form:checkbox path="roles" value="${roleList.roleId}" checked="checked"  style="width: 20px; height: 20px; accent-color: #28a745; cursor: pointer;" />
                    												</td>
                    											</c:if>
                    											<c:if test = "${! fn:containsIgnoreCase(user.roles, roleList.roleName)}">
                    												<td style="width:9%;"><form:checkbox path="roles" value="${roleList.roleId}"  style="width: 20px; height: 20px; accent-color: #28a745; cursor: pointer;" /></td>
                    											</c:if>
                    										</c:forEach>
                    										<c:forEach var = "i" begin = "${roleMap.value.size()}" end = "8">
                            									 <td style="width:9%;">&nbsp;</td>
                          									</c:forEach>

                    									 	<td style="width:9%;"><input type="submit" style="background-color: blue;padding: 4px 5px;"value="Update Permission" /></td>

                    									</tr>
                    								</form:form>

                    						</c:forEach>


                    					</table>
                    					<hr>
                    			</c:if>
			</sec:authorize>



            <c:if test="${roleMap.key ne 'PRIV' and fn:substring(roleMap.key, fn:length(roleMap.key)-4, fn:length(roleMap.key)) ne '-SAR'}">
				<div class="profile-header">
				<h2>${roleMap.key}</h2>
				</div>
				<table style="width: 90%;">
					<tr>
						<th style="background-color:green;width:12%;">User</th>
						<c:forEach var="roleList" items="${roleMap.value}">
							<th style="width:9%;">${roleList.roleName}</th>
						</c:forEach>
						
						<c:forEach var = "i" begin = "${roleMap.value.size()}" end = "8">
        					 <th style="width:9%;">&nbsp;</th>
      					</c:forEach>
        					  
      						
						
						<th>Action</th>
					</tr>
						
						<c:forEach var="user" items="${ACTIVE_USERS_LIST}">
							<c:if test = "${! fn:containsIgnoreCase(user.roles, 'ADMIN')}">
								<form:form action="update_update_user_permissions" modelAttribute="USER_OBJ">
								<input type="hidden" name="userId" value="${user.userId}" />
								<input type="hidden" name="roleName" value="${roleMap.key}" />
								<tr>
										<td style="width:9%;">${user.username}</td>
										<c:forEach var="roleList" items="${roleMap.value}">

											<c:if test = "${fn:containsIgnoreCase(user.roles, roleList.roleName)}">
												<td style="width:9%;">
												 	<form:checkbox path="roles" value="${roleList.roleId}" checked="checked"  style="width: 20px; height: 20px; accent-color: #28a745; cursor: pointer;" />
												</td>
											</c:if>
											<c:if test = "${! fn:containsIgnoreCase(user.roles, roleList.roleName)}">
												<td style="width:9%;"><form:checkbox path="roles" value="${roleList.roleId}"  style="width: 20px; height: 20px; accent-color: #28a745; cursor: pointer;" /></td>
											</c:if>
										</c:forEach>
										<c:forEach var = "i" begin = "${roleMap.value.size()}" end = "8">
        									 <td style="width:9%;">&nbsp;</td>
      									</c:forEach>
        				
									 	<td style="width:9%;"><input type="submit" style="background-color: blue;padding: 4px 5px;"value="Update Permission" /></td>
									
									</tr>
								</form:form>
							</c:if>
						</c:forEach>
						
						
					</table>
					<hr>
			</c:if>
			</c:forEach>
	
  
</div>  

</body>
</html> 

<%--<form:checkboxes title="Assigned Roles:" path="roles" id="roles" items="${roleMap.value}" itemLabel="roleName" itemValue="roleId" />** --%>
<%-- <input type="checkbox" name="roles" value="${roleList.roleName}" checked></input>--%>
