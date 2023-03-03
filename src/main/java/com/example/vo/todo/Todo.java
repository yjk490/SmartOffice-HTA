package com.example.vo.todo;

import java.util.Date;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;

@Alias("Todo")
@Getter
@Setter
public class Todo {

	private int todoNo;
	private String important;
	private String title;
	private String content;
	private String progressStatus;
	private int progressRate;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date startDate;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date endDate;
	private String read;
	private String deleted;
	private Date createdDate;
	private Date updatedDate;
	private int boxNo;
	private int employeeNo;
	private String positionName;
	private int receiveEmployeeNo;
	private String receiveEmployeeName;
	private int jobCatNo;
}
