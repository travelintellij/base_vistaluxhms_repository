<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- ===== AI MODIFICATION START ===== -->
<!-- Change: Added missing JSTL Functions taglib import for fn prefix -->
<!-- Reason: fn:startsWith() is used on line 364 for logo URL processing but the fn taglib was not imported, causing a JasperException -->
<!-- Scope: login.jsp — taglib declarations -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- ===== AI MODIFICATION END ===== -->
  <!DOCTYPE html>
  <html lang="en">

  <%--=====AI MODIFICATION START=====Change: Complete login page redesign with Grand Suite luxury hotel theme Reason:
    Old login had broken SCSS nesting, broken script tag, and basic styling. New design uses valid CSS, split-screen
    layout, hotel-inspired aesthetics. Scope: login.jsp — the first page users see --%>

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Login | AxisHMS Pro</title>

      <link rel="icon"
        href="data:image/png;base64,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"
        type="image/png">

      <!-- Google Fonts -->
      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link
        href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=DM+Sans:wght@300;400;500;600&display=swap"
        rel="stylesheet">

      <!-- Toast messages -->
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
      <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

      <style>
        /* ===== Grand Suite Login Theme ===== */
        :root {
          --gs-charcoal: #1B2A3D;
          --gs-charcoal-light: #243447;
          --gs-gold: #C9A84C;
          --gs-gold-dark: #B08E30;
          --gs-gold-glow: rgba(201, 168, 76, 0.15);
          --gs-ivory: #FAF8F5;
          --gs-white: #FFFFFF;
          --gs-beige: #E8E4DE;
          --gs-text-primary: #2D3748;
          --gs-text-muted: #8C8A87;
          --gs-danger: #B84444;
        }

        * {
          margin: 0;
          padding: 0;
          box-sizing: border-box;
        }

        html,
        body {
          height: 100%;
          width: 100%;
          font-family: 'DM Sans', 'Segoe UI', sans-serif;
          background: var(--gs-ivory);
        }

        /* Main split layout */
        .login-wrapper {
          display: flex;
          min-height: 100vh;
        }

        /* Left brand panel */
        .login-brand {
          flex: 1;
          background: linear-gradient(135deg, var(--gs-charcoal) 0%, var(--gs-charcoal-light) 50%, #1a3550 100%);
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
          padding: 40px;
          position: relative;
          overflow: hidden;
        }

        .login-brand::before {
          content: '';
          position: absolute;
          top: -50%;
          left: -50%;
          width: 200%;
          height: 200%;
          background: radial-gradient(circle at 30% 70%, rgba(201, 168, 76, 0.05) 0%, transparent 60%);
          pointer-events: none;
        }

        .login-brand::after {
          content: '';
          position: absolute;
          bottom: 0;
          left: 0;
          right: 0;
          height: 3px;
          background: linear-gradient(90deg, transparent, var(--gs-gold), transparent);
        }

        .login-brand-content {
          text-align: center;
          z-index: 1;
        }

        .login-brand h1 {
          font-family: 'Playfair Display', serif;
          font-size: 2.4rem;
          color: var(--gs-white);
          font-weight: 600;
          letter-spacing: 0.03em;
          margin-bottom: 8px;
        }

        .login-brand h1 span {
          color: var(--gs-gold);
        }

        .login-brand-tagline {
          color: var(--gs-beige);
          font-size: 0.95rem;
          font-weight: 300;
          letter-spacing: 0.05em;
          opacity: 0.85;
        }

        .login-brand-divider {
          width: 50px;
          height: 2px;
          background: var(--gs-gold);
          margin: 24px auto;
          border-radius: 1px;
        }

        .login-brand-desc {
          color: rgba(232, 228, 222, 0.6);
          font-size: 0.85rem;
          max-width: 300px;
          line-height: 1.6;
        }

        /* Right form panel */
        .login-form-panel {
          flex: 1;
          display: flex;
          align-items: center;
          justify-content: center;
          padding: 40px;
          background: var(--gs-ivory);
        }

        .login-card {
          width: 100%;
          max-width: 380px;
          animation: loginFadeIn 0.5s ease;
        }

        @keyframes loginFadeIn {
          from {
            opacity: 0;
            transform: translateY(12px);
          }

          to {
            opacity: 1;
            transform: translateY(0);
          }
        }

        .login-logo {
          text-align: center;
          margin-bottom: 24px;
        }

        .login-logo img {
          width: 100px;
          height: 100px;
          border-radius: 12px;
          border: 2px solid var(--gs-beige);
          box-shadow: 0 4px 12px rgba(27, 42, 61, 0.08);
        }

        .login-heading {
          font-family: 'Playfair Display', serif;
          font-size: 1.6rem;
          color: var(--gs-charcoal);
          font-weight: 600;
          text-align: center;
          margin-bottom: 4px;
        }

        .login-subtext {
          font-size: 0.85rem;
          color: var(--gs-text-muted);
          text-align: center;
          margin-bottom: 32px;
        }

        /* Error message */
        .login-error {
          background: rgba(184, 68, 68, 0.08);
          border-left: 3px solid var(--gs-danger);
          color: var(--gs-danger);
          padding: 10px 14px;
          border-radius: 4px;
          font-size: 0.85rem;
          margin-bottom: 20px;
        }

        /* Form fields */
        .login-field {
          margin-bottom: 20px;
          position: relative;
        }

        .login-field label {
          display: block;
          font-size: 0.8rem;
          font-weight: 500;
          color: var(--gs-text-primary);
          margin-bottom: 6px;
          letter-spacing: 0.03em;
        }

        .login-field input {
          width: 100%;
          padding: 12px 14px;
          padding-left: 42px;
          font-family: 'DM Sans', sans-serif;
          font-size: 0.9rem;
          color: var(--gs-text-primary);
          background: var(--gs-white);
          border: 1px solid var(--gs-beige);
          border-radius: 6px;
          outline: none;
          transition: all 0.25s ease;
        }

        .login-field input:focus {
          border-color: var(--gs-gold);
          box-shadow: 0 0 0 3px var(--gs-gold-glow);
        }

        .login-field input::placeholder {
          color: var(--gs-text-muted);
        }

        .login-field .field-icon {
          position: absolute;
          left: 14px;
          bottom: 13px;
          font-size: 1rem;
          color: var(--gs-text-muted);
          pointer-events: none;
          transition: color 0.25s ease;
        }

        .login-field input:focus~.field-icon {
          color: var(--gs-gold);
        }

        /* Login button */
        .login-btn {
          width: 100%;
          padding: 13px;
          background: var(--gs-gold);
          color: var(--gs-charcoal);
          border: 1px solid var(--gs-gold-dark);
          border-radius: 6px;
          font-family: 'DM Sans', sans-serif;
          font-size: 0.95rem;
          font-weight: 600;
          cursor: pointer;
          transition: all 0.25s ease;
          letter-spacing: 0.03em;
          margin-top: 8px;
        }

        .login-btn:hover {
          background: var(--gs-gold-dark);
          color: var(--gs-white);
          transform: translateY(-1px);
          box-shadow: 0 4px 12px rgba(201, 168, 76, 0.3);
        }

        .login-btn:active {
          transform: translateY(0);
        }

        .login-footer-link {
          display: block;
          text-align: center;
          margin-top: 20px;
          font-size: 0.8rem;
          color: var(--gs-text-muted);
          text-decoration: none;
          transition: color 0.2s ease;
        }

        .login-footer-link:hover {
          color: var(--gs-gold-dark);
        }

        /* Responsive */
        @media (max-width: 768px) {
          .login-wrapper {
            flex-direction: column;
          }

          .login-brand {
            padding: 30px 20px;
            min-height: 180px;
          }

          .login-brand h1 {
            font-size: 1.6rem;
          }

          .login-brand-desc {
            display: none;
          }

          .login-form-panel {
            padding: 30px 20px;
          }
        }
      </style>
    </head>

    <body>
      <div class="login-wrapper">

        <!-- Left Brand Panel -->
        <div class="login-brand">
          <div class="login-brand-content">
            <c:choose>
              <c:when test="${not empty centralConfig.hotelName}">
                <h1>${centralConfig.hotelName}</h1>
              </c:when>
              <c:otherwise>
                <h1>Axis<span>HMS</span> Pro</h1>
              </c:otherwise>
            </c:choose>
            <p class="login-brand-tagline">P R E M I U M &nbsp; H O T E L &nbsp; C R M</p>
            <div class="login-brand-divider"></div>
            <p class="login-brand-desc">
              Empowering hoteliers with intelligent lead management,
              seamless quotations, and effortless guest experiences.
            </p>
          </div>
        </div>

        <!-- Right Form Panel -->
        <div class="login-form-panel">
          <div class="login-card">

            <div class="login-logo">
              <c:choose>
                <%-- ===== AI MODIFICATION START ===== --%>
                <%-- Change: Add context path dynamically to internally uploaded logos on login page --%>
                <%-- Reason: Avoid broken image link by prepending context path for internal resources --%>
                <%-- Scope: Login Page > Logo URL processing --%>
                <c:when test="${not empty centralConfig.logoPath}">
                  <c:choose>
                    <c:when test="${fn:startsWith(centralConfig.logoPath, '/resources')}">
                      <c:set var="logoUrl" value="${pageContext.request.contextPath}${centralConfig.logoPath}" />
                    </c:when>
                    <c:otherwise>
                      <c:set var="logoUrl" value="${centralConfig.logoPath}" />
                    </c:otherwise>
                  </c:choose>
                </c:when>
                <c:otherwise>
                  <c:set var="logoUrl" value="${pageContext.request.contextPath}/resources/images/ashoka_logo.jpg" />
                </c:otherwise>
              </c:choose>
              <img src="${logoUrl}" alt="Hotel Logo">
              <%-- ===== AI MODIFICATION END ===== --%>
            </div>

            <h2 class="login-heading">Welcome Back</h2>
            <p class="login-subtext">Sign in to your account</p>

            <c:if test="${param.error != null}">
              <div class="login-error">
                <c:choose>
                  <c:when test="${not empty SPRING_SECURITY_LAST_EXCEPTION.message}">
                    ${SPRING_SECURITY_LAST_EXCEPTION.message}
                  </c:when>
                  <c:otherwise>
                    Invalid username or password. Please try again.
                  </c:otherwise>
                </c:choose>
              </div>
            </c:if>

            <form id="loginForm" name="f" th:action="@{/login}" method="post" autocomplete="off">

              <div class="login-field">
                <label for="username">Username</label>
                <input type="text" name="username" id="username" placeholder="Enter your username" autocomplete="off"
                  required>
                <span class="field-icon">&#128100;</span>
              </div>

              <div class="login-field">
                <label for="password">Password</label>
                <input type="password" name="password" id="password" placeholder="Enter your password"
                  autocomplete="off" required>
                <span class="field-icon">&#128274;</span>
              </div>

              <button type="submit" class="login-btn">Sign In</button>

            </form>

            <a href="${pageContext.request.contextPath}/forgot-password" class="login-footer-link">
              Forgot Password?
            </a>

          </div>
        </div>

      </div>

      <script>
        function validateForm() {
          var username = $('#username').val();
          var password = $('#password').val();
          if (username.trim() === '' || password.trim() === '') {
            toastr.error('Please fill in all fields.');
            return false;
          }
          return true;
        }

        $(document).ready(function () {
          $('#loginForm').submit(function () {
            return validateForm();
          });
          // Focus on username field
          $('#username').focus();
        });
      </script>

      <%--=====AI MODIFICATION END=====--%>

    </body>

  </html>