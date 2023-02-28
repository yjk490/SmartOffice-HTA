package com.example.service;

import java.util.HashMap;     
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired; 
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dto.todo.TodoBoxListDto;
import com.example.dto.todo.TodoDetailDto;
import com.example.dto.todo.TodoListDto;
import com.example.dto.todo.TodoProgressDto;
import com.example.dto.todo.TodoReceiveSelect;
import com.example.dto.todo.TodoSearchOpt;
import com.example.mapper.TodoMapper;
import com.example.utils.Pagination;
import com.example.vo.todo.Category;
import com.example.vo.todo.ReceiveEmployees;
import com.example.vo.todo.Todo;
import com.example.vo.todo.TodoBox;
import com.example.vo.todo.TodoComment;
import com.example.web.request.TodoModifyForm;
import com.example.web.request.TodoRegisterForm;

@Service
@Transactional
public class TodoService {

	@Autowired 
	private TodoMapper todoMapper;
	
	// 업무 등록하기
	public void insertTodo(TodoRegisterForm form, int empNo) {
		
		List<Integer> receive = form.getTodoRecieveSelect();
		// 수신자가 없을 경우
		if(receive.isEmpty()) {
			Todo todo = new Todo();
			todo.setEmployeeNo(empNo);
			BeanUtils.copyProperties(form, todo);
			todoMapper.insertTodo(todo);
		}
		// 수신자가 있을 경우
		// 수신자 empNolist
		else if(!receive.isEmpty()) {
			//업무 등록하기
			Todo todo = new Todo();
			todo.setEmployeeNo(empNo);
			todo.setReceiveEmployeeNo(receive.get(0));
			BeanUtils.copyProperties(form, todo);
			todoMapper.insertTodo(todo);
			
			// 수신 업무 등록
			ReceiveEmployees receiveEmp = new ReceiveEmployees();
			for (int receiveNo: receive) {
				receiveEmp.setTodoNo(todo.getTodoNo());
				receiveEmp.setEmpNo(empNo);
				receiveEmp.setReceiveEmpNo(receiveNo);
				System.out.println("todoNo: " + todo.getTodoNo());
				System.out.println("empNo: " + empNo);
				System.out.println("receiveNo: " + receiveNo);
				todoMapper.insertReceive(receiveEmp);
			}
		}
	}
	
	// 등록창에서 수신자 목록조회
	public List<TodoReceiveSelect> getTodoReceiveSelect() {
		List<TodoReceiveSelect> receiveList = todoMapper.getTodoReceiveSelect();
		return receiveList;
	}
	
	// 나의 업무 조회(list)
	public Map<String, Object> getTodos(int page, TodoSearchOpt opt, int empNo) {
		int totalRows = todoMapper.getTotalRows(); // empNo 넣어야함
		Pagination pagination = new Pagination(page, totalRows, opt.getRows());
		
		List<TodoListDto> todos = todoMapper.getTodos(pagination.getBegin(),
													pagination.getEnd(),
													opt.getStatus(),
													opt.getCategory(),
													opt.getOpt(),
													opt.getImportant(),
													opt.getStartDate(),
													opt.getEndDate(),
													opt.getKeyword(),
													empNo);
		System.out.println("begin: " + pagination.getBegin() + "end: " + pagination.getEnd() + "rows: "+ opt.getRows());
		Map<String, Object> result = new HashMap<>();
		result.put("todos", todos);
		result.put("pagination", pagination);
		
		return result;
	}
	
	// 수신 업무 조회(list)
	public Map<String, Object> ReceiveTodos(int page, TodoSearchOpt opt, int receiveEmpNo) {
		int totalRows = todoMapper.getTotalRows(); // empNo 넣어야함
		Pagination pagination = new Pagination(page, totalRows, opt.getRows());
		
		List<TodoListDto> todos = todoMapper.getReceiveTodos(pagination.getBegin(),
				pagination.getEnd(),
				opt.getStatus(),
				opt.getCategory(),
				opt.getOpt(),
				opt.getImportant(),
				opt.getStartDate(),
				opt.getEndDate(),
				opt.getKeyword(),
				receiveEmpNo);
		System.out.println("begin: " + pagination.getBegin() + "end: " + pagination.getEnd() + "rows: "+ opt.getRows());
		Map<String, Object> result = new HashMap<>();
		result.put("todos", todos);
		result.put("pagination", pagination);
		
		return result;
	}
	// 상세화면 조회
	public TodoDetailDto detailDtos(int todoNo) {
		return  todoMapper.detailDtos(todoNo);
	}
	
