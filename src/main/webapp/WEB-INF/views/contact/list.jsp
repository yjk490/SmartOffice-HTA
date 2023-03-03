<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<title>주소록 목록</title>
<style>
/* Style the tab */
.tab {
  width: auto;
  background-color: #ffffff;
}

/* Style the buttons inside the tab */
.tab button {
  background-color: inherit;
  float: left;
  border: none;
  outline: none;
  cursor: pointer;
  padding: 7px 13px;
  transition: 0.3s;
  font-size: 14px;
  border-top: 1px solid #3399ff;
  border-left: 1px solid #3399ff;
  border-right: 1px solid #3399ff;
  border-radius: 5px 5px 0px 0px;
}

/* Change background color of buttons on hover */
.tab button:hover {
  background-color: #d3d3d3;
  text-decoration: none;
}

.w3-hover-light-grey:hover {
 	text-decoration: none;
}

/* Create an active/current tablink class */
.tab button.active {
  background-color: #3399ff;
  color: white;
}

/* Style the tab content */
.tabcontent {
  display: none;
  padding: 6px 12px;
  border: 1px solid #ccc;
  border-top: none;
}

.tagbtn {
  font-size: 12px;    
  border: 1px solid green;
  outline: none;
  color: black;
  padding: 3px 8px;
  background-color: inherit;
  font-family: inherit;
  margin-left: 8px;
  margin-right: 8px;
  border-radius: 5px;
}

.sort-button {
	background-color: white;
	outline: none;
  	box-shadow: none;
  	border: none;
}

.tdcenter {
	vertical-align: middle;
}

.littlemg {
	margin: 5px;
}

.center {
  text-align: center;
}

.pagination {
  display: inline-block;
}

.pagination a {
  color: black;
  float: left;
  padding: 8px 16px;
  text-decoration: none;
  border-radius: 5px;
}

.pagination a.active {
  color: black;
  border: 1px solid #3399ff;
}

