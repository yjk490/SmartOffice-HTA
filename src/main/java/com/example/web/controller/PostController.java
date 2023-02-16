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
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.dto.post.CommentDto;
import com.example.dto.post.PostDetailDto;
import com.example.security.AuthenticatedUser;
import com.example.security.LoginEmployee;
import com.example.service.PostService;
import com.example.web.request.PostRegisterForm;
import com.example.web.request.PostSearchOption;
import com.example.web.response.PostSearchResult;
import com.example.web.view.FileDownloadView;

@Controller
@RequestMapping("/post")
public class PostController {
	
	@Autowired
	private PostService postService;
	@Autowired
	FileDownloadView fileDownloadView;
	@Value("${file.directory}")
	private String directory;
	
	@GetMapping("/list")
	public String list(@RequestParam(name = "page", required = false, defaultValue = "1") int page, PostSearchOption opt, Model model) {
		PostSearchResult result = postService.getPosts(page, opt);
		
		model.addAttribute("pagination", result.getPagination());
		model.addAttribute("posts", result.getPosts());
		model.addAttribute("opt", opt);
		
		return "post/list";
	}
	
	@GetMapping("/register")
	public String registerForm() {
		return "post/register-form";
	}
	
	@PostMapping("/register")
	public String register(@AuthenticatedUser LoginEmployee loginEmployee, List<MultipartFile> uploadFiles, PostRegisterForm form) throws IOException { // 매개변수로 loginUser객체 추가되어야 함. 추후 수정 계획 
		List<String> savedFilenames = new ArrayList<>();
		
		// 웹 브라우저에서의 파일 업로드
		for (MultipartFile file : uploadFiles) {
			if (!file.isEmpty()) {
				String savedFilename = UUID.randomUUID().toString() + file.getOriginalFilename();
				
				savedFilenames.add(savedFilename);
				
				FileCopyUtils.copy(file.getInputStream(), new FileOutputStream(new File(directory, savedFilename)));
			}
		}
		form.setSavedFilenames(savedFilenames);

		postService.registerPost(loginEmployee.getNo(), form);
		
		return "redirect:list";
	}
	
	@GetMapping("/detail")
	public String detail(@RequestParam("postNo") int postNo, @AuthenticatedUser LoginEmployee loginEmployee, Model model) {
		PostDetailDto postDetailDto = postService.getPostDetailDto(postNo, loginEmployee.getNo());
		
		model.addAttribute("post", postDetailDto);
		
		return "post/detail";
	}
	
	@GetMapping("/download")
	public ModelAndView fileDownload(@RequestParam("filename") String filename) {
		File file = new File(directory, filename);
//		if (!file.exists()) {
//			throw new ApplicationException("["+filename+"] 파일이 존재하지 않습니다.");
//		}
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("file", file);
		mav.setView(fileDownloadView);
		
		return mav;
	}
	
	@GetMapping("/scrap")
	@ResponseBody
	public void scrap(@RequestParam("postNo") int postNo, @AuthenticatedUser LoginEmployee loginEmployee) {
		postService.scrapPost(postNo, loginEmployee.getNo());
	}
	
	@GetMapping("/recommend")
	@ResponseBody
	public void recommend(@RequestParam("postNo") int postNo, @AuthenticatedUser LoginEmployee loginEmployee) {
		postService.recommendPost(postNo, loginEmployee.getNo());
	}
	
	@PostMapping("/register-comment")
	@ResponseBody
	public void registerComment(@RequestParam("postNo") int postNo, @RequestParam("content") String content, @AuthenticatedUser LoginEmployee loginEmployee) {
		postService.registerComment(postNo, content, loginEmployee.getNo());
	}
	
	@GetMapping("/comment-list")
	@ResponseBody
	public List<CommentDto> commentList(int postNo, int employeeNo) {
		List<CommentDto> comments = postService.getComments(postNo, employeeNo);
		return comments;
	}
	
	@GetMapping("/recommend-comment")
	@ResponseBody
	public void recommendComment(@RequestParam("commentNo") int commentNo, @AuthenticatedUser LoginEmployee loginEmployee) {
		postService.recommendComment(commentNo, loginEmployee.getNo());
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
