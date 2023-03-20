package com.example.web.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CommentSearchOption {

	private int rows = 10;
	private String keyword = "";
	private int employeeNo = 0;
}
