package com.example.web.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.example.security.AuthenticatedUser;
import com.example.security.LoginEmployee;
import com.example.service.ScheduleService;
import com.example.vo.schedule.MeetingRoom;
import com.example.web.request.ScheduleRegisterForm;
import com.example.web.view.FileDownloadView;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {
	
		private final String directory = "c:/files";
		
		@Autowired
		FileDownloadView fileDownloadView;
		@Autowired
		private ScheduleService scheduleService;
	
		//일정 화면 요청
		@GetMapping("/schedule")
		public String schedule() {
			return "schedule/schedule";
		}
		
		//일정 등록화면 요청
		@GetMapping("/register")
		public String scheduleRegister() {
			return "schedule/register-form";
		}
		
		@PostMapping("/register")
		public String registerSchedule(@AuthenticatedUser LoginEmployee loginEmployee,ScheduleRegisterForm form) throws IOException{
			loginEmployee = new LoginEmployee(10015, "", "");
			MultipartFile upfile = form.getUpfile();
			if (!upfile.isEmpty()) {
				String filename = upfile.getOriginalFilename();
				form.setFilename(filename);
				
				FileCopyUtils.copy(upfile.getInputStream(), new FileOutputStream(new File(directory, filename)));
			}
			
			scheduleService.registerSchedule(loginEmployee.getNo() ,form);
			
			return "redirect:schedule";
		}
		
}
