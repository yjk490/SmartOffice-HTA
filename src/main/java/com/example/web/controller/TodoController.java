package com.example.web.controller;

import java.io.File;       
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
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
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.dto.todo.TodoDetailDto;
import com.example.dto.todo.TodoProgressDto;
import com.example.dto.todo.TodoReceiveSelect;
import com.example.dto.todo.TodoSearchOpt;
import com.example.exception.ApplicationException;
import com.example.security.AuthenticatedUser;
import com.example.security.LoginEmployee;
import com.example.service.TodoService;
import com.example.vo.todo.Category;
import com.example.vo.todo.Todo;
import com.example.vo.todo.TodoBox;
import com.example.vo.todo.TodoComment;
import com.example.web.request.TodoModifyForm;
import com.example.web.request.TodoRegisterForm;
import com.example.web.view.FileDownloadView;

@Controller
@RequestMapping("/todo")
@SessionAttributes({"modifyTodo"})
public class TodoController {

	@Autowired
	TodoService todoService;
	@Autowired
	private FileDownloadView fileDownloadView;
	
	private final String directory = "c:/files";
	
	// 리스트 화면요청
	@GetMapping("/list")
	public String todo(@RequestParam(name = "page", required = false, defaultValue = "1") int page,
						@RequestParam(name = "category", required = false, defaultValue = "100") int categoryNo,
						@AuthenticatedUser LoginEmployee loginEmployee,
						TodoSearchOpt opt,
						Model model) {
		// 나의 할 일(개인), 업무 요청 및 보고
		if (categoryNo == 100 || categoryNo == 101 || categoryNo == 102 ||categoryNo == 103) {
			Map<String, Object> result = todoService.getTodos(page, opt, loginEmployee.getNo());
			model.addAttribute("todos", result.get("todos"));
			model.addAttribute("pagination", result.get("pagination"));
			model.addAttribute("opt", opt);
			
			Category cat = todoService.getCategoryByNo(categoryNo);
			model.addAttribute("category", cat);
			
			List<TodoBox> todoBoxes = todoService.getBoxByEmpNo(loginEmployee.getNo());
			model.addAttribute("todoBoxes", todoBoxes);
			
			int unread = todoService.getUnreadCount(loginEmployee.getNo());
			model.addAttribute("unread", unread);
			
		// 수신업무
		} else {
			Map<String, Object> result = todoService.ReceiveTodos(page, opt, loginEmployee.getNo());
			model.addAttribute("todos", result.get("todos"));
			model.addAttribute("pagination", result.get("pagination"));
			model.addAttribute("opt", opt);
			
			Category cat = todoService.getCategoryByNo(categoryNo);
			model.addAttribute("category", cat);
			
			int unread = todoService.getUnreadCount(loginEmployee.getNo());
			model.addAttribute("unread", unread);
		}
		
		return "todo/list";
	}
	
	// 조건별 검색
	@PostMapping("/list")
	public String todoSearch(@RequestParam(name = "page", required = false, defaultValue = "1") int page,
			@RequestParam(name = "category", required = false, defaultValue = "100") int categoryNo,
			@AuthenticatedUser LoginEmployee loginEmployee,
			TodoSearchOpt opt,
			Model model) {
		if (categoryNo == 100 || categoryNo == 101 || categoryNo == 102 ||categoryNo == 103) {
			Map<String, Object> result = todoService.getTodos(page, opt, loginEmployee.getNo());
			model.addAttribute("todos", result.get("todos"));
			model.addAttribute("pagination", result.get("pagination"));
			model.addAttribute("opt", opt);
			
			Category cat = todoService.getCategoryByNo(categoryNo);
			model.addAttribute("category", cat);
			
		} else {
			Map<String, Object> result = todoService.ReceiveTodos(page, opt, loginEmployee.getNo());
			model.addAttribute("todos", result.get("todos"));
			model.addAttribute("pagination", result.get("pagination"));
			model.addAttribute("opt", opt);
			
			Category cat = todoService.getCategoryByNo(categoryNo);
			model.addAttribute("category", cat);
		}
		return "todo/list";
	}
	
	// 읽음확인
	@GetMapping("/read")
	public String read(@AuthenticatedUser LoginEmployee loginEmployee, 
						@RequestParam("todoNo") int todoNo, @RequestParam("category")int categoryNo, Model model) {
		if(categoryNo != 104) {
			todoService.reading(todoNo);
		} else {
			todoService.receiveReading(todoNo, loginEmployee.getNo());
		}
		
		return "redirect:detail?todoNo=" + todoNo + "&category=" + categoryNo;
	}
	
	// 나의 할일 상세화면 요청
	@GetMapping("/detail")
	public String todoDetail(@RequestParam("todoNo") int todoNo, @RequestParam("category") int categoryNo, 
							@AuthenticatedUser LoginEmployee loginEmployee, Model model) {
		
		if(categoryNo == 100) {
			TodoDetailDto todoDetailDto = todoService.getTodoDetail(todoNo);
			model.addAttribute("dto", todoDetailDto);
			
		} else {
			
			TodoDetailDto dto = todoService.detailDtos(todoNo);
			model.addAttribute("dto", dto);
		}
		
		Category cat = todoService.getCategoryByNo(categoryNo);
		model.addAttribute("category", cat);
		
		List<TodoComment> comments = todoService.CommentList(todoNo);
		model.addAttribute("comments",comments);
		
		int login = loginEmployee.getNo();
		model.addAttribute("loginUserNo", login);
		
		String receiveName = todoService.receiveEmployee(todoNo);
		model.addAttribute("receiveName", receiveName);
		
		int count = todoService.getReceiverCount(todoNo);
		model.addAttribute("count", count);
		
		int unread = todoService.getUnreadCount(loginEmployee.getNo());
		model.addAttribute("unread", unread);
		
		return "todo/detail";
	}
	
