package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.dto.post.CommentListDto;
import com.example.dto.post.PostListDtoWithMyComment;
import com.example.dto.post.PostListDtoWithMyScrap;
import com.example.dto.post.PostListDtoWithNotice;
import com.example.dto.post.PostDetailDto;
import com.example.dto.post.PostListDto;
import com.example.vo.post.AttachedFile;
import com.example.vo.post.Comment;
import com.example.vo.post.Post;
import com.example.vo.post.Tag;
import com.example.web.request.CommentSearchOption;
import com.example.web.request.PostSearchOption;

@Mapper
public interface PostMapper {

	void insertPost(Post post);
	void insertTags(List<Tag> tags);
	void insertAttachedFiles(List<AttachedFile> attachedFiles);
	void insertPostRecommend(@Param("postNo") int postNo, @Param("employeeNo")int employeeNo);
	void insertPostScrap(@Param("postNo") int postNo, @Param("employeeNo")int employeeNo);
	void insertComment(Comment comment);
	void insertCommentRecommend(@Param("commentNo") int commentNo, @Param("employeeNo") int employeeNo);
	
	int selectTotalRows(@Param("opt") PostSearchOption opt);
	List<PostListDto> selectPostListDtos(@Param("begin") int beginPage, @Param("end") int endPage, @Param("opt") PostSearchOption opt);
	PostDetailDto selectPostDetailDto(@Param("postNo") int postNo, @Param("employeeNo") int employeeNo);
	List<AttachedFile> selectAttachedFiles(int postNo);
	List<Tag> selectTags(int postNo);
	Post selectPost(int postNo);
	List<Post> selectPosts(List<Integer> postNoList);
	int selectPostSequence();
	List<CommentListDto> selectCommentListDtos(@Param("postNo") int postNo, @Param("employeeNo") int employeeNo);
	CommentListDto selectCommentListDto(@Param("commentNo") int commentNo, @Param("employeeNo") int employeeNo);
	Comment selectComment(int commentNo);
	int selectCommentSequence();
	List<String> getEmpRolesByEmployeeNo(int empNo);
	int selectTotalRowsWithNotice(int employeeNo);
	List<PostListDtoWithNotice> selectPostListDtosWithNotice(@Param("begin") int beginPage, @Param("end") int endPage, @Param("employeeNo") int employeeNo);
	int selectTotalRowsWithMyComment(@Param("opt") CommentSearchOption opt);
	List<PostListDtoWithMyComment> selectPostListDtosWithMyComment(@Param("begin") int beginPage, @Param("end") int endPage, @Param("opt") CommentSearchOption opt);
	int selectTotalRowsWithMyScrap(@Param("opt") PostSearchOption opt);
	List<PostListDtoWithMyScrap> selectPostListDtosWithMyScrap(@Param("begin") int beginPage, @Param("end") int endPage, @Param("opt") PostSearchOption opt);
	
	void updatePost(Post post);
	void updatePosts(List<Post> posts);
	void updateComment(Comment comment);
	
	void deletePosts(List<Integer> postNoList);
	void deletePostScrap(@Param("postNo")int postNo, @Param("employeeNo")int employeeNo);
	void deletePostRecommend(@Param("postNo")int postNo, @Param("employeeNo")int employeeNo);
	void deleteCommentRecommend(@Param("commentNo") int commentNo, @Param("employeeNo") int employeeNo);
	void deleteFiles(List<String> deleteFileNames);
	void deleteTags(List<String> deleteTagContents);
	void deleteComment(int commentNo);
	
}
