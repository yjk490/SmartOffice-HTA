<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" 
	trimDirectiveWhitespaces="true" isErrorPage="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<title>애플리케이션</title>
</head>
<body>
<c:set var="top" value="home" />
<%@ include file="../common/navbar.jsp" %>
<div class="container">
	<div class="row mb-3">
		<div class="col-12">
			<div class="alert alert-danger">
				<h1 class="mb-4">샘플 애플리케이션 오류 페이지</h1>
				<p class="fs-4">오류 내용 : 접근 권한이 없습니다.<p>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>