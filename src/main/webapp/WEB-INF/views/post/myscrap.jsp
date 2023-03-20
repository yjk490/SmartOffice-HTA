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
			<div class="row border m-1 mb-2">
				<p class="fs-1 my-2">게시판 활동내역</p>
				<p class="fs-5 my-3">${loginUser.name }님이 스크랩한 게시글</p>
			</div>
			<form id="form-search" method="GET" action="myscrap">
				<input type="hidden" name="page" value="${pagination.page }" />
				<div class="m-1 mb-3 py-4 d-flex justify-content-end border-bottom">
					<div>
						<div class="d-inline-block">
							<select id="dropdown-rows" class="form-select form-select-xs border-secondary" name="rows">
								<option value="10" ${opt.rows eq 10 ? 'selected' : ''}>10개씩</option>
								<option value="15" ${opt.rows eq 15 ? 'selected' : ''}>15개씩</option>
								<option value="20" ${opt.rows eq 20 ? 'selected' : ''}>20개씩</option>
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
				<c:when test="${empty myscraps }">
					<div class="row mb-1 text-center">
						<span>게시글이 존재하지 않습니다.</span>
					</div>
				</c:when>
				<c:otherwise>
					<c:forEach var="post" items="${myscraps }">
						<div class="mb-3 p-1 border-bottom">
							<div class="row">
								<div class="col-6">
									<div class="row mb-2">
										<a href="/post/detail?postNo=${post.no }" class="link-dark">${post.title }</a>
									</div>
									<div class="row">
										<span class="text-truncate">${post.content }</span>
									</div>
								</div>
								<div class="col-6 text-end">
									<div class="row">
										<span>${post.scrapCreatedDateTimeToString }</span>
									</div>
								</div>
							</div>
						</div>	
					</c:forEach>
				</c:otherwise>
			</c:choose>
			<c:if test="${not empty myscraps }">
				<div class="row">
					<nav id="pagination">
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
$(function () {
	function submitForm(page) {
		$(":input[name=page]").val(page)
		$("#form-search").submit()
	}
	
	$("#dropdown-rows").change(function() {
		submitForm(1)
	})
	
	$("#btn-keyword").click(function() {
		submitForm(1)
	})
	
	$("#pagination a").click(function(event) {
		event.preventDefault();
		
		let page = $(this).attr("href")
		submitForm(page)
	})
	
})
</script>
</body>
</html>