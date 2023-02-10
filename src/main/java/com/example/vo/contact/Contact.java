package com.example.vo.contact;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("Contact")
@Getter
@Setter
public class Contact {
	
	private int contactNo;
	private String name;
	private String share;
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

}
