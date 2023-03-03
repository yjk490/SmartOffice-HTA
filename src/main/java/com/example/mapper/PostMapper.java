package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.dto.post.CommentDto;
import com.example.dto.post.PostListDtoWithMyComment;
import com.example.dto.post.PostListDtoWithMyScrap;
import com.example.dto.post.PostListDtoWithNotice;
import com.example.dto.post.PostDetailDto;
import com.example.dto.post.PostListDto;
import com.example.vo.post.AttachedFile;
import com.example.vo.post.Comment;
import com.example.vo.post.Post;
import com.example.vo.post.Tag;
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
	
	int getTotalRows(@Param("opt") PostSearchOption opt);
	List<PostListDto> getPostListDto(@Param("begin") int beginPage, @Param("end") int endPage, @Param("opt") PostSearchOption opt);
	PostDetailDto getPostDetailDto(@Param("postNo") int postNo, @Param("employeeNo") int employeeNo);
	List<AttachedFile> getAttachedFilesByPostNo(int postNo);
//	List<List<AttachedFile>> getAttachedFilesListByPostNoList(List<Integer> postNoList);
	List<Tag> getTagsByPostNo(int postNo);
	Post getPostByNo(int postNo);
	List<Post> getPostsByNoList(List<Integer> postNoList);
	int getPostSequence();
	List<CommentDto> getCommentsByPostNo(@Param("postNo") int postNo, @Param("employeeNo") int employeeNo);
	CommentDto getCommentDtoByCommentNo(@Param("commentNo") int commentNo, @Param("employeeNo") int employeeNo);
	Comment getCommentByNo(int commentNo);
	int getCommentSequence();
	List<String> getEmpRolesByEmployeeNo(int empNo);
	int getTotalRowsWithMyComment(@Param("opt") PostSearchOption opt);
	List<PostListDtoWithMyComment> getPostListDtoWithMyComment(@Param("begin") int beginPage, @Param("end") int endPage, @Param("opt") PostSearchOption opt);
	int getTotalRowsWithMyScrap(@Param("opt") PostSearchOption opt);
	List<PostListDtoWithMyScrap> getPostListDtoWithMyScrap(@Param("begin") int beginPage, @Param("end") int endPage, @Param("opt") PostSearchOption opt);
	int getTotalRowsWithNotice(@Param("opt") PostSearchOption opt);
	List<PostListDtoWithNotice> getPostListDtoWithNotice(@Param("begin") int beginPage, @Param("end") int endPage, @Param("opt") PostSearchOption opt);
	
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
