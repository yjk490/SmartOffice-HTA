<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<title>애플리케이션</title>
</head>
<body>
<c:set var="top" value="schedule" />
<%@ include file="../common/navbar.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-3">
			<c:set var="left" value="register" />
			<%@include file="../common/left/schedule.jsp" %>	
		</div>
		<div class="col-9">
			<div class="col-12 mb-3">
					<h1 class="fs-4 border p-2">일정 등록</h1>
			</div>
			<form class="form-control" method="post" action="register" enctype="multipart/form-data">
				<sec:csrfInput />
				<div class="row mb-3">
					<div class="col-2">
						<label class="form-label">날짜&시간</label>
					</div>
					<div class="col-4">
						<input class="form-control" type="date" name="startDate" value="">
						<select class="form-select"  name="startTime" disabled="disabled">
							<option value="09:00">09:00</option>
							<option value="09:30">09:30</option>
							<option value="10:00">10:00</option>
							<option value="10:30">10:30</option>
							<option value="11:00">11:00</option>
							<option value="11:30">11:30</option>
							<option value="12:00">12:00</option>
							<option value="12:30">12:30</option>
							<option value="13:00">13:00</option>
							<option value="13:30">13:30</option>
							<option value="14:00">14:00</option>
							<option value="14:30">14:30</option>
							<option value="15:00">15:00</option>
							<option value="15:30">15:30</option>
							<option value="16:00">16:00</option>
							<option value="16:30">16:30</option>
							<option value="17:00">17:00</option>
							<option value="17:30">17:30</option>
							<option value="18:00">18:00</option>
							<option value="18:30">18:30</option>
							<option value="19:00">19:00</option>
							<option value="19:30">19:30</option>
							<option value="20:00">20:00</option>
						
						</select>
					</div>
					<div class="col">
					~
					</div>			
					<div class="col-4">						
						<input class="form-control" type="date" name="endDate">	
						<select class="form-select"  name="endTime" disabled="disabled">
							<option value="09:00">09:00</option>
							<option value="09:30">09:30</option>
							<option value="10:00">10:00</option>
							<option value="10:30">10:30</option>
							<option value="11:00">11:00</option>
							<option value="11:30">11:30</option>
							<option value="12:00">12:00</option>
							<option value="12:30">12:30</option>
							<option value="13:00">13:00</option>
							<option value="13:30">13:30</option>
							<option value="14:00">14:00</option>
							<option value="14:30">14:30</option>
							<option value="15:00">15:00</option>
							<option value="15:30">15:30</option>
							<option value="16:00">16:00</option>
							<option value="16:30">16:30</option>
							<option value="17:00">17:00</option>
							<option value="17:30">17:30</option>
							<option value="18:00">18:00</option>
							<option value="18:30">18:30</option>
							<option value="19:00">19:00</option>
							<option value="19:30">19:30</option>
							<option value="20:00">20:00</option>
						</select>
					</div>
						<div class="col-1 form-check form-check-inline border">
								<div class="form-check form-switch d-inline float-end">
									<input class="form-check-input" type="checkbox" checked="checked" role="switch" name="allDay" value="Y">
								</div>
								<label class="form-label">종일 여부 체크</label>
						</div>
				</div>
				<div class="row mb-3">
					<div class="col-2">
						<label class="form-label">제목</label>
					</div>
					<div class="col-2">
					<select class="form-select" name="categoryNo">
							<option class="secondary" selected disabled>일정종류</option>
							<option value="1">업무</option>
							<option value="2">중요</option>
							<option value="3">출장</option>
							<option value="4">개인</option>
							<option value="5">휴가</option>
						
					</select>
					</div>
					<div class="col-8">
						<input class="form-control" type="text" name="title" placeholder="일정의 제목을 입력해주세요." val="">
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-2">
						<label class="form-label">장소</label>					
					</div>
					<div class="col-10">
						<input class="form-control" type="text" name="location">
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-2">
						<label class="form-label">회의실예약</label>					
					</div>
					<div class="col-2">
						<button id="meetingRoomBtn" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
						  회의실 예약
						</button>
					</div>
					<div class="col-7">
						<label>예약일자</label><input type="date" class="form-control" name="reservationDate" id="reservationDate" val="" disabled readonly="readonly">
						<span>회의실</span><input type="number" class="form-control" name="roomNo" id="roomNo" val="" disabled readonly="readonly"> 
						<span>예약시간</span><input type="text" class="form-control" name="reservationTime" id="reservationTime" val="" disabled readonly="readonly"> 
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-2">
						<label class="form-label">참여자</label>					
					</div>
					<div class="col-6">
					  <input class="form-control" style="width:20%" type="text" list="employees" id="attendant-tag" />
					  <datalist id ="employees">
						  <c:forEach var="emp" items="${emps}">
						    <option value="${emp.no }" label="${emp.name}"/>
						  </c:forEach>
					  </datalist>
					</div>
					<div class="col-4">
						<div id="tag-btn-box" class="me-3 pt-1 ps-1 mt-1"></div>
						<div id="tag-box" class="me-3 pt-1 ps-1"></div>
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-2">
						<label class="form-label">상세내용</label>					
					</div>
					<div class="col-10">
						<input class="form-control form-control-xs" type="text" name="content">
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-2">
						<label class="form-label">첨부파일</label>					
					</div>
					<div class="col-10">
						<input type="file" name="upfile" />
						<input type="file" name="upfile2" disabled />
					</div>
					<div></div>
				</div>
				<div id="buttons" class="row">
					<div class="col-9"></div>
					<div class="col-3">
						<button class="btn btn-primary" type="submit" class="btn" id="submitBtn">등록</button>
						<button class="btn btn-danger" type="" class="btn">수정</button>
						<button class="btn btn-secondary"><a href=""></a>취소</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
