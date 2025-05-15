<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Male_Fashion Template">
    <meta name="keywords" content="Male_Fashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>DoubleT</title>
    <jsp:include page="include/css-page.jsp" />
    <style>
        h1 {
          text-align: center;
          font-size: 50px;
          font-weight: bold;
          font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
          animation: colorChange 2s infinite;
          text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.3);
          margin-top: 50px;
        }

        /* Animation đổi màu chữ */
        @keyframes colorChange {
          0%   { color: #ff4b2b; }
          25%  { color: #ff416c; }
          50%  { color: #00c3ff; }
          75%  { color: #7b2ff7; }
          100% { color: #ff4b2b; }
        }


        .btn {
            border: 1px solid white;
            border-radius: 5px;
            text-decoration: none;
            color: white;
            padding: 2px;
            height: 27px;
        }

        .btn:hover {
            background-color: #8d0000;
            border: 1px solid #ba1911;
            color: white;
        }

        .movie {
            width: fit-content;
            margin: 10px;
            border-radius: 10px;
            height: 320px;
        }

        .button {
            padding-bottom: 10px;
            border-radius: 1px solid gray;
            width: 220px;
        }

        .long-text {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
    </style>

</head>

<body style="background-color: #f2f5fb">
    <jsp:include page="include/header.jsp" />
    <jsp:include page="include/header2.jsp" />
    <img src="../../resources/img/cinema/cbo.png" style="width: 100%; height: 400px;">
    <div class="film" style=" display: flex;flex-wrap: wrap;">

        <div style="width: 10%;"></div>

        <div class="main-home" style="width: 80%; margin-left: 100px;">
        <h1>Double T Cinema</h1>
        <br>
            <div style="margin: 0 auto;">
                <div style="display: flex; flex-wrap: wrap;">
                    <c:forEach var="movie" items="${movieList}">
                        <div class="movie"
                            style="display: flex;flex-direction: column; border: 1px solid gray; background-color: black; align-items: center;">
                            <img src="movie/getPhoto/<c:out value='${movie.movieId}'/>"
                                style=" width:220px; height: 250px; border-radius: 10px 10px 0px 0px;">
                            <div class="movie-inf" style=" width:220px;">
                                <center>
                                    <h5 class="card-title long-text" style="color: white; font-weight: bold;">
                                        ${movie.movieName}
                                    </h5>
                                </center>
                                <div class="button"
                                    style="display: flex;flex-wrap: nowrap;justify-content: space-evenly; height: 25px;">
                                    <a href="/movie/detail?id=${movie.movieId}" class="btn">Chi tiết</a>
                                    <a href="/booking?movieId=${movie.movieId}" class="btn">Đặt vé</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty movieList}">
                        <div class="alert alert-warning mt-4" role="alert">Không có dữ liệu (No data)</div>
                    </c:if>
                </div>
            </div>
        </div>
        <div style="width: 10%;"></div>
    </div>



    <jsp:include page="include/footer.jsp" />



</body>

</html>