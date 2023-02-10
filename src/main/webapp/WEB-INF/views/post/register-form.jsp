<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<title>애플리케이션</title>
</head>
<body>
<c:set var="top" value="post" />
<%@ include file="../common/navbar.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-3"> <!-- 사이드 바 시작 -->
			<%@ include file="../common/left/post.jsp" %>
		</div> <!-- 사이드 바 끝 -->
		<div class="col-9">
			<div class="row border m-1 mb-3">
				<p class="fs-1 my-2">글 작성하기</p>
			</div>
			<form id="form-post" class="row p-2 auto" method="post" action="register" enctype="multipart/form-data">
			<sec:csrfInput />
				<div class="mb-4">
				  	<label class="form-label lead">제목</label>
				  	<input type="text" class="form-control" name="title" placeholder="제목을 입력해주세요.">
				  	<div class="invalid-feedback">
        				<span class="ps-2">제목은 필수 입력입니다.</span>
      				</div>
				</div>
				<div class="mb-4">
				  	<label class="form-label lead">내용</label>
				  	<textarea class="form-control" name="content" rows="10" placeholder="내용을 입력해주세요."></textarea>
				  	<div class="invalid-feedback">
        				<span class="ps-2">내용은 필수 입력입니다.</span>
      				</div>
				</div>
				<div class="mb-2">
				  	<label class="form-label lead">태그</label>
				  	<input id="tag-input" type="text" class="form-control" placeholder="태그를 입력해주세요.">
					<div id="tag-btn-box" class="m-2"></div>
				</div>
				<div class="mb-4">
			  		<label class="form-label lead">파일 첨부</label>
			  		<input type="file" class="form-control" name="uploadFiles" multiple>
			  		<small class="form-text text-muted p-2">파일 1개당 10MB, 전체용량 100MB까지 첨부할 수 있습니다.</small>
				</div>
				<div class="text-end">
					<button class="btn btn-outline-secondary" type="submit">취소</button>
					<button class="btn btn-outline-primary" type="submit">등록</button>
				</div>
			</form>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	
	// 게시글 등록 폼 유효성 검사
	let $title = $("#form-post :input[name=title]")
	let $content = $("#form-post :input[name=content]")
	
	$("#form-post").keyup(function() {
		if (!$title.val() == "") {
			$title.removeClass("is-invalid")
		}
		
		if (!$content.val() == "") {
			$content.removeClass("is-invalid")
		}
	})
	
	$("#form-post").submit(function() {
		if ($title.val() == "") {
			$title.addClass("is-invalid")
			return false
		}
		if ($content.val() == "") {
			$content.addClass("is-invalid")
			return false
		}
		
		return true
	})
	
	// 게시글 등록 태그 입력
	let $tagInput = $("#tag-input");
	let $tagBtnBox = $("#tag-btn-box");
	
	$("#tag-input").keydown(function(event) {
		
		if (event.which == 13) {
			let value = $tagInput.val();
			if (value == "") {
				return false;
			}
			let tagBtn = `
				<a href="" class="text-white text-decoration-none pe-2" >
					<small class="border rounded bg-success text-white">#\${value}<i class="bi bi-x"></i>
					</small>
					<input type="hidden" name="tags" value="\${value}">
				</a>
			`;
			
			$tagBtnBox.append(tagBtn);
			$tagInput.val("");
			
			return false;
		}
		return true;
	})
	
	$tagBtnBox.on("click", 'a', function(event) {
		event.preventDefault();
		$(this).remove()
	})
	
})
</script>
</body>
</html>