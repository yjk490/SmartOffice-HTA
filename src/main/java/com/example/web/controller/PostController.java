package com.example.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/post")
public class PostController {

	@GetMapping
	public String home() {
		return "post/home";
	}
	
	@GetMapping("/registerform")
	public String registerForm() {
		return "post/register-form";
	}
	
	@GetMapping("/detail")
	public String detail() {
		return "post/detail";
	}
}
