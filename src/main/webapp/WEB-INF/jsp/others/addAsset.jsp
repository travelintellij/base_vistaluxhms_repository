<%@ page contentType="text/html;charset=UTF-8" language="java" %>
              <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
              <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

              <html>
              <head>
              <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/stylesfilter.css">
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
                         background: #f4f6f9;
                         font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                         margin: 0;
                         padding: 0;
                     }

                    body {
                        background-image: url('<%= request.getContextPath() %>/resources/images/clientadd.jpg');
                        background-size: cover;
                        background-position: center;
                        background-attachment: fixed;
                        height: 100vh;
                        position: relative;
                        opacity: .98;
                    }

                    body::after {
                        content: "";
                        position: absolute;
                        top: 0;
                        left: 0;
                        right: 0;
                        bottom: 0;
                        background: rgba(255,255,255,0.3);
                        z-index: -1;
                    }

                    .form-container-wrapper {
                        background: transparent !important;
                    }

                    .form-container {
                        width: 60%;
                        margin: 40px auto;
                        padding: 25px;
                        background: #fff;
                        border-radius: 10px;
                        box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
                    }

                    .form-container h2 {
                        text-align: center;
                        margin-bottom: 30px;
                        font-size: 32px;
                        font-weight: bold;
                    }

                    .form-row {
                        display: flex;
                        align-items: center;
                        margin-bottom: 20px;
                    }

                    .form-row label {
                        width: 34%;
                        font-weight: 600;
                        font-size: 15px;
                    }

                    .form-row input,
                    .form-row select,
                    .form-row textarea {
                        width: 66%;
                        padding: 10px;
                        border: 1px solid #ccc;
                        border-radius: 4px;
                        font-size: 14px;
                    }

                    .form-row textarea {
                        resize: vertical;
                    }

                    .form-row input:focus,
                    .form-row select:focus,
                    .form-row textarea:focus {
                        border-color: #ff4b2b;
                        box-shadow: 0 0 5px rgba(255,75,43,0.3);
                        outline: none;
                    }

                    .button-container {
                        text-align: center;
                        margin-top: 30px;
                    }

                    .button-container input[type="submit"],
                    .button-container input[type="button"] {
                        padding: 10px 20px;
                        border: none;
                        border-radius: 4px;
                        font-size: 14px;
                        cursor: pointer;
                    }







                    .error-message {
                        color: red;
                        font-size: 13px;
                        margin-left: 10px;
                    }

                      #description:focus {
                          border-color: #ff4b2b;
                          box-shadow: 0 0 15px rgba(255,75,43,0.3);
                          outline: none;
                      }

                      .asset-container {
                          width: 45%;
                          min-width: 45%;
                          max-width: 45%;
                          margin: 40px auto;
                      }
                  </style>
              </head>
              <body>

              <jsp:include page="/WEB-INF/jsp/_menu_builder_header.jsp"/>


                  <div class="form-container-wrapper">
                      <div class="form-container">

                  <h2>Add Asset</h2>

                  <form:form modelAttribute="assetDTO" action="${pageContext.request.contextPath}/save_asset" method="post">

                      <div class="form-row">
                          <label for="assetName">Asset Name *</label>
                          <form:input path="assetName" id="assetName" required="true" />
                      </div>


                     <div class="form-row">
                         <label for="assetCost">Asset Cost</label>
                         <form:input path="assetCost" id="assetCost" type="number" step="0.01"
                                     value="${assetDTO.assetCost != null ? assetDTO.assetCost : ''}" />

                         <c:if test="${not empty costError}">
                             <span class="error-message">${costError}</span>
                         </c:if>
                     </div>



                   <div class="form-row">
                       <label for="categoryId">Category *</label>
                       <form:select path="categoryId" id="categoryId" required="true">
                           <form:option value="">-- Select Category --</form:option>
                           <c:forEach var="cat" items="${categories}">
                               <form:option value="${cat.categoryId}" label="${cat.categoryName}" />
                           </c:forEach>
                       </form:select>
                       <form:errors path="categoryId" cssClass="error-message" />
                   </div>

                      <div class="form-row">
                          <label for="assetOwnerId">Assign Owner</label>
                          <form:select path="assetOwnerId" id="assetOwnerId">
                              <form:option value="">-- Select Employee --</form:option>
                           <c:forEach var="team" items="${ashokaTeams}">
                               <form:option value="${team.userId}" label="${team.name} (${team.username})" />
                           </c:forEach>
                          </form:select>
                          <c:if test="${not empty ownerError}">
                              <span class="error-message">${ownerError}</span>
                          </c:if>
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


                      <div class="button-container">
                      <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ASSET_MANAGER')">
                          <input type="submit" value="Save Asset"/>
                          </sec:authorize>
                          <a href="${pageContext.request.contextPath}/view_assets_list">  <input type="button"
                                                                                                 class="clear-filter-btn"
                                                                                                 value="View Asset List"/>
                      </div>
                  </form:form>
              </div></div>
              </body>
              </html>

