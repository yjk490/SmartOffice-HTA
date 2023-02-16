package com.example.web.request;

import java.util.Date;
import java.util.List;

import org.springframework.boot.context.properties.bind.DefaultValue;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import com.example.vo.schedule.MeetingRoom;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ScheduleRegisterForm {
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDate;
	private String startTime;
	private String endTime;
	private String allDay;
	private int categoryNo;
	private String title;
	private MeetingRoom meetingRoom;	//타입 이렇게 하면 받아지나? MeetingRoom으로 받고 ScheduleRegisterForm.meetingRoom으로 들어오나?
	private String location;
	private List<Integer> attendants;
	private String content;
	private MultipartFile upfile;
	private String filename;
}
