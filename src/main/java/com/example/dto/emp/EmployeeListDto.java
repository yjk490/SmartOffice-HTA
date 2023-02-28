package com.example.dto.emp;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("EmployeeListDto")
@Setter
@Getter
public class EmployeeListDto {
	
	private int empNo;
	private String empName;
	private String tel;
	private String email;
	private String deptName;
	private String status;

}
