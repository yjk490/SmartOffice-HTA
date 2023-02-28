package com.example.web.request;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NoteRegisterForm {
	
	private String important;
	private String title;
	private List<Integer> receiversNo;
	private String content;
	private String filename;
	private MultipartFile upfile;
	private int boxNo;
	
	

}
