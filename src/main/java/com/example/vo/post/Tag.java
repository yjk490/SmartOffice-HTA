package com.example.vo.post;

import lombok.AllArgsConstructor;
import lombok.Getter;

// Tag는 영구 삭제될 뿐(DB에서 완전 삭제) 수정되지 않기 때문에 Setter메서드를 만들지 않고 생성자를 통해 생성해서 값을 바꿀 수 없게 함.
@AllArgsConstructor
@Getter
public class Tag {
	
	private int postNo;
	private String content;
	
}
