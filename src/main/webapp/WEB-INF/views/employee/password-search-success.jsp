<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<title>SMART OFFICE</title>
</head>
<body>
<c:set var="top" value="login" />
<%@ include file="../common/navbar.jsp" %>
<div class="container">
	<div class="row mt-5">
		<div class="col-8 offset-2">
			<div class="w3-container w3-card-4 w3-light-grey w3-text-black w3-margin">
				<div class="row mb-3">
					<div class="col-12 mt-5 mb-3">
						<h2 class="w3-center"><b>비밀번호 찾기</b></h2>
					</div>
				</div>
				<div class="w3-row w3-margin">
					<div class="mt-4 mb-4"><b>비밀번호 찾기가 완료되었습니다.</b></div>
					<div class="mt-4 mb-4">임시 비밀번호는 <b>${temporaryPassword }</b>입니다. 로그인 후 비밀번호 변경을 통해 꼭 바꿔주세요.</div>
					<button type="button" class="w3-button w3-block w3-section w3-black"><a class="text-decoration-none" href="/login">로그인으로 돌아가기</a></button>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>