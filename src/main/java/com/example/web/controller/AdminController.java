package com.example.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public String emplist(@RequestParam(name= "page", required = false, defaultValue = "1") int page, 
			@RequestParam(name="opt", required=false, defaultValue="") String opt,
			@RequestParam(name="rows", required=false, defaultValue="10") int rows,
			@RequestParam(name="keyword", required=false, defaultValue="") String keyword, Model model) {
		
		Map<String, Object> param = new HashMap<>();
		param.put("rows", rows);
		if(!opt.isBlank() && !keyword.isBlank()) {
			param.put("opt", opt);
			param.put("keyword", keyword);
		}
		param.put("page", page);
		
		
		Map<String, Object> result = employeeService.getAllEmployees(param);
		model.addAttribute("employees", result.get("employees")); 
		model.addAttribute("pagination", result.get("pagination"));
		model.addAttribute("rows", rows);
		model.addAttribute("keyword", keyword);
		model.addAttribute("opt", opt);
		
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
	
	// 사용자 사용 중지 요청
	@GetMapping("/stop")
	public String stop(@RequestParam("empNo")List<Integer> empNos) {
		employeeService.stopEmployees(empNos);
		
		return "admin/employee-list";
	}
	
	// 사용자 사용 해지 요청
	@GetMapping("/delete")
	public String delete(@RequestParam("empNo")List<Integer> empNos) {
		employeeService.deleteEmployees(empNos);
		
		return "admin/employee-list";
	}
	
	// 사용자 사용 복구 요청
	@GetMapping("/back")
	public String back(@RequestParam("empNo")List<Integer> empNos) {
		employeeService.backEmployees(empNos);
		
		return "admin/employee-list";
	}

}
