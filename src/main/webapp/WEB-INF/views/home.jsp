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
<c:set var="top" value="home" />
<%@ include file="common/navbar.jsp" %>
<div class="container">
	<div class="row mb-4">
		<div class="col-3 border p-3 bg-light">
			<div class="w3-container w3-center">
				<img src="https://mblogthumb-phinf.pstatic.net/MjAyMDA2MTBfMTY1/MDAxNTkxNzQ2ODcyOTI2.Yw5WjjU3IuItPtqbegrIBJr3TSDMd_OPhQ2Nw-0-0ksg.8WgVjtB0fy0RCv0XhhUOOWt90Kz_394Zzb6xPjG6I8gg.PNG.lamute/user.png?type=w800" 
				alt="Alps" class="w3-circle" style="width:75%">
					<h5>홍길동</h5>
					<p>영업부</p>
			</div>
		</div>
		<div class="col-9">
			<div class="border p-3 bg-light">
				<h4>주간 일정 <a href=""><i class="far fa-plus-square w3-right-align"></i></a></h4>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-6">
			<div class="border p-3 bg-light">
				<h4>오늘의 할일 <a href=""><i class="far fa-plus-square w3-right-align"></i></a></h4>
					<div class="w3-container p-3">
					  <table class="w3-table-all w3-small">
					    <tr>
					      <th>No</th>
					      <th>Title</th>
					    </tr>
					    <tr>
					      <td>10001</td>
					      <td><a href="" class="text-decoration-none">영업팀 결제건</a></td>
					    </tr>
					    <tr>
					      <td>10002</td>
					      <td><a href="" class="text-decoration-none">팀장님 결제서류</a></td>
					    </tr>
					    <tr>
					      <td>10003</td>
					      <td><a href="" class="text-decoration-none">회의록 정리</a></td>
					    </tr>
					    <tr>
					      <td>10004</td>
					      <td><a href="" class="text-decoration-none">결제 서류 처리</a></td>
					    </tr>
					    <tr>
					      <td>10005</td>
					      <td><a href="" class="text-decoration-none">협업요청</a></td>
					    </tr>
					  </table>
					</div>
			</div>
		</div>
		<div class="col-6">
			<div class="border p-3 bg-light">
				<h4>쪽지 알림 <a href=""><i class="far fa-plus-square w3-right-align"></i></a></h4>
					<div class="w3-container p-3">
					  <table class="w3-table-all w3-small">
					  	<colgroup>
							<col width="15%">
							<col width="*">
							<col width="25%">
						</colgroup>
					    <tr>
					      <th class="text-center">보낸사람</th>
					      <th class="text-center">Title</th>
					      <th class="text-center">보낸일자</th>
					    </tr>
					    <tr>
					      <td class="text-center">강감찬</td>
					      <td class="text-center"><a href="" class="text-decoration-none">쪽지 제목</a></td>
					      <td class="text-center">2023-02-01</td>
					    </tr>
					    <tr>
					      <td class="text-center">김연경</td>
					      <td class="text-center"><a href="" class="text-decoration-none">쪽지 제목</a></td>
					      <td class="text-center">2023-02-01</td>
					    </tr>
					    <tr>
					      <td class="text-center">이재원</td>
					      <td class="text-center"><a href="" class="text-decoration-none">쪽지 제목</a></td>
					      <td class="text-center">2023-02-01</td>
					    </tr>
					    <tr>
					      <td class="text-center">관리자</td>
					      <td class="text-center"><a href="" class="text-decoration-none">쪽지 제목</a></td>
					      <td class="text-center">2023-02-01</td>
					    </tr>
					    <tr>
					      <td class="text-center">서지오</td>
					      <td class="text-center"><a href="" class="text-decoration-none">쪽지 제목</a></td>
					      <td class="text-center">2023-02-01</td>
					    </tr>
					  </table>
					</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>