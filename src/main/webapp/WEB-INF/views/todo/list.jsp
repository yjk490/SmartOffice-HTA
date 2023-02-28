<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css">
<style>
tr button {
	width: 80px;
}
</style>
<title>애플리케이션</title>
</head>
<body>
<c:set var="top" value="todo" />
<%@ include file="../common/navbar.jsp"%>
<div class="container">
	<div class="row">
		<div class="col-2">
			<c:set var="left" value="${category.no }" />
			<%@ include file="../common/left/todoSide.jsp"%>
		</div>
		<div class="col-10">
			<div class="row">
				<div class="col-12">
					<form id="list" class="mb-3" method="post" action="list?category=${category.no }">
					<sec:csrfInput />
					<input type="hidden" name="category" value="${category.no }"/>
					<input type="hidden" name="page" value="${pagination.page }" />
						<c:choose>
							<c:when test="${category.name eq '나의 할 일' }">
								<h3 class="heading fw-bold">나의 할 일</h3>
							</c:when>
							<c:when test="${category.name eq '업무 요청' }">
								<h3 class="heading fw-bold">나의 업무요청</h3>
							</c:when>
							<c:when test="${category.name eq '업무 보고' }">
								<h3 class="heading fw-bold">나의 업무보고</h3>
							</c:when>
							<c:when test="${category.name eq '업무 일지' }">
								<h3 class="heading fw-bold">나의 업무일지</h3>
							</c:when>
							<c:when test="${category.name eq '수신 업무 요청' }">
								<h3 class="heading fw-bold">수신 업무</h3>
							</c:when>
						</c:choose>
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-3">
						<div class="d-flex justify-content-between">
							<select id="changeRows" class="form-select form-select-xs" style="width: 80px !important" name="rows">
								<option value="10" ${opt.rows eq 10 ? 'selected' : ''}>10</option>
								<option value="15" ${opt.rows eq 15 ? 'selected' : ''}>15</option>
								<option value="20" ${opt.rows eq 20 ? 'selected' : ''}>20</option>
							</select>
							<div class="mt-2">
								<input type="checkbox" name="important" value="Y" ${opt.important eq 'Y' ? 'checked' : '' }>중요
								<small>
									<c:if test="${category.name eq '나의 할 일' || category.name eq '업무 요청' || category.name eq '수신 업무 요청' }">
										<input type="checkbox" name="status" value="D" ${opt.status eq 'D' ? 'checked' : '' }>지연
									</c:if>
									<c:if test="${category.name eq '나의 할 일' || category.name eq '업무 요청' }">
										<input type="checkbox" name="status" value="W" ${opt.status eq 'W' ? 'checked' : '' }>작업
									</c:if>
									<c:if test="${category.name eq '업무 보고' || category.name eq '수신 업무 요청' || category.name eq '수신 업무 보고' }">
										<input type="checkbox" name="status" value="R" ${opt.status eq 'R' ? 'checked' : '' }>반려
									</c:if>
									 <c:if test="${category.name eq '업무 보고' || category.name eq '수신 업무 보고' }">
										<input type="checkbox" name="status" value="A" ${opt.status eq 'A' ? 'checked' : '' }>승인
									</c:if>
									<c:if test="${category.name eq '나의 할 일' || category.name eq '업무 요청' }">
										<input type="checkbox" name="status" value="C" ${opt.status eq 'C' ? 'checked' : '' }>완료
									</c:if>
								</small>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="row">
							<div class="col-2 text-end">
								<label class="form-label mt-2">from</label>
							</div>
							<div class="col-4">
								<input type="date" class="form-control" name="startDate" value="<fmt:formatDate value="${todo.startDate }" pattern="yyyy-MM-dd"/>" />
							</div>
							<div class="col-2 text-end">
								<label class="form-label mt-2">to</label>
							</div>
							<div class="col-4">
								<input type="date" class="form-control" name="endDate" value="<fmt:formatDate value="${todo.endDate }" pattern="yyyy-MM-dd"/>" />
							</div>
						</div>
					</div>
					<div class="col">
						<div class="input-group mb-3">
							<select class="form-select form-select-xs border-secondary"
								name="opt">
								<option value="title" ${opt.opt eq 'title' ? 'selected' : ''}>제목</option>
								<c:if test="${category.name eq '나의 할 일' || category.name eq '수신 업무 요청' }">
									<option value="writer" ${opt.opt eq 'writer' ? 'selected' : ''}>요청자</option>
								</c:if>
								<c:if test="${category.name eq '업무 요청' }">
									<option value="writer" ${opt.opt eq 'writer' ? 'selected' : ''}>담당자</option>
								</c:if>
								<c:if test="${category.name eq '업무 보고' || category.name eq '업무 일지'}">
									<option value="writer" ${opt.opt eq 'writer' ? 'selected' : ''}>수신자</option>
								</c:if>
								<c:if test="${category.name eq '수신 업무 보고' }">
									<option value="writer" ${opt.opt eq 'writer' ? 'selected' : ''}>보고자</option>
								</c:if>
								<c:if test="${category.name eq '수신 업무 일지' }">
									<option value="writer" ${opt.opt eq 'writer' ? 'selected' : ''}>등록자</option>
								</c:if>
								<option value="content" ${opt.opt eq 'content' ? 'selected' : ''}>내용</option>
							</select> 
							<input type="text" class="form-control w-25 border-secondary" name="keyword" value="${opt.keyword }">
							<button type="submit" class="btn btn-outline-secondary btn-xs" id="btn-search"> <i class="bi bi-search"></i></button>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-12">
						<table class="table table-sm">
							<colgroup>
								<col width="3%">
								<col width="7%">
								<col width="7%">
								<col width="12%">
								<col width="*">
								<col width="10%">
								<col width="10%">
								<c:choose>
									<c:when test="${category.name eq '나의 할 일' || category.name eq '업무 일지' || category.name eq '수신 업무 일지'}">
										<col width="10%">
									</c:when>
									<c:otherwise>
										<col width="10%">
										<col width="7%">
										<col width="7%">
									</c:otherwise>
								</c:choose>
							</colgroup>
							<thead>
								<tr>
									<th><input type="checkbox" id="allCheck"></th>
									<th class="text-center">번호</th>
									<th class="text-center">중요</th>
									<c:choose>
										<c:when test="${category.name eq '나의 할 일' || category.name eq '업무 요청' || category.name eq '업무 보고' }">
											<th class="text-center">업무보관함</th>
										</c:when>
										<c:otherwise>
											<th class="text-center">업무유형</th>
										</c:otherwise>
									</c:choose>
									<th class="text-center">제목</th>
									<c:if test="${category.name eq '업무 요청' }">
										<th class="text-center">담당자</th>
									</c:if>
									<c:if test="${category.name eq '수신 업무 요청' }">
										<th class="text-center">요청자</th>
									</c:if>
									<c:if test="${category.name eq '수신 업무 보고' }">
										<th class="text-center">보고자</th>
									</c:if>
									<c:if test="${category.name eq '업무 보고' || category.name eq '업무 일지' }">
										<th class="text-center">수신자</th>
									</c:if>
									<c:if test="${category.name eq '수신 업무 일지' }">
										<th class="text-center">등록자</th>
									</c:if>
									<c:if test="${category.name eq '업무 일지' || category.name eq '수신 업무 일지' }">
										<th class="text-center">등록일</th>
									</c:if>
									<c:if test="${category.name eq '나의 할 일' }">
										<th class="text-center"></th>
									</c:if>
									<c:if test="${category.name eq '나의 할 일' || category.name eq '업무 요청' || category.name eq '수신 업무 요청' || category.name eq '업무 보고' || category.name eq '수신 업무 보고'}">
										<th class="text-center">요청일</th>
										<th class="text-center">마감일</th>
										<th class="text-center">상태</th>
									</c:if>
									<c:if test="${category.name ne '나의 할 일' }">
										<th class="text-center">확인</th>
									</c:if>
								</tr>
							</thead>
							<tbody class="align-middle">
								<c:choose>
									<c:when test="${empty todos }">
										<p>등록된 업무가 없습니다.</p>
									</c:when>
									<c:otherwise>
										<c:forEach var="todo" items="${todos }">
											<tr id="infolist">
												<td><input type="checkbox" name="checklist" value=${todo.todoNo } /></td>
												<td id="no" class="text-center">${todo.todoNo }</td>
												<td class="text-center"><i class="${todo.important eq 'Y' ?  'fas fa-star w3-text-amber' : 'far fa-star w3-text-amber'} "></i></td>
												<c:choose>
													<c:when test="${category.name eq '나의 할 일' || category.name eq '업무 요청' || category.name eq '업무 보고' || category.name eq '업무 일지'}">
														<td class="text-center">${todo.boxName }</td>
													</c:when>
													<c:otherwise>
														<td class="text-center">${todo.jobCatName }</td>
													</c:otherwise>
												</c:choose>
												<td class="text-center"><a href="read?todoNo=${todo.todoNo }&category=${category.no}">${todo.title }</a></td>
												<c:if test="${category.name eq '업무 요청' || category.name eq '업무 보고' || category.name eq '업무 일지' }">
													<td class="text-center">${todo.receiveEmpName }</td>
												</c:if>
												<c:if test="${category.name eq '수신 업무 요청' || category.name eq '수신 업무 보고' || category.name eq '수신 업무 일지' }">
													<td class="text-center">${todo.empName }</td>
												</c:if>
												<c:if test="${category.name eq '나의 할 일' }">
													<td></td>
												</c:if>
												<c:if test="${category.name eq '업무 일지' || category.name eq '수신 업무 일지'}">
													<td class="text-center"><fmt:formatDate	value="${todo.createdDate }" /></td>
												</c:if>
												<c:if test="${category.name eq '나의 할 일' || category.name eq '업무 요청' || category.name eq '수신 업무 요청' || category.name eq '업무 보고' || category.name eq '수신 업무 보고'}">
													<td class="text-center"><fmt:formatDate value="${todo.startDate }" /></td>
												</c:if>
												<c:if test="${category.name eq '나의 할 일' || category.name eq '업무 요청' || category.name eq '수신 업무 요청' || category.name eq '업무 보고' || category.name eq '수신 업무 보고'}">
													<td class="text-center"><fmt:formatDate value="${todo.endDate }" /></td>
												</c:if>
												<c:if test="${category.name eq '나의 할 일' || category.name eq '업무 요청' || category.name eq '수신 업무 요청' || category.name eq '업무 보고' || category.name eq '수신 업무 보고'}">
													<c:choose>
														<c:when test="${todo.progressStatus eq 'W' }">
															<td class="text-center"><button type="button" class="text-white fw-bold btn btn-secondary btn-sm" disabled>작업중</button></td>
														</c:when>
														<c:when test="${todo.progressStatus eq 'C' }">
															<td class="text-center"><button type="button" class="text-white fw-bold btn btn-info btn-sm" disabled>완료</button></td>
														</c:when>
														<c:otherwise>
															<td class="text-center"><button type="button" class="text-white fw-bold btn btn-danger btn-sm" disabled>지연</button></td>
														</c:otherwise>
													</c:choose>
												</c:if>
												<c:choose>
													<c:when test="${category.name eq '업무 요청' || category.name eq '업무 보고' || category.name eq '업무 일지'}">
														<c:choose>
															<c:when test="${todo.read eq 'N' }">
																<td class="text-center"><button type="button" class="text-black fw-bold btn btn-light btn-outline-secondary btn-sm" >안읽음</button></td>
															</c:when>
															<c:otherwise>
																<td class="text-center"><button type="button" class="text-white fw-bold btn btn-success btn-sm" >읽음확인</button></td>
															</c:otherwise>
														</c:choose>
													</c:when>
													<c:when test="${category.no eq '104' }">
														<c:choose>
															<c:when test="${todo.read eq 'N' }">
																<td class="text-center"><button type="button" class="text-black fw-bold btn btn-light btn-outline-secondary btn-sm" >안읽음</button></td>
															</c:when>
															<c:otherwise>
																<td class="text-center"><button type="button" class="text-white fw-bold btn btn-success btn-sm" >읽음확인</button></td>
															</c:otherwise>
														</c:choose>
													</c:when> 
												</c:choose>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</form>
				</div>
			</div>
			<c:if test="${not empty todos }">
				<div class="w3-center" id="pagination">
					<div class="w3-bar">
					  <a class="page-link w3-button ${pagination.first ? 'disabled' : '' }" href="${pagination.prevPage }">«</a>
					  <c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">
					  	<a class="page-link w3-button ${pagination.page eq num ? 'w3-light-gray' : '' }" href="${num }">${num }</a>
					  </c:forEach>
					  <a class="page-link w3-button ${pagination.last ? 'disabled' : '' }" href="${pagination.nextPage }">»</a>
					</div>
				</div>
			</c:if>
			<div class="row">
				<div class="col-12 text-end">
					<a href="insert?category=${category.no }" class="btn btn-dark btn-sm">업무등록</a>
					<c:if test="${category.name ne '수신 업무 요청' }">
						<a id="boxSelect"class="btn btn-outline-dark btn-sm" data-bs-toggle="modal" data-bs-target="#modal-form-todoBox">보관함지정</a>
					</c:if>
					<a href="" class="btn btn-outline-dark btn-sm fw-bold">업무완료</a>
					<a id="delete" href="list?category=${category.no }" class="btn btn-outline-dark btn-sm">삭제</a>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 업무를 보관함에 넣기 -->
