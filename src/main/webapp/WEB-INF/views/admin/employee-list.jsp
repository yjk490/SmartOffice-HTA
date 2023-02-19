<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
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
<c:set var="top" value="admin" />
<%@ include file="../common/navbar.jsp" %>
<div class="container">
	<div class="row g-3">
		<div class="col-3">
			<c:set var="left" value="emplist" />
			<%@ include file="../common/left/admin.jsp" %>
		</div>
		<div class="col-9">
		<div class="col-12 mb-3">
			<h1 class="fs-4 border p-2">사원 관리</h1>
		</div>
		<form id="note-form" method="get" action="list">
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
						<option value="empName" ${opt eq 'empName' ? 'selected' : '' }>사원이름</option>
						<option value="empNo" ${opt eq 'empNo' ? 'selected' : '' }>사원번호</option>
						<option value="deptName" ${opt eq 'deptName' ? 'selected' : '' }>부서명</option>
					</select>
					<input type="text" class="form-control form-control-xs" id="search-keyword" name="keyword" value="${keyword }" />
					<button type="button" class="btn btn-outline-secondary btn-xs" id="btn-keyword"><i class="fa fa-search"></i></button>
				</div>
			</div>
		</form>
		<form id="emp-update">
		<table class="table table-sm">
			<colgroup>
				<col width="5%">
				<col width="10%">
				<col width="17%">
				<col width="20%">
				<col width="*">
				<col width="13%">
				<col width="10%">
			</colgroup>
			<thead>
				<tr>
					<th>
						<div>
 							<input class="form-check-input" type="checkbox" id="checkbox-all" value="" aria-label="...">
						</div>
					</th>
					<th class="text-center">사원이름</th>
					<th class="text-center">사원번호</th>
					<th class="text-center">전화번호</th>
					<th class="text-center">이메일</th>
					<th class="text-center">부서명</th>
					<th class="text-center">상태</th>
				</tr>
			</thead>
			<tbody>
				<!-- 사원이 없으면 아래 내용을 출력한다. -->
				<c:choose>
					<c:when test="${empty employees }">
						<tr>
							<td colspan="7" class="text-center"><b>등록된 사원이 없습니다.</b></td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="employee" items="${employees }">
							<tr>
								<td>
									<div>
										<input class="form-check-input" type="checkbox" name="empNo" value="${employee.empNo }" aria-label="...">
									</div>
								</td>
								<td class="text-center">${employee.empName }</td>
								<td class="text-center">${employee.empNo }</td>
								<td class="text-center">${employee.tel }</td>
								<td class="text-center">${employee.email }</td>
								<td class="text-center">${employee.deptName }</td>
								<td class="text-center">
									<c:choose>
										<c:when test="${employee.status eq 'Y' }">
											정상
										</c:when>
										<c:when test="${employee.status eq 'S' }">
											중지
										</c:when>
										<c:otherwise>
											탈퇴
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		</form>
		<div class="w3-bar">
			 <button type="button" id="btn-stop" class="w3-button w3-padding-small w3-round-large w3-black">선택중지</button>
			 <button type="button" id="btn-delete" class="w3-button w3-padding-small w3-round-large w3-light-gray">선택해지</button>
			 <button type="button" class="w3-button w3-padding-small w3-right w3-round-large w3-black"><a class="text-decoration-none" href="/admin/form"><b>사원등록</b></a></button>
		</div>
		<c:if test="${not empty employees }">
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
	
	let $buttonStop = $("#btn-stop").prop("disabled",true);
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
	
	// 모든 체크 박스 체크하기
	$("#checkbox-all").change(function(){
		let $allChecked = $(this).prop('checked');
		$(":checkbox[name=empNo]").prop('checked', $allChecked);
		toggleSelectedCheckbox();
	});
	
	$(":checkbox[name=empNo]").change(function() {
		toggleCheckboxAll();
		toggleSelectedCheckbox();
	});
	
	// 개별 체크박스의 체크갯수가 체크박스의 총 갯수와 같으면, 전체 체크 박스의 체크 상태와 동일하게 설정
	function toggleCheckboxAll(){
		let $checkboxLength = $(":checkbox[name=empNo]").length;
		let $checkedCheckboxLength = $(":checkbox[name=empNo]:checked").length;
		$("#checkbox-all").prop('checked', $checkboxLength === $checkedCheckboxLength);
	
	}
	
	// 체크박스의 값이 없으면 삭제/보관 버튼 disable 처리
	function toggleSelectedCheckbox() {
		let $buttonStop = $("#btn-stop");
		let $buttonDelete = $("#btn-delete");
		let $checkedCheckboxLength =  $(":checkbox[name=empNo]:checked").length;
		
		if ($checkedCheckboxLength === 0) {
			$buttonStop.prop("disabled",true);
			$buttonDelete.prop("disabled",true);
		} else {
			$buttonStop.prop("disabled",false);
			$buttonDelete.prop("disabled",false);
		}
	}
	
	
})
</script>
</body>
</html>