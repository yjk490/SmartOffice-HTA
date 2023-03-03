package com.example.vo.todo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("AttachedFileTodo")
@Getter
@Setter
public class AttachedFileTodo {

	private int no;
	private String filename;
}
