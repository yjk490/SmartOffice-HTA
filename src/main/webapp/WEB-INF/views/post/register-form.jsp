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
			<div class="row border m-1 mb-3">
				<p class="fs-1 my-2">글 작성하기</p>
			</div>
			<div class="row p-2 auto">
			<form>
				<div class="mb-4">
				  	<label class="form-label lead">제목</label>
				  	<input type="text" class="form-control" placeholder="제목을 입력해주세요.">
				</div>
				<div class="mb-4">
				  	<label class="form-label lead">태그</label>
				  	<input type="text" class="form-control" placeholder="태그를 입력해주세요.">
				</div>
				<div class="mb-4">
				  	<label class="form-label lead">내용</label>
				  	<textarea class="form-control" rows="10" placeholder="내용을 입력해주세요."></textarea>
				</div>
				<div class="mb-4">
  					<label class="form-label"></label>
  					<input class="form-control" type="file" multiple>
  					<small class="form-text text-muted p-2">최대 ~MB까지 첨부할 수 있습니다.</small>
				</div>
			</div>
			<div class="row p-2">
				<div class="text-end">
					<button class="btn btn-outline-secondary" type="submit">취소</button>
					<button class="btn btn-outline-primary" type="submit">완료</button>
				</div>
			</div>
			</form>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>