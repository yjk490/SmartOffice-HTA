package com.example.dto.post;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CommentDto {

	private int no;
	private int employeeNo;
	private String name;
	private String content;
	private int recommendCount;
	private Date createdDate;
	private boolean recommended;
}
