package com.example.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.example.vo.post.AttachedFile;
import com.example.vo.post.Post;
import com.example.vo.post.Tag;

@Mapper
public interface PostMapper {

	int getPostSequence();
	void insertPost(Post post);
	void insertTag(Tag tag);
	void insertAttachedFile(AttachedFile attachedFile);
}
