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
	<div class="row pt-4 mx-2">
		<div class="col-3"> <!-- 사이드 바 시작 -->
			<%@ include file="../common/left/post.jsp" %>
		</div> <!-- 사이드 바 끝 -->	
		<div class="col-9">
			<div class="row border m-1 mb-2">
				<p class="fs-1 my-2">게시판 활동내역</p>
				<p class="fs-5 my-3">OOO님이 쓴 댓글</p>
			</div>
			<div class="m-1 mb-3 py-4 d-flex justify-content-end border-bottom">
				<div class="mx-3">
					<select class="form-select form-select-xs" name="rows">
						<option value="10">10개씩</option>
						<option value="15">15개씩</option>
						<option value="20">20개씩</option>
					</select>
				</div>
				<div>
					<div class="input-group">
	  					<button class="btn btn-outline-secondary" type="button" ><i class="fa fa-search""></i></button>
	  					<input type="text" class="form-control border-secondary" name="keyword" value="" placeholder="검색어를 입력하세요." />
					</div>
				</div>
			</div>
			<div class="mb-3 p-2 border-bottom">
				<div class="row mb-2">
					<div class="col-6">
						<a href="/post/detail" class="link-dark">내가 댓글 쓴 게시글 제목</a>
					</div>
					<div class="col-6 text-end">
						<span>2023. 2. 6.(댓글 작성한 날짜)</span>
					</div>
				</div>
				<div class="row">
					<div>
						<span>댓글 내용 입니다. 댓글 내용 입니다. 댓글 내용 입니다. 댓글 내용 입니다. 댓글 내용 입...</span>
					</div>
				</div>
			</div>									
			<div class="mb-3 p-2 border-bottom">
				<div class="row mb-2">
					<div class="col-6">
						<a href="/post/detail" class="link-dark">내가 댓글 쓴 게시글 제목</a>
					</div>
					<div class="col-6 text-end">
						<span>2023. 2. 6.(댓글 작성한 날짜)</span>
					</div>
				</div>
				<div class="row">
					<div>
						<span>댓글 내용 입니다. 댓글 내용 입니다. 댓글 내용 입니다. 댓글 내용 입니다. 댓글 내용 입...</span>
					</div>
				</div>
			</div>									
			<div class="mb-3 p-2 border-bottom">
				<div class="row mb-2">
					<div class="col-6">
						<a href="/post/detail" class="link-dark">내가 댓글 쓴 게시글 제목</a>
					</div>
					<div class="col-6 text-end">
						<span>2023. 2. 6.(댓글 작성한 날짜)</span>
					</div>
				</div>
				<div class="row">
					<div>
						<span>댓글 내용 입니다. 댓글 내용 입니다. 댓글 내용 입니다. 댓글 내용 입니다. 댓글 내용 입...</span>
					</div>
				</div>
			</div>									
			<div class="mb-3 p-2 border-bottom">
				<div class="row mb-2">
					<div class="col-6">
						<a href="/post/detail" class="link-dark">내가 댓글 쓴 게시글 제목</a>
					</div>
					<div class="col-6 text-end">
						<span>2023. 2. 6.(댓글 작성한 날짜)</span>
					</div>
				</div>
				<div class="row">
					<div>
						<span>댓글 내용 입니다. 댓글 내용 입니다. 댓글 내용 입니다. 댓글 내용 입니다. 댓글 내용 입...</span>
					</div>
				</div>
			</div>									
			<div class="mb-3 p-2 border-bottom">
				<div class="row mb-2">
					<div class="col-6">
						<a href="/post/detail" class="link-dark">내가 댓글 쓴 게시글 제목</a>
					</div>
					<div class="col-6 text-end">
						<span>2023. 2. 6.(댓글 작성한 날짜)</span>
					</div>
				</div>
				<div class="row">
					<div>
						<span>댓글 내용 입니다. 댓글 내용 입니다. 댓글 내용 입니다. 댓글 내용 입니다. 댓글 내용 입...</span>
					</div>
				</div>
			</div>
			<div class="row">
				<nav>
					<ul class="pagination pagination justify-content-center pt-5">
						<li class="page-item">
							<a class="page-link link-dark" href=""><<</a>
						</li>
						<li class="page-item">
							<a class="page-link link-dark" href="">1</a>
						</li>
						<li class="page-item">
							<a class="page-link link-dark" href="">2</a>
						</li>
						<li class="page-item">
							<a class="page-link link-dark" href="">3</a>
						</li>
						<li class="page-item">
							<a class="page-link link-dark" href="">4</a>
						</li>
						<li class="page-item">
							<a class="page-link link-dark" href="">5</a>
						</li>
						<li class="page-item">
							<a class="page-link link-dark" href="">>></a>
						</li>
					</ul>
				</nav>
			</div>													
		</div>
	</div>   
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>