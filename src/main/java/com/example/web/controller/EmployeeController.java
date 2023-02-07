package com.example.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class EmployeeController {
	
	@GetMapping("/profile")
	public String profilechange() {
		return "employee/profile-form";
	}
	
	@GetMapping("/password")
	public String passwordchange() {
		return "employee/password-form";
	}

}
