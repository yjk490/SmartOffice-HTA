<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>연락처 추가</title>
<style>
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
				<h1>연락처 추가</h1>
			</div>
			
		<table class="table table-bordered">
			<colgroup>
					<col width="15%">
					<col width="35%">
					<col width="15%">
					<col width="35%">
			</colgroup>
		      <tr>
		      <th class="w3-light-grey w3-center tdcenter">이름</th>
		      <td class="w3-center tdcenter"><input class="form-control" name="name" type="text" placeholder=""></td>
		      <th class="w3-light-grey w3-center tdcenter">공유여부</th>
		      <td class="w3-center tdcenter"><div class="tdcenter"><input class="w3-section tdcenter" type="radio" name="public" value="public" checked><label class="w3-margin tdcenter">공유</label> <input class="w3-section tdcenter" type="radio" name="private" value="private"><label class="w3-margin tdcenter">개인</label></div></td>
		    </tr>
		    <tr>
		      <th class="w3-light-grey w3-center tdcenter">전화번호</th>
		      <td>
		      	  <div class="input-group">
				    <input type="text" class="form-control" name="tel" placeholder="연락처를 입력하세요..">
				    <div class="input-group-btn">
				      <button class="btn btn-default" type="submit">
				        <i class="bi bi-plus-square"></i>
				      </button>
				    </div>
				  </div>
			  </td>
		      <th class="w3-light-grey w3-center tdcenter">이메일</th>
		      <td class="w3-center tdcenter"><input class="form-control" name="email" type="text" placeholder=""></td>
		    </tr>
		    <tr>
		      <th class="w3-light-grey w3-center tdcenter">태그</th>
		      <td>
		        <label for="browser" class="form-label">태그 단어를 입력하세요(한글ㄴㄴ?)</label>
				<input class="form-control" list="browsers" name="tag" id="tag">
				<datalist id="tag">
				  <option value="가족">
				  <option value="친구">
				  <option value="디자인">
				  <option value="외주">
				  <option value="태그없음">
				</datalist>
				</td>
		      <th class="w3-light-grey w3-center tdcenter">생일</th>
		      <td class="tdcenter"><input class="form-control" type="date" id="birthday" name="birthday"></td>
		    </tr>
		    <tr>
		      <th class="w3-light-grey w3-center tdcenter">회사</th>
		      <td><input class="form-control" name="company" type="text" placeholder=""></td>
		      <th class="w3-light-grey w3-center tdcenter">부서/직급</th>
		      <td><input class="form-control" name="position" type="text" placeholder=""></td>
		    </tr>
		    <tr>
		      <th colspan="1" class="w3-light-grey w3-center tdcenter">주소</td>
		      <td colspan="3">
		      	<div class="input-group">
		      		<input class="form-control" type="text" id="sample6_postcode" placeholder="우편번호">
					<input class="w3-button w3-border" type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
				</div>
					<input class="form-control" type="text" id="sample6_address" placeholder="주소">
					<input class="form-control" type="text" id="sample6_detailAddress" placeholder="상세주소">
					<input class="form-control" type="text" id="sample6_extraAddress" placeholder="참고항목">
			</td>
		    </tr>
		    <tr>
		      <th colspan="1" class="w3-light-grey w3-center tdcenter">사진</td>
		      <td colspan="3"><input class="form-control" name="email" type="text" placeholder=""></td>
		    </tr>
		    <tr>
		      <th colspan="1" class="w3-light-grey w3-center tdcenter">URL</td>
		      <td colspan="3"><textarea class="form-control" rows="2" id="memo"></textarea></td>
		    </tr>
		    <tr>
		      <th colspan="1" class="w3-light-grey w3-center tdcenter">메모</td>
		      <td colspan="3"><textarea class="form-control" rows="5" id="memo"></textarea></td>
		    </tr>
	  	</table>
	  	
	  	<div class="w3-container">
				<div class="w3-bar">
				  <button type="submit" class="w3-button w3-white w3-border w3-padding w3-border-green w3-round-large w3-left w3-right littlemg">저장</button>
				  <a href="../contact/list" class="w3-button w3-white w3-border w3-padding w3-border-red w3-round-large w3-left w3-right littlemg">취소</a>
				</div>
			</div>
	  	
	  	
	  	
	  	
	  	
		</div>
		
		
</div>
</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
</html>