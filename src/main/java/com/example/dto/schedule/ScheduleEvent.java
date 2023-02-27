package com.example.dto.schedule;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import com.example.utils.DateUtils;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Setter;


@Setter
@Alias("ScheduleEvent")
public class ScheduleEvent {

	private int no;		//dd
	@DateTimeFormat(pattern = "yyyy-MM-dd")	//dd
	private Date startDate;					//dd
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDate;					//dd
	private String startTime;
	private String endTime;
	private String allDay;
	private String title;
	private int categoryNo;
	private String content;
	private String location;
	private int employeeNo;
	//회의실
	private int roomNo;
	private Date reservationDate;
	private String reservationTime;
	//참석자
	private String employeesNo;
	private String employees;
	//첨부파일
	private String filename;
	
	
	
	public String getId() {
		return String.valueOf(no);
	}
	
	public boolean getAllDay() {
		return "Y".equals(allDay);
	}
	
	public Date getStart() {
		return DateUtils.dateToDate(startDate, startTime);
	}
	
	public Date getEnd() {
		return DateUtils.dateToDate(endDate, endTime);
	}
	
	public String getTitle() {
		return title;
	}
	
	public String getGroupId() {
		return String.valueOf(categoryNo);
	}
	
	//카테고리별로 색깔 다르게하기
	public String getBackgroundColor() {
		if(categoryNo == 1) {		//업무
			return "blue";
		} else if(categoryNo == 2) {	//중요
			return "red";
		} else if(categoryNo == 3) {		//출장
			return "green";
		} else if(categoryNo == 4) {		//개인일정
			return "black";
		} else if(categoryNo == 5) {		//휴가
			return "orange";
		} else {
			return "yellow";				//지금은 없지만 나머지
		}	
	}
	
	public String getContent() {
		return content;
	}
	//회의실
	
	public int getRoomNo() {
		return roomNo;
	}
	
	
	public Date getReservationDate() {
		
		return reservationDate;
	}
	
	
	public String[] getReservationTime(){
		if(reservationTime != null) {
			String[] reservationTimes = reservationTime.split(",");
			return reservationTimes;
		}else {
			String[] times = {reservationTime};
			return times;
		}
	}
	
	//참가자
	public String[] getEmployeeNames() {
		if(employees != null) {
			String[] employeeNames = employees.split(",");
			return employeeNames;
		}else {
			String[] emps = {employees};
			return emps;
		}
		
	}
	
	public String[] getEmployeesNos() {
		if(employeesNo != null) {
			String[] employeesNos = employeesNo.split(",");
			return employeesNos;
		}else {
			String[] emps = {employeesNo};
			return emps;
		}
	}
	
	//첨부파일
	
	public String getFilename() {
		return filename;
	}

}
