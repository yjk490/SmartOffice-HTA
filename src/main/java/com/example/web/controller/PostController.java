package com.example.web.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.dto.post.CommentDto;
import com.example.dto.post.PostDetailDto;
import com.example.exception.ApplicationException;
import com.example.security.AuthenticatedUser;
import com.example.security.LoginEmployee;
import com.example.service.PostService;
import com.example.web.request.PostModifyForm;
import com.example.web.request.PostRegisterForm;
import com.example.web.request.PostSearchOption;
import com.example.web.response.PostSearchResult;
import com.example.web.view.FileDownloadView;

@Controller
@RequestMapping("/post")
@SessionAttributes({"modifyPost"})
public class PostController {
	
	@Autowired
	private PostService postService;
	@Autowired
	FileDownloadView fileDownloadView;
	@Value("${file.directory}")
	private String directory;
	@Value("${spring.servlet.multipart.max-file-size}")
	private int maxFileSize;
	@Value("${spring.servlet.multipart.max-request-size}")
	private int maxTotalFileSize;
	
	@GetMapping("/list")
	public String list(@RequestParam(name = "page", required = false, defaultValue = "1") int page, PostSearchOption opt, Model model) {
		PostSearchResult result = postService.getPosts(page, opt);
		
		model.addAttribute("pagination", result.getPagination());
		model.addAttribute("posts", result.getPosts());
		model.addAttribute("opt", opt);
		
		return "post/list";
	}
	
	@GetMapping("/register-post")
	public String registerForm() {
		return "post/register-form";
	}
	
	@PostMapping("/register-post")
	public String registerPost(@AuthenticatedUser LoginEmployee loginEmployee, List<MultipartFile> uploadFiles, PostRegisterForm form) throws IOException {
		// ?????????????????? ?????? ?????????
		Map<String, String> fileNamesMap = new HashMap<String, String>();
		for (MultipartFile file : uploadFiles) {
			if (!file.isEmpty()) {
				String originalFileName = file.getOriginalFilename();
				String savedFileName = UUID.randomUUID().toString() + originalFileName;
				
				FileCopyUtils.copy(file.getInputStream(), new FileOutputStream(new File(directory, savedFileName)));
				
				fileNamesMap.put(savedFileName, originalFileName);
			}
		}
		form.setFileNamesMap(fileNamesMap);
		
		postService.registerPost(loginEmployee.getNo(), form);
		
		return "redirect:list";
	}
	
	// ????????? ?????? ?????? ?????? vs ??????
	// ?????? ??????
	/*
	 	????????? ?????? ?????? ??????
	 	?????? 
	 		- ????????? ??????????????? ???????????? ????????? ?????? ????????? ?????? ??? ??????. ????????? ???????????? ???????????? ??????.
	 		- ?????????????????? ?????? ??? ?????? ????????? ????????? ????????? ?????? ????????? ??? ???????????? ????????? ????????? ????????? ????????? ????????? ????????? ?????? ??? ??????.
	 	?????? 
	 		- ????????? ???????????? ????????? ????????? ????????????. ???????????? ???????????? ????????? ????????? ????????????.
	 		
	 */
	@GetMapping("/detail")
	public String detail(@RequestParam("postNo") int postNo, @AuthenticatedUser LoginEmployee loginEmployee, Model model) {
		PostDetailDto postDetailDto = postService.getPostDetailDto(postNo, loginEmployee.getNo());
		
	//	if (postDetailDto == null || "Y".equals(postDetailDto.getDeleted())) {
	//		throw new ApplicationException("["+postNo+"] ??? ???????????? ???????????? ????????????.");
	//	}
		
		model.addAttribute("post", postDetailDto);
		
		return "post/detail";
	}
	
