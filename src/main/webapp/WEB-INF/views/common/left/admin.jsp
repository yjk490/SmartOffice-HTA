<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>
<div class="container mt-2">
	<div class="w3-sidebar w3-bar-block col-3 border h-auto">
			<div class="w3-container border-bottom ml-2">
				<h4><b>관리자</b></h4>
			</div>
			<div class="border-bottom">
				<div class="w3-panel w3-display-container">
					<a class="w3-bar-item w3-btn w3-round-xlarge w3-black w3-large w3-center" href="/admin/form"><b>사원 등록</b></a>
				</div>
			</div>
			<div class="mt-3 mb-3">
				<a class="w3-bar-item w3-button ${left eq 'emplist' ? 'w3-border w3-border-gray w3-round-large' : '' }" style="${left eq 'emplist' ? 'text-shadow:0.6px 0.6px 0 #444' : ''}" href="/admin/list">사원 관리</a>
			</div>
	</div>
</div>
</body>

