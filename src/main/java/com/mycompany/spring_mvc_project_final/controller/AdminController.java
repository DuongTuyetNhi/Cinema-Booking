package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.entities.Category;
import com.mycompany.spring_mvc_project_final.entities.Movie;
import com.mycompany.spring_mvc_project_final.repository.CategoryRepository;
import com.mycompany.spring_mvc_project_final.repository.MovieRepository;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import javax.ws.rs.GET;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/admin")
public class AdminController {

    @Autowired
    private MovieRepository movieRepository;

    @Autowired
    private CategoryRepository categoryRepository;


    @GetMapping("/addMovie")
    public String showAddMovieForm(Model model) {
        model.addAttribute("movie", new Movie());
        setCategoryDropDownList(model);
        return "admin/addMovie";
    }

    @RequestMapping(value = "/saveMovie",
            consumes = MediaType.MULTIPART_FORM_DATA_VALUE,
            produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, "text/plain;charset=UTF-8"})
    public ModelAndView save(
//                            @RequestParam("movieName") String movieName,
//                             @RequestParam("nation") String nation,
                             @RequestPart("image") MultipartFile image,
//                             @RequestParam("describeMovie") String describeMovie,
//                             @RequestParam("producer") String producer,
//                             @RequestParam("actor") String actor,
//                             @RequestParam("trailer") String trailer,
                             //@RequestParam("categoryId") Long categoryId,
                             Movie movie,
                             Model model
                             ) {
        try {
            //Movie m = new Movie();
            // Thiết lập các thuộc tính của phim từ dữ liệu nhận được từ form
//            m.setMovieName(movieName);
            movie.setPhoto(image.getBytes()); // Lưu dữ liệu ảnh
//            m.setNation(nation);
//            m.setDescribeMovie(describeMovie);
//            m.setProducer(producer);
//            m.setActor(actor);
//            m.setTrailer(trailer);
            setCategoryDropDownList(model);
           // Category category = categoryRepository.findById(movie.getCategory()).get();
            //Category category = categoryRepository.findById(Long.parseLong(categoryId)).get();
           // m.setCategory(movie.getCategory());
            movieRepository.save(movie); // Lưu thông tin phim vào cơ sở dữ liệu

            // Chuyển hướng người dùng đến trang hiển thị danh sách phim
            return new ModelAndView("redirect:/movie");

        } catch (Exception e) {
            // Trả về trang lỗi nếu có lỗi xảy ra
            return new ModelAndView("movie/MovieList");
        }
    }



//    @PostMapping("/saveMovie")
//    public String saveMovie(@ModelAttribute("movie") @Valid Movie movie, BindingResult bindingResult, Model model) {
//        if (bindingResult.hasErrors()) {
//            setCategoryDropDownList(model);
//            return "admin/addMovie";
//        }
//        movieRepository.save(movie);
//        return "redirect:/home";
//    }

    @RequestMapping(value = "/editMovie", method = RequestMethod.GET)
    public String showEditMovie(@RequestParam("id") Long movieId, Model model) {
        Movie movie = movieRepository.findByMovieId(movieId);
        model.addAttribute("movie", movie);
        setCategoryDropDownList(model);
        return "admin/editMovie";
    }

    @RequestMapping(value = "/updateMovie", method = RequestMethod.POST)
    public String updateMovie(@ModelAttribute Movie movie){
        System.out.println("3333");
        movieRepository.save(movie);
        return "redirect:/";
    }


    @RequestMapping(value = "/deleteMovie", method = RequestMethod.GET)
    public String deleteMovie(@RequestParam("id") Long movieId) {
        movieRepository.deleteById(movieId);
        return "redirect:/";
    }



    private void setCategoryDropDownList(Model model){
        List<Category> cateList = (List<Category>) categoryRepository.findAll();
        if(!cateList.isEmpty()){
            Map<Long,String> cateMap = new LinkedHashMap<>();
            for(Category category : cateList){
                cateMap.put(category.getCategoryId(), category.getCateName());
            }
            model.addAttribute("categoryList", cateMap);
        }
    }
}
