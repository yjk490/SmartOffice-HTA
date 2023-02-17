package com.example.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dto.note.NoteListDto;
import com.example.mapper.NoteMapper;
import com.example.utils.Pagination;
import com.example.vo.note.Note;
import com.example.vo.note.NoteAttachedFile;
import com.example.vo.note.NoteReceiver;
import com.example.web.request.NoteRegisterForm;

@Service
@Transactional
public class NoteService {
	
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
	
	public Map<String, Object> getRecieveNotes(Map<String, Object> param){
		int totalRows = noteMapper.getRecieveTotalRows(param);
		int page = (Integer)param.get("page");
		int rows = (Integer)param.get("rows");
		int no = (Integer)param.get("no");
		Pagination pagination = new Pagination(page,totalRows, rows);
		
		param.put("begin", pagination.getBegin());
		param.put("end", pagination.getEnd());
		
		List<NoteListDto> notes = noteMapper.getRecieveNotesByNo(param);
		
		Map<String, Object> result = new HashMap<>();
		result.put("notes", notes);
		result.put("pagination", pagination);
		result.put("no", no);
		
		return result;
		
	}

	public void deleteNotes(List<Integer> noteNos) {
		for(int noteNo : noteNos) { 
			Note note = noteMapper.getNoteByNo(noteNo);
			note.setBoxNo(10006);
			note.setDeleted("D");
			
			// 설정 값을 update에 입력한다.
			noteMapper.updateNote(note);
		}
		
	}

	public void saveNotes(List<Integer> noteNos) {
		for(int noteNo : noteNos) { 
			Note note = noteMapper.getNoteByNo(noteNo);
			note.setBoxNo(10004);
			
			// 설정 값을 update에 입력한다.
			noteMapper.updateNote(note);
		}
		
	}

}
