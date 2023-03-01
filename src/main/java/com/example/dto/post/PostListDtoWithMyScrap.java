package com.example.dto.post;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

import com.example.utils.DateTimeToString;

import lombok.Getter;

@Getter
public class PostListDtoWithMyScrap {

	private int no;
	private String title;
	private String content;
	private LocalDateTime scrapCreatedDateTime;
	private String scrapCreatedDateTimeToString;
	
	public PostListDtoWithMyScrap(int no, String title, String content, LocalDateTime scrapCreatedDateTime) {
		super();
		this.no = no;
		this.title = title;
		this.content = content;
		this.scrapCreatedDateTime = scrapCreatedDateTime;
		this.scrapCreatedDateTimeToString = DateTimeToString.LocalDateTimeToString(scrapCreatedDateTime);
	}
}
