<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String root = request.getContextPath();
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
	
	if(clientDto != null){
		isAdminAll = clientDto.getClientType().equals("전체관리자");
		isAdminPermission = clientDto.getClientType().equals("권한관리자");
	}
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<jsp:include page="/template/sidebar1.jsp"></jsp:include>

<script>
	$(function(){

		$(".menuItem").each(function(index, data){
			if(window.location.pathname == $(this).attr('href')){
				$(this).addClass("active");
			}
		});

	});
</script>

<div class="sidebarContainer">
<%if(clientDto != null){ %>
	<%if(isAdminAll){ %>
	<span class="sidebarTitle">전체관리자</span>
	
	<ul class="sidebarMenu">
		<li><a class="menuItem" href="<%=root %>/client/clientList.jsp">회원 목록</a></li>
		<li><a class="menuItem" href="<%=root %>/area/areaList.jsp">지점 목록</a></li>
		<li><a class="menuItem" href="<%=root %>/role/roleList.jsp">권한관리자 목록</a></li>
	</ul>
	
	<%} %>
	<%if(isAdminPermission || isAdminAll){ %>
	
	<span class="sidebarTitle">권한관리자</span>
	
	<ul class="sidebarMenu">
		<li><a class="menuItem" href="<%=root %>/client/clientPartialList.jsp">회원 목록</a></li>
		<li><a class="menuItem" href="<%=root %>/role/rolePartialList.jsp">일반관리자 목록</a></li>
		<li><a class="menuItem" href="<%=root %>/promotion/promotionList.jsp">배너 목록</a></li>
	</ul>
	
	<%} %>
	<span class="sidebarTitle">대여접수</span>
	
	<ul class="sidebarMenu">
		<li><a class="menuItem" href="<%=root %>/lendBook/lendBookInsert.jsp">대여접수</a></li>
		<li><a class="menuItem" href="<%=root %>/lendBook/lendBookUpdate.jsp">대여반납</a></li>
		<li><a class="menuItem" href="<%=root %>/lendBook/lendBookList.jsp">대여목록</a></li>
	</ul>
	
	<span class="sidebarTitle">도서 데이터 추가</span>
	
	<ul class="sidebarMenu">
		<li><a class="menuItem" href="<%=root %>/book/bookInsert.jsp">도서등록</a></li>
		<li><a class="menuItem" href="<%=root %>/book/bookList.jsp">도서목록</a></li>
	</ul>
	
	<span class="sidebarTitle">지점별 도서 입고</span>
	
	<ul class="sidebarMenu">
		<li><a class="menuItem" href="<%=root %>/getBook/getBookInsert.jsp">입고등록</a></li>
		<li><a class="menuItem" href="<%=root %>/getBook/getBookList.jsp">입고목록</a></li>
	</ul>
<%} %>
</div>

<jsp:include page="/template/sidebar2.jsp"></jsp:include>