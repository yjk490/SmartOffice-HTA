package com.example.dto.post;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
public class CommentListDto {

	private int no;
	private int employeeNo;
	private String name;
	private String content;
	private int recommendCount;
	private LocalDateTime createdDateTime;
	private String createdDateTimeToString;
	private boolean recommended;
	
	public CommentListDto(int no, int employeeNo, String name, String content, int recommendCount, LocalDateTime createdDateTime,
			boolean recommended) {
		this.no = no;
		this.employeeNo = employeeNo;
		this.name = name;
		this.content = content;
		this.recommendCount = recommendCount;
		this.createdDateTime = createdDateTime;
		this.recommended = recommended;
		
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
