package com.example.vo.post;

import java.util.Date;

import lombok.Builder;
import lombok.Getter;

@Getter
public class Comment {

	private int no;
	private int employeeNo;
	private int postNo;
	private String content;
	private int recommendCount;
	private Date createdDate;
	private Date updatedDate;
	
	@Builder
	private Comment(int no, int employeeNo, int postNo, String content) {
		this.no = no;
		this.employeeNo = employeeNo;
		this.postNo = postNo;
		this.content = content;
	}
	
	public void modifyContent(String content) {
		this.content = content;
	}
	
	public void increaseRecommendCount() {
		this.recommendCount += 1;
	}
	
	public void decreaseRecommendCount() {
		this.recommendCount -= 1;
	}
	
}
