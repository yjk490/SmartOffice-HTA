package com.example.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {
	
	@GetMapping("/admin/list")
	public String emplist() {
		return "/admin/employee-list";
	}
	
	@GetMapping("/admin/form")
	public String empform() {
		return "/admin/register-form";
	}
	
	@GetMapping("/admin/document")
	public String documentlist() {
		return "/admin/document-list";
	}

}
