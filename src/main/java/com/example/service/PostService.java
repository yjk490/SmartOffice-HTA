package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.mapper.PostMapper;
import com.example.vo.post.AttachedFile;
import com.example.vo.post.Post;
import com.example.vo.post.Tag;
import com.example.web.request.PostRegisterForm;

@Service
public class PostService {

	@Autowired
	PostMapper postMapper;
	
	public void registerPost(PostRegisterForm form) { // 매개변수로 int empNo 추가되어야 함. 추후 수정 계획
		int postNo = postMapper.getPostSequence();
		
		// POST 테이블에 게시글 정보 저장
		// 빌더패턴으로 객체를 생성할 때  들어가는데 이를 체크해서 예외처리하기 위해서는 어떻게 해야하는지?
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
