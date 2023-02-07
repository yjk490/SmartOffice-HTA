<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css">
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<style>
.btn-xs {
	margin-top: -4px; 
	--bs-btn-padding-y: .25rem; 
	--bs-btn-padding-x: .5rem; 
	--bs-btn-font-size: .75rem;
}
.form-select-xs {
	min-height: calc(1.5em + 0.5rem + 2px);
    padding: 0.25rem 0.5rem;
    font-size: .875rem;
    border-radius: 0.25rem;
    width: 110px;
    display: inline-block !important;
}
.form-control-xs{
 	min-height: calc(1.5em + 0.5rem + 2px);
    padding: 0.25rem 0.5rem;
    font-size: .875rem;
    border-radius: 0.25rem;
    width: 300px;
    display: inline-block !important;
 }
.w-150 {
	min-width: 150px !important;
}
  }
</style>
<title>SMART OFFICE</title>
</head>
<body>
<c:set var="top" value="note" />
<%@ include file="../common/navbar.jsp" %>
<div class="container">
	<div class="row g-3">
		<div class="col-3">
			<%@ include file="../common/left/note.jsp" %>
		</div>
		<div class="col-9">
		<div class="col-12 mb-3">
			<h1 class="fs-4 border p-2">쪽지 보내기</h1>
		</div>
		<form id="note-form" class="border p-3" method="post" action="register">
			<div class="mb-3 mt-3">
				<div class="form-check mb-3">
 					<input class="form-check-input" type="checkbox" path="important" value="Y">
					<label class="form-check-label"><i class="fas fa-star w3-text-amber"></i> 중요</label>
				</div>
				<div class="w3-border-top mb-3">
				</div>
				<div class="mb-3">
					<input type="text" class="form-control form-control-sm" name="title" path="title" placeholder="제목을 입력하세요." />
				</div>
				<div class="mb-3 d-flex">
					<input type="text" class="form-control form-control-sm" name="senderNo" path="senderNo" placeholder="수신자 직원번호를 입력하세요." />
					<button id="btn-open" href="#modal" class="w3-button w3-black w3-margin-left w3-tiny" type="button">+</button>
					<!-- 사원 검색 모달창 -->
					<div id="modal" class="w3-modal w3-margin">
					    <div class="w3-modal-content">
					      <header class="w3-container mb-2 w3-black"> 
					        <h4>수신자 검색</h4>
					      </header>
					      <div class="w3-container w3-margin d-flex justify-content-between">
					      	<input type="hidden" name="page" value="" />
					      	<div>
								<select class="form-select form-select-xs" name="opt">
									<option>주소록전체</option>
									<option>개인주소록</option>
									<option>공유주소록</option>
								</select>
								<input type="text" class="form-control form-control-xs" name="keyword" value="" />
								<button type="button" class="btn btn-outline-secondary btn-xs" id="btn-search"><i class="fa fa-search"></i></button>
							</div>
					      </div>
					      <div class="w3-container w3-margin">
					       	<table class="table table-sm">
					       		<colgroup>
									<col width="33%">
									<col width="*">
									<col width="33%">
								</colgroup>
								<thead>
									<tr>
										<th class="text-center">사원번호</th>
										<th class="text-center">사원이름</th>
										<th class="text-center">부서명</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="text-center">10001</td>
										<td class="text-center"><a class="text-decoration-none" id="modal-name" >강감찬</a></td>
										<td class="text-center">영업부</td>
									</tr>
								</tbody>
					       	</table>
					       	<div>
					       		<div id="name-btn-box" class="me-3 pt-1 ps-1 mt-1"></div>
								<div id="name-box" class="me-3 pt-1 ps-1"></div>
					       	</div>
					      </div>
					      <footer class="w3-container text-end w3-container w3-margin-bottom">
							<button class="w3-button w3-padding-small w3-round-large w3-light-gray" id="btn-out" type="button"><a class="text-decoration-none">취소</a></button>
							<button class="w3-button w3-padding-small w3-round-large w3-black" id="btn-enter" type="button">보내기</button>
					      </footer>
					    </div>
				  </div>
				</div>
				<div class="mb-3">
					<label class="form-label">내용</label>
					<textarea rows="4" class="form-control" name="content" path="content"></textarea>
				</div>
				<div class="w3-border-top mb-3">
				</div>
				<div class="mb-3">
					<label class="form-label">첨부파일</label>
					<input type="file" class="form-control" name="upfile" path="upfile" />
				</div>
				<div class="text-end mt-4">
					<button class="w3-button w3-padding-small w3-round-large w3-light-gray"><a class="text-decoration-none" href="/note/receive">취소</a></button>
					<button class="w3-button w3-padding-small w3-round-large w3-black"><a class="text-decoration-none" href="/note/draftnote">임시저장</a></button>
					<button id="submit" type="submit" class="w3-button w3-padding-small w3-round-large w3-blue">보내기</button>
				</div>
			</div>
		</form>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
$(function(){
	
	let $modalName = $("#modal-name");
	let $nameBtnBox = $("#name-btn-box");
	let $nameBox = $("#name-box");
	
	$("#modal-name").click(function(event) {
		
		let value = $modalName.val();
		if (value == "") {
			alert("수신자를 한명 이상 선택하세요.");
			return false;
		}
		let nameBtn = `
			<small class="border rounded bg-secondary p-1 text-white">#\${value} <a href="" class="text-white text-decoration-none"><i class="bi bi-x"></i></a></small>
		`;
		let name = `
			<input type="hidden" name="tags" value="\${value}">
		`
		$nameBtnBox.append(nameBtn);
		$nameBox.append(name);
		
		return true;
	});
	
	$("#btn-open").click(function() {
		$("#modal").fadeIn();
	});
	
	$("#btn-out").click(function() {
		$("#modal").fadeOut();
	});
	
	$("#note-form").submit(function() {
		let title = $("#note-form input[name=title]").val();
		let sender = $("#note-form input[name=senderNo]").val();
		let content = $("#note-form textarea[name=content]").val();
		
		if (title == "") {
			alert("제목을 입력하세요");
			return false;
		}
		if (sender == "") {
			alert("수신자 번호를 등록하세요");
			return false;
		}
		if (content == "") {
			alert("내용을 입력하세요");
			return false;
		}
		return true;
	});
	
});


</script>
</body>
</html>