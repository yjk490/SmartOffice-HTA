package com.example.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("Addressbook")
@Getter
@Setter
public class Addressbook {
	
	private int addressbookNo;
	private String type;
	private String addressname;
	private String deleted;
	private Date createdDate;
	private Date updatedDate;
	private int empNo;

}
