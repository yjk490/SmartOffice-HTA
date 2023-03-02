package com.example.dto.contact;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("ContactTagDto")
public class ContactTagDto {
	
	private int contactNo;
	private int addressbookNo;
	private String addressbookName;
	
	public ContactTagDto() {
		super();
		// TODO Auto-generated constructor stub
	}

	
}
