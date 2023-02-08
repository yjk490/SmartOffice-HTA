<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css">
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<style>
.btn-xs {
	margin-top: -4px; 
	--bs-btn-padding-y: .25rem; 
	--bs-btn-padding-x: .5rem; 
	--bs-btn-font-size: .75rem;
}
.form-select-xs {
	min-height: calc(1.5em + 0.5rem + 2px);
    padding: 0.25rem 0.5rem;
    font-size: .875rem;
    border-radius: 0.25rem;
    width: 90px;
    display: inline-block !important;
}
.form-control-xs{
 	min-height: calc(1.5em + 0.5rem + 2px);
    padding: 0.25rem 0.5rem;
    font-size: .875rem;
    border-radius: 0.25rem;
    width: 150px;
    display: inline-block !important;
 }
.w-150 {
	min-width: 150px !important;
}
  }
</style>
<title>애플리케이션</title>
</head>
<body>
<c:set var="top" value="admin" />
<%@ include file="../common/navbar.jsp" %>
<div class="container">
	<div class="row g-3">
		<div class="col-3">
			<c:set var="left" value="emplist" />
			<%@ include file="../common/left/admin.jsp" %>
		</div>
		<div class="col-9">
		<div class="col-12 mb-3">
			<h1 class="fs-4 border p-2">사원 관리</h1>
		</div>
		<div class="mb-3 d-flex justify-content-between">
			<input type="hidden" name="page" value="" />
			<div>
				<select class="form-select form-select-xs" name="rows">
					<option>10개씩</option>
					<option>15개씩</option>
					<option>20개씩</option>
				</select>
			</div>
			<div>
				<select class="form-select form-select-xs" name="opt">
					<option>사원이름</option>
					<option>사원번호</option>
					<option>부서명</option>
				</select>
				<input type="text" class="form-control form-control-xs" name="keyword" value="" />
				<button type="button" class="btn btn-outline-secondary btn-xs" id="btn-search"><i class="fa fa-search"></i></button>
			</div>
		</div>
		<table class="table table-sm">
				<colgroup>
					<col width="5%">
					<col width="10%">
					<col width="17%">
					<col width="20%">
					<col width="*">
					<col width="13%">
					<col width="10%">
				</colgroup>
				<thead>
					<tr>
						<th>
							<div>
 								<input class="form-check-input" type="checkbox" id="checkboxNoLabel" value="" aria-label="...">
							</div>
						</th>
						<th class="text-center">사원이름</th>
						<th class="text-center">사원번호</th>
						<th class="text-center">전화번호</th>
						<th class="text-center">이메일</th>
						<th class="text-center">부서명</th>
						<th class="text-center">상태</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<div>
 								<input class="form-check-input" type="checkbox" id="checkboxNoLabel" value="" aria-label="...">
							</div>
						</td>
						<td class="text-center">강감찬</td>
						<td class="text-center">10001</td>
						<td class="text-center">010-1111-1111</td>
						<td class="text-center">kang@naver.com</td>
						<td class="text-center">인사부</td>
						<td class="text-center">정상</td>
					</tr>
					<tr>
						<td>
							<div>
 								<input class="form-check-input" type="checkbox" id="checkboxNoLabel" value="" aria-label="...">
							</div>
						</td>
						<td class="text-center">김연경</td>
						<td class="text-center">10002</td>
						<td class="text-center">010-2222-2222</td>
						<td class="text-center">kim@naver.com</td>
						<td class="text-center">홍보부</td>
						<td class="text-center">중지</td>
					</tr>
			</table>
			<div class="w3-bar">
			  <button class="w3-button w3-padding-small w3-round-large w3-black">선택중지</button>
			  <button class="w3-button w3-padding-small w3-round-large w3-light-gray">선택해지</button>
			  <button class="w3-button w3-padding-small w3-right w3-round-large w3-black"><a class="text-decoration-none" href="/admin/form"><b>사원등록</b></a></button>
			</div>
			<div class="w3-center">
				<div class="w3-bar">
				  <a href="#" class="w3-button">«</a>
				  <a href="#" class="w3-button w3-light-gray">1</a>
				  <a href="#" class="w3-button">2</a>
				  <a href="#" class="w3-button">3</a>
				  <a href="#" class="w3-button">4</a>
				  <a href="#" class="w3-button">»</a>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>