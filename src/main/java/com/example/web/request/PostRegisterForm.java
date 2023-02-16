package com.example.web.request;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PostRegisterForm {

	private String title;
	private String content;
	private List<String> tags;
	private List<String> savedFilenames;
}
