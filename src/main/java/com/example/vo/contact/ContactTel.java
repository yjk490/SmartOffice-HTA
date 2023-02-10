package com.example.vo.contact;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("ContactTel")
@Getter
@Setter
public class ContactTel {
	
	private int contactNo;
	private String contactTel;
	
	public ContactTel(int contactNo, String contactTel) {
		
	}

}
