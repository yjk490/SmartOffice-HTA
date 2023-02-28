package com.example.web.response;

import java.util.List;

import com.example.dto.post.PostListDto;
import com.example.utils.Pagination;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class PostSearchResult {

	private Pagination pagination;
	// MyCommentDto와 PostListDto를 담아야 하는데 이 클래스는 데이터 전송용으로만 사용되므로
	// 위 두 객체에 대한 각각의 XXXSearchResult를 정의하기에는 비효율적이라 판단하여 와일드 카드 사용
	private List<?> posts;
}
