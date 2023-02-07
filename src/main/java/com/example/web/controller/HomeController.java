package com.example.web.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.service.EmployeeService;

@Controller
public class HomeController {
	
	@Autowired
	private EmployeeService employeeService;
	
	// 홈 화면 요청
	@GetMapping("/")
	public String home() {
		return "home";
	}

	
	// 로그인 화면 요청
	@GetMapping("/login")
	public String loginform() {
		return "/employee/login-form";
	}
	

}
