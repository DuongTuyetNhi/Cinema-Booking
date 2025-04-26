<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enter Token</title>
    <style>
        body {
            background-color: #f2f5fb;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            background-color: #031d2c;
            border-radius: 15px;
            width: 400px;
            padding: 40px;
            color: white;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .container input[type="text"],
        .container button {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
        }

        .container input[type="text"] {
            box-sizing: border-box;
            margin-top: 20px;
        }

        .container button {
            background-color: #f2f5fb;
            font-weight: bold;
            color: #031d2c;
            cursor: pointer;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .container button:hover {
            background-color: #8d0000;
            color: white;
        }

        .note {
            color: gray;
            font-size: 0.9rem;
            text-align: center;
            margin-top: -10px;
        }

        .logo {
            width: 100px;
            margin-bottom: 30px;
        }

        label {
            align-self: flex-start;
            font-size: 1rem;
            margin-bottom: 5px;
            font-weight: 500;
        }
    </style>
</head>

<body>
    <div class="container">
        <img src="../../resources/img/cinema/logo.png" class="logo">
        <form action="/verify-token" method="post" style="width: 100%;">
            <input type="hidden" name="email" value="${param.email}">
            <label for="token">Mã xác thực:</label>
            <input type="text" id="token" name="token" required minlength="6" maxlength="6"
                oninvalid="this.setCustomValidity('Vui lòng nhập mã xác thực gồm 6 ký tự')"
                ninput="this.setCustomValidity('')">
            <button type="submit">Gửi</button>
        </form>
        <c:if test="${not empty error}">
            <p style="color: red;">Mã xác thực không hợp lệ hoặc đã hết hạn.</p>
        </c:if>
        <p class="note">Nhập mã xác thực để kích hoạt tài khoản của bạn.Lưu ý, mã chỉ có hiệu lực trong vòng 12 giờ.</p>
    </div>
</body>

</html>
