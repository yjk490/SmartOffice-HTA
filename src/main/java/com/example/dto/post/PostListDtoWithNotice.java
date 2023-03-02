package com.example.dto.post;

import java.time.LocalDateTime;

import com.example.utils.DateTimeToString;

import lombok.Getter;

@Getter
public class PostListDtoWithNotice {

	private String employeeName;
	private String content;
	private String type;
	private int postNo;
	private LocalDateTime noticeCreatedDateTime;
	private String noticeCreatedDateTimeToString;
	
	public PostListDtoWithNotice(String employeeName, String content, String type, int postNo,
			LocalDateTime noticeCreatedDateTime) {
		this.employeeName = employeeName;
		this.content = content;
		this.type = type;
		this.postNo = postNo;
		this.noticeCreatedDateTime = noticeCreatedDateTime;
		this.noticeCreatedDateTimeToString = DateTimeToString.LocalDateTimeToString(noticeCreatedDateTime);
	}
	
	
}
