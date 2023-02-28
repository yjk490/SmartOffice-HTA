package com.example.vo.todo;

import java.util.Date;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;

@Alias("TodoComment")
@Getter
@Setter
public class TodoComment {

	private int commentNo;
	private int todoNo;
	private String content;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date createdDate;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date updatedDate;
	private String deleted;
	private int employeeNo;
	private String employeeName;
	private String positionName;
}
