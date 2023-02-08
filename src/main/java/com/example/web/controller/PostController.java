package com.example.web.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.example.service.PostService;
import com.example.web.request.PostRegisterForm;

@Controller
@RequestMapping("/post")
public class PostController {
	
	@Autowired
	private PostService postService;

	@Value("${file.directory}")
	private String directory;
	
	@GetMapping("/list")
	public String list() {
		return "post/list";
	}
	
	@GetMapping("/register-form")
	public String registerForm() {
		return "post/register-form";
	}
	
	@PostMapping("/register")
	public String register(PostRegisterForm form) throws IOException { // 매개변수로 loginUser객체 추가되어야 함. 추후 수정 계획 
		
		List<MultipartFile> uploadFiles = form.getUploadFiles();
		List<String> filenames = new ArrayList<>();
		
		// 웹 브라우저에서의 파일 업로드
		for (MultipartFile uploadFile : uploadFiles) {
			if (!uploadFile.isEmpty()) {
				String uuid = UUID.randomUUID().toString();
				String filename = uuid + uploadFile.getOriginalFilename();
				filenames.add(filename);
				
				FileCopyUtils.copy(uploadFile.getInputStream(), new FileOutputStream(new File(directory, filename)));
			}
		}
		form.setFilenames(filenames);

		postService.registerPost(form);
		
		return "redirect:list";
	}
	
	@GetMapping("/detail")
	public String detail() {
		return "post/detail";
	}
	
	@GetMapping("/notice")
	public String notice() {
		return "post/notice";
	}
	
	@GetMapping("/mypost")
	public String mypost() {
		return "post/mypost";
	}
	
	@GetMapping("/mycomment")
	public String mycomment() {
		return "post/mycomment";
	}
	
	@GetMapping("/myscrap")
	public String myscrap() {
		return "post/myscrap";
	}
	
	@GetMapping("/myfile")
	public String myflie() {
		return "post/myfile";
	}
}
