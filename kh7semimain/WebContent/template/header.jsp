<%@page import="library.beans.RoleDao"%>
<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@page import="library.beans.AreaDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String pageNow = request.getRequestURI();
	String title = request.getParameter("title");

	String root = request.getContextPath();
	boolean isLogin = session.getAttribute("clientNo") != null;
	
	AreaDao areaDao = new AreaDao();
	List<AreaDto> list = areaDao.list();
	
	int areaNo;
	try{
		areaNo = (int)session.getAttribute("areaNo");
	}
	catch (Exception e){
		areaNo = 0;
	}
	
	int clientNo;
	try{
		clientNo = (int)session.getAttribute("clientNo");
	}
	catch(Exception e){
		clientNo = 0;
	}
	
	ClientDao clientDao = new ClientDao();
	ClientDto clientDto = clientDao.get(clientNo);
	
	boolean adminAll = false;
	boolean adminPart = false;
	
	if(clientDto != null){
		adminAll = clientDto.getClientType().equals("전체관리자");
		adminPart = clientDto.getClientType().equals("권한관리자");
	}
%>
 
<!DOCTYPE html>
<html>
<head>
<title><%=title %></title>
<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/common.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/menu.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/layout.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/test.css">
	<style>
		
	</style>
	
	<script>
	window.onload = function(){
		var area = document.querySelector("#area");
		area.value="<%=root %>/areaSelect.kh?areaNo=<%=areaNo%>";
	}
	
	function areaChange(){
		var area = document.querySelector("#area");
		if(area.value){
			location.href = area.value + "&back=<%=pageNow%>";
		}
	}
</script>
</head>
<body>
	<main>
		<div class="float-container">
			<a href="#" class="right">사이트맵</a>
			<%if(!isLogin){ %>
			<a href="<%=root %>/client/clientInsert.jsp" class="right">회원가입</a>
			<a href="<%=root %>/client/login.jsp" class="right">로그인</a>
			<%}else{ %>
			<a href="<%=root %>/client/clientDetail.jsp" class="right">마이페이지</a>
			<a href="<%=root %>/client/logout.kh" class="right">로그아웃</a>
			<%} %>
			<select id="area" onchange="areaChange();" class="left">
				<option value="">도서관 바로가기</option>
				<option value="<%=root %>/areaSelect.kh?areaNo=0">도서관 홈으로</option>
				<%for (AreaDto areaDto : list){ %>
				<option value="<%=root %>/areaSelect.kh?areaNo=<%=areaDto.getAreaNo()%>"><%=areaDto.getAreaName() %></option>
				<%} %>
			</select>
		</div>
		
		<div class="float-container">
			<div class="left">
				<a href="<%=request.getContextPath() %>">
				<%if(areaNo > 0){ %>
					<%=areaDao.detail(areaNo).getAreaName() %>
				<%} else { %>
					메인 도서관
				<%} %>
				</a>
			</div>
			<div class="left">
				<form action="#" method="post">
					<input type="text" placeholder="검색어를 입력하세요">
					<input type="submit" value="검색">
				</form>
			</div>
				<%if(adminAll || adminPart){ %>
					<div class="right">
						<span><%=clientDto.getClientType() %></span>
						<a href="<%=root %>/admin/adminMenu.jsp">관리자메뉴</a>
					</div>
				<%} %>
			
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
						<li><a href="<%=root%>/search/searchInput.jsp">통합자료검색</a></li>
						<li><a href="#">신착자료</a></li>
						<li><a href="#">추천도서</a></li>
						<li><a href="#">대출베스트</a></li>
					</ul>
				</li>
				
				
				<li>
					<a href="<%=root%>/service/serviceInfo.jsp">도서관 서비스</a>
					<ul>
						<li><a href="<%=root%>/reservation/reservationInfo.jsp">도서 예약</a></li>
						<li><a href="<%=root%>/hopelist/hopelist.jsp">희망도서</a></li>
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
					<a href="<%=request.getContextPath() %>/client/clientDetail.jsp">마이페이지</a>
					<ul>
						<li><a href="<%=request.getContextPath() %>/client/clientDetail.jsp">회원 정보</a></li>
						<li><a href="#">대출/예약/신청도서 관리</a></li>
						<li><a href="<%=root%>/wishlist/wishlist.jsp">관심도서</a></li>
					</ul>
				</li>
				
				
			</ul>
		</nav>