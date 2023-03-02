<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<title>애플리케이션</title>
<style>
	/* 일요일 날짜 빨간색 */
	.fc-day-sun a {
	  color: red;
	  text-decoration: none;
	}
	
	/* 토요일 날짜 파란색 */
	.fc-day-sat a {
	  color: blue;
	  text-decoration: none;
	}
</style>
</head>
<body>
<c:set var="top" value="schedule" />
<%@ include file="../common/navbar.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-3">
			<c:set var="left" value="calendar" />
			<%@include file="../common/left/schedule.jsp" %>	
		</div>
		<div class="col-9">
				<div class="col-12 mb-3">
					<h1 class="fs-4 border p-2">일정 보기</h1>
				</div>
				<div class="row mb-3">
					<div class="col-3"> 
						<select class="w3-padding form-select form-select-xs" id="scheduleCategory">
							<option disabled>일정분류</option>
							<option value="whole" selected>전체 일정</option>
							<option value="1">업무 일정</option>
							<option value="2">중요 일정</option>
							<option value="3">출장 일정</option>
							<option value="4">개인 일정</option>
							<option value="5">휴가 일정</option>
						</select>
					</div>
					<div class="col-5">
						
					</div>
					<div class="col-3 w3-padding">
					</div>
				</div>
				
				
				<div class="row">
					
					<div class="col-12" id='calendar'></div>
				</div>
		</div>
	</div>	
</div>

<!-- 일정 등록/수정 모달 -->
<div class="modal" tabindex="-1" id="modal-schedule-info">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">일정 정보</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="card">
					<div class="card-body">
						<form name="schedule-form" action="modify" method="post" enctype="multipart/form-data" class="row g-3">
						<sec:csrfInput />
						<input hidden name="no" val="">
							<div class="col-sm-4">
								<label class="form-label">구분</label>
								<select class="form-select form-select-sm" name="categoryNo">
									<option value="1">업무</option>
									<option value="2">중요</option>
									<option value="3">출장</option>
									<option value="4">개인</option>
									<option value="5">휴가</option>
								</select>
							</div>
							<div class="col-sm-8">
								<label class="form-label">제목</label>
								<input type="text" class="form-control form-control-sm" name="title">
							</div>
							<div class="col-sm-12">
								<label class="form-label">종일여부</label>
								<div class="form-check form-switch d-inline float-end">
									<input class="form-check-input" type="checkbox" role="switch" name="allDay" value="Y">
								</div>
							</div>
							<div class="col-sm-6 mb-2">
								<label class="form-label">시작일자</label>
								<input type="date" class="form-control form-control-sm" name="startDate" val="">
							</div>
							<div class="col-sm-6 mb-2">
								<label class="form-label">시작시간</label>
								<select class="form-control form-control-sm" name="startTime" id="startTime" val="" disabled="disabled">
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
							<div class="col-sm-6 mb-2">
								<label class="form-label">종료일자</label>
								<input type="date" class="form-control form-control-sm" name="endDate" val="">
							</div>
							<div class="col-sm-6 mb-2">
								<label class="form-label">종료시간</label>
								<select class="form-control form-control-sm" name="endTime" val="" disabled="disabled">
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
							<div class="col-sm-12">
								<label class="form-label">내용</label>
								<input type="text" class="form-control" name="content" val="">
							</div>
							<!-- 회의실예약모달연결하기 -->
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
							<div class="col-sm-12">
								<label class="form-label">참석자</label>
								<input type="text" class="form-control" name="attendants" val="" disabled="disabled">
							</div>
							<div class="col-sm-12">
								<label  class="form-label">첨부파일</label>
								<a href="download?filename=" class="btn btn-outline-dark btn-sm" name="attachedFile" disabled="disabled">${file.filename } <i class="bi bi-download ms-2"></i></a>
							</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="submit" class="btn btn-primary" id="btn-modify-schedule" data-bs-dismiss="modal">수정</button>
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			</div>
		</form>
		</div>
	</div>
</div>

<!-- 회의실 modal -->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">회의실예약</h1>
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
        <button type="button" class="btn btn-primary" data-bs-target="#modal-schedule-info" data-bs-toggle="modal" id="RoomReservationBtn">등록</button>
        <button type="button" class="btn btn-secondary" data-bs-target="#modal-schedule-info" data-bs-toggle="modal">닫기</button>
      </div>
    </div>
  </div>
</div>



