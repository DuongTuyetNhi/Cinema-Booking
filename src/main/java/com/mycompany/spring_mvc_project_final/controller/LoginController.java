/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.entities.AccountEntity;
import com.mycompany.spring_mvc_project_final.entities.Role;
//import com.mycompany.spring_mvc_project_final.enums.UserStatus;
import com.mycompany.spring_mvc_project_final.entities.User;
import com.mycompany.spring_mvc_project_final.enums.UserStatus;
import com.mycompany.spring_mvc_project_final.repository.AccountRepository;
import com.mycompany.spring_mvc_project_final.repository.RoleRepository;
import com.mycompany.spring_mvc_project_final.repository.UserRepository;
import com.mycompany.spring_mvc_project_final.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.concurrent.ThreadLocalRandom;

@Controller
public class LoginController {

    @Autowired
    BCryptPasswordEncoder bCryptPasswordEncoder;
    @Autowired
    AccountRepository accountRepository;
    @Autowired
    RoleRepository roleRepository;
    @Autowired
    UserRepository userRepository;

    @Autowired
    private JavaMailSender mailSender;
    @Autowired
    EmailService emailService;

    @RequestMapping("/login")
    public String loginPage(Model model, @RequestParam(value = "error", required = false) boolean error) {

        if (error) {
            model.addAttribute("message", "Email hoặc mật khẩu không đúng. Vui lòng thử lại!");
        }
        return "login";
    }

    @RequestMapping("/admin/home")
    public String viewHome(Model model) {

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }

        model.addAttribute("message", "Hello Admin: " + username);
        return "admin/home";
    }

    @GetMapping(value = "/admin/add")
    public String addAccount() {
        return "/admin/add";
    }

    @PostMapping(value = "/admin/add")
    public String addAccount(@RequestParam("email") String email,
                             @RequestParam("password") String password,
                             Model model) {

        if (email.isEmpty() || password.isEmpty()) {
            model.addAttribute("error", "Email và mật khẩu không thể để trống.");
            return "/admin/add";
        }

        // Kiểm tra xem email đã được sử dụng chưa
        AccountEntity existingAccount = accountRepository.findByEmail(email);
        if (existingAccount != null) {
            model.addAttribute("error", "Email đã được sử dụng.");
            return "/admin/add";
        }

        AccountEntity newAccount = new AccountEntity();
        newAccount.setEmail(email);
        newAccount.setPassword(bCryptPasswordEncoder.encode(password));
//        newAccount.setStatus(UserStatus.ACTIVE);

        // muon lay role tu DB thi sd RoleRepository de select toan bo list role

        List<Role> roleList = roleRepository.findAll();
//       Set<RoleEntity> roleEntitySet = new HashSet<>();
//       RoleEntity roleEntity = new RoleEntity();
//       roleEntity.setRole(Role.ROLE_USER);
//       roleEntitySet.add(roleEntity);
        Set<Role> roleSet = new HashSet<Role>(roleList);

        newAccount.setUserRoles(roleSet);

        accountRepository.save(newAccount);

        return "redirect:/admin/home"; // Change the redirect path to the appropriate page
    }


    @RequestMapping("/user/home")
    public String viewHome(Model model, HttpSession session) {

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();

        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
            session.setAttribute("username", username);

        }

        return "student/index";
    }

    @RequestMapping(value = {"/home"}, method = RequestMethod.GET)
    public String welcomePage(Model model) {
        return "redirect:/movie";
    }

    @RequestMapping(value = {"/test2"}, method = RequestMethod.GET)
    public String welcomePage44(Model model) {
        return "home";
    }

    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

