package com.example.vo.note;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("NoteAttachedFile")
@Getter
@Setter
public class NoteAttachedFile {
	
	private int noteNo;
	private String filename;

}
