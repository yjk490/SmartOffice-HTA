package com.example.dto.contact;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("ContactListDto")
public class ContactListDto {
	
	private int contactNo;
	private String name;
	private List<String> contactTel;
	private String email;
	private Date createdDate;
	private List<Integer> addressbookNo;
	private List<String> addressbookName;
	
}
