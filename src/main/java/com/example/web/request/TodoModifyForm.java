package com.example.web.request;

import java.util.Date;  

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TodoModifyForm {

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
	private Date createdDate;
	private Date updatedDate;
	private int boxNo;
	private int employeeNo;
	private int receiveEmployeeNo;
}
