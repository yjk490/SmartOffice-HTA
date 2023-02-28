package com.example.dto.note;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import com.example.vo.employee.Employee;
import com.example.vo.note.NoteAttachedFile;

import lombok.Getter;
import lombok.Setter;

@Alias("NoteDetailDto")
@Getter
@Setter
public class NoteDetailDto {
	
	private int noteNo;
	private String title;
	private String important;
	private String senderName;
	// 수신자 리스트를 담는 객체
	private List<Employee> employees;
	private Date sendDate;
	private Date readDate;
	private String status;
	private String content;
	private List<NoteAttachedFile> attachedFiles;

}
