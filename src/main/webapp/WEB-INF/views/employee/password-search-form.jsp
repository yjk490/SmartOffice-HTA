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
			<form id="form-search-password" method="post" action="help" class="w3-container w3-card-4 w3-light-grey w3-text-black w3-margin">
				<div class="row mb-5">
					<div class="col-12 mt-5">
						<h2 class="w3-center"><b>비밀번호 찾기</b></h2>
					</div>
				</div>
				<div class="w3-row w3-margin">
					<div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-user"></i></div>
					<div class="w3-rest">
						<input class="w3-input w3-border" name="no" type="text" placeholder="사원번호">
					</div>
				</div>
				
				<div class="w3-row w3-margin">
					<div class="w3-col" style="width:50px"><i class="w3-xxlarge fas fa-envelope"></i></div>
					<div class="w3-rest">
						<input class="w3-input w3-border" name="email" type="text" placeholder="이메일">
					</div>
				</div>
				<div class="w3-center mb-5">
					<button type="submit" class="w3-button w3-block w3-section w3-black"><b>비밀번호 찾기</b></button>
				</div>
			</form>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>