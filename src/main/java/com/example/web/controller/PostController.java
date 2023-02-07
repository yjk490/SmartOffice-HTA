package com.example.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/post")
public class PostController {

	@GetMapping("/list")
	public String list() {
		return "post/list";
	}
	
	@GetMapping("/register-form")
	public String registerForm() {
		return "post/register-form";
	}
	
	@PostMapping("/register")
	public String register() {
		return "redirect:list";
	}
	
	@GetMapping("/detail")
	public String detail() {
		return "post/detail";
	}
	
	@GetMapping("/notice")
	public String notice() {
		return "post/notice";
	}
	
	@GetMapping("/mypost")
	public String mypost() {
		return "post/mypost";
	}
	
	@GetMapping("/mycomment")
	public String mycomment() {
		return "post/mycomment";
	}
	
	@GetMapping("/myscrap")
	public String myscrap() {
		return "post/myscrap";
	}
	
	@GetMapping("/myfile")
	public String myflie() {
		return "post/myfile";
	}
}