//    @PostMapping("/register")
//    public String registerUser(@ModelAttribute("user") User user) {
//        // Kiểm tra xem email đã được sử dụng chưa
//        if (userRepository.existsByEmail(user.getEmail())) {
//            return "redirect:/register?error"; // Đã tồn tại email trong hệ thống
//        }
//
//        // Mã hóa mật khẩu trước khi lưu vào cơ sở dữ liệu
//        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
//
//        // Thiết lập trạng thái ACTIVE cho tài khoản
//        AccountEntity accountEntity = AccountEntity.fromUser(user);
//        accountEntity.setStatus(UserStatus.ACTIVE);
//        Role role = new Role();
//        role.setId(2); // Gán role_id = 2
//        // Gán vai trò cho tài khoản
//        Set<Role> roles = new HashSet<>();
//        roles.add(role);
//        accountEntity.setUserRoles(roles);
//        // Lưu thông tin người dùng vào cơ sở dữ liệu
//        userRepository.save(user);
//        // Lưu thông tin tài khoản vào cơ sở dữ liệu
//        accountRepository.save(accountEntity);
//
//        return "redirect:/login"; // Đăng ký thành công, chuyển hướng đến trang đăng nhập
//    }

    @PostMapping("/register")
    public String registerUser(@ModelAttribute("user") User user, HttpServletRequest request) {

        if (userRepository.existsByEmail(user.getEmail())) {
            return "redirect:/register?error"; // Đã tồn tại email trong hệ thống
        }

        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));

        AccountEntity accountEntity = AccountEntity.fromUser(user);
        accountEntity.setStatus(UserStatus.UNACTIVE);
        Role role = new Role();
        role.setId(2); // Gán role_id = 2
        // Gán vai trò cho tài khoản
        Set<Role> roles = new HashSet<>();
        roles.add(role);
        accountEntity.setUserRoles(roles);

        // Tạo và lưu token vào cơ sở dữ liệu
        String token = generateRandomToken();
        accountEntity.setToken(token);
        LocalDateTime expirationTime = LocalDateTime.now().plusHours(12); // Thời gian hết hạn là 12 giờ sau
        accountEntity.setTokenExpiration(expirationTime);

        userRepository.save(user);
        accountRepository.save(accountEntity);

        String appUrl = request.getScheme() + "://" + request.getServerName();
        emailService.sendTokenEmail(user.getEmail(), token, appUrl);

        return "redirect:/token?email=" + user.getEmail(); // Chuyển hướng đến trang nhập token
    }

//    @GetMapping("/token")
//    public String tokenPage(@RequestParam("email") String email, Model model) {
//        model.addAttribute("email", email);
//        return "tokenPage";
//    }
//
//    @PostMapping("/verify-token")
//    public String verifyToken(@RequestParam("email") String email, @RequestParam("token") String token) {
//
//        AccountEntity accountEntity = accountRepository.findByEmailAndToken(email, token);
//        if (accountEntity != null && isValidToken(accountEntity)) {
//            accountEntity.setStatus(UserStatus.ACTIVE);
//            accountRepository.save(accountEntity);
//            return "redirect:/login";
//        } else {
//            return "redirect:/token?email=" + email + "&error=invalid_token";
//        }
//    }

    @GetMapping("/token")
    public String tokenPage(@RequestParam("email") String email, Model model) {
        model.addAttribute("email", email);
        return "tokenPage";
    }

    @PostMapping("/verify-token")
    public String verifyToken(@RequestParam("email") String email,
                              @RequestParam("token") String token,
                              RedirectAttributes redirectAttributes) {

        AccountEntity accountEntity = accountRepository.findByEmailAndToken(email, token);
        if (accountEntity != null && isValidToken(accountEntity)) {
            accountEntity.setStatus(UserStatus.ACTIVE);
            accountRepository.save(accountEntity);
            return "redirect:/login";
        } else {
            redirectAttributes.addFlashAttribute("error", "invalid_token");
            redirectAttributes.addAttribute("email", email);
            return "redirect:/token";
        }
    }

    private boolean isValidToken(AccountEntity accountEntity) {
        LocalDateTime expirationTime = accountEntity.getTokenExpiration();
        return expirationTime.isAfter(LocalDateTime.now());
    }



    private String generateRandomToken() {
        int randomNum = ThreadLocalRandom.current().nextInt(100000, 999999 + 1);
        return String.valueOf(randomNum);
    }

}