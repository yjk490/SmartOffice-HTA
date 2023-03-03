<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>
<div class="container mt-2">
	<div class="w3-sidebar w3-bar-block col-3 border h-auto">
			<div class="w3-container border-bottom ml-2">
				<h4><b>쪽지</b></h4>
			</div>
			<div class="border-bottom">
				<div class="w3-panel w3-display-container">
					<a class="w3-bar-item w3-btn w3-round-xlarge w3-black w3-large w3-center" href="/note/form"><b>쪽지 보내기</b></a>
				</div>
			</div>
			<div class="mt-3">
					<a class="w3-bar-item w3-button ${left eq 'receive' ? 'w3-border w3-border-gray w3-round-large' : '' }" style="${left eq 'receive' ? 'text-shadow:0.6px 0.6px 0 #444' : ''}" href="/note/receive">받은 쪽지함<!--<span class="w3-badge w3-right">6</span> --></a>
			       	<a class="w3-bar-item w3-button ${left eq 'send' ? 'w3-border w3-border-gray w3-round-large' : '' }" style="${left eq 'send' ? 'text-shadow:0.6px 0.6px 0 #444' : ''}" href="/note/sendnote">보낸 쪽지함</a>
			        <a class="w3-bar-item w3-button ${left eq 'draft' ? 'w3-border w3-border-gray w3-round-large' : '' }" style="${left eq 'draft' ? 'text-shadow:0.6px 0.6px 0 #444' : ''}" href="/note/draftnote">임시 보관함</a>
			        <a class="w3-bar-item w3-button ${left eq 'folder' ? 'w3-border w3-border-gray w3-round-large' : '' }" style="${left eq 'folder' ? 'text-shadow:0.6px 0.6px 0 #444' : ''}" href="/note/foldernote">쪽지 보관함</a>
			        <a class="w3-bar-item w3-button ${left eq 'important' ? 'w3-border w3-border-gray w3-round-large' : '' }" style="${left eq 'important' ? 'text-shadow:0.6px 0.6px 0 #444' : ''}" href="/note/important">중요 쪽지함</a>
			        <a class="w3-bar-item w3-button ${left eq 'wagger' ? 'w3-border w3-border-gray w3-round-large' : '' }" style="${left eq 'wagger' ? 'text-shadow:0.6px 0.6px 0 #444' : ''}" href="/note/wagger">휴지통</a>
			</div>
	</div>
</div>
</body>

