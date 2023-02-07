package com.example.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("Employee")
@Getter
@Setter
public class Employee {
	
	private int no;
	private String encryptPassword;
	private String name;
	private String tel;
	private String email;
	private String photo;
	private Date hireDate;
	private String status;
	private Date createdDate;
	private Date updatedDate;
	private int deptNo;
	private int positionNo;

}
