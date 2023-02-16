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
<sec:authentication property="principal" var="loginUser" />
<%@ include file="../common/navbar.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-3"> <!-- 사이드 바 시작 -->
			<%@ include file="../common/left/post.jsp" %>
		</div> <!-- 사이드 바 끝 -->
		<div class="col-9">
			<div class="row border m-1 mb-4">
				<p class="fs-1 my-2">자유 게시판</p>
				<p class="fs-5 my-3">자유롭게 의견을 나누고 생각의 폭을 넓혀보세요.</p>
			</div>
			<div class="row">
				<div class="col">
					<div class="my-3 border-bottom border-secondary">
						<p class="fs-3 fw-bold">${post.title }</p>
						<p hidden id="hidden-post-info" 
							data-post-no="${post.no }" 
							data-emp-no="${loginUser.no }"}></p>
					</div>
					<div class="my-3 border-bottom border-secondary">
						<div class="row mb-3">
							<div class="col-10">
								<div>
									<span class="fs-5">${post.name }</span>
								</div>
								<div>
									<span>${post.createdDate }</span>
									<span>조회수 ${post.scrapCount }</span>
									<c:forEach var="file" items="${post.attachedFiles }">
										<a href="/post/download?filename=${file.savedName }" 
										   class="btn btn-outline-dark btn-sm" 
										   style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">${file.originalName }</a>
									</c:forEach>
								</div>
							</div>
							<div class="col-2 text-end pe-5">
								<a id="toggle-scrap" href="" class="link-dark">
									<i class="bi bi-pin-angle-fill fs-3 ${post.scrapped eq false ? 'd-none' : '' }" ></i>
									<i class="bi bi-pin-angle fs-3 ${post.scrapped eq true ? 'd-none' : '' }" ></i>
								</a>
								<span class="fs-3">${post.scrapCount }</span>
							</div>
						</div>
						<div class="row mb-3">
							<p>${post.content }</p>
						</div>
						<div class="row mb-3">
							<div class="col py-3">
								<c:forEach var="tag" items="${post.tags }">
									<a href="/post/list?type=content&keyword=${tag.content }" >
									<span class="badge text-bg-success">${tag.content }</span>
									</a>
								</c:forEach>
							</div>
							<div class="col text-end pe-5">
								<div class="d-inline me-4">
									<button type="button" class="btn btn-outline-primary ${post.employeeNo eq loginUser.no ? '' : 'd-none' }">수정</button>
									<button type="button" class="btn btn-outline-danger ${post.employeeNo eq loginUser.no ? '' : 'd-none' }">삭제</button>
								</div>
								<div class="d-inline">
									<a id="toggle-recommend" href="" class="link-dark">
										<i class="bi bi-hand-thumbs-up-fill fs-3 ${post.recommended eq false ? 'd-none' : '' }"></i>
										<i class="bi bi-hand-thumbs-up fs-3 ${post.recommended eq true ? 'd-none' : '' }"></i>
									</a>
									<span clss="fs-3">${post.recommendCount }</span>
								</div>
							</div>
						</div>
					</div>
					<div id="div-register-comment" class="my-5 border-bottom border-secondary">
						<div class="mb-3">
						  	<textarea class="form-control" name="content" rows="3" placeholder="내용을 입력해주세요."></textarea>
							<div class="invalid-feedback">
	        					<span class="ps-2">댓글 내용을 입력해주세요.</span>
	      					</div>
						</div>
						<div class="mb-3 text-end">
							<button type="button" class="btn btn-outline-primary">댓글 쓰기</button>
						</div>
					</div>
					<div id="div-comment-list">
						<!-- ajax 요청으로 댓글 리스트 렌더링 -->
					</div>
				</div>
			</div>
		</div>
	</div>  
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(function () {
	
	let postNo = $('#hidden-post-info').data('post-no')
	let loginEmployeeNo = $('#hidden-post-info').data('emp-no')
	
	let $commentListBox = $("#div-comment-list")
	let $commentRegisterInputBox = $("#div-register-comment :input[name=content]")
	let $commentRegisterBtn = $("#div-register-comment button")
	
	// 댓글 리스트 ajax 요청 후, <div id="div-comment-list">에 렌더링
	getCommentList()
	function getCommentList() {
		$.getJSON('/post/comment-list',
				{
					postNo: postNo,
					employeeNo: loginEmployeeNo
				})
				.done(function (comments) {
					
					$.each(comments, function(index, comment) {
						console.log(index + 1  + ':' + comment.recommended)
						
						let ModifyAndDeleteBtn = (comment.employeeNo != loginEmployeeNo) ? 'd-none' : ''
						let filledIcon = (comment.recommended == false) ? 'd-none' : '' 
						let unFilledIcon = (comment.recommended == true) ? 'd-none' : '' 
						let commentBox = `
										<div class="my-3 border-bottom">
											<div class="row mb-3">
												<div>
													<span>\${comment.name }</span>
												</div>
												<div>
													<span>\${comment.createdDate }</span>
												</div>
											</div>
											<div class="row">
												<p>\${comment.content }</p>
											</div>
											<div class="row mb-3">
												<div class="col text-end pe-5">
													<div class="d-inline me-4">
														<button type="button" class="btn btn-outline-primary btn-sm \${ModifyAndDeleteBtn}">수정</button>
														<button type="button" class="btn btn-outline-danger btn-sm \${ModifyAndDeleteBtn}">삭제</button>
													</div>
													<div class="d-inline">
														<a href="" class="link-dark" data-comment-no="\${comment.no}">
															<i class="bi bi-hand-thumbs-up-fill fs-5 \${filledIcon}"></i>
															<i class="bi bi-hand-thumbs-up fs-5 \${unFilledIcon}"></i>
														</a>
														<span class="fs-5">\${comment.recommendCount }</span>
													</div>
												</div>						
											</div>
										</div>					
										`
						
						$commentListBox.append(commentBox)
					})
				})
	}
	
	// 추천 및 스크랩 아이콘 클릭하면 숫자 바뀌고 토글 
	function toggleIcon(clickedElement) {
		let isFilled = clickedElement.children('i:eq(1)').hasClass('d-none')
		let currentValue = Number(clickedElement.next().text())
		
		if (!isFilled) {
			clickedElement.next().text(currentValue + 1)
		} else {
			clickedElement.next().text(currentValue - 1)
		}
		
		clickedElement.children('i').toggleClass('d-none')
	}
	
	$commentListBox.on('click', 'a', function(event) {
		event.preventDefault();
		
		let clickedElement = $(this)
		$.get("/post/recommend-comment",
				{
					commentNo: $(this).data('comment-no')
				})
				.done(function () {
					toggleIcon(clickedElement)
				})
	})
			
	
	$("#toggle-scrap").click(function(event) {
		event.preventDefault();
		
		let clickedElement = $(this)
		$.get("/post/scrap", 
			  {
				postNo: postNo
			  })
			  .done(function () {
				toggleIcon(clickedElement)
			  })
	})
	
	$("#toggle-recommend").click(function(event) {
		event.preventDefault();
		
		let clickedElement = $(this)
		$.get("/post/recommend", 
			  {
				postNo: postNo
			  })
			  .done(function () {
				toggleIcon(clickedElement)
			  })
	})
	
	$commentRegisterInputBox.keyup(function () {
		if (!$(this) == "") {
			$(this).removeClass("is-invalid")
		}
	})
	
	$commentRegisterBtn.click(function () {
		if ($commentRegisterInputBox.val() == "") {
			$commentRegisterInputBox.addClass("is-invalid")
			return false
		}
		
		$.post("/post/register-comment",
				{
					postNo: postNo,
					content: $commentRegisterInputBox.val()
				})
				.done(function () {
					$commentRegisterInputBox.val("")
					$commentListBox.empty()
					getCommentList()
				})
				
	})
	
})
</script>
</body>
</html>