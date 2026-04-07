<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password | AxisHMS Pro</title>

    <link rel="icon"
        href="data:image/png;base64,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"
        type="image/png">

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">

    <style>
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
            --gs-success: #2F855A;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        html, body {
            height: 100%; width: 100%;
            font-family: 'DM Sans', 'Segoe UI', sans-serif;
            background: var(--gs-ivory);
        }

        .login-wrapper { display: flex; min-height: 100vh; }

        .login-brand {
            flex: 1;
            background: linear-gradient(135deg, var(--gs-charcoal) 0%, var(--gs-charcoal-light) 50%, #1a3550 100%);
            display: flex; flex-direction: column; align-items: center; justify-content: center;
            padding: 40px; position: relative; overflow: hidden;
        }

        .login-brand::before {
            content: ''; position: absolute; top: -50%; left: -50%; width: 200%; height: 200%;
            background: radial-gradient(circle at 30% 70%, rgba(201, 168, 76, 0.05) 0%, transparent 60%);
            pointer-events: none;
        }

        .login-brand::after {
            content: ''; position: absolute; bottom: 0; left: 0; right: 0; height: 3px;
            background: linear-gradient(90deg, transparent, var(--gs-gold), transparent);
        }

        .login-brand-content { text-align: center; z-index: 1; }

        .login-brand h1 {
            font-family: 'Playfair Display', serif; font-size: 2.4rem;
            color: var(--gs-white); font-weight: 600; letter-spacing: 0.03em; margin-bottom: 8px;
        }

        .login-brand h1 span { color: var(--gs-gold); }

        .login-brand-tagline {
            color: var(--gs-beige); font-size: 0.95rem; font-weight: 300;
            letter-spacing: 0.05em; opacity: 0.85;
        }

        .login-brand-divider {
            width: 50px; height: 2px; background: var(--gs-gold);
            margin: 24px auto; border-radius: 1px;
        }

        .login-brand-desc {
            color: rgba(232, 228, 222, 0.6); font-size: 0.85rem;
            max-width: 300px; line-height: 1.6;
        }

        .login-form-panel {
            flex: 1; display: flex; align-items: center; justify-content: center;
            padding: 40px; background: var(--gs-ivory);
        }

        .login-card {
            width: 100%; max-width: 400px; animation: loginFadeIn 0.5s ease;
        }

        @keyframes loginFadeIn {
            from { opacity: 0; transform: translateY(12px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .page-icon {
            text-align: center; margin-bottom: 20px; font-size: 3rem;
        }

        .login-heading {
            font-family: 'Playfair Display', serif; font-size: 1.6rem;
            color: var(--gs-charcoal); font-weight: 600; text-align: center; margin-bottom: 4px;
        }

        .login-subtext {
            font-size: 0.85rem; color: var(--gs-text-muted);
            text-align: center; margin-bottom: 28px; line-height: 1.5;
        }

        .alert-box {
            padding: 12px 16px; border-radius: 6px; font-size: 0.85rem;
            margin-bottom: 20px; line-height: 1.5;
        }

        .alert-error {
            background: rgba(184, 68, 68, 0.08); border-left: 3px solid var(--gs-danger);
            color: var(--gs-danger);
        }

        .alert-success {
            background: rgba(47, 133, 90, 0.08); border-left: 3px solid var(--gs-success);
            color: var(--gs-success);
        }

        .login-field { margin-bottom: 20px; position: relative; }

        .login-field label {
            display: block; font-size: 0.8rem; font-weight: 500;
            color: var(--gs-text-primary); margin-bottom: 6px; letter-spacing: 0.03em;
        }

        .login-field input {
            width: 100%; padding: 12px 14px; padding-left: 42px;
            font-family: 'DM Sans', sans-serif; font-size: 0.9rem;
            color: var(--gs-text-primary); background: var(--gs-white);
            border: 1px solid var(--gs-beige); border-radius: 6px; outline: none;
            transition: all 0.25s ease;
        }

        .login-field input:focus {
            border-color: var(--gs-gold); box-shadow: 0 0 0 3px var(--gs-gold-glow);
        }

        .login-field input::placeholder { color: var(--gs-text-muted); }

        .login-field .field-icon {
            position: absolute; left: 14px; bottom: 13px; font-size: 1rem;
            color: var(--gs-text-muted); pointer-events: none; transition: color 0.25s ease;
        }

        .login-field input:focus ~ .field-icon { color: var(--gs-gold); }

        .login-btn {
            width: 100%; padding: 13px; background: var(--gs-gold); color: var(--gs-charcoal);
            border: 1px solid var(--gs-gold-dark); border-radius: 6px;
            font-family: 'DM Sans', sans-serif; font-size: 0.95rem; font-weight: 600;
            cursor: pointer; transition: all 0.25s ease; letter-spacing: 0.03em; margin-top: 8px;
        }

        .login-btn:hover {
            background: var(--gs-gold-dark); color: var(--gs-white);
            transform: translateY(-1px); box-shadow: 0 4px 12px rgba(201, 168, 76, 0.3);
        }

        .login-btn:active { transform: translateY(0); }

        .login-footer-link {
            display: block; text-align: center; margin-top: 20px; font-size: 0.85rem;
            color: var(--gs-text-muted); text-decoration: none; transition: color 0.2s ease;
        }

        .login-footer-link:hover { color: var(--gs-gold-dark); }

        .password-strength {
            height: 4px; border-radius: 2px; margin-top: 6px;
            background: var(--gs-beige); overflow: hidden; transition: all 0.3s ease;
        }

        .password-strength-bar {
            height: 100%; width: 0; border-radius: 2px; transition: all 0.3s ease;
        }

        .strength-hint {
            font-size: 0.75rem; color: var(--gs-text-muted); margin-top: 4px;
        }

        @media (max-width: 768px) {
            .login-wrapper { flex-direction: column; }
            .login-brand { padding: 30px 20px; min-height: 160px; }
            .login-brand h1 { font-size: 1.6rem; }
            .login-brand-desc { display: none; }
            .login-form-panel { padding: 30px 20px; }
        }
    </style>
</head>

<body>
    <div class="login-wrapper">

        <!-- Left Brand Panel -->
        <div class="login-brand">
            <div class="login-brand-content">
                <h1>Axis<span>HMS</span> Pro</h1>
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

                <div class="page-icon">&#128272;</div>

                <c:choose>
                    <c:when test="${resetComplete}">
                        <h2 class="login-heading">Password Reset Complete</h2>
                        <p class="login-subtext">Your password has been successfully updated.</p>
                    </c:when>
                    <c:when test="${invalidToken}">
                        <h2 class="login-heading">Invalid Link</h2>
                        <p class="login-subtext">This reset link is no longer valid.</p>
                    </c:when>
                    <c:otherwise>
                        <h2 class="login-heading">Set New Password</h2>
                        <p class="login-subtext">Enter your new password below to regain access to your account.</p>
                    </c:otherwise>
                </c:choose>

                <c:if test="${not empty Error}">
                    <div class="alert-box alert-error">${Error}</div>
                </c:if>

                <c:if test="${not empty Success}">
                    <div class="alert-box alert-success">${Success}</div>
                </c:if>

                <!-- Show form only when token is valid and reset is not complete -->
                <c:if test="${empty invalidToken && empty resetComplete}">
                    <form method="post" action="${pageContext.request.contextPath}/reset-password" autocomplete="off" id="resetForm">
                        <input type="hidden" name="token" value="${token}">

                        <div class="login-field">
                            <label for="password">New Password</label>
                            <input type="password" name="password" id="password" placeholder="Enter new password" required minlength="6">
                            <span class="field-icon">&#128274;</span>
                            <div class="password-strength">
                                <div class="password-strength-bar" id="strengthBar"></div>
                            </div>
                            <div class="strength-hint" id="strengthHint">Minimum 6 characters</div>
                        </div>

                        <div class="login-field">
                            <label for="confirmPassword">Confirm Password</label>
                            <input type="password" name="confirmPassword" id="confirmPassword" placeholder="Confirm new password" required minlength="6">
                            <span class="field-icon">&#128274;</span>
                        </div>

                        <button type="submit" class="login-btn" id="submitBtn">Reset Password</button>

                    </form>
                </c:if>

                <c:choose>
                    <c:when test="${resetComplete}">
                        <a href="${pageContext.request.contextPath}/login" class="login-footer-link" style="font-weight: 600; color: var(--gs-gold-dark);">
                            &#10004; Go to Login
                        </a>
                    </c:when>
                    <c:when test="${invalidToken}">
                        <a href="${pageContext.request.contextPath}/forgot-password" class="login-footer-link">
                            Request a New Reset Link &rarr;
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="login-footer-link">
                            &larr; Back to Login
                        </a>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>

    </div>

    <script>
        // Password strength indicator
        var passwordInput = document.getElementById('password');
        var strengthBar = document.getElementById('strengthBar');
        var strengthHint = document.getElementById('strengthHint');

        if (passwordInput) {
            passwordInput.addEventListener('input', function() {
                var val = this.value;
                var strength = 0;

                if (val.length >= 6) strength++;
                if (val.length >= 8) strength++;
                if (/[A-Z]/.test(val)) strength++;
                if (/[0-9]/.test(val)) strength++;
                if (/[^A-Za-z0-9]/.test(val)) strength++;

                var colors = ['#B84444', '#C9A84C', '#C9A84C', '#2F855A', '#2F855A'];
                var hints = ['Too short', 'Weak', 'Fair', 'Good', 'Strong'];
                var widths = ['20%', '40%', '60%', '80%', '100%'];

                if (val.length === 0) {
                    strengthBar.style.width = '0';
                    strengthHint.textContent = 'Minimum 6 characters';
                    strengthHint.style.color = '#8C8A87';
                } else {
                    var idx = Math.min(strength, 4);
                    strengthBar.style.width = widths[idx];
                    strengthBar.style.background = colors[idx];
                    strengthHint.textContent = hints[idx];
                    strengthHint.style.color = colors[idx];
                }
            });
        }

        // Confirm password match validation
        var resetForm = document.getElementById('resetForm');
        if (resetForm) {
            resetForm.addEventListener('submit', function(e) {
                var pw = document.getElementById('password').value;
                var cpw = document.getElementById('confirmPassword').value;
                if (pw !== cpw) {
                    e.preventDefault();
                    alert('Passwords do not match.');
                }
            });
        }
    </script>

</body>
</html>
