package com.example.web.request;

import java.util.List;
import java.util.Map;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PostRegisterForm {

	private String title;
	private String content;
	private List<String> tagContents;
	private Map<String, String> fileNamesMap;
	
}
