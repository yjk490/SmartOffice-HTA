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
    
    <a href="../contact/list" class="text-decoration-none">
    	<div class="w3-bar-block border h-auto">
		<div class="w3-container border-bottom">
		<h4 class="">주소록</h4>
		</div>
	</a>
		
			<div class="w3-panel w3-display-container">
		 	 <a href="../contact/form" class="text-decoration-none w3-bar-item w3-center w3-border w3-border-blue w3-hover-blue w3-button w3-text-hover-white"><i class="bi bi-plus-square"></i> 주소록 등록</a>
		  	</div>
		  	
		  <div class="w3-show-inline-block" style="width: 100%">	
			  <div class="w3-bar border-top">
				  <a href="#" class="w3-button w3-left-align w3-hover-light-grey"  style="width: 85%"><i class="bi bi-person-bounding-box textblue"></i> 공유주소록 <span class="w3-small w3-text-blue">211</span></a>
				  <a href="#" class="w3-button w3-right w3-hover-light-grey"  style="width: 15%"><i class="bi bi-plus-circle"></i></a>
			  </div>
		  </div>
		  
		  <div class="w3-bar">
				  <div>
				  	  <a href="#" class="w3-bar-item w3-button w3-left-align w3-hover-light-grey"><i class="starfill bi bi-star-fill"></i> 자주 사용하는 연락처</a>
				  </div>
			  </div>
		  
		  <div class="w3-show-inline-block" style="width: 100%">
			  <div class="w3-bar">
				  <div>
				  	  <a href="#" class="w3-button w3-left-align w3-hover-light-grey"   style="width: 70%">외주 <span class="w3-small w3-text-blue">50</span></a>
					  <a href="#" class="w3-button w3-right w3-hover-light-grey"  style="width: 15%"><i class="bi bi-x-circle"></i></a>
					  <a href="#" class="w3-button w3-right w3-hover-light-grey"  style="width: 15%"><i class="bi bi-three-dots"></i></a>
				  </div>
			  </div>
		  </div>
		 <div class="w3-show-inline-block" style="width: 100%">
			  <div class="w3-bar">
				  <div>
				  	  <a href="#" class="w3-button w3-left-align w3-hover-light-grey"   style="width: 70%">디자인 <span class="w3-small w3-text-blue">11</span></a>
					  <a href="#" class="w3-button w3-right w3-hover-light-grey"  style="width: 15%"><i class="bi bi-x-circle"></i></a>
					  <a href="#" class="w3-button w3-right w3-hover-light-grey"  style="width: 15%"><i class="bi bi-three-dots"></i></a>
				  </div>
			  </div>
		  </div>
		  <div class="w3-show-inline-block" style="width: 100%">
			  <div class="w3-bar">
				  <div>
				  	  <a href="#" class="w3-button w3-left-align w3-hover-light-grey"   style="width: 70%">태그없음 <span class="w3-small w3-text-blue">150</span></a>
					  <a href="#" class="w3-button w3-right w3-hover-light-grey"  style="width: 15%"><i class="bi bi-x-circle"></i></a>
					  <a href="#" class="w3-button w3-right w3-hover-light-grey"  style="width: 15%"><i class="bi bi-three-dots"></i></a>
				  </div>
			  </div>
		  </div>
		  	
		  <div class="w3-show-inline-block" style="width: 100%">	
			  <div class="w3-bar border-top">
				  <a href="#" class="w3-button w3-left-align w3-hover-light-grey"  style="width: 85%"><i class="bi bi-person-bounding-box textblue"></i> 개인주소록 <span class="w3-small w3-text-blue">211</span></a>
				  <a href="#" class="w3-button w3-right w3-hover-light-grey"  style="width: 15%"><i class="bi bi-plus-circle"></i></a>
			  </div>
		  </div>
		  
		  	<div class="w3-bar">
				<div>
					<a href="#" class="w3-bar-item w3-button w3-left-align w3-hover-light-grey"><i class="starfill bi bi-star-fill"></i> 자주 사용하는 연락처</a>
				</div>
			</div>
		  
		  <div class="w3-show-inline-block" style="width: 100%">
			  <div class="w3-bar">
				  <div>
				  	  <a href="#" class="w3-button w3-left-align w3-hover-light-grey"   style="width: 70%">가족 <span class="w3-small w3-text-blue">50</span></a>
					  <a href="#" class="w3-button w3-right w3-hover-light-grey"  style="width: 15%"><i class="bi bi-x-circle"></i></a>
					  <a href="#" class="w3-button w3-right w3-hover-light-grey"  style="width: 15%"><i class="bi bi-three-dots"></i></a>
				  </div>
			  </div>
		  </div>
		 <div class="w3-show-inline-block" style="width: 100%">
			  <div class="w3-bar">
				  <div>
				  	  <a href="#" class="w3-button w3-left-align w3-hover-light-grey"   style="width: 70%">친구 <span class="w3-small w3-text-blue">11</span></a>
					  <a href="#" class="w3-button w3-right w3-hover-light-grey"  style="width: 15%"><i class="bi bi-x-circle"></i></a>
					  <a href="#" class="w3-button w3-right w3-hover-light-grey"  style="width: 15%"><i class="bi bi-three-dots"></i></a>
				  </div>
			  </div>
		  </div>
		  <div class="w3-show-inline-block" style="width: 100%">
			  <div class="w3-bar">
				  <div>
				  	  <a href="#" class="w3-button w3-left-align w3-hover-light-grey "   style="width: 70%">태그없음 <span class="w3-small w3-text-blue">150</span></a>
					  <a href="#" class="w3-button w3-right w3-hover-light-grey"  style="width: 15%"><i class="bi bi-x-circle"></i></a>
					  <a href="#" class="w3-button w3-right w3-hover-light-grey"  style="width: 15%"><i class="bi bi-three-dots"></i></a>
				  </div>
			  </div>
		  </div>
		  
		 </div>
  	</div>
</body>
</html>