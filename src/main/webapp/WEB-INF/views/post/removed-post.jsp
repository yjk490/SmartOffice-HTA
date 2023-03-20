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
			<div class="row border m-1 mb-2 text-danger">
				<p class="fs-1 my-2">삭제한 게시글</p>
				<p class="fs-5 my-3">삭제한 게시글을 복구하거나 영구삭제할 수 있습니다.</p>
			</div>
			<form id="form-search" method="GET" action="removed-post-list">
				<input type="hidden" name="page" value="${pagination.page }" />
				<div class="m-1 mb-3 py-4 d-flex justify-content-between border-bottom">
					<div class="col-6 text-start">
						<div class="d-inline-block">
							<select id="dropdown-rows" class="form-select form-select-xs border-secondary" name="rows">
								<option value="10" ${opt.rows eq 10 ? 'selected' : ''}>10개씩</option>
								<option value="15" ${opt.rows eq 15 ? 'selected' : ''}>15개씩</option>
								<option value="20" ${opt.rows eq 20 ? 'selected' : ''}>20개씩</option>
							</select>
						</div>
					</div>
					<div class="col-6 text-end">
						<div class="d-inline-block">
							<select class="form-select form-select-xs border-secondary" name="type">
								<option value="title" ${opt.type eq 'title' ? 'selected' : '' }>제목</option>
								<option value="content" ${opt.type eq 'content' ? 'selected' : '' }>제목+내용</option>
								<option value="name" ${opt.type eq 'name' ? 'selected' : '' }>이름</option>
							</select>
						</div>
						<div class="d-inline-block">
							<div class="input-group">
				  				<button id="btn-keyword" class="btn btn-outline-secondary" type="button"><i class="fa fa-search""></i></button>
				  				<input type="text" class="form-control border-secondary" name="keyword" value="${opt.keyword }" placeholder="검색어를 입력하세요." />
							</div>
						</div>
					</div>
				</div>
			</form>
			<c:choose>
				<c:when test="${empty removedPosts }">
					<div class="row mb-1 text-center">
						<span>삭제한 게시글이 존재하지 않습니다.</span>
					</div>
				</c:when>
				<c:otherwise>
				<form id="form-recover-or-delete-post" method="GET">
					<c:forEach var="post" items="${removedPosts }">
						<div class="mb-3 p-1 border-bottom">
							<div class="row mb-2">
								<div class="col-6">
									<div class="row mb-2">
										<a href="/post/detail?postNo=${post.no }" class="link-dark">${post.title }</a>
									</div>
									<div class="row">
										<span class="text-truncate">${post.content }</span>
									</div>
								</div>
								<div class="col-6 text-end">
									<div class="row mb-2">
										<span>${post.createdDateTimeToString }</span>
									</div>
									<div class="d-inline">
										<input class="form-check-input mx-2" type="checkbox" name="postNo" value="${post.no }">
										<a href="/post/recover-post?postNo=${post.no }" class="btn btn-outline-success btn-sm">복구</a>
										<a href="/post/delete-post?postNo=${post.no }" class="btn btn-outline-danger btn-sm">영구삭제</a>
									</div>
								</div>
							</div>
						</div>	
					</c:forEach>
					<div class="mb-3 p-1 text-end">
						<button id="btn-check-all" type="button" class="btn btn-outline-secondary btn-sm">전체선택</button>
						<input type="submit" class="btn btn-success btn-sm" value="복구" formaction="recover-post">
						<input type="submit" class="btn btn-danger btn-sm" value="영구삭제" formaction="delete-post">
					</div>
				</form>	
				</c:otherwise>
			</c:choose>
			<c:if test="${not empty removedPosts }">
				<div class="row">
					<nav id="pagenation">
						<ul class="pagination pagination justify-content-center pt-5">
							<li class="page-item">
								<a class="page-link link-dark ${pagination.first ? 'disabled' : '' }" href="${pagination.prevPage }" aria-label="Previous">
									<span aria-hidden="true">&laquo;</span>
								</a>
							</li>
							<c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">
								<li class="page-item">
									<a class="page-link ${pagination.page eq num ? 'active' : '' }" href="${num}">${num }</a>
								</li>
							</c:forEach>
							<li class="page-item">
								<a class="page-link link-dark ${pagination.last ? 'disabled' : '' }" href="${pagination.nextPage }" aria-label="Previous">
									<span aria-hidden="true">&raquo;</span>
								</a>
							</li>
						</ul>
					</nav>
				</div>			
			</c:if>			
		</div>
	</div>   
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	
	// 검색 옵션, 정렬 기준, 페이지번호가 쿼리스트링으로 있는 Form태그를 전송하는 함수
	function submitForm(page) {
		$(":input[name=page]").val(page)
		$("#form-search").submit()
	}
	
	// 한 페이지에 출력할 행 개수를 바꾸면 페이지 번호를 1로 초기화하고 전송
	$("#dropdown-rows").change(function() {
		submitForm(1)
	})
	
	// 페이지 번호를 클릭하면 해당 페이지번호를 입력해서 전송
	$("#pagination a").click(function(event) {
		event.preventDefault();
		
		let page = $(this).attr("href")
		submitForm(page)
	})
	
	// 검색어를 입력하고 검색 버튼을 누르면 페이지 번호를 1로 초기화하고 전송
	$("#btn-keyword").click(function() {
		submitForm(1)
	})	
	
	$("#btn-check-all").click(function() {
		let total = $("#form-recover-or-delete-post :checkbox").length
		let checked = $("#form-recover-or-delete-post :checked").length
		
		if (total != checked) {
			$("#form-recover-or-delete-post :checkbox").prop("checked", true)
		} else {
			$("#form-recover-or-delete-post :checkbox").prop("checked", false)
		}
	})
	
})
</script>
</body>
</html>