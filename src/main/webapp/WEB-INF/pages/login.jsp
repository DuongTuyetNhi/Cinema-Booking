
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="description" content="Male_Fashion Template">
        <meta name="keywords" content="Male_Fashion, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
            <title>Đăng nhập</title>
            <style>
                body {
                    height: 740px;
                    margin: 0;
                    font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
                }

                .background {
                    display: flex;
                    height: 100%;
                    background-image: url(R.jpg);
                }

                /* .background .left{
                    background-color: #f2f5fb;
                    width: 100%;
                    height: 100%;
                }
                .background .right{
                    background-color:  #031d2c;
                    width: 100%;
                    height: 100%;
                } */
                .main {
                    display: flex;
                    height: 600px;
                    width: 65%;
                    position: absolute;
                    top: 70px;
                    left: 267px;
                    border-radius: 15px;
                }

                .main .left {
                    background-color: #03141e;
                    width: 100%;
                    border-radius: 10px 0 0 10px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

                .main .right {
                    background-color: #f2f5fb;
                    width: 100%;
                    border-radius: 0 10px 10px 0;
                    box-shadow: 5px;

                }

                .template {
                    width: 345px;
                    margin: 100px auto;

                }

                .template .logic {
                    font-weight: 500;
                    font-size: 35px;
                    margin: 15px;
                    text-align: center;
                }

                label {
                    font-size: 17px;
                    font-weight: 600;
                }

                #email,
                #password {
                    margin: 8px 0 15px 0;
                    padding: 13px 10px;
                    border-radius: 7px;
                    font-size: 16px;
                    border: 1.5px solid rgb(199, 196, 196);
                    width: 325px;
                    font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;

                }

                #password:hover {
                    border: 1.7px solid #031d2c;
                }

                #email:hover {
                    border: 1.7px solid #031d2c;
                }

                .button {
                    padding: 13px;
                    font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
                    font-weight: 600;
                    font-size: 16px;
                    width: 100%;
                    border-radius: 7px;
                    border: none;
                    color: #fff;
                    background-color: #031d2c;
                    margin: 10px 0;
                }

                .register-password {
                    display: flex;
                    justify-content: space-between;
                    padding: 0 5px;
                }

                .register-password a {
                    color: #031d2c;
                }
            </style>
    </head>
    <body>


       <div class="background">
               <div class="left"></div>
               <div class="right"></div>
           </div>
           <div class="main">
               <div class="left">
                   <img src="../../resources/img/cinema/logo.png" alt="" width="70%">
               </div>
               <div class="right">
                   <div class="template">
                       <p class="logic">Đăng nhập</p>
                       <form action="<c:url value="j_spring_security_check"/>" method="post">
                           <!-- /login?error=true -->
                                <div class="textbox">
                                    <c:if test="${message != null && message != ''}">
                                        <p style="color: red" class="error-message">${message}</p>
                                    </c:if>
                                </div>
                           <input type="email" id="email" name="username" placeholder="Nhập email..." required
                                  oninvalid="this.setCustomValidity('Vui lòng không bỏ trống trường này')"
                                  oninput="this.setCustomValidity('')"><br>

                           <input type="password" id="password" name="password" placeholder="Nhập password..." required
                                  oninvalid="this.setCustomValidity('Vui lòng không bỏ trống trường này')"
                                  oninput="this.setCustomValidity('')"><br>


                           <input type="submit" value="Đăng nhập" class="button">
                           <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                       </form>
                       <div class="register-password">
                           <a href="/register">Đăng ký</a>
                       </div>
                   </div>

               </div>
           </div>
       
    </body>
</html>