package com.example.web.controller;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.dto.emp.EmployeeDetailDto;
import com.example.dto.note.NoteListDto;
import com.example.dto.schedule.ScheduleEvent;
import com.example.dto.todo.TodoListDto;
import com.example.security.AuthenticatedUser;
import com.example.security.LoginEmployee;
import com.example.service.EmployeeService;
import com.example.service.NoteService;
import com.example.service.ScheduleService;
import com.example.web.request.EmployeePasswordForm;

@Controller
public class HomeController {
	
	@Autowired
	private EmployeeService employeeService;
	@Autowired
	private NoteService noteService;
	@Autowired
	private ScheduleService scheduleService;
	
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

	@GetMapping("/home/schedule")
	@ResponseBody
	public List<ScheduleEvent> getSchedules(@AuthenticatedUser LoginEmployee loginEmployee, 
				@RequestParam("startDate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDate,
				@RequestParam("endDate") @DateTimeFormat(pattern =  "yyyy-MM-dd") Date endDate){

		Map<String, Object> param = new HashMap<>();
		param.put("empNo", loginEmployee.getNo());
		param.put("startDate", startDate);
		param.put("endDate", endDate);
		
		return scheduleService.getEvents(param);
	}
	
	@GetMapping("/home/chart")
	@ResponseBody
	public Map<String, Object> getDonutChartData(@AuthenticatedUser LoginEmployee loginEmployee) {
		
		Map<String, Object> data = new HashMap<>();
		int empNo= loginEmployee.getNo();
		List<TodoListDto> todoListDtos = employeeService.getTodoListDtoByNo(empNo);
		int total = 0;
		int w = 0;
		int c = 0;

		for (TodoListDto todoListDto : todoListDtos) {
			String progressStatus = todoListDto.getProgressStatus();
			int progressStatusLength = progressStatus.length();
			int numberOfW = progressStatus.length() - progressStatus.replace("W", "").length();
			int numberOfC = progressStatus.length() - progressStatus.replace("C", "").length();
			w += numberOfW;
			c += numberOfC;
			total += progressStatusLength;
		}
		
		data.put("w", w);
		data.put("c", c);
		data.put("total", total);
		
		return data;
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
		if (employeePasswordForm.getEmpNo() == null) {
			errors.rejectValue("empNo", null, "사원번호는 필수입력값입ㄴ미.");
		}
		
		if(errors.hasErrors()) {
			return "employee/password-search-form";
		} 
		
		EmployeeDetailDto dto = employeeService.getEmplDetail(employeePasswordForm.getEmpNo());
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
