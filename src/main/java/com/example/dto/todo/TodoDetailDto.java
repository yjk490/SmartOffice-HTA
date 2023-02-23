package com.example.dto.todo;

import java.util.Date; 
import java.util.List;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import com.example.vo.todo.ReceiveEmployees;
import com.example.vo.todo.TodoComment;

import lombok.Getter;
import lombok.Setter;

@Alias("TodoDetailDto")
@Getter
@Setter
public class TodoDetailDto {

	private int todoNo;
	private int boxNo;
	private String boxName;
	private String title;
	private String content;
	private String progressStatus;
	private int empNo;
	private String empName;
	private Date createdDate;
	private Date updatedDate;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date StartDate;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date EndDate;
	private List<ReceiveEmployees> receiveEmp;
	private List<TodoComment> comments;
	// private List<String> fileName;
	// private List<AttachedFile> attachedFiles;
}
