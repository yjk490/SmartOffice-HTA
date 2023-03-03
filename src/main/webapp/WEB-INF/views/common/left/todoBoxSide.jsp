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
				<span class="caret caret-down"><a href="todoBox?boxNo=100" class="text-decoration-none text-dark" >나의 할일</a></span>
				<ul class="nested active">
				<!-- c:forEach -->
				<c:forEach var="todoBox" items="${myTodo }">
					<li><a href="todoBox?boxNo=${todoBox.boxNo }" class="text-decoration-none text-dark">${todoBox.boxName }</a></li>
				</c:forEach>
				</ul>
			</li>
			<li>
				<span class="caret"><a href="todoBox?boxNo=101" class="text-decoration-none text-dark">업무 요청보관함</a></span>
				<ul class="nested active">
				<!-- c:forEach -->
				<c:forEach var="todoBox" items="${requestTodo }">
					<li><a href="todoBox?boxNo=${todoBox.boxNo }" class="text-decoration-none text-dark">${todoBox.boxName }</a></li>
				</c:forEach>
				</ul>
			</li>
			<li>
				<span class="caret caret-down"><a href="todoBox?boxNo=102" class="text-decoration-none text-dark">업무 보고보관함</a></span>
				<ul class="nested active">
				<!-- c:forEach -->
				<c:forEach var="todoBox" items="${reportTodo }">
					<li><a href="todoBox?boxNo=${todoBox.boxNo }" class="text-decoration-none text-dark">${todoBox.boxName }</a></li>
				</c:forEach>
				</ul>
			</li>
			<li>
				<span class="caret caret-down"><a href="todoBox?boxNo=103" class="text-decoration-none text-dark">업무 일지</a></span>
				<ul class="nested active">
				<!-- c:forEach -->
				<c:forEach var="todoBox" items="${dailyTodo }">
					<li><a href="todoBox?boxNo=${todoBox.boxNo }" class="text-decoration-none text-dark">${todoBox.boxName }</a></li>
				</c:forEach>
				</ul>
			</li>
		</ul>
	</div>
</body>