<%@page import="library.beans.RoleAreaDao"%>
<%@page import="library.beans.RoleAreaDto"%>
<%@page import="library.beans.RoleDao"%>
<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@page import="library.beans.AreaDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String pageNow = request.getRequestURI();
	String title = request.getParameter("title");

	String root = request.getContextPath();
	boolean isLogin = session.getAttribute("clientNo") != null;
	
	AreaDao areaDao = new AreaDao();
	
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
	
	boolean isAdminAll = false;
	boolean isAdminPermission = false;
	boolean isAdminNormal = false;
	
	if(clientDto != null){
		isAdminAll = clientDto.getClientType().equals("전체관리자");
		isAdminPermission = clientDto.getClientType().equals("권한관리자");
		isAdminNormal = clientDto.getClientType().equals("일반관리자");
	}
	
	boolean isAdminCurrentArea = clientDao.isAdminCurrentArea(clientNo, areaNo);
	
	RoleAreaDao roleAreaDao = new RoleAreaDao();
	
	List<AreaDto> list = areaDao.list();
	List<RoleAreaDto> permissionList = roleAreaDao.areaListByClient(clientNo);
%>
 
<!DOCTYPE html>
<html>
<head>
<title><%=title %></title>
<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/common.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/menu.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/scrolledMenu.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/layout.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/test.css">
	<style>
	
	</style>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script>
	$(function(){
		var area = $(".area");
		area.val("<%=root %>/areaSelect.kh?areaNo=<%=areaNo%>");
		if(area[1]){
			area[1].value = "";
		}
		
		$(window).scroll(function(){
			var menu = $(".menu");
			var top = $("html").scrollTop() || $("body").scrollTop();
			if(top >= 140){
				menu.addClass("fixed");
			}else {
				menu.removeClass("fixed");
			}
		});
		
		$(".area").change(function(){
			var area = $(this);
			for(var i = 0 ; i < area.length ; i++){
				if(area[i].value){
					if(String(area[i].value) != "<%=root %>/areaSelect.kh?areaNo=<%=areaNo %>"){
						location.href = area[i].value + "&back=<%=pageNow%>";
					}		
				}
			}
		});
	});
</script>
</head>
<body>
	<main>
		<div class="float-container loginNav">
			<div class="right">
				<a href="#">사이트맵</a>
				<%if(!isLogin){ %>
				<a href="<%=root %>/client/clientInsert.jsp">회원가입</a>
				<a href="<%=root %>/client/login.jsp">로그인</a>
				<%}else{ %>
				<a href="<%=root %>/client/clientDetail.jsp">마이페이지</a>
				<a href="<%=root %>/client/logout.kh">로그아웃</a>
				<%} %>
			</div>
			
			<div class="left">
				<select class="area">
					<option value="">도서관 바로가기</option>
					<option value="<%=root %>/areaSelect.kh?areaNo=0">도서관 홈으로</option>
					<%for (AreaDto areaDto : list){ %>
					<option value="<%=root %>/areaSelect.kh?areaNo=<%=areaDto.getAreaNo()%>"><%=areaDto.getAreaName() %></option>
					<%} %>
				</select>
			</div>
		</div>
		
		<div class="float-container text-center">
			<div class="left logo">
				<a href="<%=request.getContextPath() %>">
				<%if(areaNo > 0){ %>
					<%=areaDao.detail(areaNo).getAreaName() %>
				<%} else { %>
					메인 도서관
				<%} %>
				</a>
			</div>
			
			<div class="searchHeader">
				<form action="#" method="post">
					<input type="text" placeholder="도서명을 입력하세요" class="searchInput">
					<input type="image" src="<%=root %>/image/search.png" alt="검색버튼" class="searchImage">
				</form>
			</div>
							
			<div class="right myMenu">
			
				<%if(isAdminAll || isAdminPermission || isAdminNormal){ %>
					<div class="right">
						<span><%=clientDto.getClientType() %></span>
						
						<select class="area">
							<option value="">내 관리지점</option>
								<%if(isAdminAll){ %>
									<option value="<%=root %>/areaSelect.kh?areaNo=0">도서관 홈으로</option>
									<%for (AreaDto areaDto : list){ %>
									<option value="<%=root %>/areaSelect.kh?areaNo=<%=areaDto.getAreaNo()%>"><%=areaDto.getAreaName() %></option>
									<%} %>
								<%}else{ %>
									<%for (RoleAreaDto roleAreaDto : permissionList){ %>
									<option value="<%=root %>/areaSelect.kh?areaNo=<%=roleAreaDto.getAreaNo()%>"><%=roleAreaDto.getAreaName() %></option>
									<%} %>
								<%} %>
						</select>
						
						<a href="<%=root %>/admin/adminMenu.jsp">관리자메뉴</a>
					</div>
				<%} %>
				
			</div>
				
		</div>
	
		<nav>
			<!-- 메뉴 -->
			<ul class="menu" style="z-index:1">
				<li>
					<a href="<%=root%>/location/location.jsp">도서관 소개</a>
					<ul>
						<li><a href="<%=root%>/location/location.jsp">찾아오는길</a></li>
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