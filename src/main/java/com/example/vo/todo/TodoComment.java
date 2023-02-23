package com.example.vo.todo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("TodoComment")
@Getter
@Setter
public class TodoComment {

	private int commentNo;
	private int todoNo;
	private String content;
	private Date createdDate;
	private Date updatedDate;
	private String deleted;
	private int employeeNo;
	private String employeeName;
}
