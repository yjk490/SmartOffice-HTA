package com.example.web.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import com.example.exception.ApplicationException;
import com.example.security.AuthenticatedUser;
import com.example.security.LoginEmployee;
import com.example.service.EmployeeService;

@Controller
@RequestMapping("/employee")
public class EmployeeController {
	
	private final String directory = "c:/files";
	
	@Autowired
	EmployeeService employeeService;
	
	@GetMapping("/profile")
	@AuthenticatedUser
	public String profilechangeForm(Model model) {
		
		return "employee/profile-form";
	}
	
	@PostMapping("/profile")
	public String profilechange(@AuthenticatedUser LoginEmployee loginEmployee,
			@RequestParam(name = "profile") MultipartFile profile) throws IOException {
		MultipartFile upfile = profile;
		if(!upfile.isEmpty()) {
			String filename = upfile.getOriginalFilename();
			
			FileCopyUtils.copy(upfile.getInputStream(), new FileOutputStream(new File(directory, filename)));
		}
		
		employeeService.updateProfile(loginEmployee.getNo(), profile);
		
		return "redirect:profile-success";
	}
	
	// 비밀번호 바꾸기
	@GetMapping("/password")
	@AuthenticatedUser
	public String passwordchangeForm() {
		return "employee/password-form";
	}
	
	@PostMapping("/password")
	public String changePassword(@AuthenticatedUser LoginEmployee loginEmployee, 
			@RequestParam(name = "empNo") int empNo,
			@RequestParam(name = "oldPassword") String oldPassword,
			@RequestParam(name = "password") String password) {
		
		if(loginEmployee.getNo() == empNo) {
			employeeService.changePassword(loginEmployee.getNo(), oldPassword, password);
			return "redirect:password-success";
		} else {
			throw new ApplicationException("["+empNo+"] 사원 번호 입력 오류입니다.");
		}
		
	}
	
	@GetMapping("/password-success")
	public String passwordChangeSuccess() {
		return "employee/password-success";
	}
	
	@GetMapping("/profile-success")
	public String profileChangeSuccess() {
		return "employee/profile-success";
	}

}
