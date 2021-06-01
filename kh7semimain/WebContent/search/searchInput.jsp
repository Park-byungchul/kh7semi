<%@page import="java.util.List"%>
<%@page import="library.beans.GetBookDto"%>
<%@page import="library.beans.GetBookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String root = request.getContextPath();
	//목록을 구하는 서버단 코드(Java)
	//= pageNo : 현재 화면의 페이지 번호
	//= type : 검색 수행시의 분류
	//= keyword : 검색 수행시의 검색어
	request.setCharacterEncoding("UTF-8");
	String type = request.getParameter("type"); //검색 정보
	String keyword = request.getParameter("keyword"); //검색 정보
	
	
	GetBookDao getBookDao = new GetBookDao();
	List<GetBookDto> getBookList;
	//select값이 기본 -> '전체' 값을 null로 주고 keyword만 전송
		if(type == null && keyword == null) {
			getBookList = getBookDao.list();
		}
		else if(type.equals("all")){
			getBookList = getBookDao.searchList(keyword);
		}
		else{ //select가 '전체'가 아니면 type과 keyword 같이 전송
			getBookList = getBookDao.searchList(type, keyword);
		}

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자료 검색</title>
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
			<h2>자료 검색</h2>
		</header>
		
		<section>
			<div class= "float-container">
				<aside class="multi-container">
				
				</aside>
				<div class="multi-container" style="width:80%;">
			<div>
				<input type="button"  onclick="location.href='<%=root%>/reservation/reservationInfo.jsp'" value="대출 및 예약 안내">
				<input type="button" value="자료 검색">		
			</div>
				<br><br>
			
				<div>
					<select>
 						<option>전체</option>
 						<option>서명</option>
 						<option>저자</option>
 					</select>
					
					<input type="text" size="50" height = "20">
					<input type="submit" value="검색">
				</div> <br><br>
				
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