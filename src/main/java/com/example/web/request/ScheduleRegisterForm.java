	package com.example.web.request;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotBlank;

import org.springframework.boot.context.properties.bind.DefaultValue;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import com.example.vo.schedule.MeetingRoom;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ScheduleRegisterForm {
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDate;
	private String startTime;
	private String endTime;
	private String allDay;
	@NotBlank(message = "분류는 필수값입니다." )
	private int categoryNo;
	private String title;
	
	private MeetingRoom meetingRoom;	//하나하나씩 받기.
	
	private String location;
	private List<Integer> attendants;
	private String content;
	private MultipartFile upfile;
	private String filename;
}
