package com.example.web.response;

import java.util.List;

import com.example.dto.PostListDto;
import com.example.utils.Pagination;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class PostSearchResult {

	private Pagination pagination;
	private List<PostListDto> posts;
}
