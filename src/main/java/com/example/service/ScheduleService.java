package com.example.service;

import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.mapper.ScheduleMapper;
import com.example.vo.schedule.AttachedFile;
import com.example.vo.schedule.Schedule;
import com.example.web.request.ScheduleRegisterForm;

@Service
public class ScheduleService {
	
	@Autowired
	private ScheduleMapper scheduleMapper;
	
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
		
	}

	
}
