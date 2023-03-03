package com.example.dto.todo;

import java.util.Date;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;

@Alias("TodoListDto")
@Getter
@Setter
public class TodoListDto {

	private int todoNo;
	private String important;
	private int boxNo;
	private String boxName;
	private String title;
	private int empNo;
	private String empName;
	private int receiveEmpNo;
	private String receiveEmpName;
	private int jobCatNo;
	private String jobCatName;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date createdDate;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date StartDate;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date EndDate;
	private String progressStatus;
	private String read;
}
