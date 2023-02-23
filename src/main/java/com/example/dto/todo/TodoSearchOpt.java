package com.example.dto.todo;

import java.util.Date;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;

@Alias("TodoSearchOpt")
@Getter
@Setter
public class TodoSearchOpt {

	private int rows = 10;
	private int category;
	private String important;
	private String status;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date startDate;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date endDate;
	private String opt;
	private String keyword;
}
