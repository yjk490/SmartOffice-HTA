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
<%@ include file="common/navbar.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-3">
			<c:set var="left" value="일정" />
			<%@include file="common/left/schedule.jsp" %>	
		</div>
		<div class="col-9 border-style: solid; border-width: 5px;">
				<a href="">컨텐츠내용</a>
	        	
		</div>
	</div>
	
</div>


</body>
