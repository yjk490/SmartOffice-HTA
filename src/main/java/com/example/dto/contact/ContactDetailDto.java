package com.example.dto.contact;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;

@Alias("ContactDetailDto")
@Getter
@Setter
public class ContactDetailDto {
	
	//연락처 정보
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
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date createdDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date updatedDate;
	
	//태그 정보
	private List<String> contactTags;
	
	//전화번호 정보
	private List<String> contactTels;

}
