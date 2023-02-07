package com.example.web.controller;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/contact")
public class ContactController {
	
	
	// 연락처 메인화면(공유주소록)
		@GetMapping("/list")
		public String contact() {
			return "contact/list";
		}
		
	// 연락처 상세화면
		@GetMapping("/detail")
		public String detail() {
			return "contact/detail";
		}
		
	// 연락처 추가화면
		@GetMapping("/form")
		public String form() {
			return "contact/form";
		}
	// 연락처 수정화면
		@GetMapping("/modifyform")
		public String modifyform() {
			return "contact/modify-form";
		}
}
