package com.example.vo.post;


import lombok.AllArgsConstructor;
import lombok.Getter;

// 첨부파일 번호는 DB에 저장될 때 시퀀스를 통해 생성되기 때문에 생성자의 매개변수에 포함시키지 않았음.
@AllArgsConstructor
@Getter
public class AttachedFile {

	private int postNo;
	private String savedName;
	private String originalName;
	
}