</body>

<!-- modal -->
<sec:csrfInput />
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">Modal title</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="accordion" id="accordionPanelsStayOpenExample">
		  <div class="accordion-item">
		    <h2 class="accordion-header" id="panelsStayOpen-headingOne">
		      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">
		        날짜
		      </button>
		    </h2>
		    <div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne">
		      <div class="accordion-body">
		        <input class="form-control" type="date" id="modalReservationDate" name="modalReservationDate" value="">
		      </div>
		    </div>
		  </div>
		  
		  <div class="accordion-item">
		    <h2 class="accordion-header" id="panelsStayOpen-headingThree">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="false" aria-controls="panelsStayOpen-collapseThree">
		        회의실
		      </button>
		    </h2>
		    <div id="panelsStayOpen-collapseThree" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingThree">
		      <div class="accordion-body">
		        <div class="row">
		        	<div class="col form-check">
		        		<input type="radio" name="modalRoomNo" value="101">회의실1
		        		<input type="radio" name="modalRoomNo" value="102">회의실2
		        		<input type="radio" name="modalRoomNo" value="103">회의실3
		        		<input type="radio" name="modalRoomNo" value="104">회의실4
		        		<input type="radio" name="modalRoomNo" value="105">회의실5
		        	</div>
		        </div>
		      </div>
		    </div>
		  </div>
		  <div class="accordion-item">
		    <h2 class="accordion-header" id="panelsStayOpen-headingTwo">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="false" aria-controls="panelsStayOpen-collapseTwo">
		        시간
		      </button>
		    </h2>
		    <div id="panelsStayOpen-collapseTwo" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingTwo">
		      <div class="accordion-body" id="roomTime">
		        <div class="row mb-2">
		        	<div class="col-3">
		        		<input type="checkbox" name="modalReservationTime" value="09:00" > 09:00
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="modalReservationTime" value="09:30" > 09:30
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="modalReservationTime" value="10:00" > 10:00
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="modalReservationTime" value="10:30" > 10:30
		        	</div>
		        </div>
		        <div class="row mb-2">
		        	<div class="col-3">
		        		<input type="checkbox" name="modalReservationTime" value="11:00" > 11:00
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="modalReservationTime" value="11:30" > 11:30
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="modalReservationTime" value="12:00" > 12:00
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="modalReservationTime" value="12:30" > 12:30
		        	</div>
		        </div>
		        <div class="row mb-2">	
		        	<div class="col-3">
		        		<input type="checkbox" name="modalReservationTime" value="13:00" > 13:00
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="modalReservationTime" value="13:30" > 13:30
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="modalReservationTime" value="14:00" > 14:00
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="modalReservationTime" value="14:30" > 14:30
		        	</div>
		        </div>
		        <div class="row mb-2">
		        	<div class="col-3">
		        		<input type="checkbox" name="modalReservationTime" value="15:00" > 15:00
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="modalReservationTime" value="15:30" > 15:30
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="modalReservationTime" value="16:00" > 16:00
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="modalReservationTime" value="16:30" > 16:30
		        	</div>
		        </div>
		        <div class="row mb-2">
		        	<div class="col-3">
		        		<input type="checkbox" name="modalReservationTime" value="17:00" > 17:00
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="modalReservationTime" value="17:30" > 17:30
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="modalReservationTime" value="18:00" > 18:00
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="modalReservationTime" value="18:30" > 18:30
		        	</div>
		        </div>
		        <div class="row mb-2">
		        	<div class="col-3">
		        		<input type="checkbox" name="modalReservationTime" value="19:00" > 19:00
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="modalReservationTime" value="19:30" > 19:30
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="modalReservationTime" value="20:00" > 20:00
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="modalReservationTime" value="20:30" > 20:30
		        	</div>
		        </div>
		      </div>
		    </div>
		  </div>
		</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="RoomReservationBtn" data-bs-dismiss="modal">등록</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<script src="https://mvnrepository.com/artifact/org.webjars.bower/jquery"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	
	//모달창에서 입력하는 것들.
	let $reservationDate = $("input[name='reservationDate']");
	let $roomNo = $("input[name='roomNo']");
	let $reservationTimeList = $("input[name='reservationTime']");
	
	//태그 관련 	
	let $tagInput = $("#attendant-tag");
	let $tagBtnBox = $("#tag-btn-box");
	let $tagBox = $("#tag-box");
	
	//태그추가하기
	$("#attendant-tag").keydown(function(event) {
		
		if (event.which == 13) {
			let value = $tagInput.val();	
			let label = $("datalist option[value="+value+"]").attr("label")
			if (value == "") {
				return false;
			}
			let tagBtn = `
				<small id="tag-label" class="border rounded bg-primary p-1 text-white">#\${label} 
					<a href="" class="text-white text-decoration-none"><i class="bi bi-x"></i></a>
					<input type="hidden" name="attendants" value="\${value}">
				</small>
			`;
			let tag = `
				
			`
			$tagBtnBox.append(tagBtn);
			$tagBox.append(tag);
			$tagInput.val("");
			
			return false;
		}
		return true;
	});
	
	
	
	//태그 클릭하면 지우기. 나중에 수정하기.
	
	$(document).on("click","#tag-label",function(event){
		event.preventDefault();
		
		alert("클릭한값: "+ $(this).text());
		$(this).empty();
		
		$(this).detach();
	})
	
	
	
	//미팅룸예약버튼눌렀을때 이벤트. 
	$("#RoomReservationBtn").click(function(){
		let modalReservationDate = $("#modalReservationDate").val();
		let modalRoomNo = $("input[name='modalRoomNo']:checked").val();
		let modalReservationTime = $("input[name='modalReservationTime']:checked").val();
		
		let timeLength = $("input[name='modalReservationTime']:checked").length;
		let timeArray = [];
		
		if(timeLength >= 1 && modalRoomNo != null && modalReservationDate != null){
			$reservationDate.removeAttr('disabled');
			$roomNo.removeAttr('disabled');
			$reservationTimeList.removeAttr('disabled');
			
			$("input[name='modalReservationTime']:checked").each(function(e){
				let time = $(this).val();
				timeArray.push(time);
			});
			
			
			$reservationDate.val(modalReservationDate);
			$roomNo.val(modalRoomNo);
			$reservationTimeList.val(timeArray);
		}else{
			alert("예약일자, 회의실, 시간 모두를 선택해주셔야합니다.");
		}
		
		//alert(modalReservationDate);
		//alert(modalRoomNo);
		//alert(timeArray);
		
		
		
		//alert($roomNo.val());
		//alert($reservationTimeList.val());
		
	});	//회의실 예약function 종료.
	
	let $startDate = $("input[name='startDate']")
	let $endDate = $("input[name='endDate']");
	let $allDay = $("input[name='allDay']")
	let $title = $("input[name='title']");
	let $startTime = $("select[name='startTime']");
	let $endTime = $("select[name='endTime']");
	

	//빈칸이면 안되는 곳 체크하기.		
	//만약 올데이가 체크되면 시작시간 종료시간이 disabled 되게하기. 완료
	//분류는 꼭 선택, 제목 꼭 입력
	//회의실 꼭 셋 다 입력되어있어야하기 (이건 아마 회의실버튼누르는데서 하는게 좋을듯)	완료
	//+ 회의실 선택된 시간의 경우에는 표시하기(글씨색을 바꾸든지해야될듯?)	
	//참여자 중복될 경우 안들어가게 하기
	$("#submitBtn").click(function(){
		if($title.val() == null || $startDate.val() == null || $endDate.val() == null){
			return false;
			alert("제목, 시작일자, 종료일자는 필수입력값입니다.")
		};
		
	})
	
	
	
	let flag = $allDay.val();
	
	//올데이체크하면 시간 disabled되게 하기
	$allDay.click(function(){
		console.log(flag)
		if($allDay.is(":checked")){
			flag = 'N'
			$startTime.prop('disabled','disabled');
			$endTime.prop('disabled','disabled');
		}else{
			flag = 'Y'
			$startTime.prop('disabled',false);
			$endTime.prop('disabled',false);
		}
	})
	
	//종료날짜가 시작날짜보다 빠르면 시작날짜로 설정되게하기.
	$endDate.change(function(event){
		if($startDate.val() >= $endDate.val()){
			event.preventDefault();
			alert("종료일자가 시작일자보다 이른 날짜면 안됩니다.");
			$endDate.val($startDate.val());
		}
	})
	
});

</script>