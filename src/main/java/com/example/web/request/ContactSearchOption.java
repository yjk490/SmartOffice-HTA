package com.example.web.request;

import com.example.utils.Pagination;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ContactSearchOption {
	
	private String type="public";
	private String keyword = "";
	private int rows = 10;
	private String sort = "name";
	private String initial = "ALL";
	private String tag = "";
	
}