	@GetMapping("/download")
	public ModelAndView fileDownload(@RequestParam("filename") String filename) {
		File file = new File(directory, filename);
		
		if (!file.exists()) {
			String originalFilename = filename.substring(36);
			throw new ApplicationException("["+originalFilename+"] ????????? ???????????? ????????????.");
		}
		
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
	
	@GetMapping("/recommend-post")
	@ResponseBody
	public void recommend(@RequestParam("postNo") int postNo, @AuthenticatedUser LoginEmployee loginEmployee) {
		postService.recommendPost(postNo, loginEmployee.getNo());
	}
	
	@PostMapping("/register-comment")
	@ResponseBody
	public void registerComment(@RequestParam("postNo") int postNo, @RequestParam("content") String content, @AuthenticatedUser LoginEmployee loginEmployee) {
		postService.registerComment(postNo, content, loginEmployee.getNo());
	}
	
	@PreAuthorize("#employeeNo == principal.no")
	@PostMapping("/modify-comment")
	@ResponseBody
	public void modifyComment(@RequestParam("commentNo") int commentNo, @RequestParam("employeeNo") int employeeNo, @RequestParam("modifiedContent") String modifiedContent) {
		postService.modifyComment(commentNo, modifiedContent);
	}
	
	@PreAuthorize("#employeeNo == principal.no or hasRole('ROLE_ADMIN')")
	@GetMapping("/delete-comment")
	@ResponseBody
	public void deleteComment(@RequestParam("postNo") int postNo, @RequestParam("commentNo") int commentNo, @RequestParam("employeeNo") int employeeNo) {
		postService.deleteComment(postNo, commentNo);
	}
	
	@GetMapping("/comment-list")
	@ResponseBody
	public List<CommentDto> commentList(@RequestParam("postNo") int postNo, @RequestParam("employeeNo") int employeeNo) {
		List<CommentDto> comments = postService.getComments(postNo, employeeNo);
		return comments;
	}
	
	@GetMapping("/recommend-comment")
	@ResponseBody
	public void recommendComment(@RequestParam("commentNo") int commentNo, @AuthenticatedUser LoginEmployee loginEmployee) {
		postService.recommendComment(commentNo, loginEmployee.getNo());
	}
	
	@PreAuthorize("#employeeNo == principal.no")
	@GetMapping("/modify-post")
	public String modifyForm(@RequestParam("postNo") int postNo, @RequestParam("employeeNo") int employeeNo, Model model) {
		PostDetailDto postDetailDto = postService.getPostDetailDto(postNo, employeeNo);
		
		if (postDetailDto == null || "Y".equals(postDetailDto.getDeleted())) {
			throw new ApplicationException("["+postNo+"] ??? ???????????? ???????????? ????????????.");
		}		
		
		model.addAttribute("modifyPost", postDetailDto);
		
		return "post/modify-form";
	}
	
	@PreAuthorize("#form.employeeNo == principal.no")
	@PostMapping("/modify-post")
	public String modifyPost(List<MultipartFile> uploadFiles, PostModifyForm form) throws FileNotFoundException, IOException {
		// ??? ?????? ?????????
		Map<String, String> fileNamesMap = new HashMap<String, String>();
		for (MultipartFile file : uploadFiles) {
			if (!file.isEmpty()) {
				String originalFileName = file.getOriginalFilename();
				String savedFileName = UUID.randomUUID().toString() + originalFileName;
				
				FileCopyUtils.copy(file.getInputStream(), new FileOutputStream(new File(directory, savedFileName)));
				
				fileNamesMap.put(savedFileName, originalFileName);
			}
		}
		form.setFileNamesMap(fileNamesMap);
		
		postService.modifyPost(form);
		
		return "redirect:detail?postNo=" + form.getNo();
	}
	
	
	
	// ???????????? ?????? ??????, ?????????????????? ???????????? DB?????? ??????????????? ?????????.
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/remove-post-by-admin")
	public String removePost(@RequestParam("postNo") int postNo) {
		postService.removePost(postNo);
		
		return "redirect:list";
	}
	
	// ???????????? ?????? ??????, ?????????????????? ???????????? DB?????? ??????????????? ?????????.
	@PreAuthorize("#employeeNo == principal.no")
	@GetMapping("/remove-post-by-user")
	public String removePost(@RequestParam("postNo") int postNo, @RequestParam("employeeNo") int employeeNo) {
		postService.removePost(postNo);
		
		return "redirect:list";
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/recover-post")
	public String recoverPost(@RequestParam("postNo") List<Integer> postNoList) {
		postService.recoverPost(postNoList);
		
		return "redirect:removed-post-list";
	}
	
	// ???????????? ?????? ????????????
	// ???????????? ????????? ?????? ????????? DB?????? ????????????.
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/delete-post")
	public String deletePost(@RequestParam("postNo") List<Integer> postNoList) {
		postService.deletePost(postNoList);
		
		return "redirect:removed-post-list";
	}
	
	@GetMapping("/notice")
	public String notice(@RequestParam(name = "page", required = false, defaultValue = "1") int page, @AuthenticatedUser LoginEmployee loginEmployee, PostSearchOption opt, Model model) {
		opt.setEmployeeNo(loginEmployee.getNo());
		PostSearchResult result = postService.getPostsWtihNotice(page, opt);
		
		model.addAttribute("pagination", result.getPagination());
		model.addAttribute("notice", result.getPosts());
		model.addAttribute("opt", opt);	
		
		return "post/notice";
	}
	
	// mypost ?????? ?????? ??? ????????????????????? input????????? hidden???????????? employeeNo??? ????????? ?????? ?????????
	// ?????? ???????????? employeeNo??? ???????????? ?????? ????????? ??? ????????????.
	@GetMapping("/mypost")
	public String mypost(@RequestParam(name = "page", required = false, defaultValue = "1") int page, @AuthenticatedUser LoginEmployee loginEmployee, PostSearchOption opt, Model model) {
		opt.setEmployeeNo(loginEmployee.getNo());
		PostSearchResult result = postService.getPosts(page, opt);
		
		model.addAttribute("pagination", result.getPagination());
		model.addAttribute("posts", result.getPosts());
		model.addAttribute("opt", opt);		
		
		return "post/mypost";
	}
	
	@GetMapping("/mycomment")
	public String mycomment(@RequestParam(name = "page", required = false, defaultValue = "1") int page, @AuthenticatedUser LoginEmployee loginEmployee, PostSearchOption opt, Model model) {
		opt.setEmployeeNo(loginEmployee.getNo());
		PostSearchResult result = postService.getPostsWithMyComment(page, opt);
		
		model.addAttribute("pagination", result.getPagination());
		model.addAttribute("posts", result.getPosts());
		model.addAttribute("opt", opt);			
		
		return "post/mycomment";
	}
	
	@GetMapping("/myscrap")
	public String myscrap(@RequestParam(name = "page", required = false, defaultValue = "1") int page, @AuthenticatedUser LoginEmployee loginEmployee, PostSearchOption opt, Model model) {
		opt.setEmployeeNo(loginEmployee.getNo());
		PostSearchResult result = postService.getPostsWithMyScrap(page, opt);
		
		model.addAttribute("pagination", result.getPagination());
		model.addAttribute("posts", result.getPosts());
		model.addAttribute("opt", opt);				
		
		return "post/myscrap";
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/removed-post-list")
	public String removedPost(@RequestParam(name = "page", required = false, defaultValue = "1") int page, PostSearchOption opt, Model model) {
		opt.setDeleted("Y");
		PostSearchResult result = postService.getPosts(page, opt);
		
		model.addAttribute("pagination", result.getPagination());
		model.addAttribute("posts", result.getPosts());
		model.addAttribute("opt", opt);				
		
		return "post/removed-post";
	}
	
	@GetMapping("/role")
	@ResponseBody
	public List<String> role(@RequestParam("employeeNo") int employeeNo) {
		List<String> employeeRoles = postService.getEmployeeRoles(employeeNo);
		return employeeRoles;
	}
}
