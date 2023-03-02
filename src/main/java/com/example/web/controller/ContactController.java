package com.example.web.controller;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dto.contact.ContactDetailDto;
import com.example.dto.contact.ContactListDto;
import com.example.security.AuthenticatedUser;
import com.example.security.LoginEmployee;
import com.example.service.ContactService;
import com.example.vo.contact.Addressbook;
import com.example.web.request.AddressbookModifyForm;
import com.example.web.request.ContactRegisterForm;
import com.example.web.request.ContactSearchOption;
import com.example.web.response.ContactListResult;

@Controller
public class ContactController {
	
	@Autowired
	private ContactService contactService;
	
	//공유주소록 목록 조회
	@ModelAttribute("publicAddressbooks")
	public List<Addressbook> publicAddressbooks() {
		return contactService.getPublicAddressbooks();
	}
	
	// 개인주소록 목록 조회
	@ModelAttribute("privateAddressbooks")
	public List<Addressbook>  privateAddressbooks() {
		return contactService.getPrivateAddressbooks();
	}
	
	// 연락처 메인화면(공유주소록)
	@GetMapping("/contact/list")
	public String contact(@RequestParam(name = "page", required = false, defaultValue = "1") int page, ContactSearchOption opt, Model model) {
		ContactListResult result = contactService.getContacts(page, opt);
		model.addAttribute("contacts", result.getContacts());
		model.addAttribute("pagination", result.getPagination());
		model.addAttribute("opt", opt);
					
		return "contact/list";
	}
		
	// 연락처 상세화면
		@GetMapping("/contact/detail")
		public String detail(@RequestParam("contactNo") int contactNo, Model model) {
			ContactDetailDto contactDetailDto = contactService.getContactDetailDto(contactNo);
			
			model.addAttribute("contact", contactDetailDto);
			
			return "contact/detail";
		}
		
	// 연락처 추가화면
		@GetMapping("/contact/form")
		public String form() {
			return "contact/form";
		}
		
	// 연락처 등록
		@PostMapping("/contact/register")
		public String insertContact(ContactRegisterForm form) throws IOException {
			contactService.insertContact(form);
					
			return "redirect:list";
		}
		
	// 연락처 수정화면
		@GetMapping("/contact/modifyform")
		public String modifyform() {
			return "contact/modify-form";
		}
		
	// 주소록 등록
		@PostMapping("/contact/insert-addressbook")
		public String insertAddressbook(@RequestParam(name = "type", required = false) String type, @RequestParam(name = "addressbookName", required = false) String addressbookName) {
			contactService.insertAddressbook(type, addressbookName);
			
			return "redirect:list";
		}
		
	// 주소록 수정폼
		@GetMapping("/contact/modify-addressbook")
		public String modifyAddressbookForm(@RequestParam("addressbookNo") int addressbookNo, Model model) {
			Addressbook adrbook = contactService.getAddressbookByNo(addressbookNo);
			
			AddressbookModifyForm form = new AddressbookModifyForm();
			BeanUtils.copyProperties(adrbook, form);
			
			model.addAttribute("modify", form);
			
			return "contact/modify-addressbook";
		}
		
	// 주소록 수정
		@PostMapping("/contact/modify-addressbook")
		public String modifyAddressbook(@ModelAttribute("modify") AddressbookModifyForm addressbookModifyForm) {
			contactService.modifyAddressbook(addressbookModifyForm);
			
			return "redirect:list";
		}
	
	// 주소록 삭제
		@PostMapping("/contact/delete-addressbook")
		public String deleteAddressbook(@RequestParam("addressbookNo") int addressbookNo) {
			contactService.deleteAddressbook(addressbookNo);	
			
			return "redirect:list";
		}
		
	
}
