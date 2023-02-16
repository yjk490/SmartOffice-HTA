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
				<h1 class="fs-4 border p-2"><b>사원 등록 완료</b></h1>
			</div>
			<table class="table table-bordered">
				<colgroup>
					<col width="20%">
					<col width="*">
				</colgroup>
				<tbody>
					<tr>
						<th>사원 번호</th>
						<td>${emp.no }</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>${emp.name }</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>${emp.tel }</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>${emp.email }</td>
					</tr>
					<tr>
						<th>부서</th>
						<td>${emp.deptName }</td>
					</tr>
					<tr>
						<th>직급</th>
						<td>${emp.positionName }</td>
					</tr>
					<tr>
						<th>입사일</th>
						<td><fmt:formatDate value="${emp.hireDate }" pattern="yyyy-MM-dd" /></td>
					</tr>
			</table>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>