</body>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.4/index.global.min.js'></script>
<script src="https://momentjs.com/downloads/moment.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	//태그창
	let $tagInput = $("#attendant-tag");
	let $tagBtnBox = $("#tag-btn-box");
	let $tagBox = $("#tag-box");
	
	//회의실 모달창에서 입력하는 것들.
	let $reservationDate = $("input[name='reservationDate']");
	let $roomNo = $("input[name='roomNo']");
	let $reservationTimeList = $("input[name='reservationTime']");
	
	let $startDate = $("input[name='startDate']")
	let $endDate = $("input[name='endDate']");
	let $allDay = $("input[name='allDay']")
	let $title = $("input[name='title']");
	let $startTime = $("select[name='startTime']");
	let $endTime = $("select[name='endTime']");
	//올데이체크하면 시간 disabled되게 하기
	
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
	
	//올데이 체크하면 시간 disabled되게 하기. 
	let flag = $allDay.val();
	
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
	
	//시작날짜보다 끝날짜가 더 앞이면 안되게 + 시작날짜 선택하면 끝날짜도 바뀌게
	
	$startDate.change(function(){
		if($startDate.val() <= $endDate.val()){
			$endDate.val($(this).val());
		}
	})
	
	$endDate.change(function(event){
		if($startDate.val() >= $endDate.val()){
			event.preventDefault();
			alert("종료일자가 시작일자보다 이른 날짜면 안됩니다.");
			$endDate.val($startDate.val());
		}
	})
	
	
})


//모달객체를 생성합니다.
let scheduleInfoModal = new bootstrap.Modal("#modal-schedule-info");
// 모달객체가 닫히면 실행할 이벤트 핸들러 함수를 등록한다.
// 이벤트 핸들러 함수에서는 입력필드의 값을 초기화한다.
$("#modal-schedule-info").on('hidden.bs.modal', function(event) {
	//$(":input[name=title]").val("");
	//$("select[name=categoryNo] option:eq(0)").prop("selected", true);
	//$(":checkbox[name=allDay]").prop("checked", false);
	//$(":input[name=startDate]").val("");
	//$(":input[name=startTime]").val("").prop("disabled", false);
	//$(":input[name=endDate]").val("");
	//$(":input[name=endTime]").val("").prop("disabled", false);
	//$(":input[name=content]").val("");
})

$("#modal-schedule-info").on('submit', function(event){
	
})

document.addEventListener('DOMContentLoaded', function() {
	  let calendarEl = document.getElementById('calendar');

	  let calendar = new FullCalendar.Calendar(calendarEl, {
	    selectable: true,
	    locale: 'ko',
	    initialView: 'dayGridMonth',
	    firstDay: 1,
	    headerToolbar: {
	      left: 'prev,next today',
	      center: 'title',
	      right: 'dayGridMonth,timeGridWeek,timeGridDay'
	    },
	    eventTimeFormat: { // like '14:30:00'
	        hour: '2-digit',
	        minute: '2-digit',
	       	meridiem: false
	    },
	 	// events 프로퍼티에는 달력이 변경될 때마다 실행되는 함수를 등록한다.
		// info는 화면에 표시되는 달력의 시작일, 종료일을 제공한다.
		// 일정정보를 조회하고, successCallback(이벤트배열)함수의 매개변수로 일정정보를 제공하고 실행하면 화면에 반영된다.
		events: function(info, successCallback, failureCallback) {
			refreshEvents(info, successCallback);
		},
	    dateClick: function(info) {
	      alert('clicked ' + info.dateStr);
	      let clickedDate = info.dateStr;
	     
	      document.querySelector("form[name='schedule-form']").action="register";
	      openRegisterModal(info,clickedDate);
	    },
	    eventClick: function(info){
	    	//let clickedEvent = calendar.getEventById(events.no);	//클릭한걸 지정하려면 어떻게??
		    let event = calendar.getEventById(info.event.id); // an event object!	
		    //let start = event.title; // a property (a Date object)
		    let date = event.start;
		    let title = event.title;
		    let backgroundColor = event.backgroundColor;
		    let content	= event.content;
		    let id = event.id;
		    let categoryNo = event.groupId;
		    let startStr = event.startStr;
		    let endStr = event.endStr; //이거 종일일정 같은날에 종료되면 안나옴
		    let startDate = moment(event.startStr).format("YYYY-MM-DD");
		    let endDate = moment(event.endStr).format("YYYY-MM-DD");
		    
		    alert('id' + id);

	    	document.querySelector("form[name='schedule-form']").action="modify";
		    openTodoModal(event);
		    
	    }
	    /*select: function(info) {
	      alert('selected ' + info.startStr + ' to ' + info.endStr);
	    }*/
	  });

	  calendar.render();
	});

