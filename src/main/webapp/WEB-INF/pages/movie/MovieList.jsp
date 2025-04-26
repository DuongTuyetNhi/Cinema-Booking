<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib  uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Male_Fashion Template">
    <meta name="keywords" content="Male_Fashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Home Page</title>
    <jsp:include page="../include/css-page.jsp" />
    <style>

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

<body style="background-color: #f2f5fb; margin: 0; min-height: 100vh; display: flex; flex-direction: column;">

    <jsp:include page="../include/header.jsp" />
    <jsp:include page="../include/header2.jsp" />

    <div style="flex: 1;">
        <div class="film" style="display: flex; flex-wrap: wrap;">
            <div style="width: 10%;"></div>
            <div class="main-home" style="width: 80%; margin-left: 100px;">
                <div style="margin: 0 auto;">
                    <div style="display: flex; flex-wrap: wrap;">
                        <c:forEach var="movie" items="${movieList}">
                            <div class="movie"
                                style="display: flex;flex-direction: column; border: 1px solid gray; background-color: black; align-items: center; margin: 10px;">
                                <img src="<c:url value='/movie/getPhoto/'/>${movie.movieId}"
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
                            <div class="alert alert-warning mt-4" role="alert" style="min-height: 300px;">
                                Không có phim nào phù hợp với tiêu chí bạn đưa ra. Thử lại tiêu chí khác
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
            <div style="width: 10%;"></div>
        </div>
    </div>

    <jsp:include page="../include/footer.jsp" />

</body>


</html>