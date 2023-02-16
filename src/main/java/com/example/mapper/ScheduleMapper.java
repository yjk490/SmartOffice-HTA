package com.example.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.example.vo.schedule.AttachedFile;
import com.example.vo.schedule.Schedule;

@Mapper
public interface ScheduleMapper {
	void insertSchedule(Schedule schedule);

	void insertScheduleAttachedFile(AttachedFile attachedFile);

	void insertAttendant(int no, int attendantEmployeeNo);
	

}
