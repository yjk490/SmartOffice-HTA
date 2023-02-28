package com.example.vo.schedule;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("ScheduleAttachedFile")
@Getter
@Setter
public class AttachedFile {

	private int scheduleNo;
	private String filename;
}
