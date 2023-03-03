<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<style>
#todoBox {
	width: 170px;
}
</style>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css">
<title>애플리케이션</title>
</head>
<body>
<c:set var="top" value="todo" />
<%@ include file="../common/navbar.jsp" %>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col">
			<h1 class="fs-4 border p-2 bg-light">할 일 수정</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col">
			<p>제목과 내용을 입력하세요</p>
			<form id="form" class="border bg-light p-3" method="post" action="modify">
				<sec:csrfInput />
				<!-- 히든필드에 게시글 번호를 설정한다. -->
				<input type="hidden" name="todoNo" value="${modifyTodo.todoNo }" />
				<input type="hidden" name="category" value="${category }" />
				<div class="mb-2">
					<label class="form-label fw-bold">제목</label>
					<input type="text" class="form-control" name="title" value="${modifyTodo.title }"/>
				</div>
				<div class="mb-2 fw-bold" id="calendar">
					<label class="form-label ">시작일</label>
					<input type="date" class="form-control" name="startDate" value="<fmt:formatDate value="${modifyTodo.startDate }" pattern="yyyy-MM-dd"/>"/>
					<label class="form-label">종료일</label>
					<input type="date" class="form-control" name="endDate" value="<fmt:formatDate value="${modifyTodo.endDate }" pattern="yyyy-MM-dd"/>"/>
				</div>
				<div class="mb-2 fw-bold" id="todoBox">
					<label class="form-label">업무보관함 지정</label>
					<select class="form-select form-select-xs" name="boxNo">
					<c:forEach var="todoBox" items="${todoBoxes }">
						<c:choose>
							<c:when test="${empty todoBoxes }">
								<option value=""> 보관함을 생성하세요</option>
							</c:when>
							<c:otherwise>
								<option value="${todoBox.boxNo }"> ${todoBox.boxName }</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					</select>
				</div>
				<div>
					<label class="form-label fw-bold">업무상태 변경</label>
				</div>
				<div>
					<input class="form-check-input" type="radio" name="progressStatus" value="W" ${modifyTodo.progressStatus eq 'W' ? 'checked' : '' }>작업중
					<input class="form-check-input" type="radio" name="progressStatus" value="C" ${modifyTodo.progressStatus eq 'C' ? 'checked' : '' }>완료
				</div>
				<div>
					<input class="form-check-input" type="radio" name="important" value="N" ${modifyTodo.important eq 'N' ? 'checked' : ''}>일반
					<input class="form-check-input" type="radio" name="important" value="Y" ${modifyTodo.important eq 'Y' ? 'checked' : ''}>중요
				</div>
				<div class="mb-2">
					<label class="form-label fw-bold">내용</label>
					<textarea rows="4" class="form-control" name="content">${modifyTodo.content }</textarea>
				</div>
				<div class="mb-2">
					<label class="form-label fw-bold">첨부파일</label>
					<input type="file" class="form-control" name="upfile" />
				</div>
				<div class="text-end">
					<a href="detail?todoNo=${modifyTodo.todoNo }&category=${category}" class="btn btn-secondary btn-sm">취소</a>
					<button type="submit" class="btn btn-primary btn-sm">수정</button>
				</div>
			</form>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
$(function() {
	$("#form").submit(function() {
		let title = $("#form input[name=title]").val();
		let content = $("#form textarea[name=content]").val();
		
		if(title == "") {
			alert("제목은 필수입력값 입니다.")
			return false;
		}
		if(content == "") {
			alert("내용을 입력해주세요.")
			return false;
		}
		alert("수정 되었습니다.")
		return true;
	})
})
</script>
</body>
</html>