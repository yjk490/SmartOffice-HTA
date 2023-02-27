package com.example.web.controller;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.dto.emp.EmployeeDetailDto;
import com.example.dto.note.NoteListDto;
import com.example.security.AuthenticatedUser;
import com.example.security.LoginEmployee;
import com.example.service.EmployeeService;
import com.example.service.NoteService;
import com.example.web.request.EmployeePasswordForm;

@Controller
public class HomeController {
	
	@Autowired
	private EmployeeService employeeService;
	@Autowired
	private NoteService noteService;
	
	// 홈 화면 요청
	@GetMapping("/")
	public String home(@AuthenticatedUser LoginEmployee loginEmployee, Model model) {
		if(loginEmployee == null) {
			return "employee/login-form";
		} else {
			EmployeeDetailDto empDto = employeeService.getInsertEmployeeDetail(loginEmployee.getNo());
			List<NoteListDto> noteDto = noteService.getRecieveNotesByNo(loginEmployee.getNo());

			String defaultProfilePath = "/resources/images/profiles/default.png";
			String profilePath;
			
			if (!empDto.getPhoto().equals("default.png")) {
				profilePath = "/resources/images/profiles/" + empDto.getPhoto();
			} else {
				profilePath = defaultProfilePath;
			}
			
			model.addAttribute("profile", profilePath);
			model.addAttribute("emp", empDto);
			model.addAttribute("notes", noteDto);
			
			return "home";
		}
	}

	
	// 로그인 화면 요청
	@GetMapping("/login")
	public String loginform() {
		return "employee/login-form";
	}
	
	// 비밀번호 찾기
	@GetMapping("/help")
	public String passwordSearchForm(Model model) {
		EmployeePasswordForm form = new EmployeePasswordForm();
		model.addAttribute("employeePasswordForm", form);
		
		return "employee/password-search-form";
	}
	
	@PostMapping("/help")
	public String passwordSearch(@ModelAttribute("employeePasswordForm")@Valid EmployeePasswordForm employeePasswordForm, 
							BindingResult errors, RedirectAttributes redirectAttrs) {
		// 오류 1. 사원번호가 존재하지 않으면
		// 오류 2. 사원번호로 찾은 이메일이 일치하지 않으면
		
		EmployeeDetailDto dto = employeeService.getEmplDetail(employeePasswordForm.getEmpNo());
		
		if(errors.hasErrors()) {
			return "employee/password-search-form";
		} 
		if (dto == null) {
			return "employee/password-search-form";
		}
		
		String str = employeeService.getUpdateTemporaryPassword(employeePasswordForm);
		
		redirectAttrs.addAttribute("tpsw", str);
		
		return "redirect:help-success";
		
	}
	
	
	// 비밀번호 찾기 완료 요청
	@GetMapping("/help-success")
	public String passwordChangeSuccess(@RequestParam("tpsw") String temporaryPassword, Model model) {
		
		model.addAttribute("temporaryPassword", temporaryPassword);
		
		return "employee/password-search-success";
	}
	

}
