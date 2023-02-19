package com.example.web.controller;

import java.io.File;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.apache.ibatis.javassist.compiler.ast.Keyword;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.dto.emp.EmployeeDetailDto;
import com.example.security.AuthenticatedUser;
import com.example.security.LoginEmployee;
import com.example.service.EmployeeService;
import com.example.service.NoteService;
import com.example.web.request.NoteRegisterForm;
import com.example.web.view.FileDownloadView;

@Controller
@RequestMapping("/note")
public class NoteController {
	
		private final String directory = "c:/files";
	
		@Autowired
		private NoteService noteService;
		@Autowired
		private EmployeeService employeeService;
		@Autowired
		private FileDownloadView fileDownloadView;
	
		//쪽지 보내기 화면 요청
		@GetMapping("/form")
		@AuthenticatedUser
		public String noteform(Model model) {
			NoteRegisterForm form = new NoteRegisterForm();
			model.addAttribute("noteRegisterForm", form);
			
			return"note/note-form";
		}
		
		@PostMapping("/form")
		public String insertNote(@AuthenticatedUser LoginEmployee loginEmployee, 
				@ModelAttribute("noteRegisterForm") @Valid NoteRegisterForm form) throws IOException {
			MultipartFile upfile = form.getUpfile();
			if(!upfile.isEmpty()) {
				String filename = upfile.getOriginalFilename();
				form.setFilename(filename);
				
				FileCopyUtils.copy(upfile.getInputStream(), new FileOutputStream(new File(directory, filename)));
			}
			
			noteService.insertNote(loginEmployee.getNo(), form);
			
			return "redirect:sendnote";
		}
		
		// 임시보관함으로 쪽지 보내기
		@GetMapping("/draft")
		@AuthenticatedUser
		public String draftform(Model model) {
			NoteRegisterForm form = new NoteRegisterForm();
			model.addAttribute("noteRegisterForm", form);
			
			return"note/note-form";
		}
		
		@PostMapping("/draft")
		public String insertDraftNote(@AuthenticatedUser LoginEmployee loginEmployee, 
				@ModelAttribute("noteRegisterForm") @Valid NoteRegisterForm form) throws IOException {
			MultipartFile upfile = form.getUpfile();
			if(!upfile.isEmpty()) {
				String filename = upfile.getOriginalFilename();
				form.setFilename(filename);
				
				FileCopyUtils.copy(upfile.getInputStream(), new FileOutputStream(new File(directory, filename)));
			}
			
			noteService.insertDraftNote(loginEmployee.getNo(), form);
			
			return "redirect:draftnote";
		}
	
		// 받은 쪽지 화면 요청
		@GetMapping("/receive")
		public String note(@AuthenticatedUser LoginEmployee loginEmployee, 
				@RequestParam(name= "page", required = false, defaultValue = "1") int page, 
				@RequestParam(name="opt", required=false, defaultValue="") String opt,
				@RequestParam(name="rows", required=false, defaultValue="10") int rows,
				@RequestParam(name="keyword", required=false, defaultValue="") String keyword,
				Model model) {
			
			int no = loginEmployee.getNo();
			Map<String, Object> param = new HashMap<>();
			param.put("rows", rows);
			if(!opt.isBlank() && !keyword.isBlank()) {
				param.put("opt", opt);
				param.put("keyword", keyword);
			}
			param.put("page", page);
			param.put("no", no);
			
			Map<String, Object> result = noteService.getRecieveNotes(param);
			model.addAttribute("notes", result.get("notes"));
			model.addAttribute("pagination", result.get("pagination"));
			model.addAttribute("no", result.get("no"));
			model.addAttribute("rows", rows);
			model.addAttribute("keyword", keyword);
			model.addAttribute("opt", opt);
			
			return "note/receive-list";
		}
		
		
		// 보낸 쪽지 화면 요청
		@GetMapping("/sendnote")
		public String sendNote(@AuthenticatedUser LoginEmployee loginEmployee, 
				@RequestParam(name= "page", required = false, defaultValue = "1") int page, 
				@RequestParam(name="opt", required=false, defaultValue="") String opt,
				@RequestParam(name="rows", required=false, defaultValue="10") int rows,
				@RequestParam(name="keyword", required=false, defaultValue="") String keyword,
				Model model) {
			
			int no = loginEmployee.getNo();
			Map<String, Object> param = new HashMap<>();
			param.put("rows", rows);
			if(!opt.isBlank() && !keyword.isBlank()) {
				param.put("opt", opt);
				param.put("keyword", keyword);
			}
			param.put("page", page);
			param.put("no", no);
			
			Map<String, Object> result = noteService.getSendNotes(param);
			model.addAttribute("notes", result.get("notes"));
			model.addAttribute("pagination", result.get("pagination"));
			model.addAttribute("no", result.get("no"));
			model.addAttribute("rows", rows);
			model.addAttribute("keyword", keyword);
			model.addAttribute("opt", opt);
			
			return "note/send-list";
		}
		
