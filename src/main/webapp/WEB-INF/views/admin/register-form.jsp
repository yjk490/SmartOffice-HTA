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
<c:set var="top" value="admin" />
<%@ include file="../common/navbar.jsp" %>
<div class="container">
	<div class="row g-3">
		<div class="col-3">
			<%@ include file="../common/left/admin.jsp" %>
		</div>
		<div class="col-9">
			<div class="col-12 mb-3">
				<h1 class="fs-4 border p-2">사원 등록</h1>
			</div>
			<form id="form-register" class="border p-3" method="post" action="register">
				<div class="mb-3 mt-3">
					<label class="form-label">접속 권한</label>
					<div>
						<div class="form-check form-check-inline">
 							<input class="form-check-input" type="checkbox" path="roleName" value="ROLE_EMP">
							<label class="form-check-label">사원</label>
						</div>
						<div class="form-check form-check-inline">
 							<input class="form-check-input" type="checkbox" path="roleName" value="ROLE_ADMIN">
							<label class="form-check-label">관리자</label>
						</div>
					</div>
				</div>
				<div class="mb-3">
					<label class="form-label">이름</label>
					<input type="text" class="form-control form-control-sm" path="name" />
				</div>
				<div class="mb-3">
					<label class="form-label">비밀번호</label>
					<input type="password" class="form-control form-control-sm" path="password" placeholder="기본 비밀번호인 zxcv1234로 설정해주세요." />
				</div>
				<div class="mb-3">
					<label class="form-label">전화번호</label>
					<input type="text" class="form-control form-control-sm" path="tel" />
				</div>
				<div class="mb-3">
					<label class="form-label">이메일</label>
					<input type="text" class="form-control form-control-sm" path="email" />
				</div>
				<div class="mb-3">
					<label class="form-label">부서</label>
					<select id="departments" class="form-select form-select-sm" name="departments" path="departmentNo">
						<option selected="selected">부서를 선택해주세요</option>
						<option value="1001">기획</option>
						<option value="1002">인사</option>
						<option value="1003">총무</option>
						<option value="1004">회계</option>
						<option value="1005">영업</option>
						<option value="1006">개발</option>
						<option value="1007">IT</option>
						<option value="1008">마케팅</option>
					</select>
				</div>
				<div class="mb-3">
					<label class="form-label">직급</label>
					<select class="form-select form-select-sm" name="position" path="positionNo">
						<option selected="selected">직급을 선택해주세요</option>
						<option value="10001">사원</option>
						<option value="10002">주임</option>
						<option value="10003">대리</option>
						<option value="10004">과장</option>
						<option value="10005">차장</option>
						<option value="10006">부장</option>
						<option value="10007">이사</option>
						<option value="10008">상무</option>
						<option value="10009">전무</option>
						<option value="10010">부사장</option>
						<option value="10011">사장</option>
					</select>
				</div>
				<div class="mb-4">
				<form action="/action_page.php">
					<label class="form-label" for="hireDate">입사일</label>
					<input type="date" class="form-control form-control-sm" id="hireDate" name="hireDate" path="hireDate">
				</form>
				</div>
				<div class="text-end mt-3">
					<button class="w3-button w3-padding-small w3-round-large w3-light-gray"><a class="text-decoration-none" href="/admin/list">취소</a></button>
					<button type="submit" class="w3-button w3-padding-small w3-round-large w3-black">등록</button>
				</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>