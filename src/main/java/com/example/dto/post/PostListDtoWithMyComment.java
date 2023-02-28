package com.example.dto.post;

import java.time.LocalDateTime;

import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

import lombok.Getter;

@Getter
public class PostListDtoWithMyComment {

	private int no;
	private String title;
	private String comment;
	private LocalDateTime createdDateTime;
	private String createdDateTimeToString;
	
	public PostListDtoWithMyComment(int no, String title, String comment, LocalDateTime createdDateTime) {
		this.no = no;
		this.title = title;
		this.comment = comment;
		this.createdDateTime = createdDateTime;
		
		LocalDateTime now = LocalDateTime.now();
		long diffHours = ChronoUnit.HOURS.between(this.createdDateTime, now);
		long diffMinutes = ChronoUnit.MINUTES.between(this.createdDateTime, now);
		if (diffMinutes == 0) {
			this.createdDateTimeToString = "방금 전";
		} else if (diffMinutes < 60)	{
			this.createdDateTimeToString = diffMinutes + "분 전";
		} else if (diffHours < 12) {
			this.createdDateTimeToString = "약 " + diffHours + "시간 전";
		} else {
			String date = this.createdDateTime.format(DateTimeFormatter.ofPattern("yyyy. MM. dd."));
			this.createdDateTimeToString = date;
		}
	}
}
