package com.example.security;

public class LoginEmployee {
	
	private int no;
	private String encryptPassword;
	private String name;
	
	public LoginEmployee(int no, String encryptPassword, String name) {
		this.no = no;
		this.encryptPassword = encryptPassword;
		this.name = name;
	}
	

	public int getNo() {
		return no;
	}

	public String getEncryptPassword() {
		return encryptPassword;
	}

	public String getName() {
		return name;
	}

}
