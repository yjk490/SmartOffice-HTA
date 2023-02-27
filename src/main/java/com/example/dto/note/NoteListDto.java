package com.example.dto.note;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("NoteListDto")
@Getter
@Setter
public class NoteListDto {
	
	private int noteNo;
	private String important;
	private String title;
	private String senderName;
	private Date sendDate;
	private String status;

}
