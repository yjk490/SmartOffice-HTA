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
				<h1>공유주소록</h1>
			</div>
			
			<div class="w3-panel">
			  <p></p>
			</div>
			
			<div class="w3-container w3-section" style="width: 25%">
				<form>
				  <div class="input-group">
				    <input type="text" class="form-control" placeholder="연락처 검색..">
				    <div class="input-group-btn">
				      <button class="btn btn-default" type="submit">
				        <i class="w3-text-grey bi bi-search"></i>
				      </button>
				    </div>
				  </div>
				</form>
			</div>
			
			<div class="w3-container rest">
				<div class="tab w-auto">
					<button class="tablinks active">ALL</button>
					<button class="tablinks">가</button>
					<button class="tablinks">나</button>
					<button class="tablinks">다</button>
					<button class="tablinks">라</button>
					<button class="tablinks">마</button>
					<button class="tablinks">바</button>
					<button class="tablinks">사</button>
					<button class="tablinks">아</button>
					<button class="tablinks">자</button>
					<button class="tablinks">차</button>
					<button class="tablinks">카</button>
					<button class="tablinks">타</button>
					<button class="tablinks">파</button>
					<button class="tablinks">하</button>
					<button class="tablinks">A-Z</button>
					<button class="tablinks">0~9</button>					
				</div>
				<div class="w3-container w3-right rest">
					<select class="form-select form-select-xs" name="rows">
						<option>10개씩</option>
						<option>20개씩</option>
						<option>50개씩</option>
					</select>
				</div>
			</div>

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
						<th class="text-left">이름 <a class="text-decoration-none" href="">▼</a></th>
						<th class="text-left">전화번호 <a class="text-decoration-none" href="">▼</a></th>
						<th class="text-left">이메일 <a class="text-decoration-none" href="">▼</a></th>
						<th class="text-left">태그</th>
					</tr>
				</thead>
				<tbody>
					<!-- 등록된 게시글이 없으면 아래 내용을 출력한다. -->
							<tr>
								<td colspan="9" class="text-center" >등록된 연락처가 없습니다.</td>
							</tr>
								<!-- 등록된 게시글이 있으면 등록된 게시들의 갯수만큼 아래 내용을 출력한다. -->
								<tr>
									<td class="w3-center tdcenter"><input type="checkbox"></td>
									<td class="w3-center tdcenter"><i class="starfill bi bi-star"></i></td>
									<td class="text-left tdcenter"><a href="../contact/detail" class="text-decoration-none">김진철</a></td>
									<td class="text-left tdcenter">010-1111-2222</td>
									<td class="text-left tdcenter">kimjc@aa.aa</td>
									<td class="text-left tdcenter"><button class="tagbtn">외주</button><button class="tagbtn">SNS 광고</button><button class="tagbtn">그린스페이스</button></td>
								</tr>
								<tr>
									<td class="w3-center tdcenter"><input type="checkbox"></td>
									<td class="w3-center tdcenter"><i class="starfill bi bi-star"></i></td>
									<td class="text-left tdcenter"><a href="" class="text-decoration-none">김진철</a></td>
									<td class="text-left tdcenter">010-1111-2222</td>
									<td class="text-left tdcenter">kimjc@aa.aa</td>
									<td class="text-left tdcenter"><button class="tagbtn">외주</button><button class="tagbtn">SNS 광고</button><button class="tagbtn">그린스페이스</button></td>
								</tr>
								<tr>
									<td class="w3-center tdcenter"><input type="checkbox"></td>
									<td class="w3-center tdcenter"><i class="starfill bi bi-star"></i></td>
									<td class="text-left tdcenter"><a href="" class="text-decoration-none">김진철</a></td>
									<td class="text-left tdcenter">010-1111-2222</td>
									<td class="text-left tdcenter">kimjc@aa.aa</td>
									<td class="text-left tdcenter"><button class="tagbtn">외주</button><button class="tagbtn">SNS 광고</button><button class="tagbtn">그린스페이스</button></td>
								</tr>
								<tr>
									<td class="w3-center tdcenter"><input type="checkbox"></td>
									<td class="w3-center tdcenter"><i class="starfill bi bi-star"></i></td>
									<td class="text-left tdcenter"><a href="" class="text-decoration-none">김진철</a></td>
									<td class="text-left tdcenter">010-1111-2222</td>
									<td class="text-left tdcenter">kimjc@aa.aa</td>
									<td class="text-left tdcenter"><button class="tagbtn">외주</button><button class="tagbtn">SNS 광고</button><button class="tagbtn">그린스페이스</button></td>
								</tr>
								<tr>
									<td class="w3-center tdcenter"><input type="checkbox"></td>
									<td class="w3-center tdcenter"><i class="starfill bi bi-star-fill"></i></td>
									<td class="text-left tdcenter"><a href="" class="text-decoration-none">김진철</a></td>
									<td class="text-left tdcenter">010-1111-2222</td>
									<td class="text-left tdcenter">kimjc@aa.aa</td>
									<td class="text-left tdcenter"><button class="tagbtn">외주</button><button class="tagbtn">SNS 광고</button><button class="tagbtn">그린스페이스</button></td>
								</tr>
								<tr>
									<td class="w3-center tdcenter"><input type="checkbox"></td>
									<td class="w3-center tdcenter"><i class="starfill bi bi-star-fill"></i></td>
									<td class="text-left tdcenter"><a href="" class="text-decoration-none">김진철</a></td>
									<td class="text-left tdcenter">010-1111-2222</td>
									<td class="text-left tdcenter">kimjc@aa.aa</td>
									<td class="text-left tdcenter"><button class="tagbtn">외주</button><button class="tagbtn">SNS 광고</button><button class="tagbtn">그린스페이스</button></td>
								</tr>
								<tr>
									<td class="w3-center tdcenter"><input type="checkbox"></td>
									<td class="w3-center tdcenter"><i class="starfill bi bi-star-fill"></i></td>
									<td class="text-left tdcenter"><a href="" class="text-decoration-none">김진철</a></td>
									<td class="text-left tdcenter">010-1111-2222</td>
									<td class="text-left tdcenter">kimjc@aa.aa</td>
									<td class="text-left tdcenter"><button class="tagbtn">외주</button><button class="tagbtn">SNS 광고</button><button class="tagbtn">그린스페이스</button></td>
								</tr>
								<tr>
									<td class="w3-center tdcenter"><input type="checkbox"></td>
									<td class="w3-center tdcenter"><i class="starfill bi bi-star"></i></td>
									<td class="text-left tdcenter"><a href="" class="text-decoration-none">김진철</a></td>
									<td class="text-left tdcenter">010-1111-2222</td>
									<td class="text-left tdcenter">kimjc@aa.aa</td>
									<td class="text-left tdcenter"><button class="tagbtn">외주</button><button class="tagbtn">SNS 광고</button><button class="tagbtn">그린스페이스</button></td>
								</tr>
								<tr   style="border-bottom: 1px solid gray;">
									<td class="w3-center tdcenter"><input type="checkbox"></td>
									<td class="w3-center tdcenter"><i class="starfill bi bi-star"></i></td>
									<td class="text-left tdcenter"><a href="" class="text-decoration-none">김진철</a></td>
									<td class="text-left tdcenter">010-1111-2222</td>
									<td class="text-left tdcenter">kimjc@aa.aa</td>
									<td class="text-left tdcenter"><button class="tagbtn">외주</button><button class="tagbtn">SNS 광고</button><button class="tagbtn">그린스페이스</button></td>
								</tr>
				</tbody>
			</table>
			</div>
			
			<div class="w3-center">
				<div class="w3-bar">
				  <a href="#" class="w3-button w3-hover-light-grey">«</a>
				  <a href="#" class="w3-button w3-hover-light-grey">1</a>
				  <a href="#" class="w3-button w3-hover-light-grey active">2</a>
				  <a href="#" class="w3-button w3-hover-light-grey">3</a>
				  <a href="#" class="w3-button w3-hover-light-grey">4</a>
				  <a href="#" class="w3-button w3-hover-light-grey">»</a>
				</div>
			</div>
			
			<div class="w3-container"   style="border-top: 1px solid gray; border-bottom: 1px solid gray;">
				<div class="w3-bar">
				  <a href="" class="w3-button w3-white w3-border w3-padding-small w3-hover-light-grey w3-border-grey w3-round-large w3-left w3-small littlemg">내보내기</a>
				  <a href="../contact/form" class="w3-button w3-white w3-border w3-hover-light-grey w3-padding-small w3-border-green w3-round-large w3-left w3-small w3-right littlemg">등록</a>
				  <button href="" onclick="document.getElementById('delete01').style.display='block'" class="w3-button w3-white w3-border w3-padding-small w3-hover-light-grey w3-border-red w3-round-large w3-left w3-small w3-right littlemg">삭제</button>
				  <a href="" class="w3-button w3-white w3-border w3-padding-small w3-hover-light-grey w3-border-grey w3-round-large w3-left w3-small w3-right littlemg">개인 주소록에 추가</a>
				  <a href="" class="w3-button w3-white w3-border w3-padding-small w3-hover-light-grey w3-border-grey w3-round-large w3-left w3-small w3-right littlemg">쪽지</a>
				</div>
			</div>			

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
