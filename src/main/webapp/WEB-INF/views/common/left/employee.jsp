<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>
<div class="container mt-2">
	<div class="w3-sidebar w3-bar-block col-3 border h-auto">
			<div class="w3-container border-bottom ml-2">
				<h4><b>내 정보 관리</b></h4>
			</div>
			<div class="mt-3 mb-3">
					<a class="w3-bar-item w3-button ${left eq 'profile' ? 'w3-border w3-border-gray w3-round-large' : '' }" style="${left eq 'profile' ? 'text-shadow:0.6px 0.6px 0 #444' : ''}" href="/profile">프로필 관리</a>
			       	<a class="w3-bar-item w3-button ${left eq 'password' ? 'w3-border w3-border-gray w3-round-large' : '' }" style="${left eq 'password' ? 'text-shadow:0.6px 0.6px 0 #444' : ''}" href="/password">비밀번호 변경</a>
			</div>
	</div>
</div>
</body>

