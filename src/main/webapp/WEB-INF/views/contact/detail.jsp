<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>연락처 보기</title>
<style>
.tagbtn {
  font-size: 12px;    
  border: 1px solid green;
  outline: none;
  color: black;
  padding: 3px 8px;
  background-color: white;
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
</style>
</head>
<body>
<c:set var="menu" value="contact" />
<%@ include file="../common/navbar.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-3">
			<c:set var="left" value="연락처" />
			<%@include file="../common/left/contact.jsp" %>	
		</div>
		
		<div class="col-9">
			<div class="w3-container">
				<h1>연락처</h1>
			</div>
		
		<div class="w3-container w3-border w3-section w3-round-large">
				<table class="w3-table">
					<colgroup>
						<col width="25%">
						<col width="50%">
						<col width="25%">
					</colgroup>
				<tr>
			      <td class="w3-center tdcenter w3-jumbo"><i class="w3-center tdcenter bi bi-person-bounding-box" style="width: 100%"></i></td>
			      <td class="">
			      	<h2 class="">김진철</h2>
			      	<h3><br/></h3>
			      	<h4><i class="bi bi-telephone"></i> 010-1215-1111 <i class="bi bi-envelope-paper"></i> kimjc@aa.aa</h4>
			      	<h4><br /></h4>
			      	<button class="tagbtn">외주</button><button class="tagbtn">SNS 광고</button><button class="tagbtn">그린스페이스</button>
			      </td>
			      <td class=""><p class="w3-right w3-small w3-text-grey">최근수정일: 2022년 3월 22일</p></td>
			    </tr>
			    </table>
		</div>
		
		<div class="w3-half w3-border w3-round-large w3-section" style="width: 60%">
			<table class="w3-table">
					<colgroup>
						<col width="25%">
						<col width="75%">
					</colgroup>
				<tr class="w3-border-bottom">
					<td colspan="2"><h4>연락처 세부정보</h4></td>
				</tr>
				<tr class="w3-border-bottom">
			      <th class="w3-center tdcenter w3-border-right w3-light-grey">전화번호</th>
			      <td class=""><p class="tdcenter">010-1111-1111</p></td>
			    </tr>
			    <tr class="w3-border-bottom">
			      <th class="w3-center tdcenter w3-border-right w3-light-grey">메일</th>
			      <td class=""><p class="tdcenter">sojin@work.com</p></td>
			    </tr>
			    <tr class="w3-border-bottom">
			      <th class="w3-center tdcenter w3-border-right w3-light-grey">회사</th>
			      <td class=""><p class="tdcenter">그린스페이스</p></td>
			    </tr>
			    <tr class="w3-border-bottom">
			      <th class="w3-center tdcenter w3-border-right w3-light-grey">부서/직급</th>
			      <td class=""><p class="tdcenter">마케팅부 대리</p></td>
			    </tr>
			    <tr class="w3-border-bottom">
			      <th class="w3-center tdcenter w3-border-right w3-light-grey">주소</th>
			      <td class=""><p class="tdcenter">서울 종로구 oo로 00-0 1101호</p></td>
			    </tr>
			    <tr class="w3-border-bottom">
			      <th class="w3-center tdcenter w3-border-right w3-light-grey">URL</th>
			      <td class=""><p class="tdcenter">www.sample.co.kr</p></td>
			    </tr>
			    <tr class="w3-border-bottom">
			      <th class="w3-center tdcenter w3-border-right w3-light-grey">생일</th>
			      <td class=""><p class="tdcenter">1993년 3월 29일</p></td>
			    </tr>
			    <tr class="w3-border-bottom">
			      <th class="w3-center tdcenter w3-border-right w3-light-grey">메모</th>
			      <td class=""><p class="tdcenter">SNS 마케팅 주력 회사(카드뉴스, 영상)</p></td>
			    </tr>
			    </table>
		</div>
		
		<div class="w3-half w3-border w3-right w3-round-large w3-section" style="width: 35%">
			<table class="w3-table" style="width: 100%">
				<colgroup>
					<col width="15%">
					<col width="65%">
					<col width="20%">					
				</colgroup>
				<tr class="w3-border-bottom">
					<td colspan="3"><h4>최근 연락내역</h4></td>
				</tr>
				<tr class="">
				  <th class="w3-center tdcenter"><i class="w3-center tdcenter bi bi-envelope"></i></th>
				  <td class=""><p class="tdcenter">그린스페이스_12월 외주 일정 확인</p></td>
				  <td class=""><p class="tdcenter w3-text-grey">5일 전</p></td>
				</tr>
				<tr class="">
				  <th class="w3-center tdcenter"><i class="w3-center tdcenter bi bi-calendar3"></i></th>
				  <td class=""><p class="tdcenter">모코코 SNS 광고_시안_3차</p></td>
				  <td class=""><p class="tdcenter w3-text-grey">2달 전</p></td>
				</tr>
			</table>
		</div>

		<div class="w3-container w3-section">
				<div class="w3-bar">
				  <a href="../contact/list" class="w3-button w3-small w3-white w3-border w3-padding w3-hover-light-grey w3-border-grey w3-round-large w3-left w3-right littlemg">목록</a>
				  <a href="" class="w3-button w3-small w3-white w3-border w3-padding w3-hover-light-grey w3-border-grey w3-round-large w3-left w3-right littlemg">쪽지</a>
				  <a href="../contact/modifyform" type="submit" class="w3-button w3-small w3-white w3-border w3-hover-light-grey w3-padding w3-border-green w3-round-large w3-left w3-right littlemg">수정</a>
				  <a href="" class="w3-button w3-small w3-white w3-border w3-padding w3-hover-light-grey w3-border-red w3-round-large w3-left w3-right littlemg">삭제</a>
				</div>
			</div>
			
			
			
		</div>
</body>
</html>