package com.example.vo.schedule;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Alias("Schedule")
public class Schedule {

	private int no;
	private Date startDate;
	private Date endDate;
	private String startTime;
	private String endTime;
	private String allDay;
	private String title;
	private String content;
	private String location;
	private Date createdDate;
	private Date updatedDate;
	private int categoryNo;
	private int employeeNo;
}
