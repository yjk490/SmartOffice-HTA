package com.example.dto.todo;

import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Alias("TodoProgressDto")
@Getter
@Setter
public class TodoProgressDto {

	// 수신자(처리내역)
	private int progressNo;
	private int todoNo;
	private int receiveEmpNo;
	private int progressRate;
	private String progressRead;
	private String content;
	private String filename;
	private String createdDate;
	private String updatedDate;
	private MultipartFile upfile;
}
