<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<title>SMART OFFICE</title>
</head>
<body>
<c:set var="top" value="home" />
<%@ include file="common/navbar.jsp" %>
<div class="container">
	<div class="row mb-4">
		<div class="col-3">
			<div class=" border p-3 bg-light text-center">
				<img src="${profile }" 
				alt="Alps" class="w3-circle" style="width: 75%;">
					<h5>${emp.name }</h5>
					<p>${emp.deptName }팀</p>
			</div>
		</div>
		<div class="col-9">
			<div class="border p-3 bg-light">
				<h4>주간 일정 <a href="/schedule/schedule"><i class="far fa-plus-square w3-right-align"></i></a></h4>
				<div id="calendar"></div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-6">
			<div class="border p-3 bg-light" style="height: 100%">
				<h4>오늘의 할일 <a href="/todo/list?category=100"><i class="far fa-plus-square w3-right-align"></i></a></h4>
				<div>
					<canvas id="myChart" width="200" height="200"></canvas>
				</div>
			</div>
		</div>
		<div class="col-6">
			<div class="border p-3 bg-light" style="height: 100%">
				<h4>받은쪽지 알림 <a href="/note/receive"><i class="far fa-plus-square w3-right-align"></i></a></h4>
					<div class="w3-container p-3">
					  <table class="w3-table-all w3-small">
					  	<colgroup>
							<col width="15%">
							<col width="*">
							<col width="25%">
						</colgroup>
						<thead>
						    <tr>
						      <th class="text-center">보낸사람</th>
						      <th class="text-center">Title</th>
						      <th class="text-center">보낸일자</th>
						    </tr>
					    </thead>
					    <tbody>
					    	<c:choose>
					    		<c:when test="${empty notes }">
					    			<tr>
										<td colspan="3" class="text-center"><b>확인하지 않은 쪽지가 없습니다.</b></td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="note" items="${notes }">
									    <tr>
									      <td class="text-center">${note.senderName }</td>
									      <td class="text-center"><a href="note/read?noteNo=${note.noteNo }" class="text-decoration-none">${note.title }</a></td>
									      <td class="text-center"><fmt:formatDate value="${note.sendDate }"/></td>
									    </tr>
									</c:forEach>
								</c:otherwise>
					    	</c:choose>
					    </tbody>
					  </table>
					</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.2.1/dist/chart.umd.min.js"></script>
<script type="text/javascript">
$(function(){

	// chart.js를 이용한 도넛 차트
	var donutChart = document.getElementById('myChart');
	
	$.ajax({
	  url: '/home/chart',
	  method: 'GET',
	  success: function(data) {
	    var w = data.w;
	    var c = data.c;
	    var total = data.total;
	
	    var donutData = {
	      datasets: [{
	        data: [c, w],
	        backgroundColor: ['#9DCEFF', '#F2F3F6'],
	      }],
	
	      labels: ['완료' + Math.round((c/total)*1000)/10 + '%', '미완료' + Math.round((w/total)*1000)/10 + '%'],
	    };
	
	    var donutOptions = {
	      cutoutPercentage: 80,
	      tooltips: {
	        enabled: false,
	      },
	      responsive: false,
	      legend: {
	        display: false,
	      },
	      animation: {
	        animateRotate: false,
	      },
	    };
	
	    // Create the donut chart using the data and options
	    var chart = new Chart(donutChart, {
	      type: 'doughnut',
	      data: donutData,
	      options: donutOptions,
	    });
	  },
	  error: function() {
	    console.log('Error getting donut chart data');
	  },
	});

	
	// fullcalendar를 이용한 캘린더
	var calendar = new FullCalendar.Calendar(document.getElementById("calendar"), {
		initialView: 'dayGridWeek',
		locale: 'ko',
		height: 240,
		events: function(info, successCallback, failureCallback) {
			let startDate = moment(info.start).format("YYYY-MM-DD");
			let endDate = moment(info.end).format("YYYY-MM-DD");
			
			$.ajax({
				 url: "/home/schedule",
				 dataType: "json",
				 data: {
					 startDate: startDate,
					 endDate: endDate
				 },
				 success: function(response) {
					 var events = [];
					 for (var i = 0; i < response.length; i++) {
						 var event = {
								 title: response[i].title,
								 start: response[i].start,
								 end: response[i].end
						 };
						 events.push(event);
					 }
					 successCallback(events);
				 },
				 error: function(xhr) {
					 console.log("Request failed", xhr);
					 failureCallback();
				 }
			});
		}
	});
	calendar.render();

});
</script>
</body>
</html>