<div class="modal" tabindex="-1" id="modal-form-todoBox">
	<div class="modal-dialog">
		<form id="form-add-todoBox" class="p-3" method="get" action="todo-In-TodoBox">
		<input type="hidden" name="category" value="${category.no }"/>
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title fw-bold">보관함 선택</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-12">
						<div class="mb-2">
							<label class="form-label fw-bold">등록할 보관함을 선택해 주세요.</label>
							<div>
								<select class="form-select form-select-xs" name="boxNo">
								<c:forEach var="box" items="${todoBoxes }">
									<option value="${box.boxNo }" > ${box.boxName }</option>
								</c:forEach>
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
		</form>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
$(document).ready(function() {
	//체크박스 전체 선택&해제
	$('#allCheck').click(function() {
		if ($('#allCheck').prop("checked")) {
			$("input[name=checklist]").prop("checked", true);
		} else {
			$("input[name=checklist]").prop("checked", false);
		}
	});
	
	// 체크된 항목 삭제하기
	$('#delete').click(function() {
		if (confirm('삭제하시겠습니까?')) {
			
			var noArray = [];
			$("input[name=checklist]:checked").each(function() {
				let td = $(this).val();
				noArray.push(td);
			});
			
			if(noArray.length == 0) {
				alert("삭제할 업무를 체크하세요")
				event.preventDefault();
			} else {
				
				var param = noArray.map(function(no) {
					return "no=" + no;
				}).join("&");
				
				$.ajax({
					url: 'delete',
					type: 'get',
					data: param, 
					dataType: 'text',
					function(response) {
						console.log(response);
					}
				});
			}
		} else {
			return false;
		}
	})
	
	$('#form-add-todoBox').submit(function() {
		if (confirm('등록하시겠습니까?')) {
			
			var noArray = [];
			$("input[name=checklist]:checked").each(function() {
				let td = $(this).val();
				noArray.push(td);
			});
			
			if(noArray.length == 0) {
				alert("등록할 업무를 체크하세요")
				event.preventDefault();
			} else {
				
				var param = noArray.map(function(no) {
					return "no=" + no;
				}).join("&");
				
				$.ajax({
					url: 'todo-In-TodoBox',
					type: 'get',
					data: param, 
					dataType: 'text',
					function(response) {
						console.log(response);
					}
				});
			}
		} else {
			return false;
		}
	})
	
	// n개씩보기 설정할때마다 page번호 1로 변경
	$("#changeRows").change(function() {
		submitForm(1);
	})
	
	function submitForm(page) {
		var pageField = $("[name=page]");	
		pageField.value = page;									
		
		var form = $("#list");				
		form.submit();
	}
	
	$("#pagination a").click(function(event) {
		event.preventDefault();
		var page = $(this).attr("href")
		submitForm(page);
	})
	
});
</script>
</body>
</html>