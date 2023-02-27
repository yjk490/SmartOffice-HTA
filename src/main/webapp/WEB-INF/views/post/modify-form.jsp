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
				<p class="fs-1 my-2">글 수정하기</p>
			</div>
			<form id="form-post" class="row p-2 auto" method="post" action="modify-post" enctype="multipart/form-data">
				<input type="hidden" name="no" value="${modifyPost.no }">
				<input type="hidden" name="employeeNo" value="${modifyPost.employeeNo }">
				<div class="mb-4">
				  	<label class="form-label lead">제목</label>
				  	<input type="text" class="form-control" name="title" value="${modifyPost.title }" placeholder="제목을 입력해주세요.">
				  	<div class="invalid-feedback">
        				<span class="ps-2">제목은 필수 입력입니다.</span>
      				</div>
				</div>
				<div class="mb-4">
				  	<label class="form-label lead">내용</label>
				  	<textarea class="form-control" name="content" rows="10" placeholder="내용을 입력해주세요.">${modifyPost.content }</textarea>
				  	<div class="invalid-feedback">
        				<span class="ps-2">내용은 필수 입력입니다.</span>
      				</div>
				</div>
				<div class="mb-2">
				  	<label class="form-label lead">태그</label>
				  	<input id="tag-input" type="text" class="form-control" placeholder="태그를 입력해주세요.">
					<div id="tag-btn-box" class="m-2">
						<c:forEach var="tag" items="${modifyPost.tagContents }">
							<a href="" class="text-white text-decoration-none pe-2" data-tag-content="${tag }">
								<span class="badge text-bg-success">${tag}<i class="bi bi-x ms-1"></i></span>
							</a>
						</c:forEach>
					</div>
				</div>
				<div class="mb-4">
			  		<label class="form-label lead mb-2">파일 첨부</label>
			  		<input type="file" class="form-control" name="uploadFiles" multiple>
			  		<div id="div-new-file-box" class="m-1">
			  			<small class="form-text text-muted">새 첨부파일 : </small>
			  		</div>
			  		<div id="div-old-file-box" class="my-1">
			  			<small class="form-text text-muted">기존 첨부파일 : </small>
				  		<c:forEach var="map" items="${modifyPost.fileNamesMap }">
				  			<c:set var="savedFileName" value="${map.key}" />
							<c:set var="originalFileName" value="${map.value}" />
				  			<a href="" class="text-white text-decoration-none pe-2" data-delete-file-name="${savedFileName }">
								<span class="badge text-bg-secondary">${originalFileName}<i class="bi bi-x ms-1"></i></span>
							</a>
						</c:forEach>
			  		</div>
			  		<small class="form-text text-muted">파일 1개당 10MB, 전체용량 100MB까지 첨부할 수 있습니다.</small>
				</div>
				<div class="text-end">
					<a href="detail?postNo=${post.no }" class="btn btn-outline-secondary">취소</a>
					<button class="btn btn-outline-primary" type="submit">수정완료</button>
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
			
			// 태그 입력값이 공백이면 태그 입력 무효처리
			if (value == "") {
				return false;
			}
			
			// 이전에 입력했던 태그와 같은 태그를 입력하면 태그 입력 무효처리
			// 현재 입력한 태그와 같은 태그가 몇개 있는지 검사하고, 그 개수가 1개 이상이면 함수를 종료한다.
		    let existingTags = $('#tag-btn-box input[name=tagContents][value="' + value + '"]').length
			if (existingTags > 0) {
				$tagInput.val("")
				return false
			}
		    
			let tagBtn = `
				<a href="" class="text-white text-decoration-none pe-2" >
					<span class="badge text-bg-success">\${value}<i class="bi bi-x ms-1"></i></span>
					<input type="hidden" name="tagContents" value="\${value}">
				</a>
			`;
			
			$tagBtnBox.append(tagBtn);
			$tagInput.val("");
			
			return false;
		}
		return true;
	})
	
	// 기존에 입력되어 있는 태그를 삭제하는 함수.
	// 삭제할 태그를 input값으로 저장해서 서버로 보낸다.
	$tagBtnBox.on("click", 'a', function(event) {
		event.preventDefault();
		
		let deleteTagContents = $(this).data('tag-content')
		let html = `<input type="hidden" name="deleteTagContents" value="\${deleteTagContents}">`
		$("#form-post").prepend(html)
				
		$(this).remove()
	})
	
	// 새로 업로드한 첨부파일 목록을 표현하는 핸들러 함수	
	$('input[type=file]').change(function() {
		$('#div-new-file-box a').remove()
		let files = $('input[type=file]')[0].files
		let result = ``
		
		$.each(files, function(index, file) {
			let fileName = file.name
			let fileSizeKB = (file.size / 1024).toFixed(2)
			
			result += `<a href="" class="text-white text-decoration-none pe-2" data-file-name="\${fileName}">
							<span class="badge text-bg-dark">\${fileName} \${fileSizeKB}KB<i class="bi bi-x ms-1"></i></span>
					   </a> `
		})
		
		$('#div-new-file-box').append(result)
	})
	
	// 새로 업로드한 첨부파일을 부분적으로 삭제하는 핸들러 함수
	$('#div-new-file-box').on('click', 'a', function(event) {
		event.preventDefault()
		
		let files = $('input[type=file]')[0].files
		let deleteFileName = $(this).data('file-name')
		let newFiles = new DataTransfer();
			
		$.each(files, function(index, file) {
			if (file.name !== deleteFileName) {
				newFiles.items.add(file)
			}
		})
		$('input[type=file]')[0].files = newFiles.files
		
		$(this).remove()		
	})
	
	// 기존 첨부파일을 부분적으로 삭제하는 핸들러 함수. 삭제할 파일의 savedName을 input값으로 저장해서 서버로 보낸다.
	$("#div-old-file-box").on("click", 'a', function(event) {
		event.preventDefault()
		
		let deleteFileName = $(this).data('delete-file-name')
		let html = `<input type="hidden" name="deleteFileNames" value="\${deleteFileName}">`
		$("#form-post").prepend(html)
		
		$(this).remove()
	})	
	
})
</script>
</body>
</html>