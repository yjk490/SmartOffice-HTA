<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>연락처 사이드바</title>
<style>
.middlelist {
	font-size: 16px;
	margin-top: 10px;
	margin-bottom: 10px;
}

.littlelist {
  font-size: 14px;
  margin-top: 5px;
  margin-bottom: 5px;
  text-indent: 10px;
}
.littlemg {
  font-size: 14px;
  margin-top: 5px;
  margin-bottom: 5px;
}

.blue {
  background-color: #3399ff;
}

.textblue {
	color: #3399ff;
}

.starfill {
	color: #FFD700;
}

.vcenter {
	vertical-align: middle;
}
.w3-hover-light-grey:hover {
 	text-decoration: none;
}
</style>
</head>
<body>
	<div class="container">
    
	    <!-- 제목 -->
	    <a href="/contact/list" class="text-decoration-none">
	    	<div class="w3-bar-block border h-auto">
				<div class="w3-container border-bottom">
					<h4 class="">주소록</h4>
				</div>
		</a>
		
		<!-- 주소록 등록 -->
		<div class="w3-panel w3-display-container">
			<a href="/contact/form" class="text-decoration-none w3-bar-item w3-center w3-border w3-border-blue w3-hover-blue w3-button w3-text-hover-white"><i class="bi bi-plus-square"></i> 주소록 등록</a>
		</div>
		  	
		<!-- 공유주소록 -->	
		<div class="w3-show-inline-block" style="width: 100%">
			<div class="w3-bar border-top">
				<a href="/contact/list" class="w3-button w3-left-align w3-hover-light-grey"  style="width: 85%"><i class="bi bi-person-bounding-box textblue"></i> 공유주소록 <span class="w3-small w3-text-blue">211</span></a>
				<button onclick="document.getElementById('modal-form-insert01-public').style.display='block'" class="w3-button w3-right w3-hover-light-grey"  style="width: 15%"><i class="bi bi-plus-circle"></i></button>
			</div>
		</div>
		  
		<div class="w3-bar">
			<div>
				<a href="#" class="w3-bar-item w3-button w3-left-align w3-hover-light-grey"><i class="starfill bi bi-star-fill"></i> 자주 사용하는 연락처</a>
			</div>
		</div>
		
		<c:forEach var="publicAddressbook" items="${publicAddressbooks }">
			<div class="w3-show-inline-block" style="width: 100%">
				<div class="w3-bar">
					<div>
						<a href="/contact/list" class="w3-button w3-left-align w3-hover-light-grey" style="width: 70%">${publicAddressbook.addressbookName }<span class="w3-small w3-text-blue"> 50</span></a>
						<button onclick="document.getElementById('modal-form-delete01-public-${publicAddressbook.addressbookName }').style.display='block'" class="w3-button w3-right w3-hover-light-grey"  style="width: 15%"><i class="bi bi-x-circle"></i></button>
						<button onclick="document.getElementById('modal-form-modify01-public-${publicAddressbook.addressbookName }').style.display='block'" class="w3-button w3-right w3-hover-light-grey"  style="width: 15%"><i class="bi bi-three-dots"></i></button>
					</div>
				</div>
			</div>

			<!-- 공유주소록 수정 모달 -->
			<div id="modal-form-modify01-public-${publicAddressbook.addressbookName }" class="w3-modal">
		    	<div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:500px">
					<div class="w3-margin"><br>
		        		<span onclick="document.getElementById('modal-form-modify01-public-${publicAddressbook.addressbookName}').style.display='none'" class="w3-button w3-xlarge w3-hover-red w3-display-topright" title="Close Modal">&times;</span>
		        		<h2>공유주소록 수정</h2>
					</div>
				<form:form id="addressbook-modify" class="border p-3" method="post" action="modify-addressbook">
		        <div class="mb-3">
		        	<input type="hidden" class="form-control form-control-sm" name="addressbookNo" value="${publicAddressbook.addressbookNo }">
		        	<input type="hidden" class="form-control form-control-sm" name="type" value="public">
					<input type="text" class="form-control form-control-sm" name="addressbookName" placeholder="${publicAddressbook.addressbookName }" />
				</div>
		      <div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
		        <button type="submit" class="w3-button w3-right w3-border-blue w3-text-blue">수정</button>
		        <button onclick="document.getElementById('modal-form-modify01-public-${publicAddressbook.addressbookName}').style.display='none'" type="button" class="w3-button w3-right w3-text-grey">취소</button>
		      </div>
		      </form:form>
		    	</div>
		  	</div>
		  	
		  	<!-- 공유주소록 삭제 모달 -->
			<div id="modal-form-delete01-public-${publicAddressbook.addressbookName }" class="w3-modal">
	    		<div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:500px">
					<div class="w3-margin"><br>
	        			<span onclick="document.getElementById('modal-form-delete01-public-${publicAddressbook.addressbookName }').style.display='none'" class="w3-button w3-xlarge w3-hover-red w3-display-topright" title="Close Modal">&times;</span>
	        				<h2>공유주소록 삭제</h2>
					</div>
					<form:form id="addressbook-delete" class="border p-3" method="post" action="delete-addressbook">
				        <div class="mb-3">
				        	<input type="hidden" class="form-control form-control-sm" name="addressbookNo" value="${publicAddressbook.addressbookNo }">
				        	<input type="hidden" class="form-control form-control-sm" name="type" value="public">
							<input type="hidden" class="form-control form-control-sm" name="addressbookName" value="${publicAddressbook.addressbookName }" />
							<h5><span class="w3-text-red"><b>${publicAddressbook.addressbookName }</b></span> 태그를 삭제하시겠습니까?</h5>
						</div>
						<div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
					        <button type="submit" class="w3-button w3-right w3-border-blue w3-text-blue">삭제</button>
					        <button onclick="document.getElementById('modal-form-delete01-public-${publicAddressbook.addressbookName }').style.display='none'" type="button" class="w3-button w3-right w3-text-grey">취소</button>
						</div>
			      </form:form>
	    		</div>
	  	    </div>
		  	
		</c:forEach>
		  				  
		  <!-- 개인주소록 -->
		 <div class="w3-show-inline-block" style="width: 100%">	
			<div class="w3-bar border-top">
				<a href="/contact/list" class="w3-button w3-left-align w3-hover-light-grey"  style="width: 85%"><i class="bi bi-person-bounding-box textblue"></i> 개인주소록 <span class="w3-small w3-text-blue">211</span></a>
				<button onclick="document.getElementById('modal-form-insert01-private').style.display='block'"  class="w3-button w3-right w3-hover-light-grey"  style="width: 15%"><i class="bi bi-plus-circle"></i></button>
			</div>
		 </div>
		  
		 <div class="w3-bar">
			<div>
				<a href="#" class="w3-bar-item w3-button w3-left-align w3-hover-light-grey"><i class="starfill bi bi-star-fill"></i> 자주 사용하는 연락처</a>
			</div>
		 </div>
		  
		 <c:forEach var="privateAddressbook" items="${privateAddressbooks }">
			<div class="w3-show-inline-block" style="width: 100%">
				<div class="w3-bar">
					<div>
						<a href="#" class="w3-button w3-left-align w3-hover-light-grey"   style="width: 70%">${privateAddressbook.addressbookName } <span class="w3-small w3-text-blue"> 50</span></a>
						<button onclick="document.getElementById('modal-form-delete01-private-${privateAddressbook.addressbookName }').style.display='block'" class="w3-button w3-right w3-hover-light-grey"  style="width: 15%"><i class="bi bi-x-circle"></i></button>
						<button onclick="document.getElementById('modal-form-modify01-private-${privateAddressbook.addressbookName}').style.display='block'" class="w3-button w3-right w3-hover-light-grey"  style="width: 15%"><i class="bi bi-three-dots"></i></button>
					</div>
				</div>
			</div>
		  	
		  	<!-- 개인주소록 수정 모달 -->
			<div id="modal-form-modify01-private-${privateAddressbook.addressbookName }" class="w3-modal">
		    	<div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:500px">
					<div class="w3-margin"><br>
		        		<span onclick="document.getElementById('modal-form-modify01-private-${privateAddressbook.addressbookName }').style.display='none'" class="w3-button w3-xlarge w3-hover-red w3-display-topright" title="Close Modal">&times;</span>
		        		<h2>개인주소록 수정</h2>
					</div>
				<form:form id="addressbook-modify" class="border p-3" method="post" action="modify-addressbook">
		        <div class="mb-3">
		        	<input type="hidden" class="form-control form-control-sm" name="addressbookNo" value="${privateAddressbook.addressbookNo }">
		        	<input type="hidden" class="form-control form-control-sm" name="type" value="private">
					<input type="text" class="form-control form-control-sm" name="addressbookName" placeholder="${privateAddressbook.addressbookName }" />
				</div>
		      <div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
		        <button type="submit" class="w3-button w3-right w3-border-blue w3-text-blue">수정</button>
		        <button onclick="document.getElementById('modal-form-modify01-private-${privateAddressbook.addressbookName}').style.display='none'" type="button" class="w3-button w3-right w3-text-grey">취소</button>
		      </div>
		      </form:form>
		    	</div>
		  	</div>
		  	
		  	<!-- 개인주소록 삭제 모달 -->
			<div id="modal-form-delete01-private-${privateAddressbook.addressbookName }" class="w3-modal">
	    		<div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:500px">
					<div class="w3-margin"><br>
	        			<span onclick="document.getElementById('modal-form-delete01-private-${privateAddressbook.addressbookName }').style.display='none'" class="w3-button w3-xlarge w3-hover-red w3-display-topright" title="Close Modal">&times;</span>
	        				<h2>개인주소록 삭제</h2>
					</div>
					<form:form id="addressbook-delete" class="border p-3" method="post" action="delete-addressbook">
				        <div class="mb-3">
				        	<input type="hidden" class="form-control form-control-sm" name="addressbookNo" value="${privateAddressbook.addressbookNo }">
				        	<input type="hidden" class="form-control form-control-sm" name="type" value="private">
							<input type="hidden" class="form-control form-control-sm" name="addressbookName" value="${privateAddressbook.addressbookName }" />
							<h5><span class="w3-text-red"><b>${privateAddressbook.addressbookName }</b></span> 태그를 삭제하시겠습니까?</h5>
						</div>
						<div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
					        <button type="submit" class="w3-button w3-right w3-border-blue w3-text-blue">삭제</button>
					        <button onclick="document.getElementById('modal-form-delete01-private-${privateAddressbook.addressbookName }').style.display='none'" type="button" class="w3-button w3-right w3-text-grey">취소</button>
						</div>
			      </form:form>
	    		</div>
	  	    </div>
		  	
		 </c:forEach>
	
		<!-- 공유주소록 추가 모달 -->
		<div id="modal-form-insert01-public" class="w3-modal">
    		<div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:500px">
				<div class="w3-margin"><br>
        			<span onclick="document.getElementById('modal-form-insert01-public').style.display='none'" class="w3-button w3-xlarge w3-hover-red w3-display-topright" title="Close Modal">&times;</span>
        				<h2>공유주소록 추가</h2>
				</div>
				<form:form id="addressbook-register" class="border p-3" method="post" action="insert-addressbook">
        			<div class="mb-3">
			        	<input type="hidden" name="type" value="public">
						<input type="text" class="form-control form-control-sm" name="addressbookName" placeholder="신규 태그를 입력하세요." />
					</div>
      				<div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
				        <button type="submit" class="w3-button w3-right w3-border-blue w3-text-blue">추가</button>
				        <button onclick="document.getElementById('modal-form-insert01-public').style.display='none'" type="button" class="w3-button w3-right w3-text-grey">취소</button>
      				</div>
      			</form:form>
    		</div>
  	    </div>
  	
	  	<!-- 개인주소록 추가 모달 -->
	  	<div id="modal-form-insert01-private" class="w3-modal">
    		<div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:500px">
				<div class="w3-margin"><br>
        			<span onclick="document.getElementById('modal-form-insert01-private').style.display='none'" class="w3-button w3-xlarge w3-hover-red w3-display-topright" title="Close Modal">&times;</span>
        			<h2>개인주소록 추가</h2>
				</div>
			<form:form id="addressbook-register" class="border p-3" method="post" action="insert-addressbook">
		        <div class="mb-3">
		        	<input type="hidden" name="type" value="private">
					<input type="text" class="form-control form-control-sm" name="addressbookName" placeholder="신규 태그를 입력하세요." />
				</div>
		      	<div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
			        <button type="submit" class="w3-button w3-right w3-border-blue w3-text-blue">추가</button>
			        <button onclick="document.getElementById('modal-form-insert01-private').style.display='none'" type="button" class="w3-button w3-right w3-text-grey">취소</button>
		      	</div>
      		</form:form>
    		</div>
  		</div>
		  
		 </div>
  	</div>
</body>
<script type="text/javascript">
function transferAdrName(addressbookName){
	$('.w3-bar border-top').text(addressbookName)
	$('.form-control form-control-sm').attr("placeholder", addressbookName)
	
	$('.').text(addressbookNo)
	$('.form-control form-control-sm').attr("value", addressbookNo)
	}

</script>
</html>