package com.example.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class NoteController {
	
		//쪽지 보내기 화면 요청
		@GetMapping("/note/form")
		public String noteform() {
			return"note/note-form";
		}
	
		// 받은 쪽지 화면 요청
		@GetMapping("/note/receive")
		public String note() {
			return "note/receive-list";
		}
		
		// 보낸 쪽지 화면 요청
		@GetMapping("/note/sendnote")
		public String sendNote() {
			return "note/send-list";
		}
		
		// 임시 쪽지 화면 요청
		@GetMapping("/note/draftnote")
		public String draftNote() {
			return "note/draft-list";
		}

		// 임시 쪽지 화면 요청
		@GetMapping("/note/foldernote")
		public String folderNote() {
			return "note/folder-list";
		}
		
		// 중요 쪽지 화면 요청
		@GetMapping("/note/important")
		public String improtantNote() {
			return "note/important-list";
		}
		
		// 휴지통 화면 요청
		@GetMapping("/note/wagger")
		public String waggerNote() {
			return "note/wagger-list";
		}
		
		// 휴지통 화면 요청
		@GetMapping("/note/detail")
		public String detail() {
			// 지금은 화면 디자인을 위해 단순 페이지 요청
			// 추후 empNo로 조회해서 받은/보낸 쪽지 디테일 페이지 반환 코드 추가 예정
			return "note/detail";
		}
}
