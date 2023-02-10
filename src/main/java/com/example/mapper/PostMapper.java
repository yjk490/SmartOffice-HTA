package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.dto.PostListDto;
import com.example.vo.post.AttachedFile;
import com.example.vo.post.Comment;
import com.example.vo.post.Post;
import com.example.vo.post.Tag;
import com.example.web.request.PostSearchOption;

@Mapper
public interface PostMapper {

	void insertPost(Post post);
	void insertTag(Tag tag);
	void insertAttachedFile(AttachedFile attachedFile);
	
	int getPostSequence();
	int getTotalRows(@Param("type") String type, @Param("keyword") String keyword);
	List<PostListDto> getPostListDto(@Param("begin") int beginPage, @Param("end") int endPage,
									 @Param("sort") String sort,
									 @Param("type") String type, @Param("keyword") String keyword);
	List<AttachedFile> getAttachedFilesByPostNo(int postNo);
	List<Tag> getTagsByPostNo(int postNo);
	List<Comment> getCommentListByPostNo(int postNo);
	
	void updatePost(Post post);
	void updateComment(Comment comment);
	
}
