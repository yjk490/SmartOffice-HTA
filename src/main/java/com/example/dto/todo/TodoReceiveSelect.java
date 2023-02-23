package com.example.dto.todo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("TodoReceiveSelect")
@Getter
@Setter
public class TodoReceiveSelect {

	private int employeeNo;
	private String employeeName;
	private int positionNo;
	private String positionName;
}