	@PostMapping("/complete")
	public String todoComplete(TodoProgressDto dto, @RequestParam("progressRate") String rate, int category) {
		todoService.todoProgress(dto);
		return "redirect:detail?todoNo=" + dto.getTodoNo() + "&category=" + category;
	}
	// 댓글 등록하기
	@PostMapping("/addComment")
	public String addComment(@AuthenticatedUser LoginEmployee loginEmployee, 
								@RequestParam("category") int category,
								TodoComment todoComment) {
		todoComment.setEmployeeNo(loginEmployee.getNo());
		todoService.addComment(todoComment);
		return "redirect:detail?todoNo=" + todoComment.getTodoNo() + "&category=" + category;
	}
	
	@GetMapping("/delete-comment")
	public String deleteComment(int category, int commentNo, int todoNo) {
		todoService.deleteComment(commentNo);
		return "redirect:detail?todoNo=" + todoNo + "&category=" + category;
	}
	
	// 수정화면 요청
	@GetMapping("/modify")
	public String modifyform(@RequestParam("todoNo") int todoNo, @RequestParam("category") int category, Model model) {
		TodoDetailDto todoDetailDto = todoService.getTodoDetail(todoNo);
		
		TodoModifyForm form = new TodoModifyForm();
		BeanUtils.copyProperties(todoDetailDto, form);
		
		model.addAttribute("category", category);
		model.addAttribute("modifyTodo", form);
		return "todo/modify-form";
	}
	
	// 수정하기
	@PostMapping("/modify")
	public String modify(@ModelAttribute("modifyTodo") TodoModifyForm todoModifyForm, @RequestParam("category") int category) {
		todoService.updateTodo(todoModifyForm);
		return "redirect:detail?todoNo=" + todoModifyForm.getTodoNo() + "&category=" + category;
	}
	
	// 업무등록화면 요청
	@GetMapping("/insert")
	public String insertForm(@RequestParam("category") String category, Model model) {
		List<TodoReceiveSelect> receiveList =  todoService.getTodoReceiveSelect();
		model.addAttribute("receiveList", receiveList);
		model.addAttribute("category", category);
		
		return "todo/Todoform";
	}
	
	// 업무 등록하기 구현
	// userId들어가야함
	@PostMapping("/insert")
	public String insert(@AuthenticatedUser LoginEmployee loginEmployee, TodoRegisterForm form, 
						@RequestParam("jobCatNo") int categoryNo,
						@RequestParam("receiveEmpNo") List<Integer> receiveEmpNo) throws IOException {
		
		List<MultipartFile> upfiles = form.getUpfile();
		List<String> filenames = new ArrayList<>();
		for (MultipartFile upfile : upfiles) {
			if (!upfile.isEmpty()) {
				String filename = upfile.getOriginalFilename();
				filenames.add(filename);
				FileCopyUtils.copy(upfile.getInputStream(), new FileOutputStream(new File(directory, filename)));
			}
		}
		form.setFilename(filenames);
		form.setTodoRecieveSelect(receiveEmpNo);
		todoService.insertTodo(form, loginEmployee.getNo());
		
		return "redirect:list?category=" + categoryNo;
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
	
	// 업무 삭제하기(다중선택 - 체크박스)
	@GetMapping("/delete")
	// 해당 객체를 json이나 xml형태로 변환해서 응답으로변환해서 보냄(원래는 여태껏 jsp의 이름(html경로)이 반환했었는데 요청메세지에 body에 들어갈걸 반환함)
	@ResponseBody
	public String delete(@RequestParam("no") List<Integer> todoNo) {
		for(int no : todoNo) {
			System.out.println(no);
		}
		todoService.deleteTodo(todoNo);
		
		return "success";
	}
	
	// 상세화면에서 업무삭제하기
	@GetMapping("/deleteOne")
	public String deleteOne(@RequestParam("todoNo") int todoNo, @RequestParam("category") int category) {
		System.out.println(todoNo);
		System.out.println(category);
		todoService.deleteOneTodo(todoNo);
		
		return "redirect:list?category=" + category;
	}
	
	// 업무보관함 화면요청
	@GetMapping("/todoBox")		// 로그인정보 필요함
	public String todoBox(@RequestParam(name = "page", required = false, defaultValue = "1") int page, @RequestParam(name = "boxNo", required = false, defaultValue = "100") int boxNo, Model model) {
		
		Map<String, Object> result = todoService.getTodoboxes(page, boxNo);
		model.addAttribute("list", result.get("list"));
		model.addAttribute("pagination", result.get("pagination"));
		
		// 로그인정보 필요 TodoBox todoBox = todoService.getBoxByEmpNo(empNo);
		//model.addAttribute("todoBox", todoBox);
		return "todo/todoBox";
	}
	
	// 선택 업무 보관함에 설정하기
	@GetMapping("/todo-In-TodoBox")
	@ResponseBody
	public String todoInTodoBox(@RequestParam("boxNo") int boxNo, @RequestParam("no") List<Integer> todoNo,
								@RequestParam("category") int category) {
		for(int no : todoNo) {
			System.out.println(no);
			
			Todo todo = todoService.getTodoByTodoNo(no);
			todo.setBoxNo(boxNo);
		}
		return "";
	}
	
	@GetMapping("/sample")
	public String sample() {
		return "todo/sample";
	}
}
