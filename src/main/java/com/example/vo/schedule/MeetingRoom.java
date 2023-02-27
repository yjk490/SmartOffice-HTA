package com.example.vo.schedule;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("MeetingRoom")
public class MeetingRoom {
	private int roomNo;
	private int scheduleNo;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date reservationDate;
	private String reservationTime;
	
}
