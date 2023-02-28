	package com.example.web.request;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Null;

import org.springframework.boot.context.properties.bind.DefaultValue;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.lang.Nullable;
import org.springframework.web.multipart.MultipartFile;

import com.example.vo.schedule.MeetingRoom;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ScheduleModifyForm {
	
	private int no;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDate;
	private String startTime;
	private String endTime;
	private String allDay;
	@NotBlank(message = "분류는 필수값입니다." )
	private int categoryNo;
	private String content;
	private String title;
	private String location;
	
	//값을 안넘기니까 오류남.왜? ""값이 넘어가서그런거였음.
	private int roomNo;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date reservationDate;
	private List<String> reservationTime;
	
	//private List<Integer> attendants;
	
	private MultipartFile upfile;
	private String filename;
}
