<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");

	String root = request.getContextPath();
	int clientNo;
	try {
		clientNo = (int)session.getAttribute("clientNo");
	}
	catch (Exception e) {
		clientNo = 0;
	}
	ClientDao clientDao = new ClientDao();
	ClientDto clientDto = clientDao.get(clientNo);
	
	String title = "자료 검색";
%>

<jsp:include page="/template/header.jsp">
	<jsp:param value="<%=title%>" name="title"/>
</jsp:include>

<jsp:include page="/template/sidebar1.jsp"></jsp:include>

<h2>자료 검색</h2>
<ul>
	<li><a href="<%=root %>/search/searchInput.jsp">통합자료검색</a></li>
	<li><a href="#">신착자료</a></li>
	<li><a href="#">추천도서</a></li>
	<li><a href="#">대출베스트</a></li>
</ul>

<jsp:include page="/template/sidebar2.jsp"></jsp:include>