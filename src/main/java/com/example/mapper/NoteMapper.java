package com.example.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import com.example.dto.note.NoteListDto;
import com.example.vo.note.Note;
import com.example.vo.note.NoteAttachedFile;
import com.example.vo.note.NoteReceiver;

@Mapper
public interface NoteMapper {
	
	// 받은 쪽지의 갯수
	int getRecieveTotalRows(Map<String, Object> param);
	
	// 쪽지 등록
	void insertNote(Note note);
	// 쪽지 업데이트 하기
	void updateNote(Note note);
	// 쪽지의 첨부 파일 등록
	void insertNoteAttachedFile(NoteAttachedFile noteAttachedFile);
	// 쪽지의 수신자 아이디 등록
	void insertNoteReceiver(NoteReceiver noteReceiver);
	// 쪽지 번호로 쪽지 정보를 가져오기
	Note getNoteByNo(int noteNo);
	
	
	// 쪽지함 리스트 구현
	List<NoteListDto> getRecieveNotesByNo(Map<String, Object> param);




}
