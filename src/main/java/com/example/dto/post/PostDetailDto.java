package com.example.dto.post;

import java.util.Date;
import java.util.List;

import com.example.vo.post.AttachedFile;
import com.example.vo.post.Tag;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PostDetailDto {

	private int no;
	private int employeeNo;
	private String name;
	private String title;
	private String content;
	private int readCount;
	private int recommendCount;
	private int scrapCount;
	private Date createdDate;
	private List<CommentListDto> comments;
	private List<AttachedFile> attachedFiles;
	private List<Tag> tags;
}
