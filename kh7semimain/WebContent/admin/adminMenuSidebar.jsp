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

<h2>관리자 메뉴</h2>
<%if(clientDto != null){ %>
	<%if(isAdminAll){ %>
	<h3>전체관리자</h3>
	<ul>
		<li><a href="<%=root %>/client/clientList.jsp">회원 목록</a></li>
		<li><a href="<%=root %>/area/areaList.jsp">지점 목록</a></li>
		<li><a href="<%=root %>/role/roleList.jsp">권한관리자 목록</a></li>
	</ul>
	<%} %>
	<%if(isAdminPermission || isAdminAll){ %>
	<h3>권한관리자</h3>
	<ul>
		<li><a href="<%=root %>/client/clientPartialList.jsp">회원 목록</a></li>
		<li><a href="<%=root %>/role/rolePartialList.jsp">일반관리자 목록</a></li>
		<li><a href="<%=root %>/promotion/promotionList.jsp">배너 목록</a></li>
	</ul>
	<%} %>
	<h3>대여접수</h3>
	<ul>
		<li><a href="<%=root%>/lendBook/lendBookInsert.jsp">대여접수</a></li>
		<li><a href="<%=root%>/lendBook/lendBookUpdate.jsp">대여반납</a></li>
		<li><a href="<%=root%>/lendBook/lendBookList.jsp">대여목록</a></li>
	</ul>
	<h3>도서 데이터 추가하기</h3>
	<ul>
		<li><a href="<%=root%>/book/bookInsert.jsp">도서등록</a></li>
		<li><a href="<%=root%>/book/bookList.jsp">도서목록</a></li>
	</ul>
	<h3>도서 지점별 입고하기</h3>
	<ul>
		<li><a href="<%=root%>/getBook/getBookInsert.jsp">입고등록</a></li>
		<li><a href="<%=root%>/getBook/getBookList.jsp">입고목록</a></li>
	</ul>
<%} %>

<jsp:include page="/template/sidebar2.jsp"></jsp:include>