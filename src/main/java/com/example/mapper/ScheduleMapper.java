package com.example.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.dto.schedule.ScheduleDetailDto;
import com.example.dto.schedule.ScheduleEvent;
import com.example.vo.schedule.AttachedFile;
import com.example.vo.schedule.MeetingRoom;
import com.example.vo.schedule.Schedule;

@Mapper
public interface ScheduleMapper {
	void insertSchedule(Schedule schedule);

	void insertScheduleAttachedFile(AttachedFile attachedFile);

	void insertAttendant(int no, int attendantEmployeeNo);

	void insertMeetingReservation(MeetingRoom meetingRoom);

	List<ScheduleEvent> getSchedules(Map<String, Object> param);

	Schedule getScheduleByNo(int scheduleNo);

	void updateScheduleByNo(Schedule schedule);

	int countMeetingRoomByScheduleNo(int no);

	void deleteMeetingReservationByNo(int no);

	int countAttendantsByNo(int no);

	void insertSchedules(Schedule schedules);

	List<Map<String, Object>> getAllSchedulesForMap(int empNo);

	List<Schedule> getAllScheduleOnly(int empNo);
	
	
	
}
