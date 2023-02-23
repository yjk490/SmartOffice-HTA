package com.example.dto.post;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;


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
	private LocalDateTime createdDateTime;
	private String createdDateTimeToString;
	
	public PostListDto(int no, String name, String title, int readCount, int commentCount, int recommendCount,
			LocalDateTime createdDateTime) {
		this.no = no;
		this.name = name;
		this.title = title;
		this.readCount = readCount;
		this.commentCount = commentCount;
		this.recommendCount = recommendCount;
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
