
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en"  >

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Travel Intellij</title>

<link rel="icon" href="data:image/png;base64,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" type="image/png">

<!-- Linking to a CSS library for toast messages -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
<!-- Linking to jQuery and Toastr JavaScript libraries -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

    <style>* {
        font-family: -apple-system, BlinkMacSystemFont, "San Francisco", Helvetica, Arial, sans-serif;
      font-weight:  300;
      margin:  0;
    }
    html, body {
      height:  100vh;
      width:  100vw;
      margin:  0 0;
      display:  flex;
      align-items:  flex-start;
      justify-content:  flex-start;
      background:  #f3f2f2;
    }
    h4 {
      font-size:  24px;
      font-weight:  600;
      color:  #000;
      opacity:  .85;
    }
    label {
      font-size:  12.5px;
      color:  #000;
      opacity:  .8;
      font-weight:  400;
    }
    form {
      padding:  40px 30px;
      background:  #fefefe;
      display:  flex;
      flex-direction:  column;
      align-items:  flex-start;
      padding-bottom:  20px;
      width:  300px;
      h4 {
        margin-bottom:  20px;
        color:  rgba(#000, .5);
        span {
          color:  rgba(#000, 1);
          font-weight:  700;
        }
      }
      p {
        line-height:  155%;
        margin-bottom:  5px;
        font-size:  14px;
        color:  #000;
        opacity:  .65;
        font-weight:  400;
        max-width:  200px;
        margin-bottom:  40px;
      }
    }
    a.discrete {
        color:  rgba(#000, .4);
        font-size:  14px;
        border-bottom:  solid 1px rgba(#000, .0);
        padding-bottom:  4px;
        margin-left:  auto;
        font-weight:  300;
        transition:  all .3s ease;
        margin-top:  40px;
        &:hover {
          border-bottom:  solid 1px rgba(#000, .2);
        }
      }
    button {
        cursor: pointer;
      -webkit-appearance:  none;
      width:  auto;
      min-width:  100px;
      border-radius:  24px;
      text-align:  center;
      padding:  15px 40px;
      margin-top:  5px;
      background-color:  #b08bf8;
      color:  #fff;
      font-size:  14px;
      margin-left:  auto;
      font-weight:  500;
      box-shadow:  0px 2px 6px -1px rgba(0,0,0,.13);
      border:  none;
      transition:  all .3s ease;
      outline: 0;
      &:hover {
        transform:  translateY(-3px);
        box-shadow:  0 2px 6px -1px rgba(rgb(182,157,230), .65);
        &:active {
          transform:  scale(.99);
        }
      }
    }
    input {
      font-size:  16px;
      padding:  20px 0px;
      height:  56px;
      border:  none;
      border-bottom:  solid 1px rgba(0,0,0,.1);
      background:  #fff;
      width:  280px;
      box-sizing:  border-box;
      transition:  all .3s linear;
      color:  #000;
      font-weight:  400;
      -webkit-appearance:  none; appearance: none;
      &:focus {
        border-bottom:  solid 1px rgb(182,157,230);
        outline: 0;
        box-shadow:  0 2px 6px -8px rgba(rgb(182,157,230), .45);
      }
    }
    .floating-label {

      position:  relative;
      margin-bottom:  10px;
      width:  100%;
      label {
        position:  absolute;
        top: calc(50% - 7px);
        left:  0;
        opacity:  0;
        transition:  all .3s ease;
        padding-left:  44px;
      }
      input {
        border-radius: 10px;

        width:  calc(100% - 44px);
        margin-left:  auto;
        display:  flex;

      }
      .icon {
        position:  absolute;
        top:  0;
        left:  0;
        height:  56px;
        width:  44px;
        display:  flex;
        svg {
          height:  30px;
          width:  30px;
          margin:  auto;
          opacity:  .15;
          transition:  all .3s ease;
          path {
            transition:  all .3s ease;
          }
        }
      }
      input:not(:placeholder-shown) {
        padding:  28px 0px 12px 10px;
      }
      input:not(:placeholder-shown) + label {
        transform:  translateY(-10px);
        opacity:  .7;
        padding-left:50px;
      }
      input:valid:not(:placeholder-shown) + label + .icon {
        svg {
          opacity:  1;
          path {
            fill:  rgb(182,157,230);
          }
        }
      }
      input:not(:valid):not(:focus) + label + .icon {
        animation-name: shake-shake;
        animation-duration: .3s;
      }
    }
    @keyframes shake-shake {
      0% { transform: translateX(-3px);}
      20% { transform: translateX(3px); }
      40% { transform: translateX(-3px);}
      60% { transform: translateX(3px);}
      80% { transform: translateX(-3px);}
      100% { transform: translateX(0px);}
    }
    .session {
      display:  flex;
      flex-direction:  row;
      width:  auto;
      height:  auto;
      margin:  auto auto;
      background:  #ffffff;
      border-radius:  4px;
      box-shadow:  0px 2px 6px -1px rgba(0,0,0,.12);
    }
    .left {
      width:  40px;
      height:  auto;
      min-height:  100%;
      position:  relative;

      background-image: url("${pageContext.request.contextPath}/resources/images/revamped/login_page.jpeg");

      background-size:  cover;
      border-top-left-radius:  4px;
      border-bottom-left-radius:  4px;
      svg {
        height:  40px;
        width:  auto;
        margin:  20px;
      }
    }

    .logo{
    width:300px;
    height:300px;
    margin-top:-30px;
    }
.passSvg{
border:2px solid white;
}
    </style>
</head>
    <body th:include="layout :: body" th:with="content=~{::content}">
        <div class="session">
          <div class="left">
            <?xml version="1.0" encoding="UTF-8"?>
            <svg enable-background="new 0 0 300 302.5" version="1.1" viewBox="0 0 300 302.5" xml:space="preserve" xmlns="http://www.w3.org/2000/svg">
      <style type="text/css">
          .st01{fill:#fff;}
      </style>
                  <path class="st01" d="m126 302.2c-2.3 0.7-5.7 0.2-7.7-1.2l-105-71.6c-2-1.3-3.7-4.4-3.9-6.7l-9.4-126.7c-0.2-2.4 1.1-5.6 2.8-7.2l93.2-86.4c1.7-1.6 5.1-2.6 7.4-2.3l125.6 18.9c2.3 0.4 5.2 2.3 6.4 4.4l63.5 110.1c1.2 2 1.4 5.5 0.6 7.7l-46.4 118.3c-0.9 2.2-3.4 4.6-5.7 5.3l-121.4 37.4zm63.4-102.7c2.3-0.7 4.8-3.1 5.7-5.3l19.9-50.8c0.9-2.2 0.6-5.7-0.6-7.7l-27.3-47.3c-1.2-2-4.1-4-6.4-4.4l-53.9-8c-2.3-0.4-5.7 0.7-7.4 2.3l-40 37.1c-1.7 1.6-3 4.9-2.8 7.2l4.1 54.4c0.2 2.4 1.9 5.4 3.9 6.7l45.1 30.8c2 1.3 5.4 1.9 7.7 1.2l52-16.2z"/>
      </svg>
          </div>
          <form id = "loginForm" name="f" th:action="@{/login}" method="post" class="log-in" autocomplete="off">
          <div class="logo">
           <img src="<c:url value='/resources/images/ashoka_logo.jpg'/>" alt="Ashoka Image" width="100%" height="100%" />
          </div>

            <p class="floating-label">Log in to your account:</p>
            <c:if test="${param.error != null}">
                <p class="floating-label" style="color: red;">Invalid username or password.</p>
            </c:if>



            <div class="floating-label">
              <input placeholder="Username" type="text" name="username" id="username" autocomplete="off" required>
              <label for="email">Username:</label>
              <div class="icon">
      <?xml version="1.0" encoding="UTF-8"?>
      <svg enable-background="new 0 0 100 100" version="1.1" xml:space="preserve" xmlns="http://www.w3.org/2000/svg"  viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M5.52 19c.64-2.2 1.84-3 3.22-3h6.52c1.38 0 2.58.8 3.22 3"/><circle cx="12" cy="10" r="3"/><circle cx="12" cy="12" r="10"/></svg>
      <style type="text/css">
          .st0{fill:none;}
      </style>
      <g transform="translate(0 -952.36)">
          <path d="m17.5 977c-1.3 0-2.4 1.1-2.4 2.4v45.9c0 1.3 1.1 2.4 2.4 2.4h64.9c1.3 0 2.4-1.1 2.4-2.4v-45.9c0-1.3-1.1-2.4-2.4-2.4h-64.9zm2.4 4.8h60.2v1.2l-30.1 22-30.1-22v-1.2zm0 7l28.7 21c0.8 0.6 2 0.6 2.8 0l28.7-21v34.1h-60.2v-34.1z"/>
      </g>
      <rect class="st0" width="100" height="100"/>
      </svg>

              </div>
            </div>

            <div class="floating-label">
              <input placeholder="Password" type="password" name="password" id="password" autocomplete="off" required    >
              <label for="password">Password:</label>
              <div class="icon">

                <?xml version="1.0" encoding="UTF-8"?>
                <svg class="passSvg" enable-background="new 0 0 24 24" version="1.1" viewBox="0 0 24 24" xml:space="preserve"              xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <style type="text/css">
          .st0{fill:none;}
          .st1{fill:#010101;}
      </style>
              <rect class="st0" width="24" height="24"/>
              <path class="st1" d="M19,21H5V9h14V21z M6,20h12V10H6V20z"/>
              <path class="st1" d="M16.5,10h-1V7c0-1.9-1.6-3.5-3.5-3.5S8.5,5.1,8.5,7v3h-1V7c0-2.5,2-4.5,4.5-4.5s4.5,2,4.5,4.5V10z"/>
              <path class="st1" d="m12 16.5c-0.8 0-1.5-0.7-1.5-1.5s0.7-1.5 1.5-1.5 1.5 0.7 1.5 1.5-0.7 1.5-1.5 1.5zm0-2c-0.3 0-0.5 0.2-0.5 0.5s0.2 0.5 0.5 0.5 0.5-0.2 0.5-0.5-0.2-0.5-0.5-0.5z"/>
      </svg>
              </div>

            </div>
            <button type="submit" >Log in</button>
            <a style='cursor: not-allowed;' href="${pageContext.request.contextPath}/forgot-password" class="discrete">Forgot Password?</a>
          </form>
        </div>
      </body>

<script>
  function validateForm() {
      var username = $('#username').val();
      var password = $('#password').val();

      if (username.trim() === '' || password.trim() === '') {
          toastr.error('Please fill in all fields.');
          return false; // Prevent form submission
      }
      return true; // Allow form submission
  }

  // Bind validation function to form submit event
  $(document).ready(function() {
      $('#loginForm').submit(function() {
          return validateForm();
      });
  });


  <script>
</html>