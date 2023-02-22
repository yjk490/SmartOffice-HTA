package com.example.web.controller;

import java.io.File;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.dto.emp.EmployeeDetailDto;
import com.example.exception.ApplicationException;
import com.example.security.AuthenticatedUser;
import com.example.security.LoginEmployee;
import com.example.service.EmployeeService;

@Controller
@RequestMapping("/employee")
public class EmployeeController {
	
	private final String directory = "C:\\app\\eGovFrameDev-4.0.0-64bit\\workspace\\smartoffice-team2\\src\\main\\webapp\\resources\\images\\profiles";
	
	@Autowired
	EmployeeService employeeService;
	
	@GetMapping("/profile")
	@AuthenticatedUser
	public String profilechangeForm(@AuthenticatedUser LoginEmployee loginEmployee, Model model) {
		EmployeeDetailDto employee = employeeService.getEmplDetail(loginEmployee.getNo());
		
		String defaultProfilePath = "/resources/images/profiles/default.png";
		String profilePath;
		
		if (!employee.getPhoto().equals("default.png")) {
			profilePath = "/resources/images/profiles/" + employee.getPhoto();
		} else {
			profilePath = defaultProfilePath;
		}
		
		model.addAttribute("profile", profilePath);
		System.out.println(profilePath);
		
		return "employee/profile-form";
	}
	
	@PostMapping("/profile")
	public String profilechange(@AuthenticatedUser LoginEmployee loginEmployee,
		@RequestParam(name = "profile") MultipartFile profile) throws IOException {
		MultipartFile upfile = profile;
		
		if(!upfile.isEmpty()) {
			String originalFilename = upfile.getOriginalFilename();
	        String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
	        String filename = loginEmployee.getNo() + "profile" + UUID.randomUUID().toString() + extension;
	        FileCopyUtils.copy(upfile.getInputStream(), new FileOutputStream(new File(directory, filename)));
	        
	        employeeService.updateProfile(loginEmployee.getNo(), filename); 
			
		}	
		
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
