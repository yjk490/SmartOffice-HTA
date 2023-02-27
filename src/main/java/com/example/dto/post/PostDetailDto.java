package com.example.dto.post;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Map;


import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PostDetailDto {

	private int no;
	private int employeeNo;
	private String name;
	private String title;
	private String content;
	private int readCount;
	private int recommendCount;
	private int scrapCount;
	private LocalDateTime createdDateTime;
	private String createdDateTimeToString;
	private Map<String, String> fileNamesMap;
	private List<String> tagContents;
	private boolean scrapped;
	private boolean recommended;
	
	public PostDetailDto(int no, int employeeNo, String name, String title, String content, int readCount,
			int recommendCount, int scrapCount, LocalDateTime createdDateTime) {
		this.no = no;
		this.employeeNo = employeeNo;
		this.name = name;
		this.title = title;
		this.content = content;
		this.readCount = readCount;
		this.recommendCount = recommendCount;
		this.scrapCount = scrapCount;
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
