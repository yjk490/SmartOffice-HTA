package com.example.web.request;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ContactModifyForm {
	
	private int contactNo;
	private String name;
	private String email;
	private Date birth;
	private String company;
	private String dept;
	private String position;
	private String address;
	private String photo;
	private String url;
	private String memo;
	private Date createdDate;
	private Date updatedDate;
	
	private List<String> contactTels;
	
	private List<String> contactTags;

}
