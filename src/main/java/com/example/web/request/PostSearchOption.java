package com.example.web.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PostSearchOption {

	private int rows = 10;
	private String sort = "date";
	private String type = "title";
	private String keyword = "";
}
