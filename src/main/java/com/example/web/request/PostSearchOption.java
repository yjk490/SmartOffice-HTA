package com.example.web.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PostSearchOption {

	private int rows;
	private String sort;
	private String type;
	private String keyword;
}
