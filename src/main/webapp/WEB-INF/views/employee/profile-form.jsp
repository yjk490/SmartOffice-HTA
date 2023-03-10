<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<title>SMART OFFICE</title>
</head>
<body>
<c:set var="top" value="employee" />
<%@ include file="../common/navbar.jsp" %>
<div class="container">
	<div class="row g-3">
		<div class="col-3">
			<c:set var="left" value="profile" />
			<%@ include file="../common/left/employee.jsp" %>
		</div>
		<div class="col-9">
			<div class="col-12 mb-3">
				<h1 class="fs-4 border p-2">프로필 사진 변경</h1>
			</div>
			<form class="w3-panel w3-display-container border bg-light text-center" method="post" enctype="multipart/form-data" action="profile">
				<div>
					<img id="profile-container" src="<c:url value='${profile }' />" alt="Profile Image" class="w3-circle m-3" style="width: 30%;">
				</div>
				<div class="w3-panel w3-border-top w3-border-bottom">
					<input type="file" class="form-control mb-3 mt-3" id="profile" accept="image/*" onchange="setProfile(event);" name="profile" />
				</div>
			<div class="text-center mt-3 mb-3">
					<button type="submit" class="w3-button w3-medium w3-round-large w3-black">수정</button>
			</div>
			</form>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('#profile').on('change', function(event) {
		let reader = new FileReader();
		reader.onload = function(event) {
			$('#profile-container').attr('src', event.target.result);
		};
		reader.readAsDataURL(event.target.files[0]);
	});
});
</script>
</body>
</html>