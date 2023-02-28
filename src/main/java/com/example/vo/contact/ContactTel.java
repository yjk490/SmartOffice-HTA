package com.example.vo.contact;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Alias("ContactTel")
@Getter
@Setter
@ToString
public class ContactTel {
	
	private int contactNo;
	private String contactTel;

}
