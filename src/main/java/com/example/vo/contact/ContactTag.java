package com.example.vo.contact;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("ContactTag")
@Getter
@Setter
public class ContactTag {
	
	private int addressbookNo;
	private int contactNo;
	
	public ContactTag(int addressbookNo, int contactNo) {
		
	}

}
