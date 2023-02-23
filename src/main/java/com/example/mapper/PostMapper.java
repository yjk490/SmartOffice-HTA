package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.dto.post.CommentDto;
import com.example.dto.post.PostDetailDto;
import com.example.dto.post.PostListDto;
import com.example.vo.post.AttachedFile;
import com.example.vo.post.Comment;
import com.example.vo.post.Post;
import com.example.vo.post.Tag;

@Mapper
public interface PostMapper {

	void insertPost(Post post);
	void insertTags(List<Tag> tags);
	void insertAttachedFiles(List<AttachedFile> attachedFiles);
	void insertPostRecommend(@Param("postNo") int postNo, @Param("employeeNo")int employeeNo);
	void insertPostScrap(@Param("postNo") int postNo, @Param("employeeNo")int employeeNo);
	void insertComment(Comment comment);
	void insertCommentRecommend(@Param("commentNo") int commentNo, @Param("employeeNo") int employeeNo);
	
	int getTotalRows(@Param("type") String type, @Param("keyword") String keyword);
	List<PostListDto> getPostListDto(@Param("begin") int beginPage, @Param("end") int endPage,
									 @Param("sort") String sort,
									 @Param("type") String type, @Param("keyword") String keyword);
	PostDetailDto getPostDetailDto(@Param("postNo") int postNo, @Param("employeeNo") int employeeNo);
	List<AttachedFile> getAttachedFilesByPostNo(int postNo);
	List<Tag> getTagsByPostNo(int postNo);
	Post getPostByNo(int postNo);
	int getPostSequence();
	List<CommentDto> getCommentsByPostNo(@Param("postNo") int postNo, @Param("employeeNo") int employeeNo);
	CommentDto getCommentDtoByCommentNo(@Param("commentNo") int commentNo, @Param("employeeNo") int employeeNo);
	Comment getCommentByNo(int commentNo);
	int getCommentSequence();
	List<String> getEmpRolesByEmployeeNo(int empNo);
	
	void updatePost(Post post);
	void updateComment(Comment comment);
	
	void deletePost(int postNo);
	void deletePostScrap(@Param("postNo")int postNo, @Param("employeeNo")int employeeNo);
	void deletePostRecommend(@Param("postNo")int postNo, @Param("employeeNo")int employeeNo);
	void deleteCommentRecommend(@Param("commentNo") int commentNo, @Param("employeeNo") int employeeNo);
	void deleteFileBySavedName(String filename);
	
}
