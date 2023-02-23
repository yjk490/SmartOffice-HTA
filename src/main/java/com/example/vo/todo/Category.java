package com.example.vo.todo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("category")
@Getter
@Setter
public class Category {

	private int no;
	private String name;
	
}
