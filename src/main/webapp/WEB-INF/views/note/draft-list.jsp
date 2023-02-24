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
    width: 90px;
    display: inline-block !important;
}
.form-control-xs{
 	min-height: calc(1.5em + 0.5rem + 2px);
    padding: 0.25rem 0.5rem;
    font-size: .875rem;
    border-radius: 0.25rem;
    width: 150px;
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
			<c:set var="left" value="draft" />
			<%@ include file="../common/left/note.jsp" %>
		</div>
		<div class="col-9">
		<div class="col-12 mb-3">
			<h1 class="fs-4 border p-2">임시 보관함</h1>
		</div>
		<form id="note-form" method="get" action="draftnote">
			<input type="hidden" name="page" value="${pagination.page }" />
			<div class="mb-3 d-flex justify-content-between">	
				<div>
					<select id="select-rows" class="form-select form-select-xs" name="rows">
						<option value="10" ${rows eq 10 ? 'selected' : '' }>10개씩</option>
						<option value="15" ${rows eq 15 ? 'selected' : '' }>15개씩</option>
						<option value="20" ${rows eq 20 ? 'selected' : '' }>20개씩</option>
					</select>
				</div>
				<div>
					<select class="form-select form-select-xs" name="opt">
						<option value="senderName" ${opt eq 'senderName' ? 'selected' : '' }>받는사람</option>
						<option value="title" ${opt eq 'title' ? 'selected' : '' }>제목</option>
						<option value="content" ${opt eq 'content' ? 'selected' : '' }>내용</option>
					</select>
					<input type="text" class="form-control form-control-xs" id="search-keyword" name="keyword" value="${keyword }" />
					<button type="button" class="btn btn-outline-secondary btn-xs" id="btn-keyword"><i class="fa fa-search"></i></button>
				</div>
			</div>
		</form>
		<form id="note-update">
		<table class="table table-sm">
				<colgroup>
					<col width="7%">
					<col width="15%">
					<col width="*">
					<col width="25%">
				</colgroup>
				<thead>
					<tr>
						<th>
							<div>
 								<input class="form-check-input" type="checkbox" id="checkbox-all" value="" aria-label="...">
							</div>
						</th>
						<th class="text-center">받는사람</th>
						<th class="text-center">제목</th>
						<th class="text-center">저장일자</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty notes }">
							<tr>
								<td colspan="4" class="text-center"><b>임시 저장한 쪽지가 없습니다.</b></td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="note" items="${notes }">
								<tr>
									<td>
										<div>
											<input class="form-check-input" type="checkbox" name="noteNo" value="${note.noteNo }" aria-label="...">
										</div>
									</td>
									<td class="text-center">
										<c:forEach var="emp" items="${note.employees }">
											${emp.name }
										</c:forEach>
									</td>
									<td class="text-center"><a href="read?noteNo=${note.noteNo }" class="text-decoration-none">${note.title }</a></td>
									<td class="text-center"><fmt:formatDate value="${note.sendDate }"/></td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			</form>
			<div class="w3-bar">
			  <button  type="button" class="w3-button w3-padding-small w3-round-large w3-black" id="btn-delete">삭제</button>
			</div>
			<c:if test="${not empty notes }">
				<div class="w3-center" id="pagination">
					<div class="w3-bar">
					  <a class="page-link w3-button ${pagination.first ? 'disabled' : '' }" href="${pagination.prevPage }">«</a>
					  <c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">
					  	<a class="page-link w3-button ${pagination.page eq num ? 'w3-light-gray' : '' }" href="${num }">${num }</a>
					  </c:forEach>
					  <a class="page-link w3-button ${pagination.last ? 'disabled' : '' }" href="${pagination.nextPage }">»</a>
					</div>
				</div>
			</c:if>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	
	let $buttonDelete = $("#btn-delete").prop("disabled",true);
	
	function noteForm(page){
		$("#note-form input[name=page]").val(page);
		$("#note-form").submit();
	}
	
	$("#select-rows").change(function(){
		noteForm(1);
	});
	
	$("#pagination a").click(function(event){
		event.preventDefault();
		var page = $(this).attr("href");
		noteForm(page);
	});
	
	$("#btn-keyword").click(function(){
		noteForm(1);
	});
	
	// 쪽지 삭제 확인 메세지
	$("#btn-delete").click(function() {
		if ($(":checkbox[name=noteNo]:checked").length === 0){
			alert("삭제할 쪽지를 하나 이상 선택해주세요.");
			return;
		} if(confirm("쪽지를 삭제하시겠습니까?")){
			alert("선택한 쪽지의 삭제가 완료되었습니다.")
		} else {
			return false;
		}
	});
	
	// 모든 체크 박스 체크하기
	$("#checkbox-all").change(function(){
		let $allChecked = $(this).prop('checked');
		$(":checkbox[name=noteNo]").prop('checked', $allChecked);
		toggleSelectedCheckbox();
	});
	
	$(":checkbox[name=noteNo]").change(function() {
		toggleCheckboxAll();
		toggleSelectedCheckbox();
	});
	
	// 개별 체크박스의 체크갯수가 체크박스의 총 갯수와 같으면, 전체 페크 박스의 체크 상태와 동일하게 설정
	function toggleCheckboxAll(){
		let $checkboxLength = $(":checkbox[name=noteNo]").length;
		let $checkedCheckboxLength = $(":checkbox[name=noteNo]:checked").length;
		$("#checkbox-all").prop('checked', $checkboxLength === $checkedCheckboxLength);
	
	}
	
	// 체크박스의 값이 없으면 삭제/보관 버튼 disable 처리
	function toggleSelectedCheckbox() {
		let $buttonDelete = $("#btn-delete");
		let $checkedCheckboxLength =  $(":checkbox[name=noteNo]:checked").length;
		
		if ($checkedCheckboxLength === 0) {
			$buttonDelete.prop("disabled",true);
		} else {
			$buttonDelete.prop("disabled",false);
		}
	}
	
	// 삭제버튼을 누르면 휴지통으로 쪽지 보내기
	$("#btn-delete").click(function(){
		var formData = $('#note-update').serialize();
		
		$.ajax({
			url: '/note/send-delete',
			type: 'GET',
			data: formData,
			traditional: true,
			success: function() {
				location.reload();
			 }
		});
	});
	
})
</script>
</body>
</html>