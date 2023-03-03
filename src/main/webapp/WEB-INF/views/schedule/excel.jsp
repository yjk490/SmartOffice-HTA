<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<title>애플리케이션</title>
</head>
<body>
<c:set var="top" value="schedule" />
<%@ include file="../common/navbar.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-3">
			<c:set var="left" value="excel" />
			<%@include file="../common/left/schedule.jsp" %>	
		</div>
		<div class="col-9">
			<div class="row">
				<div class="col-12">
					<h1>상품 목록</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-6">
					<form class="row row-cols-lg-auto g-3 align-items-center" method="post" action="excel-upload" enctype="multipart/form-data">
					<sec:csrfInput />
						<div class="col-12">
							<div class="input-group">
								<input type="file" class="form-control form-control-sm" name="xls" placeholder="엑셀파일을 첨부하세요">
							</div>
						</div>
						<div class="col-12">
							<button type="submit" class="btn btn-dark btn-sm">엑셀파일 업로드</button>
						</div>
					</form>
				</div>
				<div class="col-6 text-end">
					<a href="excel-download" class="btn btn-outline-primary btn-sm">내 일정 엑셀로 다운로드</a>
				</div>
			</div>
			<div class="row">
				<div class="col-12">
					<table class="table">
						<thead>
							<tr>
								<th>순번</th>
								<th>일정번호</th>
								<th>시작날짜</th>
								<th>종료날짜</th>
								<th>시작시간</th>
								<th>종료시간</th>
								<th>종일여부</th>
								<th>제목</th>
								<th>내용</th>
								<th>장소</th>
								<th>분류번호</th>
								<th>직원번호</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="schedule" items="${schedules }" varStatus="loop">
								<tr>
									<td>${loop.count }</td>
									<td>${schedule.no }</td>
									<td><fmt:formatDate pattern="YYYY-MM-dd" value="${schedule.startDate }"/> </td>
									<td><fmt:formatDate pattern="YYYY-MM-dd" value="${schedule.endDate }"/></td>
									<td>${schedule.startTime }</td>
									<td>${schedule.endTime }</td>
									<td>${schedule.allDay }</td>
									<td>${schedule.title }</td>
									<td>${schedule.content }</td>
									<td>${schedule.location }</td>
									<td>${schedule.categoryNo }</td>
									<td>${schedule.employeeNo } </td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	


</body>
