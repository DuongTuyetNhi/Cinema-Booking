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

        /* Pagination Styles */
        .pagination {
            text-align: center;
            margin-top: 30px;
            margin-bottom: 30px;
        }

        .pagination a {
            margin: 0 5px;
            padding: 8px 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
            text-decoration: none;
            color: #333;
            background-color: #f8f8f8;
            cursor: pointer;
            user-select: none;
        }

        .pagination a:hover {
            background-color: #ddd;
        }

        .pagination a.active {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }

        .pagination a[style*="pointer-events: none"] {
            cursor: default;
            background-color: #f0f0f0;
            color: #aaa;
            border-color: #eee;
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

                    <c:if test="${param.success eq 'true'}">
                        <div id="successMsg" style="background-color: #d4edda; color: #155724; padding: 10px; margin-bottom: 15px; border: 1px solid #c3e6cb; border-radius: 5px;">
                            Thêm phim thành công!
                        </div>
                    </c:if>

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
                    </div>

                    <!-- Pagination -->
                    <div class="pagination">

                        <!-- Trang đầu (First) -->
                        <c:choose>
                            <c:when test="${currentPage > 0}">
                                <a href="/movie/list?page=0&size=5" title="Trang đầu">&laquo;&laquo;</a>
                            </c:when>
                            <c:otherwise>
                                <a style="pointer-events: none;">&laquo;&laquo;</a>
                            </c:otherwise>
                        </c:choose>

                        <!-- Trang trước (Previous) -->
                        <c:choose>
                            <c:when test="${currentPage > 0}">
                                <a href="/movie/list?page=${currentPage - 1}&size=5" title="Trang trước">&laquo;</a>
                            </c:when>
                            <c:otherwise>
                                <a style="pointer-events: none;">&laquo;</a>
                            </c:otherwise>
                        </c:choose>

                        <!-- Các trang số -->
                        <c:forEach var="i" begin="0" end="${totalPages - 1}">
                            <a href="/movie/list?page=${i}&size=5"
                                class="${currentPage == i ? 'active' : ''}">${i + 1}</a>
                        </c:forEach>

                        <!-- Trang sau (Next) -->
                        <c:choose>
                            <c:when test="${currentPage < totalPages - 1}">
                                <a href="/movie/list?page=${currentPage + 1}&size=5" title="Trang sau">&raquo;</a>
                            </c:when>
                            <c:otherwise>
                                <a style="pointer-events: none;">&raquo;</a>
                            </c:otherwise>
                        </c:choose>

                        <!-- Trang cuối (Last) -->
                        <c:choose>
                            <c:when test="${currentPage < totalPages - 1}">
                                <a href="/movie/list?page=${totalPages - 1}&size=5" title="Trang cuối">&raquo;&raquo;</a>
                            </c:when>
                            <c:otherwise>
                                <a style="pointer-events: none;">&raquo;&raquo;</a>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <c:if test="${empty movieList and isSearch}">
                        <div class="alert alert-warning mt-4" role="alert" style="min-height: 300px;">
                            Không có phim nào phù hợp với tiêu chí bạn đưa ra. Thử lại tiêu chí khác
                        </div>
                    </c:if>

                </div>
            </div>
            <div style="width: 10%;"></div>
        </div>
    </div>

    <jsp:include page="../include/footer.jsp" />

    <!-- Script hiển thị thông báo -->
    <script>
        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('success') === 'true') {
                var msg = document.getElementById('successMsg');
                msg.style.display = 'block';

                setTimeout(function() {
                    msg.style.display = 'none';
                    const newUrl = window.location.origin + window.location.pathname;
                    window.history.replaceState({}, document.title, newUrl);
                }, 3000);
            }
        }
    </script>

</body>

</html>
