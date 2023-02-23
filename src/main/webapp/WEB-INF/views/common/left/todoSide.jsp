<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<div class="w3-sidebar w3-bar-block col-3 border h-auto">
	<div class="w3-container border-bottom ml-2">
		<h4><b>업무관리</b></h4>
	</div>
	<div class="border-bottom">
		<div class="w3-panel w3-display-container">
			<a href="insert?category=${left }" class="w3-bar-item w3-btn w3-round-xlarge w3-black w3-large w3-center"><b>업무등록하기</b></a>
		</div>
	</div>
	<button onclick="myFunction('Menu1')" class="w3-button w3-block w3-light-grey w3-left-align">
		나의 할일
    </button>

	<div id="Menu1" class="w3-hide">
  		<a class="w3-bar-item w3-button ${left eq 100 ? 'w3-border w3-border-gray w3-round-large' : '' }" style="${left eq 100 ? 'text-shadow:0.6px 0.6px 0 #444' : ''}" href="list?category=100">나의 할일</a>
	</div>
  
  	<button onclick="myFunction('Menu2')" class="w3-button w3-block w3-light-grey w3-left-align">
		업무 요청
    </button>
	<div id="Menu2" class="w3-hide">
 	 	<a class="w3-bar-item w3-button ${left eq 101 ? 'w3-border w3-border-gray w3-round-large' : '' }" style="${left eq 101 ? 'text-shadow:0.6px 0.6px 0 #444' : ''}" href="list?category=101">나의 업무 요청</a>
        <a class="w3-bar-item w3-button ${left eq 104 ? 'w3-border w3-border-gray w3-round-large' : '' }" style="${left eq 104 ? 'text-shadow:0.6px 0.6px 0 #444' : ''}" href="list?category=104">수신 업무 요청 <span class="w3-badge w3-right">5</span></a>
	</div>
	
  	<button onclick="myFunction('Menu3')" class="w3-button w3-block w3-light-grey w3-left-align">
		업무 보고
    </button>

	<div id="Menu3" class="w3-hide">
 	 	<a class="w3-bar-item w3-button ${left eq 102 ? 'w3-border w3-border-gray w3-round-large' : '' }" style="${left eq 102 ? 'text-shadow:0.6px 0.6px 0 #444' : ''}" href="list?category=102">내가 한 업무 보고</a>
        <a class="w3-bar-item w3-button ${left eq 105 ? 'w3-border w3-border-gray w3-round-large' : '' }" style="${left eq 105 ? 'text-shadow:0.6px 0.6px 0 #444' : ''}" href="list?category=105">수신 업무 보고</a>
	</div>
	
  	<button onclick="myFunction('Menu4')" class="w3-button w3-block w3-light-grey w3-left-align">
		업무 일지
    </button>

	<div id="Menu4" class="w3-hide">
 	 	 <a class="w3-bar-item w3-button ${left eq 103 ? 'w3-border w3-border-gray w3-round-large' : '' }" style="${left eq 103 ? 'text-shadow:0.6px 0.6px 0 #444' : ''}" href="list?category=103">내가 작성한 업무 일지</a>
        <a class="w3-bar-item w3-button ${left eq 106 ? 'w3-border w3-border-gray w3-round-large' : '' }" style="${left eq 106 ? 'text-shadow:0.6px 0.6px 0 #444' : ''}" href="list?category=106">수신 업무 일지 </a>
	</div>
</div>
<script>
function myFunction(id) {
  var x = document.getElementById(id);
  if (x.className.indexOf("w3-show") == -1) {
    x.className += " w3-show"; 
  } else { 
    x.className = x.className.replace("w3-show", "");
  }
}
</script>