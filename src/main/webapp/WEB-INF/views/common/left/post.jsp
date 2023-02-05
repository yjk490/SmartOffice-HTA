<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
<script src="https://kit.fontawesome.com/b910aa4676.js" crossorigin="anonymous"></script>
<style>
a:link { text-decoration:none; }
</style>
<title>애플리케이션</title>
</head>
<body>
<div class="container">
	<div class="row border me-5">
		<div class="border-bottom text-center py-3">
			<a href="/post/list" class="link-dark fs-3">게시판</a>
		</div>
		<div class="border-bottom text-center py-3">
			<a class="btn btn-dark btn-lg" href="/post/register-form">작성하기</a>
		</div>
		<div class="list-group p-3">
		  <a href="/post/notice" class="list-group-item list-group-item-action">알림
		   <span class="badge bg-primary rounded-pill float-end">3</span>
		  </a>
		  <a href="/post/mypost" class="list-group-item list-group-item-action">내가 쓴 글</a>
		  <a href="/post/mycomment" class="list-group-item list-group-item-action">내가 쓴 댓글</a>
		  <a href="/post/myscrap"class="list-group-item list-group-item-action">스크랩</a>
		  <a href="/post/myfile"class="list-group-item list-group-item-action">다운로드 파일</a>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>