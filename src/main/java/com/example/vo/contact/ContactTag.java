package com.example.vo.contact;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Alias("ContactTag")
@Getter
@Setter
@ToString
public class ContactTag {
	
	private int addressbookNo;
	private int contactNo;
}
