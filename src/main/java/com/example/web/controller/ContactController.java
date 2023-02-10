package com.example.web.controller;
import java.io.IOException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.service.ContactService;
import com.example.web.request.ContactRegisterForm;

@Controller
public class ContactController {
	
	@Autowired
	private ContactService contactService;	
		
	// 연락처 메인화면(공유주소록)
		@GetMapping("/contact/list")
		public String contact(Model model) {
			Map<String, Object> publicAddressbook = contactService.getPublicAddressbooks();
			Map<String, Object> privateAddressbook = contactService.getPrivateAddressbooks();
			
			model.addAttribute("publicAddressbooks", publicAddressbook.get("publicAddressbooks"));
			model.addAttribute("publicTotalRows", publicAddressbook.get("totalRows"));
			model.addAttribute("privateAddressbooks", privateAddressbook.get("privateAddressbooks"));
			model.addAttribute("privateTotalRows", privateAddressbook.get("privateTotalRows"));
						
			return "contact/list";
		}
		
	// 연락처 상세화면
		@GetMapping("/contact/detail")
		public String detail() {
			return "contact/detail";
		}
		
	// 연락처 추가화면
		@GetMapping("/contact/form")
		public String form() {
			return "contact/form";
		}
	// 연락처 수정화면
		@GetMapping("/contact/modifyform")
		public String modifyform() {
			return "contact/modify-form";
		}
		
	// 주소록 등록
		@PostMapping("/contact/insert-addressbook")
		public String insertAddressbook(@RequestParam("type") String type, @RequestParam("addressbookName") String addressbookName) {
			contactService.insertAddressbook(type, addressbookName);
			
			return "redirect:list";
		}
		
	// 연락처 등록
		@PostMapping("/contact/register")
		public String insertContact(ContactRegisterForm form) throws IOException {
			contactService.insertContact(form);
			
			return "redirect:list";
		}
}
