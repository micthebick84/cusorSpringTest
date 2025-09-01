package com.example.controller;

import com.example.dto.LoginRequest;
import com.example.model.User;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpSession;

@Controller
public class MainController {

    @Autowired
    private UserService userService;

    // 첫 페이지 - 로그인 페이지
    @GetMapping("/")
    public String index() {
        return "login";
    }

    // 로그인 페이지
    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    // 로그인 처리
    @PostMapping("/login")
    public String login(LoginRequest loginRequest, Model model, HttpSession session) {
        User user = userService.authenticateUser(loginRequest.getUsername(), loginRequest.getPassword());
        
        if (user != null) {
            // 로그인 성공 - 세션에 사용자 정보 저장
            session.setAttribute("user", user);
            return "redirect:/main";
        } else {
            // 로그인 실패
            model.addAttribute("error", "아이디 또는 비밀번호가 올바르지 않습니다.");
            return "login";
        }
    }

    // 메인 페이지
    @GetMapping("/main")
    public String mainPage(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            // 로그인되지 않은 사용자는 로그인 페이지로 리다이렉트
            return "redirect:/login";
        }
        
        model.addAttribute("user", user);
        return "main";
    }

    // 메뉴 페이지 - JavaScript에서 직접 외부 API 호출
    @GetMapping("/menu")
    public String menuPage(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            // 로그인되지 않은 사용자는 로그인 페이지로 리다이렉트
            return "redirect:/login";
        }
        
        model.addAttribute("user", user);
        return "menu";
    }

    // 통계 및 보고서 페이지
    @GetMapping("/stats")
    public String statsPage(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            // 로그인되지 않은 사용자는 로그인 페이지로 리다이렉트
            return "redirect:/login";
        }
        
        model.addAttribute("user", user);
        return "stats";
    }

    // 로그아웃
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
