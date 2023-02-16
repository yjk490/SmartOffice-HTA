package com.example.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.example.vo.note.Note;
import com.example.vo.note.NoteAttachedFile;
import com.example.vo.note.NoteReceiver;

@Mapper
public interface NoteMapper {
	
	// 쪽지 등록
	void insertNote(Note note);
	// 쪽지의 첨부 파일 등록
	void insertNoteAttachedFile(NoteAttachedFile noteAttachedFile);
	// 쪽지의 수신자 아이디 등록
	void insertNoteReceiver(NoteReceiver noteReceiver);

}
