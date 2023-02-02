<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>애플리케이션</title>
</head>
<body>
<c:set var="menu" value="schedule" />
<%@ include file="../common/navbar.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-3">
			<c:set var="left" value="일정" />
			<%@include file="../common/left/schedule.jsp" %>	
		</div>
		<div class="col-9">
				<div class="row-2">
					<div class="w3-panel w3-blue w3-center w3-round-xlarge">
						<h2 class=" w3-center">일정 보기</h2>
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-3"> 
						<select id="scheduleCategory">
							<option disabled>일정분류</option>
							<option value="whole" selected>전체 일정</option>
							<option value="work">업무 일정</option>
							<option value="important">중요 일정</option>
							<option value="businessTrip">출장 일정</option>
							<option value="personal">개인 일정</option>
							<option value="vacation">휴가 일정</option>
						</select>
					</div>
					<div class="col-6 w3-blue w3-center w3-round-xlarge">
						<p>2023-01</p>
					</div>
					<div class="col-3">
					</div>
				</div>
				
				<div class="row">
					<div class="col-3" id="nextBeforeButtons" >
						<button class="w3-btn w3-round-xxlarge w3-tiny w3-padding w3-green w3-left">&laquo;</button>
						<button class="w3-btn w3-round-xxlarge w3-tiny w3-padding w3-green w3-left" >&raquo;</button>
						<button class="w3-btn w3-round-xxlarge w3-tiny w3-green w3-left">오늘</button>
					</div>
					<div class="col-6">
						<form id="search">
							<input type="date" id="start">
							<input type="date" id="end">
							<button type="submit" class="w3-btn w3-round-xxlarge w3-tiny w3-black">검색</button>
						</form>
					</div>
					<div class="col-3" id="dayButtons">
						<button id="monthly" class="w3-btn w3-round-xxlarge w3-tiny w3-padding w3-blue w3-right">월간</button>
						<button id="weekly" class="w3-btn w3-round-xxlarge w3-tiny w3-padding w3-blue w3-right">주간</button>
						<button id="daily"class="w3-btn w3-round-xxlarge w3-tiny w3-padding w3-blue w3-right">일간</button>
						<button id="list" class="w3-btn w3-round-xxlarge w3-tiny w3-padding w3-blue w3-right">목록</button>
					</div>
					
				</div>
				<div class="row">
					달력들어갈 자리
					<table>
					<thead>
					</table>
				</div>
		</div>
	</div>
	
</div>


</body>
