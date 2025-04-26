<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Male_Fashion Template">
    <meta name="keywords" content="Male_Fashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Danh sách phim</title>
    <jsp:include page="../include/css-page.jsp" />
    <style>

        .btn {
            border: 1px solid #031d2c;
            border-radius: 10px;
            text-decoration: none;
            color: #031d2c;
            padding: 5px 10px 0 10px;
            height: 27px;
            margin-bottom: 10px;
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

    <script>
        function confirmDelete(movieName) {
            return confirm("Bạn có chắc chắn muốn xóa phim '" + movieName + "'?");
        }
    </script>


</head>

<body style="background-color: #f2f5fb">
    <jsp:include page="../include/header.jsp" />
    <jsp:include page="../include/header2.jsp" />

    <div class="film" style=" display: flex;flex-wrap: wrap; margin-bottom: 20px;">
        <div style="width: 10%;"></div>
        <div class="main-home" style="width: 80%; margin-left: 100px; margin-top: 20px;">
            <div style="margin: 0 auto; color: #031d2c;">
                <h2>Tên phim : ${movie.movieName}<a href="/booking?movieId=${movie.movieId}" class="btn" style="padding-bottom: 25px; margin-left: 30px; width: 100px;">Đặt vé</a></h2>
                <img src="getPhoto/<c:out value='${movie.movieId}'/>"style=" width:220px; height: 270px; border-radius: 10px 10px 0px 0px;">
                <p>Quốc gia: ${movie.nation}</p>
                <p>Thể loại: ${movie.category.cateName}</p>
                <p>Thời lượng: ${movie.timeSlot}</p>
                <p>Đạo diễn: ${movie.director}</p>
                <p>Nhà sản xuất: ${movie.producer}</p>
                <p>Diễn viên: ${movie.actor}</p>
                <p>Trailer: <a href="${movie.trailer}" style="color: #031d2c; text-decoration: none;">${movie.trailer}</a></p>
                <p>Mô tả: ${movie.describeMovie}</p>

                <div class="button" style="display: flex; flex-wrap: nowrap; justify-content: space-evenly; height: 25px;">

                          <sec:authorize access="hasRole('ROLE_ADMIN')">
                               <a href="/admin/editMovie?id=${movie.movieId}" class="btn" style="padding-bottom: 25px;">Sửa</a>

                              <a href="/admin/deleteMovie?id=${movie.movieId}" class="btn" onclick="return confirmDelete('${movie.movieName}')" style="padding-bottom: 25px;">
                                 Xóa
                              </a>
                          </sec:authorize>
                </div>
            </div>
        </div>
        <div style="width: 10%;"></div>
    </div>

    <jsp:include page="../include/footer.jsp" />
</body>

</html>