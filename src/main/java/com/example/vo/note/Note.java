package com.example.vo.note;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("Note")
@Getter
@Setter
public class Note {
	
	private int noteNo;
	private String important;
	private String title;
	private int senderNo;
	private String content;
	private Date sendDate;
	private Date readDate;
	private String status;
	private String deleted;
	private Date createdDate;
	private Date updatedDate;
	private int boxNo;

}
