package com.example.vo.todo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("TodoEmployees")
@Getter
@Setter
public class TodoEmployees {

	private int todoNo;
	private int empNo;
}
