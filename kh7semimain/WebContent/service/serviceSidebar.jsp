<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
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
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<jsp:include page="/template/sidebar1.jsp"></jsp:include>

<h2>도서관 서비스</h2>
<ul>
	<li><a href="<%=root %>/service/serviceInfo.jsp">이용안내</a></li>
	<li><a href="<%=root %>/reservation/reservationInfo.jsp">도서 예약</a></li>
	<li><a href="<%=root %>/hopelist/hopelist.jsp">희망도서</a></li>
	<li><a href="<%=root %>/plan/plan.jsp">행사일정</a></li>
</ul>

<jsp:include page="/template/sidebar2.jsp"></jsp:include>