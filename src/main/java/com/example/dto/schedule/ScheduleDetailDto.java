package com.example.dto.schedule;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import com.example.vo.schedule.AttachedFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Alias("ScheduleDto")
public class ScheduleDetailDto {

	private int no;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
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
	
	private int roomNo;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date reservationDate;
	private List<String> reservationTime;
	
	private List<Integer> attendantEmployeeNo; //이거 타입 뭘로할지??
	
	private String filename;
	
	
}
