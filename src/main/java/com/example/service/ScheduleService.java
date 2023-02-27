package com.example.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dto.schedule.ScheduleDetailDto;
import com.example.dto.schedule.ScheduleEvent;
import com.example.mapper.ScheduleMapper;
import com.example.vo.schedule.AttachedFile;
import com.example.vo.schedule.MeetingRoom;
import com.example.vo.schedule.Schedule;
import com.example.web.request.ScheduleModifyForm;
import com.example.web.request.ScheduleRegisterForm;

@Service
public class ScheduleService {
	
	@Autowired
	private ScheduleMapper scheduleMapper;
	
	@Transactional
	public void registerSchedule(int employeeNo, ScheduleRegisterForm form) {
		//Schedule정보 저장(employee_schedules테이블에)
		Schedule schedule = new Schedule();
		
		if(form.getAllDay() == null) {				
			form.setAllDay("N");
		}
		
		schedule.setEmployeeNo(employeeNo);
		BeanUtils.copyProperties(form, schedule);
		
		scheduleMapper.insertSchedule(schedule);
		
		//첨부파일정보 저장.(schedule_attached_files테이블에)
		if(form.getFilename() != null) {
			AttachedFile attachedFile = new AttachedFile();
			attachedFile.setScheduleNo(schedule.getNo());
			attachedFile.setFilename(form.getFilename());
			
			scheduleMapper.insertScheduleAttachedFile(attachedFile);
		}
		
		//참석자 attendants들 태그로 해서 저장(schedule_attendants테이블에)	
		if(form.getAttendants() != null) {
			List<Integer> attendantTags = form.getAttendants();
			
			for(int attendantEmployeeNo : attendantTags) {
				scheduleMapper.insertAttendant(schedule.getNo(),attendantEmployeeNo);
			}
		}
		
		//회의실예약 MeetingRoom객체로 받아서 저장(MeetingReservation테이블에)
		MeetingRoom meetingRoom = new MeetingRoom();
		
		//roomNo, 예약일, 예약시간 중 하나라도 안고르면 안들어가게
		if(form.getRoomNo() == 0 || form.getReservationDate() == null || form.getReservationTime().size() == 0) {
			return;
		}else {			
			meetingRoom.setRoomNo(form.getRoomNo());
			meetingRoom.setReservationDate(form.getReservationDate());
			meetingRoom.setScheduleNo(schedule.getNo());
			
			if(meetingRoom != null) {
				//scheduleNo는 없으니까 따로 넣어주기.(for문으로)
				for(String time : form.getReservationTime()) {
					meetingRoom.setReservationTime(time);
					
					scheduleMapper.insertMeetingReservation(meetingRoom);
				}
			}
		}
	}
	
	//날짜범위에 맞는 일정 가져오기(로그인유저에 해당하는)
	public List<ScheduleEvent> getEvents(Map<String, Object> param) {
		List<ScheduleEvent> schedules = scheduleMapper.getSchedules(param);
		
		/*List<ScheduleEvent> events = new ArrayList<>();
		for (Schedule s : schedules) {
			ScheduleEvent event = new ScheduleEvent();
			event.setSchedule(s);
			events.add(event);
		}*/
		
		return schedules;
	}


	@Transactional
	public void modifySchedule(int no, ScheduleModifyForm form) {
		//employee_schedules에 넣기.
		Schedule schedule = scheduleMapper.getScheduleByNo(form.getNo());
		BeanUtils.copyProperties(form, schedule);
		
		scheduleMapper.updateScheduleByNo(schedule);
		
		//MeetingRoom에 넣기.
		if(form.getRoomNo() == 0 || form.getReservationDate() == null || form.getReservationTime().size() == 0) {
			return;
			
		//입력된 값이 있을 때 기존에 저장된 게 있는 경우.
		}else if(scheduleMapper.countMeetingRoomByScheduleNo(schedule.getNo()) >= 1) {
			scheduleMapper.deleteMeetingReservationByNo(form.getNo());
			
			MeetingRoom meetingRoom = new MeetingRoom();
			meetingRoom.setRoomNo(form.getRoomNo());
			meetingRoom.setReservationDate(form.getReservationDate());
			meetingRoom.setScheduleNo(schedule.getNo());
			
			if(meetingRoom != null) {
				//scheduleNo는 없으니까 따로 넣어주기.(for문으로)
				for(String time : form.getReservationTime()) {
					meetingRoom.setReservationTime(time);
					
					scheduleMapper.insertMeetingReservation(meetingRoom);
				}
			}
		//나머지경우.(입력된 값이 있는데 기존에 저장된게 없는 경우)
		}else {
			MeetingRoom meetingRoom = new MeetingRoom();
			meetingRoom.setRoomNo(form.getRoomNo());
			meetingRoom.setReservationDate(form.getReservationDate());
			meetingRoom.setScheduleNo(schedule.getNo());
			
			for(String time : form.getReservationTime()) {
				meetingRoom.setReservationTime(time);
				
				scheduleMapper.insertMeetingReservation(meetingRoom);
			}
			
		}
		
		//해당 일정에 회의실예약이 있는지 먼저 체크하기.
		
		
		//참석자 넣기.
		
		//있는지 세기.
		/*
		 * int countAttendants = scheduleMapper.countAttendantsByNo(schedule.getNo());
		if(countAttendants >= 1) {
			
		}
		
		if(form.getAttendants() != null) {
			List<Integer> attendantTags = form.getAttendants();
			
			for(int attendantEmployeeNo : attendantTags) {
				scheduleMapper.insertAttendant(schedule.getNo(),attendantEmployeeNo);
			}
		}
		*/
		
		
	}
	
}
