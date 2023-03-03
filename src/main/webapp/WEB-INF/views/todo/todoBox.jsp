<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css">
<style>
tr button {
	width:80px;
}

</style>
<title>애플리케이션</title>
</head>
<body>
<c:set var="top" value="todo" />
<%@ include file="../common/navbar.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-2">
			<c:set var="left" value="todoBox" />
			<%@ include file="../common/left/todoBoxSide.jsp" %>
		</div>
		<div class="col-10">
			<div class="row">
				<div class="col-8">
					<h3 class="heading fw-bold">업무보관함 이름이 오는 곳</h3>
				</div>
				<div class="col text-end">
					<small>
						<input type="checkbox" name="type" value="Y">나의 할 일
						<input type="checkbox" name="type" value="Y">업무요청
						<input type="checkbox" name="type" value="Y">업무보고
						<input type="checkbox" name="type" value="Y">업무일지
					</small>
				</div>
			</div>
			<div class="row mb-3">
				<div class="col-3">
					<div class="d-flex justify-content-between">
						<select class="form-select form-select-xs" style="width: 80px !important" name="rows" onchange="changeRows()">
							<option value="10" > 10</option>
							<option value="15" > 15</option>
							<option value="20" > 20</option>
						</select>
					</div>
				</div>
				<div class="col">
					<div class="row">
						<div class="col-2 text-end">
							<label class="form-label mt-2">from</label>
						</div>
						<div class="col-4">
							<input type="date" class="form-control" name="beginDate" value="<fmt:formatDate value="${todo.beginDate }" pattern="yyyy-MM-dd"/>"/>
						</div>
						<div class="col-2 text-end">
							<label class="form-label mt-2">to</label>
						</div>
						<div class="col-4">
							<input type="date" class="form-control" name="endDate" value="<fmt:formatDate value="${todo.endDate }" pattern="yyyy-MM-dd"/>"/>				
						</div>
					</div>
				</div>
				<div class="col">
					<div class="input-group mb-3">
  						<select class="form-select form-select-xs border-secondary" name="opt">
							<option value="title"> 제목</option>
							<option value="writer"> 작성자</option>
							<option value="content"> 내용</option>
						</select>
						<input type="text" class="form-control w-25 border-secondary">
  						<button class="btn btn-outline-secondary" type="button"><i class="bi bi-search"></i></button>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-12">
					<table class="table table-sm">
						<colgroup>
							<col width="3%">
							<col width="7%">
							<col width="*">
							<col width="15%">
							<col width="15%">
							<col width="10%">
							<col width="10%">
						</colgroup>
						<thead>
							<tr>
								<th><input type="checkbox"></th>
								<th class="text-center">번호</th>
								<th class="text-center">제목</th>
								<th class="text-center">담당자</th>
								<th class="text-center">마감일</th>
								<th class="text-center">상태</th>
								<th class="text-center">확인</th>
							</tr>
						</thead>
						<tbody class="align-middle">
						<c:if test="${empty list }">
							<p>등록된 업무가 없습니다.</p>
						</c:if>
						<c:forEach var="list" items="${list }">
							<tr>
								<td><input type="checkbox" name="" value=""/></td>
								<td class="text-center">${list.todoNo }</td>
								<td class="text-center"><a href="detail?todoNo=${list.todoNo }&category=${list.jobCatNo}">${list.title }</a></td>
								<c:choose>
									<c:when test="${empty list.receiveEmpName }">
										<td class="text-center">없음</td>
									</c:when>
									<c:otherwise>
										<td class="text-center">${list.receiveEmpName }</td>
									</c:otherwise>
								</c:choose>
								<td class="text-center"><fmt:formatDate value="${list.endDate }" /></td>
								<c:choose>
									<c:when test="${list.status eq 'W' }">
										<td class="text-center"><button type="button" class="text-white fw-bold btn btn-secondary btn-sm" disabled>작업중</button></td>
									</c:when>
									<c:when test="${list.status eq 'C' }">
										<td class="text-center"><button type="button" class="text-white fw-bold btn btn-info btn-sm" disabled>완료</button></td>
									</c:when>
									<c:otherwise>
										<td class="text-center"><button type="button" class="text-white fw-bold btn btn-danger btn-sm" disabled>지연</button></td>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${list.read eq 'N' }">
										<td class="text-center"><button type="button" class="text-black fw-bold btn btn-light btn-outline-secondary btn-sm" disabled>안읽음</button></td>
									</c:when>
									<c:otherwise>
										<td class="text-center"><button type="button" class="text-white fw-bold btn btn-success btn-sm" disabled>읽음확인</button></td>
									</c:otherwise>
								</c:choose>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<div class="row">
				<div class="col-12">
					<div class="w3-center">
						<div class="w3-bar">
						  <a href="#" class="w3-button w3-hover-light-grey">«</a>
						  <a href="#" class="w3-button w3-hover-light-grey">1</a>
						  <a href="#" class="w3-button w3-hover-light-grey active">2</a>
						  <a href="#" class="w3-button w3-hover-light-grey">3</a>
						  <a href="#" class="w3-button w3-hover-light-grey">4</a>
						  <a href="#" class="w3-button w3-hover-light-grey">»</a>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-12 text-end">
					<p><i class="bi bi-info-circle-fill" style="color: red"></i> 제목을 누르면 상세화면이 열립니다.</p>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 업무보관함 추가하기 모달창 -->
<div class="modal" tabindex="-1" id="modal-form-todoBox">
	<div class="modal-dialog modal-lg">
		<form id="form-add-todoBox" class="p-3" method="post" action="insert-todoBox">
		<input type="hidden" name="boxNo" value="${boxNo }" />
		<sec:csrfInput />
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title fw-bold">업무보관함 추가하기</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-12 mb-2">
						<label class="form-label fw-bold">보관함 이름</label>
						<input type="text" class="form-control" name="boxName" />
					</div>
				</div>
				<div class="row">
					<div class="col-12">
						<div class="mb-2">
							<label class="form-label fw-bold">상위보관함 지정</label>
							<div>
								<select class="form-select form-select-xs" name="parentBoxNo">
									<option value="100" > 나의 할 일</option>
									<option value="101" > 업무 요청</option>
									<option value="102" > 업무 보고</option>
									<option value="103" > 업무 일지</option>
								</select>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				<button type="submit" class="btn btn-primary">등록하기</button>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
$("#form-add-todoBox").submit(function() {
	let title = $("input[name=boxname]").val();
	
	if (title == "") {
		alert("보관함 이름을 입력하세요");
		return false;
	}
	alert("등록 되었습니다.")
	return true;
});
</script>
</body>
</html>