package com.example.vo.employee;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Alias("EmployeeRole")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class EmployeeRole {
	
	private int empNo;
	private String roleName;

}
