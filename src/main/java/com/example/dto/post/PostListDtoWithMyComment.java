package com.example.dto.post;

import java.time.LocalDateTime;

import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

import com.example.utils.DateTimeToString;

import lombok.Getter;

@Getter
public class PostListDtoWithMyComment {

	private int no;
	private String title;
	private String commentContent;
	private LocalDateTime commentCreatedDateTime;
	private String commentCreatedDateTimeToString;
	
	public PostListDtoWithMyComment(int no, String title, String commentContent, LocalDateTime commentCreatedDateTime) {
		this.no = no;
		this.title = title;
		this.commentContent = commentContent;
		this.commentCreatedDateTime = commentCreatedDateTime;
		this.commentCreatedDateTimeToString = DateTimeToString.LocalDateTimeToString(commentCreatedDateTime);
	}
}
