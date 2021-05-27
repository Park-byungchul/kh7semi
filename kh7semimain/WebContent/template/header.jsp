<%@page import="library.beans.AreaDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String root = request.getContextPath();
	boolean isLogin = session.getAttribute("clientNo") != null;
	
	AreaDao areaDao = new AreaDao();
	List<AreaDto> list = areaDao.list();
	
	int libraryNo;
	String libraryName;
	try{
		libraryNo = Integer.parseInt(request.getParameter("libraryNo"));
		libraryName = areaDao.detail(libraryNo).getAreaName();
	}
	catch (Exception e){
		libraryNo = 0;
		libraryName = "메인 도서관";
	}
%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>도서관</title>
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/common.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/menu.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/layout.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/test.css">
	<style>
		
	</style>
</head>
<body>
	<main>
		<div class="float-container">
			<%if(!isLogin){ %>
			<a href="#" class="right">사이트맵</a>
			<a href="<%=request.getContextPath() %>/client/clientInsert.jsp" class="right">회원가입</a>
			<a href="<%=request.getContextPath() %>/client/login.jsp" class="right">로그인</a>
			<%}else{ %>
			<a href="<%=request.getContextPath() %>/client/logout.kh">로그아웃</a>
			<%} %>
			
			<select onchange="if(this.value) location.href=(this.value)" class="left">
				<option value="">도서관 바로가기</option>
				<option value="<%=request.getContextPath() %>">도서관 홈으로</option>
				<%for (AreaDto areaDto : list){ %>
				<option value="<%=request.getContextPath() %>?libraryNo=<%=areaDto.getAreaNo()%>"><%=areaDto.getAreaName() %></option>
				<%} %>
			</select>
		</div>
		
		<div class="float-container">
			<div class="left">
				<a href="#"><%=libraryName %></a>
			</div>
			<div class="left">
				<form action="#" method="post">
					<input type="text" placeholder="검색어를 입력하세요">
					<input type="submit" value="검색">
				</form>
			</div>
			<div class="right">
				<a href="<%=request.getContextPath() %>/client/clientList.jsp">관리자메뉴</a>
			</div>
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
					<a href="#">자료 검색</a>
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
						<li><a href="<%=root%>/board/noticeList.jsp">공지사항</a></li>
						<li><a href="<%=root%>/board/qnaList.jsp">질문 답변</a></li>
						<li><a href="<%=root%>/board/freeBoardList.jsp">자유게시판</a></li>
						<li><a href="<%=root%>/board/reviewList.jsp">도서 리뷰</a></li>
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