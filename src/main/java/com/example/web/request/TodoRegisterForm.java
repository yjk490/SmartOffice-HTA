package com.example.web.request;

import java.util.Date; 
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import com.example.dto.todo.TodoReceiveSelect;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TodoRegisterForm {

	private int jobCatNo;
	private String title;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date startDate;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date endDate;
	private int boxNo;
	private String content;
	private String important;
	private List<Integer> TodoRecieveSelect;
	private List<String> filename;
	private List<MultipartFile> upfile;
}
