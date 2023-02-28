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
			<sec:authorize access="hasRole('ADMIN')">
				<div class="row border m-1 mb-2 text-danger">
					<p class="fs-1 my-2">자유 게시판</p>
					<p class="fs-5 my-3">관리자 모드입니다. 부적절한 게시글을 삭제할 수 있습니다.</p>
				</div>
			</sec:authorize>
			<sec:authorize access="hasRole('EMPLOYEE')">
				<div class="row border m-1 mb-2">
					<p class="fs-1 my-2">자유 게시판</p>
					<p class="fs-5 my-3">자유롭게 의견을 나누고 생각의 폭을 넓혀보세요.</p>
				</div>
			</sec:authorize>
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
									<span>${post.createdDateTimeToString }</span>
									<span class="ms-2"><i class="fa-regular fa-eye"></i> ${post.readCount }</span>
									<c:forEach var="map" items="${post.fileNamesMap }">
										<c:set var="savedFileName" value="${map.key}" />
										<c:set var="originalFileName" value="${map.value}" />
										<a href="/post/download?filename=${savedFileName }" 
										   class="btn btn-outline-dark btn-sm" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">
										   ${originalFileName }</a>
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
								<c:forEach var="tag" items="${post.tagContents }">
									<a href="/post/list?type=content&keyword=${tag }" >
									<span class="badge text-bg-success">${tag }</span>
									</a>
								</c:forEach>
							</div>
							<div class="col text-end pe-5">
							<sec:authorize access="hasRole('ADMIN')">
								<div class="d-inline me-4">
									<c:if test="${post.employeeNo eq loginUser.no }">
									<a href="/post/modify-post?postNo=${post.no }&employeeNo=${post.employeeNo }" class="btn btn-primary">수정</a>
									</c:if>
									<a href="/post/remove-post?postNo=${post.no }" class="btn btn-danger">삭제</a>
								</div>
							</sec:authorize>
							<sec:authorize access="hasRole('EMPLOYEE')">
							<c:if test="${post.employeeNo eq loginUser.no }">
								<div class="d-inline me-4">
									<a href="/post/modify-post?postNo=${post.no }&employeeNo=${post.employeeNo }" class="btn btn-outline-primary">수정</a>
									<a href="/post/delete-post?postNo=${post.no }&employeeNo=${post.employeeNo }" class="btn btn-outline-danger">삭제</a>
								</div>
							</c:if>
							</sec:authorize>
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

	getCommentList()
	function getCommentList() {
		$.getJSON('/post/role',
				{
					employeeNo: loginEmployeeNo
				})
				.done(function (employeeRoles) {
					let hasAdmin = employeeRoles.includes('ROLE_ADMIN');
					
					$.getJSON('/post/comment-list',
							{
								postNo: postNo,
								employeeNo: loginEmployeeNo
							})
							.done(function (comments) {
								$.each(comments, function(index, comment) {
									let modifyOrDeleteBtn = ""
									if (comment.employeeNo == loginEmployeeNo) {
										modifyOrDeleteBtn = `
															<button type="button" class="btn btn-outline-primary btn-sm" data-comment-event="modifyComment">수정</button>
															<button type="button" class="btn btn-outline-danger btn-sm"  data-comment-event="deleteComment">삭제</button>
															`
									} else if (hasAdmin) {
										modifyOrDeleteBtn = `<button type="button" class="btn btn-danger btn-sm" data-comment-event="deleteComment">삭제</button>`
									}
									
									let filledIcon = (comment.recommended == false) ? 'd-none' : '' 
									let unFilledIcon = (comment.recommended == true) ? 'd-none' : '' 
											
									let commentBox = `
													<div class="my-3 border-bottom" data-comment-event="commentBox">
													<p hidden 
														data-comment-name="\${comment.name }"
														data-comment-date="\${comment.createdDateTimeToString }"
														data-comment-content="\${comment.content }"
														data-comment-no="\${comment.no }"
														data-emp-no="\${comment.employeeNo }">
													</p>
														<div class="row mb-3">
															<div>
																<span>\${comment.name }</span>
															</div>
															<div>
																<span>\${comment.createdDateTimeToString }</span>
															</div>
														</div>
														<div class="row">
															<p>\${comment.content }</p>
														</div>
														<div class="row mb-3">
															<div class="col text-end pe-5">
																<div class="d-inline me-4">
																	\${modifyOrDeleteBtn}
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

	$commentListBox.on('click', 'button[data-comment-event=modifyComment]', function() {
		let $commentBox = $(this).parents('div[data-comment-event=commentBox]')
		let commentName = $commentBox.find('p').data('comment-name')
		let commentDate = $commentBox.find('p').data('comment-date')
		let commentContent = $commentBox.find('p').data('comment-content')		
		let commentNo = $commentBox.find('p').data('comment-no')
		let employeeNo = $commentBox.find('p').data('emp-no')
		let originalCommentBoxHtml = $commentBox.html()
		
		let modifyCommentBox = `
								<div class="row mb-3">
									<div>
										<span>\${commentName }</span>
									</div>
									<div>
										<span>\${commentDate }</span>
									</div>
								</div>		
								<div class="mb-3">
		  							<textarea class="form-control" name="modifiedContent" rows="3" placeholder="내용을 입력해주세요.">\${commentContent}</textarea>
									<div class="invalid-feedback">
										<span class="ps-2">댓글 내용을 입력해주세요.</span>
									</div>
								</div>
								<div class="mb-3 text-end">
									<button type="button" data-comment-event="modifyCommentCancel" class="btn btn-outline-secondary">취소</button>
									<button type="button" data-comment-event="modifyCommentComplete" class="btn btn-outline-primary">수정완료</button>
								</div>		
							   `
		$commentBox.html(modifyCommentBox)
		
		$('button[data-comment-event=modifyCommentCancel]').click(function () {
			$commentBox.html(originalCommentBoxHtml)
		})
		
		$('button[data-comment-event=modifyCommentComplete]').click(function () {
		    $.post("/post/modify-comment",
		    		{
						commentNo: commentNo,
						employeeNo: employeeNo,
						modifiedContent: $commentBox.find('textarea[name=modifiedContent]').val()
		    		})
		    		.done(function () {
						$commentListBox.empty()
						getCommentList()		    			
		    		})
		})
	})
	
	
	
	$commentListBox.on('click', 'button[data-comment-event=deleteComment]', function(event) {
		let $commentBox = $(this).parents('div[data-comment-event=commentBox]')
		$.get("/post/delete-comment",
				{
					commentNo:  $commentBox.find('p').data('comment-no'),
					employeeNo:  $commentBox.find('p').data('emp-no')
				})
				.done(function () {
					$commentBox.remove()
				})
	})
	
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
		$.get("/post/recommend-post", 
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