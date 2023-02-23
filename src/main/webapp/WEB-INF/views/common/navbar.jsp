<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark mb-3">
<div class="container">
		<ul class="navbar-nav me-auto">
			<li class="nav-item"><a class="nav-link ${top eq 'home' ? 'active' : '' }" href="/">SMART OFFICE</a></li>
			<sec:authorize access="hasAnyRole('ROLE_EMPLOYEE', 'ROLE_ADMIN')">
				<li class="nav-item"><a class="nav-link ${top eq 'note' ? 'active' : '' }" href="/note/receive">쪽지</a></li>
				<li class="nav-item"><a class="nav-link ${top eq 'schedule' ? 'active' : '' }" href="/schedule/schedule">일정</a></li>
				<li class="nav-item"><a class="nav-link ${top eq 'contact' ? 'active' : '' }" href="/contact/list">주소록</a></li>
				<li class="nav-item"><a class="nav-link" href="">메모(일단)</a></li>
				<li class="nav-item"><a class="nav-link" href="">메신저</a></li>
				<li class="nav-item"><a class="nav-link ${top eq 'post' ? 'active' : '' }" href="/post/list">게시판</a></li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle ${top eq 'todo' ? 'active' : '' }" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
						업무
					</a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="/todo/todoBox">업무 문서함</a></li>
						<li><a class="dropdown-item" href="/todo/list?category=100">업무 관리</a></li>
					</ul>
				</li>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<li class="nav-item"><a class="nav-link ${top eq 'admin' ? 'active' : '' }" href="/admin/list">관리자</a></li>
			</sec:authorize>
		</ul>
			<sec:authorize access="isAuthenticated()">
				<span class="navbar-text"><strong class="text-white"><sec:authentication property="principal.name"/></strong>님 환영합니다.</span>
			</sec:authorize>
		<ul class="navbar-nav">
			<sec:authorize access="isAuthenticated()">
				<li class="nav-item"><a class="nav-link ${top eq 'employee' ? 'active' : '' }" href="/profile">내정보 보기</a></li>
				<li class="nav-item"><a class="nav-link" href="/logout" onclick="logout(event)">로그아웃</a></li>
			</sec:authorize>
			<sec:authorize access="!isAuthenticated()">
				<li class="nav-item"><a class="nav-link ${top eq 'login' ? 'active' : '' }" href="/login">로그인</a></li>
			</sec:authorize>
		</ul>
</div>
</nav>
<form id="form-logout" method="post" action="/logout">
	<sec:csrfInput />
</form>
<script>
	function logout(event){
		event.preventDefault();
		document.getElementById("form-logout").submit();
	}
</script>
