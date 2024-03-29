<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Show Time</title>
    <style>
        table {
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: center;
        }
        .day-button {
            background-color: #f0f0f0;
            border: 1px solid #ccc;
            padding: 5px 10px;
            cursor: pointer;
        }
        .day-button:hover {
            background-color: #ddd;
        }
        .selected {
            background-color: #007bff; /* Màu nền của nút khi được chọn */
            color: #fff; /* Màu chữ của nút khi được chọn */
        }
    </style>
</head>
<body>

    <h2>Chọn ngày chiếu</h2>
    <h1>Phim ${movieId}</h1>
    <table>
        <thead>
            <tr>
                <c:forEach var="day" items="${daysOfWeek}">
                    <td>${day}</td>
                </c:forEach>
            </tr>
        </thead>
        <tbody>
            <tr>
                <c:forEach var="date" items="${dates}" varStatus="loop">
                    <th>
                        <button class="day-button" name="selectedDate" value="${date}" id="btn-${loop.index}" ${loop.index == 0 ? 'class="selected"' : ''}>
                            ${date.split(' ')[0]}/${date.split(' ')[1]}
                        </button>
                    </th>
                </c:forEach>
            </tr>
        </tbody>
    </table>
    <h2>Chọn lịch chiếu</h2>

            <c:forEach var="roomShowtime" items="${roomShowtimes}">
                    ${roomShowtime.roomId}
                    ${roomShowtime.showTimeId}
            </c:forEach>


    <script>
        // Lấy tất cả các nút
        const buttons = document.querySelectorAll('.day-button');

        // Lặp qua từng nút để thêm xử lý sự kiện click
        buttons.forEach(button => {
            button.addEventListener('click', function() {
                // Xóa tất cả các lớp CSS 'selected' trên tất cả các nút
                buttons.forEach(btn => {
                    btn.classList.remove('selected');
                });

                // Thêm lớp CSS 'selected' cho nút được chọn
                this.classList.add('selected');

                // Gửi dữ liệu ngày được chọn đến controller
                const selectedDate = this.value;
                sendSelectedDate(selectedDate);
            });
        });

        function sendSelectedDate(selectedDate) {
            const xhr = new XMLHttpRequest();
            xhr.open('POST', '/processSelected');
            xhr.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');
            xhr.onload = function() {
                if (xhr.status === 200) {
                    console.log('Đã gửi ngày được chọn đến controller');
                    console.log(xhr.responseText);
                    // Cập nhật nội dung trang dựa trên phản hồi từ controller
                    updateShowTimeTable(JSON.parse(xhr.responseText));
                } else {
                    console.error('Đã xảy ra lỗi khi gửi dữ liệu đến controller');
                }
            };
            // Chuyển đổi ngày thành định dạng "yyyy-MM-dd" và gửi dưới dạng JSON
            xhr.send(JSON.stringify({ selectedDate: selectedDate }));
        }

        function updateShowTimeTable(showTimes) {
            const showtimeTableBody = document.getElementById('showtimeTableBody');
            showtimeTableBody.innerHTML = ''; // Xóa nội dung cũ

            // Thêm dữ liệu mới
            showTimes.forEach(showTime => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${showTime.roomId}</td>
                    <td>${showTime.showTimeId}</td>
                    <!-- Thêm các cột khác tùy thuộc vào thông tin bạn muốn hiển thị -->
                `;
                showtimeTableBody.appendChild(row);
            });
        }
    </script>


</body>
</html>
