<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css">
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<title>SMART OFFICE</title>
</head>
<body>
<c:set var="top" value="employee" />
<%@ include file="../common/navbar.jsp" %>
<div class="container">
	<div class="row g-3">
		<div class="col-3">
			<c:set var="left" value="password" />
			<%@ include file="../common/left/employee.jsp" %>
		</div>
		<div class="col-9">
			<div class="col-12 mb-3">
				<h1 class="fs-4 border p-2">비밀번호 변경</h1>
			</div>
			<div class="col-12 mb-3">
				<div class="fs-5 border p-2 text-center"><b>비밀번호가 성공적으로 변경되었습니다.</b></div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#form-change-password").submit(function() {
		let empNo = $(":password[name=empNo]").val();
		let oldPassword = $(":password[name=oldPassword]").val();
		let password = $("#password").val();
		let passwordConfirm = $("#password-confirm").val();
		
		if(empNo == ""){
			alert("사원번호는 필수 입력값입니다.");
			return false;
		}
		if (oldPassword == "") {
			alert("기존 비밀번호는 필수 입력값입니다.");
			return false;
		}
		if (password == "") {
			alert("새 비밀번호는 필수 입력값입니다.");
			return false;
		}
		if (passwordConfirm == "") {
			alert("비밀번호 확인은 필수 입력값입니다.");
			return false;
		}
		if (oldPassword == password) {
			alert("새 비밀번호를 이전 비밀번호와 같은 값으로 지정할 수 없습니다.");
			return false;
		}
		if (password != passwordConfirm) {
			alert("새 비밀번호와 비밀번호 확인 값이 서로 일치하지 않습니다.");
			return false;
		}
		
		return true;
	});
})
</script>
</body>
</html>