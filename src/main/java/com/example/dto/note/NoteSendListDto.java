package com.example.dto.note;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import com.example.vo.employee.Employee;

import lombok.Getter;
import lombok.Setter;

@Alias("NoteSendListDto")
@Getter
@Setter
public class NoteSendListDto {
	
	private int noteNo;
	private String important;
	private String title;
	// 수신자 리스트를 담는 객체
	private List<Employee> employees;
	private Date sendDate;
	private String status;

}
