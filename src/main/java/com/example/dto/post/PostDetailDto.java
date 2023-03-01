package com.example.dto.post;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Map;

import com.example.utils.DateTimeToString;

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
	private String deleted;
	private String createdDateTimeToString;
	private Map<String, String> fileNamesMap;
	private List<String> tagContents;
	private boolean scrapped;
	private boolean recommended;
	
	public PostDetailDto(int no, int employeeNo, String name, String title, String content, int readCount,
			int recommendCount, int scrapCount, LocalDateTime createdDateTime, String deleted) {
		this.no = no;
		this.employeeNo = employeeNo;
		this.name = name;
		this.title = title;
		this.content = content;
		this.readCount = readCount;
		this.recommendCount = recommendCount;
		this.scrapCount = scrapCount;
		this.createdDateTime = createdDateTime;
		this.deleted = deleted;
		this.createdDateTimeToString = DateTimeToString.LocalDateTimeToString(createdDateTime);
	}
	
	
}
