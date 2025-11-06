<%@ page contentType="text/html;charset=UTF-8" language="java" %>
              <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
              <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

              <html>
              <head>
                  <title>Add Asset</title>
                  <style>

                   .error-message {
                      color: red;
                      font-size: 16px;
                      margin-top: 5px;
                      display: block;
                  }

                  .btn-cancel {
                      background: #ccc;
                      color: #333;
                      padding: 18px 40px;
                      font-size: 22px;
                      font-weight: bold;
                      border-radius: 15px;
                      text-decoration: none;
                      display: inline-block;
                      transition: all 0.3s ease;
                      border: none;
                      cursor: pointer;
                  }

                  .btn-cancel:hover {
                      background: #999;
                      color: #fff;
                      transform: scale(1.05);
                  }
              .page-header-fullwidth {
                  width: 100%;
                  background-color: #fff;
                  padding: 20px 0;
                  margin-bottom: 40px;
                  }

              .page-header-fullwidth h2 {
                  font-size: 36px;
                  color: #ff4b2b;
                  margin: 0;
                  padding-left: 20px;
              }
                      body {
                          margin: 0; padding: 0;
                          font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                          background: linear-gradient(135deg, #6dd5ed, #2193b0);
                          min-height: 100vh;

                      }
                      .container {
                          width: 95%; max-width: 900px;
                          background: #fff; border-radius: 20px;
                          padding: 50px 60px;
                          margin: 50px auto;
                          box-shadow: 0 15px 40px rgba(0,0,0,0.3);
                      }
                      h2 { text-align: center; font-size: 40px; margin-bottom: 40px; color: #ff4b2b; }
                      .form-cell { margin-bottom: 30px; }
                      label { display: block; font-size: 20px; font-weight: bold; margin-bottom: 12px; color: #333; }
                      input[type="text"], input[type="number"], input[type="date"], select {
                          width: 100%; padding: 18px 15px; font-size: 18px;
                          border-radius: 12px; border: 2px solid #ccc; transition: all 0.3s ease;
                      }
                      input[type="text"]:focus, input[type="number"]:focus, input[type="date"]:focus, select:focus {
                          border-color: #ff4b2b; box-shadow: 0 0 15px rgba(255,75,43,0.3); outline: none;
                      }
                      select { cursor: pointer; }
                      .form-actions { text-align: center; margin-top: 40px; }
                      .save-btn {
                          background: linear-gradient(90deg, #ff416c, #ff4b2b);
                          color: #fff; padding: 18px 40px; font-size: 22px; font-weight: bold;
                          border: none; border-radius: 15px; cursor: pointer; transition: all 0.3s ease;
                      }
                      .save-btn:hover { transform: scale(1.05); box-shadow: 0 0 20px rgba(255,75,43,0.5); }
                      .cancel-btn { margin-left: 20px; font-size: 18px; color: #555; text-decoration: none; }
                      .cancel-btn:hover { color: #ff4b2b; text-decoration: underline; }


                      #description:focus {
                          border-color: #ff4b2b;
                          box-shadow: 0 0 15px rgba(255,75,43,0.3);
                          outline: none;
                      }
                  </style>
              </head>
              <body>

              <jsp:include page="/WEB-INF/jsp/_menu_builder_header.jsp"/>


                  <div class="container">

                  <div style="text-align:center; margin-bottom: 30px;">
                      <h2 style="font-size: 36px; color: #ff4b2b; margin: 0;">Add New Asset</h2>
                  </div>

                  <form:form modelAttribute="assetDTO" action="${pageContext.request.contextPath}/save_asset" method="post">

                      <div class="form-cell">
                          <label for="assetName">Asset Name *</label>
                          <form:input path="assetName" id="assetName" required="true" />
                      </div>


                     <div class="form-cell">
                         <label for="assetCost">Asset Cost</label>
                         <form:input path="assetCost" id="assetCost" type="number" step="0.01"
                                     value="${assetDTO.assetCost != null ? assetDTO.assetCost : ''}" />

                         <c:if test="${not empty costError}">
                             <span class="error-message">${costError}</span>
                         </c:if>
                     </div>



                   <div class="form-cell">
                       <label for="categoryId">Category *</label>
                       <form:select path="categoryId" id="categoryId" required="true">
                           <form:option value="">-- Select Category --</form:option>
                           <c:forEach var="cat" items="${categories}">
                               <form:option value="${cat.categoryId}" label="${cat.categoryName}" />
                           </c:forEach>
                       </form:select>
                       <form:errors path="categoryId" cssClass="error-message" />
                   </div>

                      <div class="form-cell">
                          <label for="assetOwnerId">Assign Owner</label>
                          <form:select path="assetOwnerId" id="assetOwnerId">
                              <form:option value="">-- Select Employee --</form:option>
                           <c:forEach var="team" items="${ashokaTeams}">
                               <form:option value="${team.userId}" label="${team.name} (${team.username})" />
                           </c:forEach>
                          </form:select>
                      </div>


                      <div class="form-cell" style="width: 100%;">
                          <label for="description">Description</label>
                          <form:textarea
                              path="description"
                              id="description"
                              rows="6"
                              maxlength="200"
                              placeholder="Enter asset description ..."
                              style="width: 100%; height: 150px; font-size: 18px; padding: 15px; border-radius: 12px; border: 2px solid #ccc; resize: vertical;" />
                            </div>


                      <div class="form-actions">
                      <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ASSET_MANAGER')">
                          <button type="submit" class="save-btn">Save Asset</button>
                          </sec:authorize>
                          <a href="${pageContext.request.contextPath}/view_assets_list" class="cancel-btn btn-cancel">Cancel</a>
                      </div>
                  </form:form>
              </div>
              </body>
              </html>

