package com.example.service;

import java.util.List;

import org.springframework.beans.BeanUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.mapper.EmployeeMapper;
import com.example.mapper.NoteMapper;
import com.example.vo.note.Note;
import com.example.vo.note.NoteAttachedFile;
import com.example.vo.note.NoteReceiver;
import com.example.web.request.NoteRegisterForm;

@Service
@Transactional
public class NoteService {
	
	@Autowired
	private EmployeeMapper employeeMapper;
	@Autowired
	private NoteMapper noteMapper;
	
	// 쪽지 보내기 구현
	public void insertNote(int empNo, NoteRegisterForm form) {
		Note note = new Note();
		note.setSenderNo(empNo);
		
		BeanUtils.copyProperties(form, note);
		noteMapper.insertNote(note);
		
		if(form.getFilename() != null) {
			NoteAttachedFile noteAttachedFile  = new NoteAttachedFile();
			noteAttachedFile.setNoteNo(note.getNoteNo());
			noteAttachedFile.setFilename(form.getFilename());
			
			noteMapper.insertNoteAttachedFile(noteAttachedFile);
		}
		
		if(form.getReceiversNo() != null) {
			List<Integer> receiversNo = form.getReceiversNo();
			for(int receiverNo : receiversNo) {
				NoteReceiver noteReceiver = new NoteReceiver(note.getNoteNo(), receiverNo);
				noteMapper.insertNoteReceiver(noteReceiver);
			}
		}
		
	}

}