		// 임시 쪽지 화면 요청
		@GetMapping("/draftnote")
		public String draftNote(@AuthenticatedUser LoginEmployee loginEmployee, 
				@RequestParam(name= "page", required = false, defaultValue = "1") int page, 
				@RequestParam(name="opt", required=false, defaultValue="") String opt,
				@RequestParam(name="rows", required=false, defaultValue="10") int rows,
				@RequestParam(name="keyword", required=false, defaultValue="") String keyword,
				Model model) {
			int no = loginEmployee.getNo();
			Map<String, Object> param = new HashMap<>();
			param.put("rows", rows);
			if(!opt.isBlank() && !keyword.isBlank()) {
				param.put("opt", opt);
				param.put("keyword", keyword);
			}
			param.put("page", page);
			param.put("no", no);
			
			Map<String, Object> result = noteService.getDraftNotes(param);
			model.addAttribute("notes", result.get("notes"));
			model.addAttribute("pagination", result.get("pagination"));
			model.addAttribute("no", result.get("no"));
			model.addAttribute("rows", rows);
			model.addAttribute("keyword", keyword);
			model.addAttribute("opt", opt);
			
			
			return "note/draft-list";
		}

		// 쪽지 보관함 화면 요청
		@GetMapping("/foldernote")
		public String folderNote(@AuthenticatedUser LoginEmployee loginEmployee, 
				@RequestParam(name= "page", required = false, defaultValue = "1") int page, 
				@RequestParam(name="opt", required=false, defaultValue="") String opt,
				@RequestParam(name="rows", required=false, defaultValue="10") int rows,
				@RequestParam(name="keyword", required=false, defaultValue="") String keyword,
				Model model) {
			int no = loginEmployee.getNo();
			Map<String, Object> param = new HashMap<>();
			param.put("rows", rows);
			if(!opt.isBlank() && !keyword.isBlank()) {
				param.put("opt", opt);
				param.put("keyword", keyword);
			}
			param.put("page", page);
			param.put("no", no);
			
			Map<String, Object> result = noteService.getSaveNotes(param);
			model.addAttribute("notes", result.get("notes"));
			model.addAttribute("pagination", result.get("pagination"));
			model.addAttribute("no", result.get("no"));
			model.addAttribute("rows", rows);
			model.addAttribute("keyword", keyword);
			model.addAttribute("opt", opt);
			
			return "note/folder-list";
		}
		
