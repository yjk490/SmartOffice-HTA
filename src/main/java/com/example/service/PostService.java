package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dto.PostListDto;
import com.example.mapper.PostMapper;
import com.example.utils.Pagination;
import com.example.vo.post.AttachedFile;
import com.example.vo.post.Post;
import com.example.vo.post.Tag;
import com.example.web.request.PostRegisterForm;
import com.example.web.request.PostSearchOption;
import com.example.web.response.PostSearchResult;

@Service
public class PostService {

	@Autowired
	PostMapper postMapper;
	
	// PageMaker 객체를 하나 만들어서 한번에 처리할 수 있도록 고민해볼 것. Pagination 상속?
	// ex)
	// PageMaker pageMaker = new PageMaker(page, opt)
	// postMapper.getTotalRows(pageMaker)
	// postMapper.getPostListDto(pageMaker)
	public PostSearchResult getPosts(int page, PostSearchOption opt) {
		int totalRows = postMapper.getTotalRows(opt.getType(), opt.getKeyword());
		Pagination pagination = new Pagination(page, totalRows, opt.getRows());
		
		List<PostListDto> posts = postMapper.getPostListDto(pagination.getBegin(), pagination.getEnd(),
															opt.getSort(),
															opt.getType(), opt.getKeyword());
		
		PostSearchResult result = new PostSearchResult(pagination, posts);
		
		return result;
	}
	
	
	public void registerPost(PostRegisterForm form) { // 매개변수로 int empNo 추가되어야 함. 추후 수정 계획
		int postNo = postMapper.getPostSequence();
		
		// POST 테이블에 게시글 정보 저장
		// 빌더패턴으로 객체를 생성할 때, 입력값을 누락했을 경우 어떻게 예외처리 할 수 있는지?
		Post post = Post.builder()
					.no(postNo)
					.employeeNo(10001)
					.title(form.getTitle())
					.content(form.getContent())
					.build();
		
		postMapper.insertPost(post);
		
		// POST_TAGS 테이블에 태그 정보 저장
		if (form.getTags() != null) {
			List<String> tags = form.getTags();
			
			for (String tagContent : tags) {
				Tag tag = new Tag(postNo, tagContent);
				postMapper.insertTag(tag);
			}
		}
		
		// POST_ATTACHED_FILES 테이블에 업로드파일 정보 저장
		if (form.getUploadFiles() != null) {
			List<String> filenames = form.getFilenames();
			
			for (String filename : filenames) {
				AttachedFile attachedFile = new AttachedFile(postNo, filename);
				postMapper.insertAttachedFile(attachedFile);
			}
		}
	}
	
	
}