.pagination a:hover:not(.active) {background-color: #ddd;}

</style>
</head>
<body>
<c:set var="top" value="contact" />
<%@ include file="../common/navbar.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-3">
			<c:set var="left" value="연락처" />
			<%@include file="../common/left/contact.jsp" %>	
		</div>
		
		<div class="col-9">
			<div class="w3-container">
				<h1>${opt.type eq 'public' ? '공유' : '개인'}주소록</h1>
			</div>
			
			<div class="w3-panel">
			  <p></p>
			</div>
			
			<!-- 검색창 -->
			<div class="w3-container w3-section" style="width: 25%">
				<form id="contactSearchForm" method="GET" action="list">
				<input type="hidden" name="type" value="${opt.type }">
				<input type="hidden" name="tag" value="${opt.tag }">
				<input type="hidden" name="page" value="${pagination.page }">
				  <div class="input-group">
				    <input type="text" name="keyword" class="form-control" value="${opt.keyword }" placeholder="연락처 검색..">
					<button id="keyword" type="button" class="btn btn-default">
				        <i class="w3-text-grey bi bi-search"></i>
					</button>
				  </div>
				</div>
			
			<!-- 가~9 이름으로 찾기 -->
			<div class="w3-container rest">
				<div class="tab w-auto">
					<!-- tablinks 클래스의 버튼을 눌렀을 때 button의 value가 [name:initial] input의 value로 들어가야 함 -->
					<input type="hidden" id="initial" name="initial" value="${opt.initial }">
					<button class="tablinks" value="ALL">ALL</button>
					<button class="tablinks" value="가">가</button>
					<button class="tablinks" value="나">나</button>
					<button class="tablinks" value="다">다</button>
					<button class="tablinks" value="라">라</button>
					<button class="tablinks" value="마">마</button>
					<button class="tablinks" value="바">바</button>
					<button class="tablinks" value="사">사</button>
					<button class="tablinks" value="아">아</button>
					<button class="tablinks" value="자">자</button>
					<button class="tablinks" value="차">차</button>
					<button class="tablinks" value="카">카</button>
					<button class="tablinks" value="타">타</button>
					<button class="tablinks" value="파">파</button>
					<button class="tablinks" value="하">하</button>
					<button class="tablinks" value="A">A-Z</button>
					<button class="tablinks" value="0">0~9</button>					
				</div>
				<div class="w3-container w3-right rest">
					<select id="opt-rows" class="form-select form-select-xs" name="rows">
						<option value="10" ${opt.rows eq 10 ? 'selected' : ''}>10개씩</option>
						<option value="20" ${opt.rows eq 20 ? 'selected' : ''}>20개씩</option>
						<option value="50" ${opt.rows eq 50 ? 'selected' : ''}>50개씩</option>
					</select>
				</div>
			</div>

			<!-- 연락처 목록 -->
			<div class="w3-container" style="border-top: 1px solid gray;">
				<table class="table table-small" id="table-contact">
				<colgroup>
					<col width="7%">
					<col width="7%">
					<col width="10%">
					<col width="15%">
					<col width="15%">
					<col width="46%">
				</colgroup>
				<thead>
					<tr style="border-bottom: 1px solid gray;">
						<th class="w3-center"><input type="checkbox"></th>
						<th class="w3-center">중요</th>
						<!-- sort-button 클래스의 버튼을 onclick 했을 때 [name=sort] input에 button값이 들어가야 함 -->
							<input class="sort-opt" id="sort" type="hidden" name="sort" value="${opt.sort }">
							<th class="text-left">이름 <button id ="sort-button" class="sort-button" value="name">▼</button></th>
							<th class="text-left">전화번호 <button id ="sort-button" class="sort-button" value="tel">▼</button></th>
							<th class="text-left">이메일 <button id ="sort-button" class="sort-button" value="email">▼</button></th>
						<th class="text-left">태그</th>
					</tr>
				</form>
				</thead>
				<tbody>
				<form>
					<c:choose>
						<c:when test="${empty contacts }">
							<tr>
								<td colspan="9" class="text-center" >등록된 연락처가 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="contact" items="${contacts}">
								<tr>
									<td class="w3-center tdcenter"><input type="checkbox"></td>
									<td class="w3-center tdcenter"><i class="starfill bi bi-star"></i></td>
									<td class="text-left tdcenter"><a href="../contact/detail?type=${opt.type }&contactNo=${contact.contactNo}" class="text-decoration-none">${contact.name }</a></td>
									<td class="text-left tdcenter">
									<c:forEach var="tel" items="${contact.tel }">
										${tel }
									</c:forEach>
									</td>
									<td class="text-left tdcenter">${contact.email }</td>
									<td class="text-left tdcenter">
										<c:forEach var="tag" items="${contact.addressbookName }">
				      						<a href="/contact/list?tag=${tag }" class="tagbtn">${tag }</a>
				      					</c:forEach>
			      					</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
				</table>
			</div>
			
			<!-- 페이지네이션 -->
			<c:if test="${not empty contacts }">
			<div class="w3-center">
				<div class="w3-bar">
					<a href="${pagination.prevPage }" class="w3-button w3-hover-light-grey ${pagination.first ? 'disabled' : '' }">«</a>
					<c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">
						<a href="list?page=${num }" class="w3-button w3-hover-light-grey ${pagination.page eq num ? 'active' : '' }">${num }</a>
					</c:forEach>
					<a href="${pagination.nextPage }" class="w3-button w3-hover-light-grey ${pagination.last ? 'disabled' : '' }">»</a>
				</div>
			</div>
			</c:if>
			
			<!-- 버튼 모음 -->
			<div class="w3-container" style="border-top: 1px solid gray; border-bottom: 1px solid gray;">
				<div class="w3-bar">
					<a class="w3-button w3-white w3-border w3-padding-small w3-hover-light-grey w3-border-grey w3-round-large w3-left w3-small littlemg">내보내기</a>
					<a href="../contact/form" class="w3-button w3-white w3-border w3-hover-light-grey w3-padding-small w3-border-green w3-round-large w3-left w3-small w3-right littlemg">등록</a>
					<button onclick="document.getElementById('delete01').style.display='block'" class="w3-button w3-white w3-border w3-padding-small w3-hover-light-grey w3-border-red w3-round-large w3-left w3-small w3-right littlemg">삭제</button>
					<a href="#" class="w3-button w3-white w3-border w3-padding-small w3-hover-light-grey w3-border-grey w3-round-large w3-left w3-small w3-right littlemg">개인 주소록에 추가</a>
					<a href="#" class="w3-button w3-white w3-border w3-padding-small w3-hover-light-grey w3-border-grey w3-round-large w3-left w3-small w3-right littlemg">쪽지</a>
				</div>
			</div>
		</form>			

			<!-- 연락처 삭제 -->
		  	<div id="delete01" class="w3-modal">
		    	<div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:500px">
					<div class="w3-margin"><br>
				        <span onclick="document.getElementById('delete01').style.display='none'" class="w3-button w3-xlarge w3-hover-red w3-display-topright" title="Close Modal">&times;</span>
				        <h2>연락처 삭제</h2>
					</div>
					<div class="w3-margin w3-center w3-padding">
						<h5><span class="w3-text-red"><b>"김진철"</b></span> 님을 삭제하시겠습니까?</h5>
					</div>
					<div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
				        <button onclick="document.getElementById('delete01').style.display='none'" type="submit" class="w3-button w3-right w3-border-red w3-text-red">삭제</button>
				        <button onclick="document.getElementById('delete01').style.display='none'" type="button" class="w3-button w3-right w3-text-grey">취소</button>
					</div>
				</div>
			</div>
			
		</div>
	</div>
</div>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
	// 제이쿼리 매개변수가 여러 개일 때 제대로 들어가는지 확인 필요 > 현재 안 들어감
	// page, form값 제출
	function ContactSearchForm(page) {
		$(":input[name=type]").val(type);
		$(":input[name=tag]").val(tag);
		$(":input[name=page]").val(page);
		$("#contactSearchForm").submit()
	}
	
	// sort 버튼 클릭 시 해당 값으로 input값 변경하여 제출(데이터갯수는 변동되지 않으니, page값 그대로)
	$(".sort-button").click(function(){
		var sort = $(this).val();
		$(":input[name=sort]").attr("value", sort);
		$(":input[name=type]").val(type);
		$(":input[name=tag]").val(tag);
		$(":input[name=page]").val(page);
		ContactSearchForm(page)
	});
	
	// rows값 제출(한 페이지에 들어가는 데이터갯수가 변동되니, page값 1로 초기화)
	// list?type=public&tag=%ED%83%9C%EA%B7%B8%EC%97%86%EC%9D%8C:707 Uncaught ReferenceError: type is not defined 타입, 태그값이 들어가 있는데 못 찾는다?
	$("#opt-rows").change(function() {
		$(":input[name=type]").val(type);
		$(":input[name=tag]").val(tag);
		ContactSearchForm(1);
	})
	
	// initial값 제출 (데이터갯수가 변동되니, page값 1로 초기화)
	$(".tablinks").click(function() {
		var initial = $(this).val();
		$(":input[name=initial]").attr("value", initial);
		$(":input[name=type]").val(type);
		$(":input[name=tag]").val(tag);
		ContactSearchForm(page);
	})
	
	// keyword값 제출
	$("#keyword").click(function() {
		$(":input[name=type]").val(type);
		$(":input[name=tag]").val(tag);
		ContactSearchForm(1);
	})
	
		// keyword값 제출
	$("#tagbtn").click(function() {
		$(":input[name=type]").val(type);
		$(":input[name=tag]").attr("value", tag);
		ContactSearchForm(1);
	})
</script>
