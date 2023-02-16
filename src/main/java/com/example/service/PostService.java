package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dto.post.CommentDto;
import com.example.dto.post.PostDetailDto;
import com.example.dto.post.PostListDto;
import com.example.mapper.PostMapper;
import com.example.utils.Pagination;
import com.example.vo.post.AttachedFile;
import com.example.vo.post.Comment;
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
	
	public PostDetailDto getPostDetailDto(int postNo, int employeeNo) {
		PostDetailDto postDetailDto = postMapper.getPostDetailDto(postNo, employeeNo);
//		if (postDetailDto == null) {
//			throw new ApplicationException("["+postNo+"] 번 게시글이 존재하지 않습니다.");
//		}
		
		List<AttachedFile> attachedFiles = postMapper.getAttachedFilesByPostNo(postNo);
		postDetailDto.setAttachedFiles(attachedFiles);
		
		List<Tag> tags = postMapper.getTagsByPostNo(postNo);
		postDetailDto.setTags(tags);
		
		return postDetailDto;
	}
	
	
	public void registerPost(int employeeNo, PostRegisterForm form) { 
		int postNo = postMapper.getPostSequence();
		
		// POST 테이블에 게시글 정보 저장
		// 빌더패턴으로 객체를 생성할 때, 입력값을 누락했을 경우 어떻게 예외처리 할 수 있는지?
		Post post = Post.builder()
					.no(postNo)
					.employeeNo(employeeNo)
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
		List<String> savedFilenames = form.getSavedFilenames();
		
		if (savedFilenames != null) {
			
			for (String savedName : savedFilenames) {
				AttachedFile attachedFile = new AttachedFile(postNo, savedName, savedName.substring(36));
				postMapper.insertAttachedFile(attachedFile);
			}
		}
	}

	public void scrapPost(int postNo, int employeeNo) {
		PostDetailDto postDetailDto = postMapper.getPostDetailDto(postNo, employeeNo);
		Post post = postMapper.getPostByNo(postNo);
		
		if (!postDetailDto.isScrapped()) {
			postMapper.insertPostScrap(postNo, employeeNo);
			post.increaseScrapCount();
			postMapper.updatePost(post);
		} else {
			postMapper.deletePostScrap(postNo, employeeNo);
			post.decreaseScrapCount();
			postMapper.updatePost(post);
		}
		
	}
	
	public void recommendPost(int postNo, int employeeNo) {
		PostDetailDto postDetailDto = postMapper.getPostDetailDto(postNo, employeeNo);
		Post post = postMapper.getPostByNo(postNo);
		
		if (!postDetailDto.isRecommended()) {
			postMapper.insertPostRecommend(postNo, employeeNo);
			post.increaseRecommendCount();
			postMapper.updatePost(post);
		} else {
			postMapper.deletePostRecommend(postNo, employeeNo);
			post.decreaseRecommendCount();
			postMapper.updatePost(post);
		}
	}
	
	public void registerComment(int postNo, String content, int employeeNo) {
		int commentNo = postMapper.getCommentSequence();
		Comment comment = Comment.builder()
						  .no(commentNo)
						  .employeeNo(employeeNo)
						  .postNo(postNo)
						  .content(content)
						  .build();
		
		postMapper.insertComment(comment);
	}
	
	public List<CommentDto> getComments(int postNo, int employeeNo) {
		List<CommentDto> comments = postMapper.getCommentsByPostNo(postNo, employeeNo);
		return comments;
	}
	
	public void recommendComment(int commentNo, int employeeNo) {
		CommentDto commentDto = postMapper.getCommentDtoByCommentNo(commentNo, employeeNo);
		Comment comment = postMapper.getCommentByNo(commentNo);
		
		System.out.println("### 댓글 번호: " + commentNo);
		System.out.println("### 로직 실행 전 댓글 추천 여부: " + commentDto.isRecommended());
		
		if(!commentDto.isRecommended()) {
			postMapper.insertCommentRecommend(commentNo, employeeNo);
			comment.increaseRecommendCount();
			postMapper.updateComment(comment);
		} else {
			postMapper.deleteCommentRecommend(commentNo, employeeNo);
			comment.decreaseRecommendCount();
			postMapper.updateComment(comment);
		}
		
		CommentDto commentDto2 = postMapper.getCommentDtoByCommentNo(commentNo, employeeNo);
		System.out.println("### 댓글 번호: " + commentNo);
		System.out.println("### 로직 실행 후 댓글 추천 여부: " + commentDto2.isRecommended());
		
	}
	
}
