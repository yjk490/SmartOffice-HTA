<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style>
	.text-dark {
		font-size: 13px;
	}
</style>
<body>
	<div class="w3-sidebar w3-bar-block col-3 border h-auto">
		<div class="w3-container border-bottom ml-2">
			<h4><b>업무보관함</b></h4>
		</div>
		<div class="border-bottom">
			<div class="w3-panel w3-display-container">
				<button class="w3-bar-item w3-btn w3-round-xlarge w3-black w3-large w3-center" data-bs-toggle="modal" data-bs-target="#modal-form-todoBox"><b>업무보관함 추가</b></button>
			</div>
		</div>
		<ul class="tree border py-3 text-dark">
			<li>
				<span class="caret caret-down"><a class="text-decoration-none text-dark" >나의 할일</a></span>
				<ul class="nested active">
				<!-- c:forEach -->
					<li><a href="" class="text-decoration-none text-dark">나의 할 일 보관함 1</a></li>
					<li><a href="" class="text-decoration-none text-dark">나의 할 일 보관함 2</a></li>
				</ul>
			</li>
			<li>
				<span class="caret"><a  class="text-decoration-none text-dark">업무 요청보관함</a></span>
			</li>
			<li>
				<span class="caret caret-down"><a class="text-decoration-none text-dark">업무 보고보관함</a></span>
			</li>
			<li>
				<span class="caret caret-down"><a class="text-decoration-none text-dark">업무 일지</a></span>
				<ul class="nested active">
					<li><a href="" class="text-decoration-none text-dark">일일업무일지</a></li>
					<li><a href="" class="text-decoration-none text-dark">주간업무일지</a></li>
				</ul>
			</li>
			<li>
				<span class="caret"><a href="" class="text-decoration-none text-dark">임시게시판</a></span>
			</li>
		</ul>
	</div>
</body>