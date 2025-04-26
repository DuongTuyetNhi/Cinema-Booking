<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Registration</title>
    <style>
        body {
            background-color: #f2f5fb;
        }

        .border-form {
            margin: 80px auto;
            background-color: #03141c;
            color: #fff;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
            width: 600px;
            border-radius: 10px;
            padding-top: 20px;
            padding-bottom: 30px;
        }

        .border-form .img-tab {
            text-align: center;
        }

        .border-form p {
            font-weight: 500;
            font-size: 35px;
            margin: 0;
            margin-top: 10px;
            text-align: center;
        }

        label {
            font-size: 16px;
            font-weight: 600;
            margin-left: 5px;
        }

        form {
            margin: 20px 60px;
            width: 700px;
        }

        .Hoten,
        .ngaysdt,
        .matkhau {
            display: flex;
            width: 450px;
        }

        .mat,
        .khau,
        .ngay,
        .sdt,
        .Ho,
        .Ten {
            width: 50%;
        }

        .mat,
        .ngay,
        .Ten {
            margin-right: 40px;
        }

        input[type="text"],
        input[type="email"],
        input[type="date"],
        input[type="password"] {
            color: #000;
            margin: 5px 0 5px 0;
            padding: 10px 15px;
            border-radius: 7px;
            font-size: 15px;
            border: 1.5px solid rgb(199, 196, 196);
            width: 450px;
            font-family: system-ui;
            background-color: #fff;
            font-weight: 600;
        }

        #firstName,
        #lastName,
        #phone,
        #birthDay,
        #password,
        #confirmPassword {
            width: 100%;
        }

        input[type="text"]:hover,
        input[type="email"]:hover,
        input[type="date"]:hover,
        input[type="password"]:hover {
            border: 2px solid gray;
        }

        input[type="submit"] {
            padding: 10px;
            font-family: system-ui;
            font-weight: 600;
            font-size: 18px;
            width: 480px;
            border-radius: 7px;
            border: none;
            background-color: #f2f5fb;
            color: #031d2c;
            margin-top: 20px;
        }

        input[type="submit"]:hover {
            border: 2px solid rgb(199, 196, 196);
            background-color: #03141c;
            color: #fff;
        }

        .error {
            color: red;
            font-size: 0.85rem;
            margin-bottom: 8px;
            display: block;
            min-height: 16px;
        }
    </style>

    <script>
        function validatePassword() {
            const password = document.getElementById("password").value;
            const confirmPassword = document.getElementById("confirmPassword").value;

            // Clear all error messages
            const errorSpans = document.querySelectorAll(".error");
            errorSpans.forEach(span => span.innerText = "");

            if (password !== confirmPassword) {
                const errorSpan = document.getElementById("confirmPassword").parentElement.querySelector(".error");
                errorSpan.innerText = "Mật khẩu xác nhận không khớp.";
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
<div class="border-form">
    <div class="img-tab">
        <img src="../../resources/img/cinema/logo.png" alt="" height="150px" width="150px" style="border-radius: 50%;">
    </div>
    <p>Đăng ký</p>

    <form action="${pageContext.request.contextPath}/register" method="post" onsubmit="return validatePassword()">
        <div class="Hoten">
            <div class="Ten">
                <label for="firstName">Tên:</label><br>
                <input type="text" id="firstName" name="firstName" required maxlength="32"
                       oninvalid="this.setCustomValidity('Vui lòng không bỏ trống trường này')"
                       oninput="this.setCustomValidity('')"><br>
                <span class="error"></span>
            </div>
            <div class="Ho">
                <label for="lastName">Họ:</label><br>
                <input type="text" id="lastName" name="lastName" required maxlength="32"
                       oninvalid="this.setCustomValidity('Vui lòng không bỏ trống trường này')"
                       oninput="this.setCustomValidity('')"><br>
                <span class="error"></span>
            </div>
        </div>

        <div class="ngaysdt">
            <div class="ngay">
                <label for="birthDay">Ngày sinh:</label><br>
                <input type="date" id="birthDay" name="birthDay" required
                       oninvalid="this.setCustomValidity('Vui lòng không bỏ trống trường này')"
                       oninput="this.setCustomValidity('')"><br>
                <span class="error"></span>
            </div>
            <div class="sdt">
                <label for="phone">Số điện thoại:</label><br>
                <input type="text" id="phone" name="phone" required minlength="10" maxlength="10"
                       pattern="\d{10}"
                       oninvalid="this.setCustomValidity(this.value === '' ? 'Vui lòng không bỏ trống trường này' : 'Vui lòng nhập số điện thoại hợp lệ gồm 10 chữ số')"
                       oninput="this.setCustomValidity('')"><br>
                <span class="error"></span>
            </div>
        </div>

       <div class="email">
           <label for="email">Email:</label><br>
           <input type="email" id="email" name="email" required minlength="6" maxlength="32"
                  oninvalid="this.setCustomValidity(this.value === '' ? 'Vui lòng không bỏ trống trường này' : 'Vui lòng nhập địa chỉ email hợp lệ')"
                  oninput="this.setCustomValidity('')"><br>
           <span class="error"></span>
       </div>

        <div class="diachi">
            <label for="address">Địa chỉ:</label><br>
            <input type="text" id="address" name="address" maxlength="100"><br>
            <span class="error"></span>
        </div>

        <div class="matkhau">
            <div class="mat">
                <label for="password">Mật khẩu:</label><br>
                <input type="password" id="password" name="password" required minlength="5" maxlength="32"
                       oninvalid="this.setCustomValidity(this.value === '' ? 'Vui lòng không bỏ trống trường này' : 'Vui lòng nhập mật khẩu từ 5 đến 32 ký tự')"
                       oninput="this.setCustomValidity('')"><br>
                <span class="error"></span>
            </div>
            <div class="khau">
                <label for="confirmPassword">Xác nhận mật khẩu:</label><br>
                <input type="password" id="confirmPassword" name="confirmPassword" required minlength="5" maxlength="32"
                       oninvalid="this.setCustomValidity(this.value === '' ? 'Vui lòng không bỏ trống trường này' : 'Mật khẩu xác nhận không khớp')"
                       oninput="this.setCustomValidity('')"><br>
                <span class="error"></span>
            </div>
        </div>

        <input type="submit" value="Đăng ký">
    </form>
    <p style="font-size: 15px; color: white;">
        Bạn đã có tài khoản?
        <a href="/login" style="color: white; font-style: italic; text-decoration: underline;">Đăng nhập tại đây</a>
    </p>

    <c:if test="${param.error != null}">
        <p id="registrationError" style="color: red; font-size: 16px;">Email đã được sử dụng. Đăng ký thất bại!</p>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    </c:if>
</div>
</body>
</html>
