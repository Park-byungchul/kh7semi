<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String root = request.getContextPath();
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대출예약 안내</title>
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/common.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/menu.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/layout.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/test.css">
	<style>
		input[type="button"] {
  			width: 300px;
 			height: 50px;
		}
		/* 사이드 영역 */
		.multi-container {
			float:left;
			width:20%;
			height:473px;
		}
	</style>
</head>
<body>
	
	<main>
		<div>
			<a href="#">로그인</a>
			<a href="#">회원가입</a>
			<a href="#">사이트맵</a>
		</div>
	
		<nav>
			<!-- 메뉴 -->
			<ul class="menu">
				<li>
					<a href="#">도서관 소개</a>
					<ul>
						<li><a href="#">찾아오는길</a></li>
						<li><a href="#">자료 현황</a></li>
						<li><a href="#">이용 안내</a></li>
					</ul>
				</li>
				
				<li>
					<a href="<%=root%>/search/searchInput.jsp">자료 검색</a>
					<ul>
						<li><a href="#">통합자료검색</a></li>
						<li><a href="#">신착자료</a></li>
						<li><a href="#">추천도서</a></li>
						<li><a href="#">대출베스트</a></li>
					</ul>
				</li>
				
				
				<li>
					<a href="<%=root%>/service/serviceInfo.jsp">도서관 서비스</a>
					<ul>
						<li><a href="<%=root%>/reservation/reservationInfo.jsp">도서 예약</a></li>
						<li><a href="#">희망도서</a></li>
						<li><a href="#">행사일정</a></li>
					</ul>
				</li>
				
				<li>
					<a href="#">열린 공간</a>
					<ul>
						<li><a href="#">공지사항</a></li>
						<li><a href="#">질문 답변</a></li>
						<li><a href="#">자유게시판</a></li>
						<li><a href="#">도서 리뷰</a></li>
					</ul>
				</li>
				
				<li>
					<a href="#">마이페이지</a>
					<ul>
						<li><a href="#">회원 정보</a></li>
						<li><a href="#">대출/예약/신청도서 관리</a></li>
						<li><a href="#">관심도서</a></li>
					</ul>
				</li>
			</ul>
		</nav>
	
		<header>
			<h2>대출 및 예약 안내</h2>
		</header>
		
		<section>
			<div class= "float-container">
				<aside class="multi-container">
				
				</aside>
				<div class="multi-container" style="width:80%;">
			<div>
				<input type="button" value="대출 및 예약 안내">
				<input type="button" onclick="location.href='<%=root%>/search/searchInput.jsp'" value="대출 및 예약 신청">		
			</div>
				<br><br>
			
				<div class="row">대출 안내</div> <br><br>
				<div class="row">대출예약 안내</div> <br><br>
				<div class="row">대출예약 신청결과 확인</div> <br><br>
				<div class="row">대출예약 선정 제외 기준</div>
			</div>
		</div>		
			
		</section>
		
		<footer>
			<h5>KHAcademy 취업반 수업자료 &copy; </h5>
			<hr>
				세션 ID: <%=session.getId()%>
				회원 번호 : <%=session.getAttribute("memberNo")%>
		</footer>
	</main>
</body>
</html>
</body>
</html>