package com.example.vo.schedule;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("Attendant")
public class Attendant {
	private int scheduleNo;
	private int attendantEmployeeNo;
}
