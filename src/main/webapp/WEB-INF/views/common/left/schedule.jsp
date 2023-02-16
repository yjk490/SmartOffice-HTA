<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<div class="container mt-2">
	<div class="w3-sidebar w3-bar-block col-3 border h-auto">
			<div class="w3-container border-bottom ml-2">
				<h4><b>일정</b></h4>
			</div>
			<div class="border-bottom">
				<div class="w3-panel w3-display-container">
					<a class="w3-bar-item w3-btn w3-round-xlarge w3-black w3-large w3-center" href="/schedule/register"><b>일정 등록</b></a>
				</div>
			</div>
			<div>
				<form action="">
				  <label for="category">유형</label>
				  <input class="form-control" type="text" list="list" id="category"/>
				  <datalist id ="list">
				    <option value="중요" />
				    <option value="업무" />
				    <option value="휴가" />
				    <option value="개인" />
				    <option value="출장" />
				  </datalist>
				  <label for="title">일정 제목</label>
				  <input class="form-control" type="text" id="title">
				</form>
				<!-- 여기에 드래그앤드랍할 대상 만들기 -->
			</div>
			<div class="mt-3">
					<a class="w3-bar-item w3-button ${left eq 'calendar' ? 'w3-border w3-border-gray w3-round-large ' : ''}" style="${left eq 'calendar' ? 'text-decoration: underline;font-weight: bold;' : '' }"}" href="/schedule/schedule">일정 보기</a>
			       	<a class="w3-bar-item w3-button" href="#">일정 가져오기</a>
			        <a class="w3-bar-item w3-button" href="#">일정 내보내기</a>
			        <a class="w3-bar-item w3-button" href="#">휴일 등록하기</a>
			        <a class="w3-bar-item w3-button" href="#">설정하기</a>
			</div>
	</div>
</div>