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
    <title>Danh sách phim</title>
    <style>
        .button-group {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
            width: 100%;
        }

        .btn {
            border: 1px solid #031d2c;
            border-radius: 10px;
            text-decoration: none;
            color: #031d2c;
            padding: 5px 10px 0 10px;
            height: 30px;
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

        .form-control,
        textarea,
        select {
            width: 80%;
            height: 30px;
            margin: 5px;
            border-radius: 10px;
            border: none;
            padding-left: 10px;
        }

        .form-label {
            width: 15%;
            font-weight: bold;
        }

        .mb-3 {
            display: flex;
            align-items: center;
        }
    </style>

</head>

<body style="background-color: #f2f5fb">
    <div class="navigation"
        style="display: flex; width: 100%; height: 150px; font-weight: bold; color: white; background-color:  #031d2c; color: white">
        <div style="width: 10%;">

        </div>
        <div
            style=" display:flex;  height: 50px; width: 80%; padding-top: 10px; margin-top: 50px; align-items: center;">
            <div style="width: 15%;">
                <img src="../../resources/img/cinema/logo.png" style="width: 100px;">
            </div>
            <div style="width: 85%;">
                <ul style="display: flex; justify-content: space-between; list-style: none;">
                    <li>
                        <a href="/" style=" margin-right: 100px; text-decoration: none; color: white;">
                            Trang chủ
                        </a>
                    </li>
                    <li>
                        <a href="/movie" style="list-style-type: none;  text-decoration: none; color: white;">
                            Phim
                        </a>
                    </li>
                    <li>
                        <a href="" style="list-style-type: none;  text-decoration: none; color: white;">
                            Lịch chiếu
                        </a>
                    </li>
                    <form:form action="/movie/search" method="post">
                        <input name="searchInput" type="text" placeholder="Tìm kiếm">
                        <button type="submit">Tìm kiếm</button>
                    </form:form>
                </ul>
            </div>
        </div>
        <div style="width: 10%;"></div>
    </div>

    <div class="film" style=" display: flex;flex-wrap: wrap; margin: 30px 0 30px 0;">
        <div style="width: 10%;"></div>
        <div class="main-home" style="width: 80%; margin-left: 100px;">
            <form:form action="/admin/saveMovie" method="post" modelAttribute="movie" enctype="multipart/form-data">
                <form:hidden path="movieId"/>

                <div class="mb-3" style="width: 100%">
                    <label for="movieName" class="form-label">Tên phim</label>
                    <form:input path="movieName" id="movieName" class="form-control"
                                required="required" maxlength="100"
                                oninvalid="this.setCustomValidity('Vui lòng không bỏ trống trường này')"
                                oninput="this.setCustomValidity('')" />
                </div>

                <div class="mb-3">
                    <label for="photo" class="form-label">Hình ảnh</label>
                    <input id="photo" type="file" name="image" class="form-control">
                </div>

                <div class="mb-3">
                    <label for="nation" class="form-label">Quốc gia</label>
                    <form:input path="nation" id="nation" class="form-control"
                                required="required" maxlength="64"
                                oninvalid="this.setCustomValidity('Vui lòng không bỏ trống trường này')"
                                oninput="this.setCustomValidity('')" />
                </div>

                <div class="mb-3">
                    <label for="timeSlot" class="form-label">Thời lượng</label>
                    <form:input path="timeSlot" id="timeSlot" class="form-control"
                                required="required" maxlength="8"
                                pattern="^([0-3][0-9]|4[0]):[0-5][0-9]:[0-5][0-9]$"
                                oninvalid="this.setCustomValidity(this.value === '' ? 'Vui lòng không bỏ trống trường này' : 'Vui lòng nhập thời lượng hợp lệ (hh:mm:ss), tối đa 04:00:00')"
                                oninput="this.setCustomValidity('')" />
                </div>

                <div class="mb-3">
                    <label class="form-label" style="">Thể loại </label>
                    <form:select path="category.categoryId" required="required"
                                 oninvalid="this.setCustomValidity('Vui lòng không bỏ trống trường này')"
                                 oninput="this.setCustomValidity('')">
                        <form:options items="${categoryList}" />
                    </form:select>
                </div>

                <div class="mb-3">
                    <label for="director" class="form-label">Đạo diễn</label>
                    <form:input path="director" id="director" class="form-control"
                                required="required" maxlength="64"
                                oninvalid="this.setCustomValidity('Vui lòng không bỏ trống trường này')"
                                oninput="this.setCustomValidity('')" />
                </div>

                <div class="mb-3">
                    <label for="producer" class="form-label">Nhà sản xuất</label>
                    <form:input path="producer" id="producer" class="form-control"
                                required="required" maxlength="64"
                                oninvalid="this.setCustomValidity('Vui lòng không bỏ trống trường này')"
                                oninput="this.setCustomValidity('')" />
                </div>

                <div class="mb-3">
                    <label for="actor" class="form-label">Diễn viên</label>
                    <form:input path="actor" id="actor" class="form-control"
                                required="required" maxlength="128"
                                oninvalid="this.setCustomValidity('Vui lòng không bỏ trống trường này')"
                                oninput="this.setCustomValidity('')" />
                </div>

                <div class="mb-3">
                    <label for="trailer" class="form-label">Trailer</label>
                    <form:input path="trailer" id="trailer" class="form-control" maxlength="255" />
                </div>

                <div class="mb-3">
                    <label for="describeMovie" class="form-label">Mô tả</label>
                    <form:textarea path="describeMovie" id="describeMovie" class="form-control"
                                   maxlength="1000" style="height: 50px;" />
                </div>


                <div class="button-group" style="width: 95%; justify-content: flex-end;">
                    <button type="button" class="btn btn-secondary" onclick="history.back()">HUỶ</button>
                    <button type="submit" class="btn btn-primary" id="successMsg" data-message="${successMessage}">LƯU</button>
                </div>

            </form:form>
        </div>
        <div style="width: 10%;"></div>
    </div>


    <div class="footer" style=" background-color: #031d2c; color: white;">
        <div class="container" style="display: flex; flex-wrap: nowrap; justify-content: space-evenly; ">
            <div class="col">
                <h3 class="footer-title" style="color: white;">Về Chúng Tôi</h3>
                <p style="color: white;">DoubleT Cinema<br>
                    Địa chỉ: DoubleT Cinema, Tp. Đà Nẵng, Việt Nam<br>
                    Điện thoại: 0123 456 789
                </p>
            </div>
            <div class="col">
                <h3 class="footer-title" style="color: white;">Liên Hệ</h3>
                <p style="color: white;">
                    <a href="https://maps.app.goo.gl/uM7ecGRwsK2TKSYG9" target="_blank"
                        style="color: white;text-decoration: none;">
                        DoubleT Cinema, Đà Nẵng
                    </a><br>
                    Email: doubletcinema@gmail.com<br>
                    Website: http://doubleT-cinema.com/
                </p>
            </div>
            <div class="col">
                <a href="" style="color: white;"><img src="" alt="Facebook"></a>
                <a href="" style="color: white;"><img src="" alt="Youtube"></a>
            </div>
        </div>
        <div class="copyright">
            <p style="color: white; ">Copyright &copy; 2024 DoubleT. All Rights Reserved.</p>
        </div>
    </div>

</body>

</html>