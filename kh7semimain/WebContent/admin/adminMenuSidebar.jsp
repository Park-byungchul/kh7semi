<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String root = request.getContextPath();
	int clientNo = (int)session.getAttribute("clientNo");
	ClientDao clientDao = new ClientDao();
	ClientDto clientDto = clientDao.get(clientNo);
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<jsp:include page="/template/sidebar1.jsp"></jsp:include>

<h2>관리자 메뉴</h2>
<%if(clientDto.getClientType().equals("전체관리자")){ %>
<h3>전체관리자</h3>
<ul>
	<li><a href="<%=root %>/client/clientList.jsp">회원관리</a></li>
	<li><a href="<%=root %>/area/areaList.jsp">지점관리</a></li>
	<li><a href="<%=root %>/role/roleList.jsp">권한관리</a></li>
</ul>
<%} else{ %>
<h3>권한관리자</h3>
<ul>
	<li><a href="<%=root %>/role/rolePartialList.jsp">내 지점 권한 관리</a></li>
</ul>
<%} %>

<jsp:include page="/template/sidebar2.jsp"></jsp:include>