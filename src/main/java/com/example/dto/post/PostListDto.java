package com.example.dto.post;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PostListDto {

	private int no;
	private String name;
	private String title;
	private int readCount;
	private int commentCount;
	private int recommendCount;
	private Date createdDate;
}
