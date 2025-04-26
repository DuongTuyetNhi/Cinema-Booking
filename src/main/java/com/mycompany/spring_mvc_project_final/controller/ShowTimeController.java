package com.mycompany.spring_mvc_project_final.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mycompany.spring_mvc_project_final.entities.Movie;
import com.mycompany.spring_mvc_project_final.entities.MovieShowtime;
import com.mycompany.spring_mvc_project_final.entities.RoomShowtime;
import com.mycompany.spring_mvc_project_final.entities.ShowTime;
import com.mycompany.spring_mvc_project_final.repository.MovieRepository;
import com.mycompany.spring_mvc_project_final.repository.MovieShowtimeRepository;
import com.mycompany.spring_mvc_project_final.repository.RoomShowTimeRepository;
import com.mycompany.spring_mvc_project_final.repository.ShowTimeRepository;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.*;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

@Controller
public class ShowTimeController {
    @Autowired
    private ShowTimeRepository showTimeRepository;
    @Autowired
    MovieRepository movieRepository;
    @Autowired
    RoomShowTimeRepository roomShowTimeRepository;
    @Autowired
    MovieShowtimeRepository movieShowtimeRepository;

    @RequestMapping(value = "/showtime")
    public String handleBooking( Model model, HttpSession session) {


        // Lấy ngày hiện tại
        LocalDate currentDate = LocalDate.now();

        // Chuyển định dạng ngày theo yêu cầu (VD: "yyyy-MM-dd")
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        // Chuyển đổi đối tượng LocalDate thành chuỗi theo định dạng "yyyy-MM-dd"
        String showDate = dateFormatter.format(currentDate);

        // In ra ngày đã định dạng
        System.out.println("Ngày hiện tại: " + showDate);

        // Tìm kiếm thông tin phim theo movieId
        List<MovieShowtime> movieShowtimes= movieShowtimeRepository.findAll();
        System.out.println("a");
        // Chuyển đổi chuỗi showDate sang kiểu java.sql.Date
        java.sql.Date sqlShowDate = java.sql.Date.valueOf(currentDate);

        // Tìm kiếm các lịch chiếu dựa trên movieId và ngày hiện tại
        List<Movie> movies = movieRepository.findAll();
        List<ShowTime> allShowTimes = new ArrayList<>();
        for (Movie movie : movies) {
            List<ShowTime> showTimes = showTimeRepository.findShowTimesByMovieIdAndShowDate(movie.getMovieId(), sqlShowDate);
            allShowTimes.addAll(showTimes);
        }

        List<Long> showtimeIds = new ArrayList<>();
        for (ShowTime showTime : allShowTimes) {
            showtimeIds.add(showTime.getShowTimeId());
        }


        List<RoomShowtime> roomShowTimes = roomShowTimeRepository.findByShowTime_ShowTimeIdIn(showtimeIds);
        System.out.println(roomShowTimes.size());
//        // Thêm thông tin phim và các lịch chiếu vào model để hiển thị trên trang booking
        model.addAttribute("roomShowTimes", roomShowTimes);
        model.addAttribute("movies", movies);
        model.addAttribute("movieShowtime", movieShowtimes);
        model.addAttribute("showTimes", allShowTimes);

        LocalDate currentDates = LocalDate.now();
        DateTimeFormatter dateFormatters = DateTimeFormatter.ofPattern("dd MM yyyy");
        DateTimeFormatter dayFormatter = DateTimeFormatter.ofPattern("EEEE", new Locale("vi", "VN"));
        List<String> dates = new ArrayList<>();
        List<String> daysOfWeek = new ArrayList<>();

        // Add current date and day of week
        dates.add(currentDates.format(dateFormatters));
        daysOfWeek.add(currentDate.format(dayFormatter));

        // Add next 6 days and their corresponding days of week
        for (int i = 1; i < 7; i++) {
            LocalDate nextDate = currentDate.plusDays(i);
            dates.add(nextDate.format(dateFormatters));
            daysOfWeek.add(nextDate.format(dayFormatter));
        }

        model.addAttribute("dates", dates);
        model.addAttribute("daysOfWeek", daysOfWeek);
        return "ShowTime";
    }

}
