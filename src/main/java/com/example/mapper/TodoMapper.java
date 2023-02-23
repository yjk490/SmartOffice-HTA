package com.example.mapper;

import java.util.Date;  
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.dto.todo.TodoBoxListDto;
import com.example.dto.todo.TodoDetailDto;
import com.example.dto.todo.TodoListDto;
import com.example.dto.todo.TodoReceiveSelect;
import com.example.vo.todo.Category;
import com.example.vo.todo.ReceiveEmployees;
import com.example.vo.todo.Todo;
import com.example.vo.todo.TodoBox;
import com.example.vo.todo.TodoComment;



@Mapper
public interface TodoMapper {

	//업무등록하기
	void insertTodo(Todo todo);
	// 등록창에서 수신자 목록조회
	List<TodoReceiveSelect> getTodoReceiveSelect();
	// 업무 List조회
	int getTotalRows();
	List<TodoListDto> getTodos(int begin, int end, String status, 
								int category, String opt, String important, 
								Date startDate, Date endDate, String keyword, int empNo);
	
	List<TodoListDto> getReceiveTodos(int begin, int end, String status, 
										int category, String opt, String important, 
										Date startDate, Date endDate, String keyword, int receiveEmpNo);
	// detail페이지 조회하기
	TodoDetailDto getTodoDetailByTodoNo(int todoNo);
	// 업무번호로 업무찾기
	Todo getTodoByTodoNo(int todoNo);
	
	// 업무유형조회
	List<Category> getCategory();
	// 유형번호로 업무유형 찾기
	Category getCategoryByNo(int no);

	// 업무수정하기
	void updateTodo(Todo todo);
	// 수신자등록하기
	void insertReceive(ReceiveEmployees receiveEmployee);
	
	// 댓글 등록하기
	void addComment(TodoComment todoComment);
	// 해당 업무 댓글 조회하기
	List<TodoComment> commentList(int todoNo);
	
	//업무보관함 List조회
	int getBoxTotalRows();
	List<TodoBoxListDto> getTodoByBoxNo(Map<String, Object> param);
	// 직원번호로 업무보관함 조회
	List<TodoBox> getBoxByEmpNo(int empNo);
	// 상위보관함번호로 하위보관함 찾기
	List<TodoBox> getBoxByParentBoxNo(int parentBoxNo);
	
}
