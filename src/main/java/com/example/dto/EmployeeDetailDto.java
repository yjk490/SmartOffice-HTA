package com.example.dto;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import com.example.vo.EmployeeRole;
import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;

@Alias("EmployeeDetailDto")
@Getter
@Setter
public class EmployeeDetailDto {
	
	private int no;
	private String name;
	private String email;
	private String tel;
	private String photo;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date hireDate;
	private String status;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date createdDate;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date updatedDate;
	private int deptNo;
	private String deptName;
	private int positionNo;
	private String positionName;
	private List<EmployeeRole> empRoles;
	
	public EmployeeDetailDto() {}
}
