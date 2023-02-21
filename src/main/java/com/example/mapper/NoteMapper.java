package com.example.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.dto.note.NoteDetailDto;
import com.example.dto.note.NoteListDto;
import com.example.vo.note.Note;
import com.example.vo.note.NoteAttachedFile;
import com.example.vo.note.NoteReceiver;

@Mapper
public interface NoteMapper {
	
	// 받은 쪽지의 갯수
	int getRecieveTotalRows(Map<String, Object> param);
	// 보낸 쪽지의 갯수
	int getSendTotalRows(Map<String, Object> param);
	// 쪽지 보관함의 쪽지 갯수
	int getSaveTotalRows(Map<String, Object> param);
	// 임시 보관함의 쪽지 갯수
	int getDraftTotalRows(Map<String, Object> param);
	// 중요 쪽지함의 쪽지 갯수
	int getImportantTotalRows(Map<String, Object> param);
	// 휴지통의 쪽지의 갯수
	int getWaggerTotalRows(Map<String, Object> param);
	
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
	
	
	// 받은 쪽지함 리스트 
	List<NoteListDto> getRecieveNotesByNo(Map<String, Object> param);
	// 보낸 쪽지함 리스트 
	List<NoteListDto> getSendNotesByNo(Map<String, Object> param);
	// 쪽지 보관함 리스트 
	List<NoteListDto> getSaveNotesByNo(Map<String, Object> param);
	// 임시 보관함의 리스트
	List<NoteListDto> getDraftNotesByNo(Map<String, Object> param);
	// 중요 쪽지함의 리스트
	List<NoteListDto> getImportantNotesByNo(Map<String, Object> param);
	// 휴지통의 리스트
	List<NoteListDto> getWaggerNotesByNo(Map<String, Object> param);
	
	// 쪽지 번호로 쪽지 상세정보를 가져온다.
	NoteDetailDto getNoteDetailByNo(int noteNo);
	// 쪽지 번호로 쪽지에 저장된 첨부파일 정보를 가져온다.
	List<NoteAttachedFile> getAttachedFilesByNoteNo(int noteNo);




}
