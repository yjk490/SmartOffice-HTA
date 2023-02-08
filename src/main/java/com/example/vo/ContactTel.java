package com.example.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("ContactTel")
@Getter
@Setter
public class ContactTel {
	
	private int contactNo;
	private String contactTel;

}
