package com.example.dto.post;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

import com.example.utils.DateTimeToString;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PostListDto {

	private int no;
	private String name;
	private String title;
	private String content;
	private int readCount;
	private int commentCount;
	private int recommendCount;
	private LocalDateTime createdDateTime;
	private String createdDateTimeToString;
	private boolean hasAttachedFile;
	
	public PostListDto(int no, String name, String title, String content, int readCount, int commentCount, int recommendCount,
			LocalDateTime createdDateTime, boolean hasAttachedFile) {
		this.no = no;
		this.name = name;
		this.title = title;
		this.content = content;
		this.readCount = readCount;
		this.commentCount = commentCount;
		this.recommendCount = recommendCount;
		this.createdDateTime = createdDateTime;
		this.createdDateTimeToString = DateTimeToString.LocalDateTimeToString(createdDateTime);
		this.hasAttachedFile = hasAttachedFile;
	}
}
