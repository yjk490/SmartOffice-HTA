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
		
		if (postDetailDto == null) {
			throw new ApplicationException("["+postNo+"] 번 게시글이 존재하지 않습니다.");
		}
		
		model.addAttribute("post", postDetailDto);
		
		return "post/detail";
	}
	
	@GetMapping("/download")
	public ModelAndView fileDownload(@RequestParam("filename") String filename) {
		File file = new File(directory, filename);
		
		if (!file.exists()) {
			String originalFilename = filename.substring(36);
			throw new ApplicationException("["+originalFilename+"] 파일이 존재하지 않습니다.");
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
		
		if (postDetailDto == null) {
			throw new ApplicationException("["+postNo+"] 번 게시글이 존재하지 않습니다.");
		}		
		
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
	@GetMapping("/remove-post-by-admin")
	public String removePost(@RequestParam("postNo") int postNo) {
		postService.removePost(postNo);
		
		return "redirect:list";
	}
	
	// 사용자에 의한 삭제, 임시보관함에 저장되어 DB에서 삭제되지는 않는다.
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
	
	// 관리자에 의한 영구삭제
	// 게시글과 관련된 모든 정보가 DB에서 삭제된다.
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/delete-post")
	public String deletePost(@RequestParam("postNo") List<Integer> postNoList) {
		postService.deletePost(postNoList);
		
		return "redirect:removed-post-list";
	}
	
	@GetMapping("/notice")
	public String notice() {
		return "post/notice";
	}
	
	// mypost 최초 진입 시 쿼리스트링이나 input태그의 hidden속성으로 employeeNo를 넘겨줄 수도 있지만
	// 서버 내부에서 employeeNo를 전달하는 것이 보안상 더 적절하다.
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
