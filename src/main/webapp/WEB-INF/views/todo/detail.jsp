<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css">
<title>애플리케이션</title>
</head>
<body>
<style> 
#box {border: 1px solid lightgray;}
tr button {
	width:90px;
}
</style>

<c:set var="top" value="todo" />
<%@ include file="../common/navbar.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-3">
			<c:set var="left" value="${category.no }" />
			<%@ include file="../common/left/todoSide.jsp" %>
		</div>
		<div class="col-9">
		<h3 class="fw-bold">업무조회</h3>
			<table class="table table-sm mt-4" id="box">
				<colgroup>
					<col width="15%">
					<col width="35%">
					<col width="*">
				</colgroup>
				<tbody class="align-middle">
					<tr>
						<th class="fw-bold">제목</th>
						<td>${todos.title }</td>
						<th class="fw-bold">상태</th>
						<c:choose>
							<c:when test="${todos.progressStatus eq 'W' }">
								<td><button type="button" class="text-white fw-bold btn btn-secondary" disabled>작업중</button></td>
							</c:when>
							<c:when test="${todos.progressStatus eq 'C'}">
								<td><button type="button" class="text-white fw-bold btn btn-info" disabled>완료</button></td>
							</c:when>
							<c:otherwise>
								<td><button type="button" class="text-white fw-bold btn btn-danger" disabled>지연</button></td>
							</c:otherwise>
						</c:choose>
					</tr>
					<c:if test="${category.name ne '나의 할 일'}">
						<tr>
							<c:choose>
								<c:when test="${category.name eq '업무 요청' || category.name eq '업무 보고' || category.name eq '수신 업무 요청'}">
									<th>지시자</th>
								</c:when>
								<c:when test="${category.name eq '업무 일지' }">
									<th>등록자</th>
								</c:when>
								<c:when test="${category.name eq '수신 업무 보고' }">
									<th>보고자</th>
								</c:when>
							</c:choose>
							<c:if test="${category.name ne '나의 할 일' }">
								<td><i class="bi bi-person-circle me-1"></i>${todos.empName }</td>
							</c:if>
							<c:if test="${category.name eq '업무 요청' || category.name eq '업무 보고' || category.name eq '수신 업무 요청' }">
								<th>담당자</th>
							</c:if>
							<c:if test="${category.name eq '업무 일지' || category.name eq '수신 업무 보고' }">
								<th>수신자</th>
							</c:if>
							<c:if test="${category.name ne '나의 할 일' }">
								<c:forEach var="receiveEmp" items="${todos.receiveEmp }">
									<td><i class="bi bi-person-circle me-2"></i>${receiveEmp.receiveEmpName }</td>
								</c:forEach>
							</c:if>
						</tr>
					</c:if>
					<c:if test="${category.name eq '나의 할 일' ||category.name eq '업무 요청' || category.name eq '수신 업무 요청' || category.name eq '업무 보고' || category.name eq '수신 업무 보고'}">
						<tr>
							<th class="fw-bold">업무기한</th>
							<td><fmt:formatDate value="${todos.startDate }"/> ~ <fmt:formatDate value="${todos.endDate }"/></td>
							<td></td>
							<td></td>
						</tr>
					</c:if>
					<c:if test="${category.name ne '나의 할 일' }">
						<tr>
							<th>등록일</th>
							<td>2023-02-01</td>
							<th>수정일</th>
							<td>2023-03-01</td>
						<tr>
					</c:if>
					<tr>
						<th class="fw-bold">업무보관함</th>
						<td>${todos.boxName }</td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<th class="fw-bold">내용</th>
						<td>${todos.content }</td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<th class="fw-bold">첨부파일</th>
						<td><a href="download?filename=${file.filename } " class="btn btn-outline-dark btn-sm">Filename<i class="bi bi-download ms-2"></i></a></td>
						<td></td>
						<td></td>
					</tr>
				</tbody>
			</table>
			<c:if test="${category.name ne '나의 할 일' }">
				<h3 class="fw-bold pt-4">처리내역</h3>
				<table class="table table-sm mt-4" id="box">
					<colgroup>
						<col width="15%">
						<col width="*">
					</colgroup>
					<tbody class="align-middle">
						<tr>
							<button class="text-white fw-bold btn btn-danger float-end mb-2" disabled>처리율40%</button>
						</tr>
						<tr>
							<c:if test="${category.name eq '업무 요청' || category.name eq '업무 보고' || category.name eq '수신 업무 요청' || category.name eq '수신 업무 보고' }">
								<th>담당자</th>
							</c:if>
							<c:if test="${category.name eq '업무 일지' || category.name eq '수신 업무 일지' }">
								<th>수신자</th>
							</c:if>
							<td><i class="bi bi-person-circle me-1"></i>최연수 사원</td>
						</tr>
						<tr>
							<th>최종 수정일</th>
							<td>2023-01-30</td>
						</tr>
						<c:choose>
							<c:when test="${category.name ne '수신 업무 요청' }">
								<tr>
									<th> 진척율</th>
									<td> 40%</td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr>
									<th> 진척율</th>
									<td id="progress">
										<button data-process-value="0%" type="button" class="btn btn-light btn btn-outline-primary btn-sm" style="width: 60px;"  name="progressRate" value="0">0%</button>
										<button data-process-value="20%" type="button" class="btn btn-light btn btn-outline-primary btn-sm" style="width: 60px;" name="progressRate" value="0">20%</button>
										<button data-process-value="40%" type="button" class="btn btn-light btn btn-outline-primary btn-sm" style="width: 60px;" name="progressRate" value="0">40%</button>
										<button data-process-value="60%" type="button" class="btn btn-light btn btn-outline-primary btn-sm" style="width: 60px;" name="progressRate" value="0">60%</button>
										<button data-process-value="80%" type="button" class="btn btn-light btn btn-outline-primary btn-sm" style="width: 60px;" name="progressRate" value="0">80%</button>
										<button data-process-value="100%" type="button" class="btn btn-light btn btn-outline-primary btn-sm" style="width: 60px;"name="progressRate" value="0">100%</button>
										<div class="w3-light-grey w3-small mt-1">
											<!-- 
												let value = $(this).attr("data-process-value")
												$("#myBar").css('width', value).text(value)
											 -->
			    							<div id="myBar" class="w3-container w3-green w3-round-xlarge" style="width:25%">25%</div>
			  							</div>
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
						<tr>
							<th>내용</th>
							<td>test입니다.</td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<td><input type="file" class="form-control " name="upfile" /></td>
						</tr>
					</tbody>
				</table>
			</c:if>
			
			<c:if test="${category.name ne '나의 할 일' }">
				<div class="row mb-3">
				<div class="col-12 mb-1">
					<form method="post" action="addComment">
					<sec:csrfInput />
						<!-- 글 번호를 value에 설정하세요 -->
						<input type="hidden" name="todoNo" value="${todos.todoNo }"/>
						<input type="hidden" name="category" value="${category.no }" />
						<div class="row mb-3">
							<div class="col">
								<input type="text" class="form-control form-control-sm" style= "height: 35px" name="content" placeholder="댓글을 남겨주세요">
							</div>
							<div class="text-end" style="margin-top: 2px;" >
								<a href=""><button class="btn btn-secondary btn-xs" style= "width: 55px; height: 30px; --bs-btn-padding-y: .25rem;" >등록</button></a>
							</div>
						</div>
					</form>
				</div>
			</div>
			<c:forEach var="comment" items="${comments }">
				<div class="col-12 mb-2">
					<div class="card">
						<div class="card-body py-1 px-3 small border-bottom">
							<div class="mb-1 d-flex justify-content-between text-muted">
								<span>${comment.employeeName }</span>
								<span><span class="me-4"><fmt:formatDate value="${comment.createdDate }"/></span> <a href="#" id="trash" class="text-danger"><i class="bi bi-trash-fill"></i></a></span>
							</div>
							<p class="card-text">${comment.content }</p>
						</div>
					</div>
				</div>
			</c:forEach>
			</c:if>
			<div class="row float-end">
				<div class="col">
					<a href="" class="btn btn-primary btn-sm fw-bold">업무완료</a>
					<a href="modify?todoNo=${todos.todoNo }&category=${category.no}" class="btn btn-outline-dark btn-sm">수정</a>
					<a id="delete" href="deleteOne?category=${category.no }&todoNo=${todos.todoNo}" class="btn btn-outline-dark btn-sm fw-bold">삭제</a>
					<a href="list?category=${category.no }" class="btn btn-outline-dark btn-sm">목록</a>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
$("#progress .btn").click(function() {
	let value = $(this).attr("data-process-value");
	$("#myBar").css('width', value).text(value);
})
$(function() {
	$("#delete").click(function() {
		if(confirm("삭제하시겠습니까?")) {
			alert("삭제되었습니다.")
			return true;
		} else {
			return false;
		}
	})
	
	$("#trash").click(function() {
		if(confirm("댓글을 삭제하시겠습니까?")) {
			alert("삭제되었습니다.")
			return true;
		} else {
			return false;
		}
	})
})
</script>
</body>
</html>