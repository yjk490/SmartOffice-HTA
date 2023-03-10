package com.example.web.request;

import java.util.List;
import java.util.Map;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PostModifyForm {

	private int no;
	private int employeeNo;
	private String title;
	private String content;
	private List<String> deleteTagContents;
	private List<String> tagContents;
	private List<String> deleteFileNames;
	private Map<String, String> fileNamesMap;
}
