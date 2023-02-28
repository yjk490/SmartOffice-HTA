package com.example.web.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.dto.schedule.ScheduleDetailDto;
import com.example.dto.schedule.ScheduleEvent;
import com.example.security.AuthenticatedUser;
import com.example.security.LoginEmployee;
import com.example.service.ScheduleService;
import com.example.vo.schedule.MeetingRoom;
import com.example.vo.schedule.Schedule;
import com.example.web.request.ScheduleModifyForm;
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
			
			MultipartFile upfile = form.getUpfile();
			if (!upfile.isEmpty()) {
				String filename = upfile.getOriginalFilename();
				form.setFilename(filename);
				
				FileCopyUtils.copy(upfile.getInputStream(), new FileOutputStream(new File(directory, filename)));
			}
			
			scheduleService.registerSchedule(loginEmployee.getNo(),form);
			
			return "redirect:schedule";
		}
		
		//달력페이지에서 날짜에 맞는 일정 가져오기.
		@GetMapping("/events")
		@ResponseBody	//리스폰스바디를 붙여야지 값을 찾아감 아니면 끝이 .jsp인 절대주소를 찾아감.
		public List<ScheduleEvent> getEvents(@AuthenticatedUser LoginEmployee loginEmployee, 
				@RequestParam("startDate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDate,
				@RequestParam("endDate") @DateTimeFormat(pattern =  "yyyy-MM-dd") Date endDate) {
			
			Map<String, Object> param = new HashMap<>();
			param.put("empNo", loginEmployee.getNo());
			param.put("startDate", startDate);
			param.put("endDate", endDate);
			
			return scheduleService.getEvents(param);
		}
		
		@PostMapping("/modify")
		public String moidfySchedule(@AuthenticatedUser LoginEmployee loginEmployee, ScheduleModifyForm form) {
			
			scheduleService.modifySchedule(loginEmployee.getNo(), form);
			
			return "redirect:schedule";	
		}
	
		
}
