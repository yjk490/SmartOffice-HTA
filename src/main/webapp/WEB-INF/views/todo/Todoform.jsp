<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<style>
#todoBox {
	width: 170px;
}
.box {
	float:left;
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
			<h1 class="fs-4 border p-2 bg-light">업무등록 하기</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col">
			<p>제목과 내용을 입력하세요</p>
			<form id="form" class="border bg-light p-3" method="post" action="insert" enctype="multipart/form-data">
				<sec:csrfInput />
				<div>
					<label class="form-label fw-bold">업무유형을 선택하세요</label>
				</div>
				<div>
					<input id="todo" class="form-check-input" type="radio" name="jobCatNo" value="100" ${category eq 100 ? 'checked' : '' } >나의 할일
					<input id="request" class="form-check-input" type="radio" name="jobCatNo" value="101" ${category eq 101 || category eq 104 ? 'checked' : '' }>업무 요청
					<input id="report" class="form-check-input" type="radio" name="jobCatNo" value="102" ${category eq 102 || category eq 105? 'checked' : ''}>업무 보고
					<input id="daily" class="form-check-input" type="radio" name="jobCatNo" value="103" ${category eq 103 || category eq 106? 'checked' : ''}>업무 일지
				</div>
				<div class="mb-2">
					<label class="form-label fw-bold">제목</label>
					<input type="text" class="form-control" name="title" />
				</div>
				<div class="row">
					<div class="col-12" name="append">
						<div class="mb-2 ms-2 box" id="receiver" style="width: 12%;">
							<label class="form-label fw-bold">수신자 지정</label> <button type="button" class="btn btn-light btn-sm btn-outline-dark" id="plusbtn"><i class="bi bi-plus-lg"></i></button>
							<div id="select">
								<select class="form-select form-select-xs" name="receiveEmpNo">
									<option value="" > 지정안함</option>
									<c:forEach var="receive" items="${receiveList }">
										<option value="${receive.employeeNo }" > ${receive.employeeName } [${receive.positionName }]</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-12">
						<div class="mb-2 fw-bold" id="calendar">
							<label class="form-label">시작일</label>
							<input type="date" class="form-control" name="startDate" value="<fmt:formatDate value="" pattern="yyyy-MM-dd"/>"/>
							<label class="form-label ">종료일</label>
							<input type="date" class="form-control" name="endDate" value="<fmt:formatDate value="" pattern="yyyy-MM-dd"/>"/>
						</div>
					</div>
				</div>
				<div class="mb-2" id="todoBox">
					<label class="form-label fw-bold">업무보관함 지정</label>
					<select class="form-select form-select-xs" name="boxNo">
					<c:forEach var="todoBox" items="${todoBoxes }">
						<c:choose>
							<c:when test="${empty todoBoxes }">
								<option value="" > 보관함을 등록해 주세요</option>
							</c:when>
							<c:otherwise>
								<option value="${todoBox.boxNo }"> ${todoBox.boxName }</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					</select>
				</div>
				<div class="mb-2">
					<label class="form-label fw-bold">내용</label>
					<textarea rows="4" class="form-control" name="content"></textarea>
				</div>
			
				<div class="mt-1">
					<input class="form-check-input" type="radio" name="important" value="N" checked>일반
					<input class="form-check-input" type="radio" name="important" value="Y">중요
				</div>
				<div class="mb-2">
					<label class="form-label fw-bold mt-2">첨부파일</label>
					<input type="file" class="form-control" name="upfile" />
				</div>
				<div class="text-end">
					<a href="list" class="btn btn-secondary btn-sm">취소</a>
					<button type="submit" class="btn btn-primary btn-sm">등록</button>
				</div>
			</form>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
$(function() {
$(".box").hide();
	$("input[name='jobCatNo']").change(function() {
		if($("input[name='jobCatNo']:checked").val() == '100') {
			$("#receiver").hide();
		} else if ($("input[name='jobCatNo']:checked").val() == '101') {
			$("#receiver").show();
		} else if ($("input[name='jobCatNo']:checked").val() == '102') {
			$("#receiver").show();
		} else if ($("input[name='jobCatNo']:checked").val() == '103') {
			$("#receiver").show();
		}
	});
	
	$("#plusbtn").click(function() {
		let div = $("div[name='append']");
		let select = `
			<div class="mt-2 ms-2 box" id="receiver" style="width: 12%;">
				<label class="form-label"></label>
				<div id="select">
					<select class="form-select form-select-xs" name="receiveEmpNo">
						<option value="" > 지정안함</option>
						<c:forEach var="receive" items="${receiveList }">
							<option value="${receive.employeeNo }" > ${receive.employeeName }  [${receive.positionName }]</option>
						</c:forEach>
					</select>
				</div>
			</div>
		`
		div.append(select);
	});
	
	$("#form").submit(function() {
		let title = $("#form input[name=title]").val();
		let startDate = $("#form input[name=startDate]").val();
		let endDate = $("#form input[name=endDate]").val();
		let content = $("#form textarea[name=content]").val();
		
		if (title == "") {
			alert("제목을 입력하세요");
			return false;
		}
		if (startDate == "") {
			alert("시작일을 지정하세요");
			return false;
		}
		if (endDate == "") {
			alert("종료일을 지정하세요");
			return false;
		}
		if (content == "") {
			alert("내용을 입력하세요");
			return false;
		}
		alert("등록 되었습니다.")
		return true;
	});
});
</script>
</body>
</html>