	// 업무유형 조회
	public List<Category> getCategory() {
		List<Category> categories = todoMapper.getCategory();
		return categories;
	}
	
	// 유형번호로 업무유형 조회하기
	public Category getCategoryByNo(int no) {
		Category category = todoMapper.getCategoryByNo(no);
		return category;
	}
	
	// 상세화면 조회하기
	public TodoDetailDto getTodoDetail(int todoNo) {
		TodoDetailDto todoDetailDto = todoMapper.getTodoDetailByTodoNo(todoNo);
		
		return todoDetailDto;
	}
	// 해당업무에 몇명의 수신자가 있는지 조회하기
	public int getReceiverCount(int todoNo) {
		int count = todoMapper.getReceiverCount(todoNo);
		return count; 
	}
	
	public String receiveEmployee(int todoNo) {
		Todo todo = todoMapper.getTodoByTodoNo(todoNo);
		String receiveName = todo.getReceiveEmployeeName();
		return receiveName;
	}
	
	// 업무번호로 업무조회하기
	public Todo getTodoByTodoNo(int todoNo) {
		Todo todo = todoMapper.getTodoByTodoNo(todoNo);
		return todo;
	}
	
	// 업무 수정하기
	public void updateTodo(TodoModifyForm todoModifyForm) {
		Todo todo = todoMapper.getTodoByTodoNo(todoModifyForm.getTodoNo());
		
		BeanUtils.copyProperties(todoModifyForm, todo);
		todoMapper.updateTodo(todo);
	}

	// 게시글 삭제하기
	public void deleteTodo(List<Integer> todoNo) {
		for(int x : todoNo) {
			Todo todo = todoMapper.getTodoByTodoNo(x);
			
			todo.setDeleted("Y");
			todoMapper.updateTodo(todo);
		}
	}

	// 업무보관함 
	public Map<String, Object> getTodoboxes(int page, int listNo) {
		int totalRows = todoMapper.getBoxTotalRows();
		Pagination pagination = new Pagination(page, totalRows);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("begin", pagination.getBegin());
		param.put("end", pagination.getEnd());
		param.put("boxNo", listNo);
		// param.put("empNo",empNo); 들어가야함
		List<TodoBoxListDto> list = todoMapper.getTodoByBoxNo(param);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", list);
		result.put("pagination", pagination);
		
		return result;
	}

	// 상위보관함번호로 하위보관함 찾기
	public List<TodoBox> getBoxByparentBoxNo(int parentBoxNo) {
		List<TodoBox> todoBox = todoMapper.getBoxByParentBoxNo(parentBoxNo);
		
		return todoBox;
	}
	// 유저별 업무보관함 조회하기
	public List<TodoBox> getBoxByEmpNo(int empNo) {
		List<TodoBox> todoBox = todoMapper.getBoxByEmpNo(empNo);
		
		return todoBox;
	}

	// 상세화면에서 삭제하기
	public void deleteOneTodo(int todoNo) {
		Todo todo = todoMapper.getTodoByTodoNo(todoNo);
		
		todo.setDeleted("Y");
		todoMapper.updateTodo(todo);
		
	}
	
	// 댓글 등록하기
	public void addComment(TodoComment todoComment) {
		todoMapper.addComment(todoComment);
	}
	
	// 해당업무의 댓글조회하기
	public List<TodoComment> CommentList(int todoNo) {
		List<TodoComment> commentList = todoMapper.commentList(todoNo);
		return commentList;
	}

	// 읽음확인표시
	public void reading(int todoNo) {
		Todo todo = todoMapper.getTodoByTodoNo(todoNo);
		todo.setRead("Y");
		todoMapper.updateTodo(todo);
	}

	// 댓글삭제
	public void deleteComment(int commentNo) {
		todoMapper.deleteComment(commentNo);
	}

	// 업무처리하기
	public void todoProgress(TodoProgressDto dto) {
		int progressNo = todoMapper.getProgressNoByNums(dto.getTodoNo(), dto.getReceiveEmpNo());
		System.out.println("progressNo: " + progressNo);
		dto.setProgressNo(progressNo);
		todoMapper.updateProgress(dto);
	}
	
	// 수신업무 읽음처리
	public void receiveReading(int todoNo, int receiveEmpNo) {
		TodoProgressDto dto = todoMapper.getProgressHistoryByNums(todoNo, receiveEmpNo);
		dto.setProgressRead("Y");
		todoMapper.updateProgress(dto);
	}
	
	// 읽지않은 업무 수
	public int getUnreadCount(int receiveEmpNo) {
		int unread = todoMapper.getUnreadCount(receiveEmpNo);
		return unread;
	}
}
