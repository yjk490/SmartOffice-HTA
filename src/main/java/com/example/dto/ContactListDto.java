package com.example.dto;

import org.apache.ibatis.type.Alias;

@Alias("ContactListDto")
public class ContactListDto {
	
	private int contactNo;
	private String name;
	private String contactTel;
	private String email;
	private int addressbookNo;
	private String addressbookName;
	
	
	public int getContactNo() {
		return contactNo;
	}
	public void setContactNo(int contactNo) {
		this.contactNo = contactNo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContactTel() {
		return contactTel;
	}
	public void setContactTel(String contactTel) {
		this.contactTel = contactTel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getaddressbookNo() {
		return addressbookNo;
	}
	public void setaddressbookNo(int addressbookNo) {
		this.addressbookNo = addressbookNo;
	}
	public String getaddressbookName() {
		return addressbookName;
	}
	public void setaddressbookName(String addressbookName) {
		this.addressbookName = addressbookName;
	}
	
	

}
