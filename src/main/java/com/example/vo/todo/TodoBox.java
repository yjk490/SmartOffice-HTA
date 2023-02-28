package com.example.vo.todo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("TodoBox")
@Getter
@Setter
public class TodoBox {

	private String boxNo;
	private String boxName;
	private int empNo;
	private int parentBoxNo;
}
