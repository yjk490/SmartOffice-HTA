package com.example.dto.todo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("TodoProgressDto")
@Getter
@Setter
public class TodoProgressDto {

	// 수신자(처리내역)
	private int progressNo;
	private int TodoNo;
	private int empNo;
	private int progressRate;
	private String Content;
	private String FileName;
	private String CreatedDate;
	private String UpdatedDate;
}
