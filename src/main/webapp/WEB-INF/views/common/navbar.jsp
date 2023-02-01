<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark mb-3">
	<div class="container">
		<ul class="navbar-nav me-auto">
			<li class="nav-item"><a class="nav-link ${top eq 'home' ? 'active' : '' }" href="/">SMART OFFICE</a></li>
			<li class="nav-item"><a class="nav-link ${top eq 'note' ? 'active' : '' }" href="/note">쪽지</a></li>
			<li class="nav-item"><a class="nav-link" href="">일정</a></li>
			<li class="nav-item"><a class="nav-link" href="">주소록</a></li>
			<li class="nav-item"><a class="nav-link" href="">메모(일단)</a></li>
			<li class="nav-item"><a class="nav-link" href="">메신저</a></li>
			<li class="nav-item"><a class="nav-link" href="">게시판</a></li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
					업무
				</a>
				<ul class="dropdown-menu">
					<li><a class="dropdown-item" href="">업무 문서함</a></li>
					<li><a class="dropdown-item" href="">업무 관리</a></li>
				</ul>
			</li>

				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
						관리자
					</a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="">사용자 관리</a></li>
						<li><a class="dropdown-item" href="">게시글 관리</a></li>
					</ul>
				</li>
			
		</ul>
			<span class="navbar-text"><strong class="text-white">홍길동</strong>님 환영합니다.</span>
		<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link" href="">내정보 보기</a></li>
				<li class="nav-item"><a class="nav-link" href="">로그아웃</a></li>
				<li class="nav-item"><a class="nav-link" href="">로그인</a></li>
				<li class="nav-item"><a class="nav-link" href="">회원가입</a></li>				
		</ul>
	</div>
</nav>
