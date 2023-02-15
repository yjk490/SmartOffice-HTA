package com.example.web.controller;

import javax.validation.Valid;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.dto.emp.EmployeeDetailDto;
import com.example.exception.AlreadyRegisteredEmailException;
import com.example.service.EmployeeService;
import com.example.vo.employee.Employee;
import com.example.web.request.EmployeeRegisterform;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private EmployeeService employeeService;
	
	@GetMapping("/list")
	public String emplist() {
		return "admin/employee-list";
	}
	
	// 회원가입 화면 요청
	@GetMapping("/form")
	public String empform(Model model) {
		EmployeeRegisterform form = new EmployeeRegisterform();
		model.addAttribute("employeeRegisterForm", form);
		
		return "admin/register-form";
	}
	
	// 회원가입 처리 요청
	@PostMapping("/form")
	public String register(@ModelAttribute("employeeRegisterForm") @Valid EmployeeRegisterform employeeRegisterform, BindingResult errors) {
		if(errors.hasErrors()) {
			return "admin/register-form";
		}
		
		try {
			Employee employee = employeeService.registerEmployee(employeeRegisterform);
			return "redirect:registered?no=" + employee.getNo();
			
		} catch (AlreadyRegisteredEmailException ex) {
			errors.rejectValue("eamil", null, "이미 사용중인 이메일입니다.");
			return "admin/register-form";
		}
	}
	
	// 회원가입 완료 화면 요청
	@GetMapping("/registered")
	public String success(@RequestParam("no") int no, Model model) {
		
		EmployeeDetailDto dto  = employeeService.getInsertEmployeeDetail(no);
		model.addAttribute("emp", dto);
		return "admin/register-success";
	}
	
	@GetMapping("/document")
	public String documentlist() {
		return "admin/document-list";
	}

}
