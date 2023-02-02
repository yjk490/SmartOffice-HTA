package com.example.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {
	//일정 화면 요청
		@GetMapping("/schedule")
		public String schedule() {
			return "schedule/schedule";
		}
}
