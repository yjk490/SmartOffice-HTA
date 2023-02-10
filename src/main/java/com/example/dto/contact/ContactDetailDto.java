package com.example.dto.contact;

import java.util.Date;

import org.apache.ibatis.type.Alias;

@Alias("ContactDetailDto")
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
	private Date createdDate;
	private Date updatedDate;
	
	//태그 정보
	private int addressbookNo;
	private String addressbookName;
	
	//전화번호 정보
	private String contactTel;
	
	
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getBirth() {
		return birth;
	}
	public void setBirth(Date birth) {
		this.birth = birth;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getmemo() {
		return memo;
	}
	public void setmemo(String memo) {
		this.memo = memo;
	}
	public Date getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	public Date getUpdatedDate() {
		return updatedDate;
	}
	public void setUpdatedDate(Date updatedDate) {
		this.updatedDate = updatedDate;
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
	public String getContactTel() {
		return contactTel;
	}
	public void setContactTel(String contactTel) {
		this.contactTel = contactTel;
	}

}
