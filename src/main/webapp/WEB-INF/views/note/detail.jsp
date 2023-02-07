<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css">
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<title>SMART OFFICE</title>
</head>
<body>
<c:set var="top" value="note" />
<%@ include file="../common/navbar.jsp" %>
<div class="container">
	<div class="row g-3">
		<div class="col-3">
			<%@ include file="../common/left/note.jsp" %>
		</div>
		<div class="col-9">
			<div class="col-12 mb-3">
				<h1 class="fs-4 border p-2">쪽지</h1>
			</div>
			<div class="border p-3">
				<table class="table table-sm">
					<colgroup>
						<col width="15%">
						<col width="35%">
						<col width="15%">
						<col width="35%">
					</colgroup>
					<tbody>
						<tr>
							<th>제목</th>
							<td colspan="3"><i class="fas fa-star w3-text-amber"></i> 테스트(중요메세지는 앞에 별표)</td>
						</tr>
						<tr>
							<th>보낸사람</th>
							<td>홍길동</td>
							<th>받는사람</th>
							<td>강감찬</td>
						</tr>
						<tr>
							<th>보낸일자</th>
							<td colspan="3">2023.02.01</td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<td colspan="3">
							 등록된 첨부파일이 없습니다.
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td colspan="3">
							 쪽지테스트입니다. 쪽지테스트입니다. 쪽지테스트입니다. 쪽지테스트입니다. 쪽지테스트입니다. 쪽지테스트입니다. 쪽지테스트입니다. 쪽지테스트입니다. 
							</td>
						</tr>
					</tbody>
				</table>
				<div class="row">
					<div class="text-end col-12">
						<button class="w3-button w3-padding-small w3-round-large w3-light-gray w3-text-gray"><a class="text-decoration-none" href="">삭제</a></button>
						<button class="w3-button w3-padding-small w3-round-large w3-light-gray"><a class="text-decoration-none" href="">보관</a></button>
						<button class="w3-button w3-padding-small w3-round-large w3-black"><a class="text-decoration-none" href="">첨부파일</a></button>
						<button class="w3-button w3-padding-small w3-round-large w3-light-gray"><a class="text-decoration-none" href="">답장</a></button>
						<button class="w3-button w3-padding-small w3-round-large w3-black"><a class="text-decoration-none" href="/note/receive">목록</a></button>
					</div>
				</div>
			</div>
		</div>
   	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>