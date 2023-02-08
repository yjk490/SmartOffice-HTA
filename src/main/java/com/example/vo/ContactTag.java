package com.example.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("ContactTag")
@Getter
@Setter
public class ContactTag {
	
	private int addressbookNo;
	private int contactNo;

}
