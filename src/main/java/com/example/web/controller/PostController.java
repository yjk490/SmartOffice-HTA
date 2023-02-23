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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.dto.post.CommentDto;
import com.example.dto.post.PostDetailDto;
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
	public String registerPost(@AuthenticatedUser LoginEmployee loginEmployee, List<MultipartFile> uploadFiles, PostRegisterForm form) throws IOException { // 매개변수로 loginUser객체 추가되어야 함. 추후 수정 계획 
		// 브라우저에서 파일 업로드
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
		
		model.addAttribute("modifyPost", postDetailDto);
		
		return "post/modify-form";
	}
	@PreAuthorize("#form.employeeNo == principal.no")
	@PostMapping("/modify-post")
	public String modifyPost(List<MultipartFile> uploadFiles, PostModifyForm form) throws FileNotFoundException, IOException {
		// 새 파일 업로드
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
	
	// 관리자에 의한 삭제, 임시보관함에 저장되어 DB에서 삭제되지는 않는다.
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/remove-post")
	public String removePost(@RequestParam("postNo") int postNo) {
		postService.removePost(postNo);
		
		return "redirect:list";
	}
	
	// 사용자 또는 관리자에 의한 영구삭제, 사용자가 직접 게시글을 삭제하거나 관리자가 임시보관함에 있는 게시글을 삭제할 때 이 요청핸들러가 실행된다.
	// 게시글과 관련된 모든 정보가 DB에서 삭제된다.
	// 요청핸들러가 실행되기 전에 현재 로그인된 사용자번호와 게시글 작성자 번호를 체크하므로  @AuthenticatedUser를 통한 유효성 검사를 할 필요가 없는거 맞는지??
	@PreAuthorize("#employeeNo == principal.no or hasRole('ROLE_ADMIN')")
	@GetMapping("/delete-post")
	public String deletePost(@RequestParam("postNo") int postNo, @RequestParam("employeeNo") int employeeNo) {
		postService.deletePost(postNo);
		
		return "redirect:list";
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
	
	@GetMapping("/role")
	@ResponseBody
	public List<String> role(@RequestParam("employeeNo") int employeeNo) {
		List<String> employeeRoles = postService.getEmployeeRoles(employeeNo);
		return employeeRoles;
	}
}
