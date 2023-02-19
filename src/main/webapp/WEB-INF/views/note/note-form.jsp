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
		<form:form modelAttribute="noteRegisterForm" id="note-form" class="border p-3" method="post" action="form" enctype="multipart/form-data">
			<sec:csrfInput />
			<div class="mb-3 mt-3">
				<div class="form-check mb-3">
 					<form:checkbox class="form-check-input" id="checkbox" name="checkbox" path="important" value="Y" />
					<label class="form-check-label"><i class="fas fa-star w3-text-amber"></i> 중요</label>
				</div>
				<div class="w3-border-top mb-3">
				</div>
				<div class="mb-3">
					<form:input class="form-control form-control-sm" name="title" path="title" placeholder="제목을 입력하세요." />
				</div>
				<div class="mb-3 d-flex">
					<input type="text" class="form-control form-control-sm" id="receivers-input" placeholder="수신자 직원번호를 직접입력 또는 검색을 통해 등록하세요." />
					<button id="btn-open" href="#modal" class="w3-button w3-black w3-margin-left w3-tiny" type="button"><i class="fa fa-search"></i></button>
					
					
					<!-- 사원 검색 모달창 -->
					
						<div id="modal" class="w3-modal w3-margin">
						    <div class="w3-modal-content">
						      <header class="w3-container mb-2 w3-black"> 
						        <h4>수신자 검색</h4>
						      </header>
						      <div class="w3-container w3-margin d-flex justify-content-between">
						      	<input type="hidden" name="page" value="" />
						      	<div>
									<input type="text" class="form-control form-control-xs" id="modal-keyword" placeholder="사원이름을 입력해주세요."/>
									<button type="button" class="btn btn-outline-secondary btn-xs" id="btn-search"><i class="fa fa-search"></i></button>
								</div>
						      </div>
						      <div class="w3-container w3-margin">
						       	<table class="table table-sm" id="table-modal">
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
											<td colspan="3" class="text-center">사원이름을 검색해주세요.</td>
										</tr>
									</tbody>
						       	</table>
						       	<div>
						       		<div id="name-btn-box" class="me-3 pt-1 ps-1 mt-1"></div>
									<div id="name-box" class="me-3 pt-1 ps-1"></div>
						       	</div>
						      </div>
						      <footer class="w3-container text-end w3-container p-3">
								<button class="w3-button w3-padding-small w3-round-large w3-light-gray" id="btn-out" type="button"><a class="text-decoration-none">취소</a></button>
						      </footer>
						    </div>
					  </div>
				<!-- 모달 끝 -->
				
				
				</div>
				<div id="receivers-box" class="me-3 pt-1 ps-1" path="receiversNo"></div>
				<div class="mb-3 mt-3">
					<label class="form-label">내용</label>
					<form:textarea rows="4" class="form-control" name="content" path="content" />
				</div>
				<div class="w3-border-top mb-3">
				</div>
				<div class="mb-3">
					<label class="form-label">첨부파일</label>
					<input type="file" class="form-control" name="upfile" path="upfile" />
				</div>
				<div class="text-end mt-4">
					<button type="button" class="w3-button w3-padding-small w3-round-large w3-light-gray"><a class="text-decoration-none" href="/note/receive">취소</a></button>
					<button type="button" class="w3-button w3-padding-small w3-round-large w3-black"><a class="text-decoration-none" id="btn-draft" href="/note/draftnote">임시저장</a></button>
					<button id="submit" type="submit" class="w3-button w3-padding-small w3-round-large w3-blue">보내기</button>
				</div>
			</div>
		</form:form>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	
	let $reInput = $("#receivers-input");
	let $reBox = $("#receivers-box");
	
	$("#receivers-input").keydown(function(event){
		
		if(event.which == 13) {
			let value = $reInput.val();
			if(value == ""){
				alert("수신자번호를 입력하세요.");
				return false;
			}
			let reBtn = `
				<a href="" class="text-white text-decoration-none">
					<small class="border rounded bg-secondary p-1 text-white">\${value}<i class="bi bi-x"></i></small>
					<input type="hidden" name="receiversNo" value= "\${value}">
				</a>
				`; 
			
			$reBox.append(reBtn);
			$reInput.val("");
			
			return false;
		}
		return true;
	});
	
	$("#btn-open").click(function() {
		$("#modal").fadeIn();
	});
	$("#btn-out").click(function() {
		$("#modal").fadeOut();
	});
	
	$("#btn-search").click(function() {
	
		let $tbody = $("#table-modal tbody").empty()
	
		let keyValue = $("#modal-keyword").val();
		 
		  
		 if(!keyValue){
			 alert("사원이름을 입력하세요");
			 return false;
		  }
	
		  $.getJSON("/note/search.json", {keyword:keyValue}, function(employeeList) {
			  if (employeeList.length == 0 ) {
				  $tbody.append('<tr><td colspan="3" class="text-center">검색어로 조회된 값이 없습니다.</td><tr>')
			  } else {
				$.each(employeeList, function(index, emp) {
					let tr = `
						<tr>
							<td class="text-center">\${emp.no}</td>
							<td class="text-center"><a href="" class="text-decoration-none" data-emp-no="\${emp.no}">\${emp.name}</a></td>
							<td class="text-center">\${emp.deptName}</td>
						</tr>
					`
					$tbody.append(tr);
				})
			   }
			}) 
		});
	
	$reBox.on("click", 'a', function(event){
		event.preventDefault();
		$(this).remove();
	});
	
	$("#table-modal tbody").on('click', 'a', function(event) {
		event.preventDefault();
		let empNo = $(this).attr('data-emp-no');
		   
		let reBtn = `
			<a href="" class="text-white text-decoration-none">
				<small class="border rounded bg-secondary p-1 text-white">\${empNo}<i class="bi bi-x"></i></small>
				<input type="hidden" name="receiversNo" value= "\${empNo}">
			</a>
			`; 
			
		$reBox.append(reBtn);
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
	
	// 임시저장 버튼을 누르면 쪽지를 임시저장함으로 저장하기
	$("#btn-draft").click(function(){
		var formData = $('#note-form').serialize();
		
		$.ajax({
			url: '/note/draft',
			type: 'GET',
			data: formData
		});
	});
	
});


</script>
</body>
</html>