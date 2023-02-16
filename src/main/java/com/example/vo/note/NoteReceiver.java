package com.example.vo.note;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Alias("NoteReceiver")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class NoteReceiver {
	
	private int noteNo;
	private int receiverNo;

}
