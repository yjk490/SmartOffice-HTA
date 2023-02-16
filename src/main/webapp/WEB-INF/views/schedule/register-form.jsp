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
						<select class="form-select"  name="startTime">
							<option value="09:00" selected>09:00</option>
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
						<select class="form-select"  name="endTime">
							<option value="09:00" selected>09:00</option>
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
						<div class="col-1 form-check form-check-inline border ">
								<input class="form-check-input" type="checkbox" name="allDay" value="Y">
								<label class="form-check-label">종일 여부 체크</label>
						</div>
				</div>
				<div class="row mb-3">
					<div class="col-2">
						<label class="form-label">제목</label>
					</div>
					<div class="col-2">
					<select class="form-select"  name="categoryNo">
							<option class="secondary" selected disabled>일정종류</option>
							<option value="1">업무</option>
							<option value="2">중요</option>
							<option value="3">출장</option>
							<option value="4">개인</option>
							<option value="5">휴가</option>
						
					</select>
					</div>
					<div class="col-8">
						<input class="form-control" type="text" name="title" placeholder="일정의 제목을 입력해주세요.">
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
						<div class="bg-primary">d</div>
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-2">
						<label class="form-label">참여자</label>					
					</div>
					<div class="col-6">
					  <input class="form-control" style="width:20%" type="text" list="employees" id="attendant-tag" />
					  <datalist id ="employees">
					    <option value="10015" label="홍길동"/>
					    <option value="10016" label="김유신"/>
					    <option value="10017" label="강감찬"/>
					    <option value="10018" label="이서연"/>
					    <option value="10019" label="이준서"/>
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
						<button class="btn btn-primary" type="submit" class="btn">등록</button>
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
<form action="" method="post" id="meetingRoomReservationForm">
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
		        <input class="form-control" type="date" id="reservationDate" name="reservationDate" value="">
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
		        		<input type="radio" name="roomNo" value="101">회의실1
		        		<input type="radio" name="roomNo" value="102">회의실2
		        		<input type="radio" name="roomNo" value="103">회의실3
		        		<input type="radio" name="roomNo" value="104">회의실4
		        		<input type="radio" name="roomNo" value="105">회의실5
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
		        		<input type="checkbox" name="reservationTime" value="09:00" > 09:00
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="reservationTime" value="09:30" > 09:30
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="reservationTime" value="10:00" > 10:00
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="reservationTime" value="10:30" > 10:30
		        	</div>
		        </div>
		        <div class="row mb-2">
		        	<div class="col-3">
		        		<input type="checkbox" name="reservationTime" value="11:00" > 11:00
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="reservationTime" value="11:30" > 11:30
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="reservationTime" value="12:00" > 12:00
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="reservationTime" value="12:30" > 12:30
		        	</div>
		        </div>
		        <div class="row mb-2">	
		        	<div class="col-3">
		        		<input type="checkbox" name="reservationTime" value="13:00" > 13:00
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="reservationTime" value="13:30" > 13:30
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="reservationTime" value="14:00" > 14:00
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="reservationTime" value="14:30" > 14:30
		        	</div>
		        </div>
		        <div class="row mb-2">
		        	<div class="col-3">
		        		<input type="checkbox" name="reservationTime" value="15:00" > 15:00
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="reservationTime" value="15:30" > 15:30
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="reservationTime" value="16:00" > 16:00
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="reservationTime" value="16:30" > 16:30
		        	</div>
		        </div>
		        <div class="row mb-2">
		        	<div class="col-3">
		        		<input type="checkbox" name="reservationTime" value="17:00" > 17:00
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="reservationTime" value="17:30" > 17:30
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="reservationTime" value="18:00" > 18:00
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="reservationTime" value="18:30" > 18:30
		        	</div>
		        </div>
		        <div class="row mb-2">
		        	<div class="col-3">
		        		<input type="checkbox" name="reservationTime" value="19:00" > 19:00
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="reservationTime" value="19:30" > 19:30
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="reservationTime" value="20:00" > 20:00
		        	</div>
		        	<div class="col-3">
		        		<input type="checkbox" name="reservationTime" value="20:30" > 20:30
		        	</div>
		        </div>
		      </div>
		    </div>
		  </div>
		</div>
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-primary" id="RoomReservationBtn">등록</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
</form>

<script src="https://mvnrepository.com/artifact/org.webjars.bower/jquery"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	let $tagInput = $("#attendant-tag");
	let $tagBtnBox = $("#tag-btn-box");
	let $tagBox = $("#tag-box");
	
	
	$("#attendant-tag").keydown(function(event) {
		
		if (event.which == 13) {
			let value = $tagInput.val();	
			let label = $("datalist option[value="+value+"]").attr("label")
			if (value == "") {
				return false;
			}
			let tagBtn = `
				<small class="border rounded bg-primary p-1 text-white">#\${label} 
				<a href="" class="text-white text-decoration-none"><i class="bi bi-x"></i></a>
				</small>
			`;
			let tag = `
				<input type="hidden" name="attendants" value="\${value}">
			`
			$tagBtnBox.append(tagBtn);
			$tagBox.append(tag);
			$tagInput.val("");
			
			return false;
		}
		return true;
	});
	
	let reservationDate = $("#reservationDate").val();
	
	$("#RoomReservationBtn").click(function(){
		
		
		alert("");
		
		
		
	});
	
	
});

</script>