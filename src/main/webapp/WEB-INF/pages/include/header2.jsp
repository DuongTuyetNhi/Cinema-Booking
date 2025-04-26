<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<body>
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
                          <a href="/showtime" style="list-style-type: none;  text-decoration: none; color: white;">
                              Lịch chiếu
                          </a>
                      </li>
                      <form:form action="/movie/search" method="post">
                          <input name="searchInput" type="text" placeholder="Tìm kiếm" maxlength="100">
                          <button type="submit">Tìm kiếm</button>
                      </form:form>

                  </ul>
              </div>
          </div>
          <div style="width: 10%;"></div>
      </div>
</div>
</body>
</html>