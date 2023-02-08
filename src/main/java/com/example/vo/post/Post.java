package com.example.vo.post;

import java.util.Date;

import lombok.Builder;
import lombok.Getter;

// 글 번호, 작성자 번호, 제목, 내용은 필수값이고 글 번호와 작성자 번호는 불변성을 유지해야 한다.
// 생성자 패턴으로 생성하기에는 매개변수가 많고 자료형이 겹쳐 가독성이 떨어지기 때문에 빌더패턴으로 생성한다.
// 그런데 매개변수 4개 모두 필수입력값이라 매개변수가 누락되는걸 방지하고 싶은데 어떻게 해야하는지?
// 
// 그러나 제목과 내용은 수정이 가능해야 하기 때문에 단순히 Setter 보다는 구체적인 이름의 메서드 작성
// 또한 나머지 필드는 수정값이 정해져 있기 때문에 Setter메서드 대신 필드에 맞는 기능을 넣은 메서드 작성
@Getter
public class Post {
	
	private int no;
	private int employeeNo;
	private String title;
	private String content;
	private int readCount;
	private int recommendCount;
	private int commentCount;
	private int scrapCount;
	private String deleted;
	private Date createdDate;
	private Date updatedDate;
	
	@Builder
	private Post(int no, int employeeNo, String title, String content) {
		this.no = no;
		this.employeeNo = employeeNo;
		this.title = title;
		this.content = content;
	}
	
	public void modifyTitle(String title) {
		this.title = title;
	}
	
	public void modifyContent(String content) {
		this.content = content;
	}
	
	public void increaseReadCount() {
		this.readCount = this.readCount + 1;
	}
	
	public void decreaseReadCount() {
		this.readCount = this.readCount - 1;
	}
	
	public void increaseRecommendCount() {
		this.recommendCount = this.recommendCount + 1;
	}
	
	public void decreaseRecommendCount() {
		this.recommendCount = this.recommendCount - 1;
	}
	
	public void increaseCommentCount() {
		this.commentCount = this.commentCount + 1;
	}
	
	public void decreaseCommentCount() {
		this.commentCount = this.commentCount - 1;
	}
	
	public void increaseScrapCount() {
		this.scrapCount = this.scrapCount + 1;
	}
	
	public void decreaseScrapCount() {
		this.scrapCount = this.scrapCount - 1;
	}
	
	public void deletePost() {
		this.deleted = "Y";
	}
	
	public void recoverPost() {
		this.deleted = "N";
	}
}
