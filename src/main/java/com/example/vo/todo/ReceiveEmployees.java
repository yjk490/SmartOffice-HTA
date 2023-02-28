package com.example.vo.todo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("ReceiveEmployees")
@Getter
@Setter
public class ReceiveEmployees {

	private int progressNo;
	private int todoNo;
	private int empNo;
	private int receiveEmpNo;
	private String receiveEmpName;
	private String positionName;
	private Date progressUpdatedDate;
	private int progressRate;
	private String progressContent; 
}