		// 중요 쪽지 화면 요청
		@GetMapping("/important")
		public String improtantNote(@AuthenticatedUser LoginEmployee loginEmployee, 
				@RequestParam(name= "page", required = false, defaultValue = "1") int page, 
				@RequestParam(name="opt", required=false, defaultValue="") String opt,
				@RequestParam(name="rows", required=false, defaultValue="10") int rows,
				@RequestParam(name="keyword", required=false, defaultValue="") String keyword,
				Model model) {
			int no = loginEmployee.getNo();
			Map<String, Object> param = new HashMap<>();
			param.put("rows", rows);
			if(!opt.isBlank() && !keyword.isBlank()) {
				param.put("opt", opt);
				param.put("keyword", keyword);
			}
			param.put("page", page);
			param.put("no", no);
			
			Map<String, Object> result = noteService.getImportantNotes(param);
			model.addAttribute("notes", result.get("notes"));
			model.addAttribute("pagination", result.get("pagination"));
			model.addAttribute("no", result.get("no"));
			model.addAttribute("rows", rows);
			model.addAttribute("keyword", keyword);
			model.addAttribute("opt", opt);
			
			return "note/important-list";
		}
		
		// 휴지통 화면 요청
		@GetMapping("/wagger")
		public String waggerNote(@AuthenticatedUser LoginEmployee loginEmployee, 
				@RequestParam(name= "page", required = false, defaultValue = "1") int page, 
				@RequestParam(name="opt", required=false, defaultValue="") String opt,
				@RequestParam(name="rows", required=false, defaultValue="10") int rows,
				@RequestParam(name="keyword", required=false, defaultValue="") String keyword,
				Model model) {
			int no = loginEmployee.getNo();
			Map<String, Object> param = new HashMap<>();
			param.put("rows", rows);
			if(!opt.isBlank() && !keyword.isBlank()) {
				param.put("opt", opt);
				param.put("keyword", keyword);
			}
			param.put("page", page);
			param.put("no", no);
			
			Map<String, Object> result = noteService.getWaggerNotes(param);
			model.addAttribute("notes", result.get("notes"));
			model.addAttribute("pagination", result.get("pagination"));
			model.addAttribute("no", result.get("no"));
			model.addAttribute("rows", rows);
			model.addAttribute("keyword", keyword);
			model.addAttribute("opt", opt);
			
			return "note/wagger-list";
		}
		
		// 쪽지 디테일 화면 요청
		@GetMapping("/detail")
		public String detail() {
			// 지금은 화면 디자인을 위해 단순 페이지 요청
			// 추후 empNo로 조회해서 받은/보낸 쪽지 디테일 페이지 반환 코드 추가 예정
			return "note/detail";
		}
		
		// 쪽지 보내기에서 모달로 사원 검색
		@GetMapping("/search.json")
		@ResponseBody
		public List<EmployeeDetailDto> search(@RequestParam("keyword") String name) {
			return employeeService.getEmpDetailByName(name);
		}
		
		// 쪽지 삭제 요청(받은 쪽지함, 쪽지보관함, 중요쪽지함에서 쪽지를 삭제)
		@GetMapping("/delete")
		public String delNote(@RequestParam("noteNo") List<Integer> noteNos) {
			noteService.deleteNotes(noteNos);
			
			// 휴지통으로 이동
			return "note/wagger-list";
		}
		
		// 쪽지 삭제 요청(보낸 쪽지함, 임시보관함에서 쪽지를 삭제)
		@GetMapping("/send-delete")
		public String delSendNote(@RequestParam("noteNo") List<Integer> noteNos) {
			noteService.deleteSendNotes(noteNos);
			
			// 휴지통으로 이동
			return "note/wagger-list";
		}
		
		// 쪽지 삭제 요청(휴지통에서 쪽지를 삭제)
		@GetMapping("/wagger-delete")
		public String delWaggerNote(@RequestParam("noteNo") List<Integer> noteNos) {
			noteService.deleteWaggerNotes(noteNos);
			
			// 휴지통으로 이동
			return "note/wagger-list";
		}
		
		// 받은 쪽지 보관함에 보관 요청
		@GetMapping("/save")
		public String saveNote(@RequestParam("noteNo") List<Integer> noteNos) {
			noteService.saveNotes(noteNos);
			
			// 쪽지 보관함으로 이동
			return "note/folder-list";
		}
}