//일정 수정 모달을 표시한다.
function openTodoModal(event) {	
	console.log($("form[name='schedule-form']").prop("action"));
	document.querySelector("form[name='schedule-form']").action="modify";
	console.log($("form[name='schedule-form']").prop("action"));
	//스케줄번호 히든필드에 넣기.
	$(":input[name=no]").val(event.id);
	
	//일단 그냥 가져올 수 있는 값들 넣기.
	let startDate = moment(event.startStr).format("YYYY-MM-DD");
	let endDate = moment(event.endStr).format("YYYY-MM-DD");
	let startTime = moment(event.startStr).format("kk:mm");
	let endTime = moment(event.endStr).format("kk:mm");
	let content = event.extendedProps.content;
	let categoryNo = event.groupId;
	let allDay = event.allDay;
	let reservationDate =  moment(event.extendedProps.reservationDate).format("YYYY-MM-DD"); 
	let roomNo = event.extendedProps.roomNo;
	let reservationTime = event.extendedProps.reservationTime;
	let attendants = event.extendedProps.employeeNames;
	let filename = event.extendedProps.filename;
	
	console.log("id: " + event.id)
	console.log("시작시간: " + startTime);
	console.log("끝시간: " + endTime);
	
	
	$(":input[name=title]").val(event.title);
	$(":input[name=startDate]").val(startDate);
	//종일일정 하루만 선택되면 끝날짜가 입력이 안됨. 그래서 시작날짜로 넣어줌.
	if(event.endStr == ""){
		$(":input[name=endDate]").val(startDate);
	} else{
		$(":input[name=endDate]").val(endDate);
	}
	//시작시간 넣어주기.
	$(":input[name=startTime]").val(startTime);
	//끝시간 넣어주기.
	
	$("select[name=categoryNo] option[value="+categoryNo+"]").prop("selected", true);
	//종일여부 값담기. 종일여부가 false면 시작시간, 끝시간 disabled를 없앰.
	if(allDay == true){
		$(":checkbox[name=allDay]").prop("checked", true);
		$(":input[name=startTime]").prop("disabled",true).val("");
		$(":input[name=endTime]").prop("disabled",true).val("");
		
	}else{
		$(":checkbox[name=allDay]").prop("checked", false);
		$(":input[name=startTime]").prop("disabled",false).val(startTime);
		$(":input[name=endTime]").prop("disabled",false).val(endTime);
		
	}
	
	$(":input[name=content]").val(content);	
	
	//회의실부분 값 넣기
	if(roomNo != 0){
		$(":input[name=reservationDate]").prop("disabled",false);
		$(":input[name=roomNo]").prop("disabled",false);
		$(":input[name=reservationTime]").prop("disabled",false);
		$(":input[name=reservationDate]").val(reservationDate);
		$(":input[name=roomNo]").val(roomNo);
		$(":input[name=reservationTime]").val(reservationTime);
	}else{
		$(":input[name=reservationDate]").prop("disabled",true);
		$(":input[name=roomNo]").prop("disabled",true);
		$(":input[name=reservationTime]").prop("disabled",true);
	}
	//참석자 값넣기. null도 length가 1이네? 일단 첫번째항으로 처리.
	if(attendants[0] != null && attendants.length >= 1){
		$(":input[name=attendants]").prop("disabled",false);
		$(":input[name=attendants]").val(attendants);
		
	}else{
		$(":input[name=attendants]").prop("disabled",true);
		
	}
	
	//파일 다운로드되게하기.
	if(filename != null){
		$("a[name=attachedFile]").prop("diabled",false);
		$("a[name=attachedFile]").prop("href", "download?filename="+filename);
		$("a[name=attachedFile]").text(filename);
	}else{
		$("a[name=attachedFile]").prop("diabled",false);
		$("a[name=attachedFile]").prop("href", "");
		$("a[name=attachedFile]").text("첨부된 파일이 없습니다.");
	}
	
	scheduleInfoModal.show();
};


//날짜클릭시 일정등록창 띄우기
function openRegisterModal(info,clickedDate){
	document.querySelector("form[name='schedule-form']").action="register";
	$(":input[name=startDate]").val(clickedDate);
	$(":input[name=endDate]").val(clickedDate);
	$(":input[name=startTime]").prop("disabled",false);
	$(":input[name=endTime]").prop("disabled",false);
	
	scheduleInfoModal.show();
}

//ScheduleEvent들 가져오기
function refreshEvents(info, successCallback) {
	let startDate = moment(info.start).format("YYYY-MM-DD");
	let endDate = moment(info.end).format("YYYY-MM-DD");

	let param = {
		startDate: startDate,
		endDate: endDate
	};
	
	$.ajax({
		type: 'get',
		url: '/schedule/events',
		data: param,
		dataType: 'json'
	})
	.done(function(events) {
		successCallback(events);
	})
}


</script>