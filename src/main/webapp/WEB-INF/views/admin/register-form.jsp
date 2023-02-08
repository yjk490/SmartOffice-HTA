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
			<form:form modelAttribute="employeeRegisterForm" id="form-register" class="border p-3" method="post" action="/admin/form">
				<div class="mb-3 mt-3">
					<label class="form-label">접속 권한</label>
					<div>
						<div class="form-check form-check-inline">
 							<form:checkbox class="form-check-input" path="roleName" value="ROLE_EMP" />
							<label class="form-check-label">사원</label>
						</div>
						<div class="form-check form-check-inline">
 							<form:checkbox class="form-check-input" path="roleName" value="ROLE_ADMIN" />
							<label class="form-check-label">관리자</label>
						</div>
					</div>
					<form:errors path="roleName" cssClass="text-danger"/>
				</div>
				<div class="mb-3">
					<label class="form-label">이름</label>
					<form:input class="form-control form-control-sm" path="name" />
					<form:errors path="name" cssClass="text-danger"/>
				</div>
				<div class="mb-3">
					<label class="form-label">비밀번호</label>
					<form:password class="form-control form-control-sm" path="password" placeholder="기본 비밀번호인 zxcv1234로 설정해주세요." />
					<form:errors path="password" cssClass="text-danger"/>
				</div>
				<div class="mb-3">
					<label class="form-label">전화번호</label>
					<form:input class="form-control form-control-sm" path="tel" />
					<form:errors path="tel" cssClass="text-danger"/>
				</div>
				<div class="mb-3">
					<label class="form-label">이메일</label>
					<form:input class="form-control form-control-sm" path="email" />
					<form:errors path="email" cssClass="text-danger"/>
				</div>
				<div class="mb-3">
					<label class="form-label">부서</label>
					<form:select id="departments" class="form-select form-select-sm" name="departments" path="departmentNo">
						<form:option value="" selected="selected">부서를 선택해주세요</form:option>
						<form:option value="1001">기획</form:option>
						<form:option value="1002">인사</form:option>
						<form:option value="1003">총무</form:option>
						<form:option value="1004">회계</form:option>
						<form:option value="1005">영업</form:option>
						<form:option value="1006">개발</form:option>
						<form:option value="1007">IT</form:option>
						<form:option value="1008">마케팅</form:option>
					</form:select>
					<form:errors path="departmentNo" cssClass="text-danger"/>
				</div>
				<div class="mb-3">
					<label class="form-label">직급</label>
					<form:select class="form-select form-select-sm" name="position" path="positionNo">
						<form:option value="" selected="selected">직급을 선택해주세요</form:option>
						<form:option value="10001">사원</form:option>
						<form:option value="10002">주임</form:option>
						<form:option value="10003">대리</form:option>
						<form:option value="10004">과장</form:option>
						<form:option value="10005">차장</form:option>
						<form:option value="10006">부장</form:option>
						<form:option value="10007">이사</form:option>
						<form:option value="10008">상무</form:option>
						<form:option value="10009">전무</form:option>
						<form:option value="10010">부사장</form:option>
						<form:option value="10011">사장</form:option>
					</form:select>
					<form:errors path="positionNo" cssClass="text-danger"/>
				</div>
				<div class="mb-4">
					<label class="form-label" for="hireDate">입사일</label>
					<form:input class="form-control form-control-sm" path="hireDate" placeholder="ex.2020-01-01" />
					<form:errors path="hireDate" cssClass="text-danger"/>
				</div>
				<div class="text-end mt-3">
					<button type="button" class="w3-button w3-padding-small w3-round-large w3-light-gray"><a class="text-decoration-none" href="/admin/list">취소</a></button>
					<button type="submit" class="w3-button w3-padding-small w3-round-large w3-black">등록</button>
				</div>
			</form:form>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>