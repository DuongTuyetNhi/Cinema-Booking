package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.entities.Movie;
import com.mycompany.spring_mvc_project_final.entities.User;
import com.mycompany.spring_mvc_project_final.repository.MovieRepository;
import com.mycompany.spring_mvc_project_final.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;
import java.util.List;
@Controller
@RequestMapping
public class HomePageController {
        @Autowired
        MovieRepository movieRepository;
        @Autowired
        UserRepository userRepository;

        @RequestMapping(method = RequestMethod.GET)
        public String showMovies(Model model, HttpSession session) {
            Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            String username = "anonymousUser"; // Mặc định là "anonymousUser" nếu không có người dùng đăng nhập

            if (principal instanceof UserDetails) {
                username = ((UserDetails) principal).getUsername();
                User user = userRepository.findByEmail(username);
                session.setAttribute("userId", user.getUserId());
            }


            List<Movie> movieList = (List<Movie>) movieRepository.findAll();
            model.addAttribute("movieList", movieList);
            return "home";
        }
}
