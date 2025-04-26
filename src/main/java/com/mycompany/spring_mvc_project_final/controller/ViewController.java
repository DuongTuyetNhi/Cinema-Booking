package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.entities.Movie;
import com.mycompany.spring_mvc_project_final.repository.MovieRepository;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.util.List;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

@Controller
@RequestMapping(value = "/movie")
public class ViewController {
    @Autowired
    MovieRepository movieRepository;

    // Phương thức để lấy và hiển thị ảnh từ cơ sở dữ liệu
    @RequestMapping(value = "/getPhoto/{id}")
    public void getPhoto(HttpServletResponse response, @PathVariable("id") long id) throws Exception {
        response.setContentType("image/jpeg");

        // Lấy dữ liệu ảnh từ cơ sở dữ liệu dựa trên ID phim
        Movie m = movieRepository.findById(id).get();
        byte[] ph = m.getPhoto();

        // Ghi dữ liệu ảnh vào luồng đầu ra
        InputStream inputStream = new ByteArrayInputStream(ph);
        IOUtils.copy(inputStream, response.getOutputStream());
    }
    @RequestMapping(method = GET)
    public String showMovies(Model model) {
        List<Movie> movieList = (List<Movie>) movieRepository.findAll();
        model.addAttribute("movieList", movieList);
        return "movie/MovieList";
    }
    @RequestMapping(value = "/detail",method = GET)
    public String detailMovie(@RequestParam("id") Long movieId, Model model){
        Movie movie = movieRepository.findById(movieId).orElse(null);
        model.addAttribute("movie", movie);
        return "movie/MovieDetails";
    }

    @RequestMapping(value = "/search", method = RequestMethod.POST)
    public String search(
        @RequestParam("searchInput") String searchInput, Model model) {
        List<Movie> movieList;
        if(searchInput.isEmpty()) {
            movieList = (List<Movie>) movieRepository.findAll();
        } else {
            movieList = movieRepository.searchByKeyword(searchInput);
//            for (Movie movie : movieList) {
//                byte[] ph = movie.getPhoto();
//                movie.setPhoto(ph); // Đặt dữ liệu ảnh vào đối tượng phim để sử dụng trong giao diện người dùng
//            }
        }
        model.addAttribute("movieList", movieList);
        return "movie/MovieList";
    }

}
