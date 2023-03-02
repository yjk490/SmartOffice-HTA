package com.example.web.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.ParseException;
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
import org.springframework.web.servlet.ModelAndView;

import com.example.dto.schedule.ScheduleDetailDto;
import com.example.dto.schedule.ScheduleEvent;
import com.example.excel.ScheduleExcelParser;
import com.example.exception.ApplicationException;
import com.example.security.AuthenticatedUser;
import com.example.security.LoginEmployee;
import com.example.service.EmployeeService;
import com.example.service.ScheduleService;
import com.example.vo.employee.Employee;
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
		@Autowired
		private EmployeeService employeeService;
		@Autowired
		private ScheduleExcelParser excelParser;
	
		//일정 화면 요청
		@GetMapping("/schedule")
		public String schedule(Model model) {
			List<Employee> emps = employeeService.getAllEmployeesNameNo();
			model.addAttribute("emps", emps);
			return "schedule/schedule";
		}
		
		//일정 등록화면 요청
		@GetMapping("/register")
		public String scheduleRegister(Model model) {
			List<Employee> emps = employeeService.getAllEmployeesNameNo();
			model.addAttribute("emps", emps);
			return "schedule/register-form";
		}
		
		@PostMapping("/register")
		public String registerSchedule(@AuthenticatedUser LoginEmployee loginEmployee,ScheduleRegisterForm form) throws IOException{
			try {
				MultipartFile upfile = form.getUpfile();
				if (!upfile.isEmpty()) {
					String filename = upfile.getOriginalFilename();
					form.setFilename(filename);
					
					FileCopyUtils.copy(upfile.getInputStream(), new FileOutputStream(new File(directory, filename)));
				}
				
				scheduleService.registerSchedule(loginEmployee.getNo(),form);
				
				return "redirect:schedule";
			}catch(NullPointerException ex) {
				scheduleService.registerSchedule(loginEmployee.getNo(),form);
				return "redirect:schedule";
			}
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
		
		@GetMapping("/download")
		public ModelAndView fileDownload(@RequestParam("filename") String filename) {
			File file = new File(directory, filename);
			if (!file.exists()) {
				throw new ApplicationException("["+filename+"] 파일이 존재하지 않습니다.");
			}
			
			ModelAndView mav = new ModelAndView();
			mav.addObject("file", file);
			mav.setView(fileDownloadView);
			
			return mav;
		}
		
		@GetMapping("/excel")
		public String excelSchedule(@AuthenticatedUser LoginEmployee loginEmployee, Model model) {
			List<Schedule> scheduleList= scheduleService.getAllScheduleOnly(loginEmployee.getNo());
			model.addAttribute("schedules", scheduleList);
			
			return "schedule/excel";
		}
		
		@GetMapping(path = "/excel-download", produces = "application/octet-stream")
		public String excelDownload(@AuthenticatedUser LoginEmployee loginEmployee, Model model) {
			
			List<String> keys = List.of("NO", "STARTDATE", "ENDDATE", "STARTTIME", "ENDTIME", "ALLDAY", "TITLE", "CATEGORYNO", "CONTENT", "LOCATION", "EMPLOYEENO");
			List<String> headers = List.of("번호", "시작날짜", "종료날짜", "시작시간", "종료시간", "종일여부", "제목", "분류번호", "내용","장소" ,"직원번호");
			List<Integer> widths = List.of(10, 20, 20, 10, 10, 10, 20, 10, 30, 10, 10);
			List<Map<String, Object>> items = scheduleService.getSchedules(loginEmployee.getNo());
			System.out.println(items);
			
			model.addAttribute("filename", "일정목록.xlsx");
			model.addAttribute("keys", keys);
			model.addAttribute("headers", headers);
			model.addAttribute("widths", widths);
			model.addAttribute("items", items);
			
			return "excelView";
		}
		
		@PostMapping("/excel-upload")
		public String excelUpload(@RequestParam("xls") MultipartFile multipartFile) throws IOException, ParseException {
			
			if (!multipartFile.isEmpty()) {
				// 업로드된 첨부파일을 바이너리 데이터로 조회한다.
				byte[] bytes = multipartFile.getBytes();
				List<Map<String, Object>> dataList = excelParser.getExcelData(bytes);
				scheduleService.insertSchedules(dataList);
			}
			
			return "redirect:schedule";
		}
		
}
