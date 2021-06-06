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

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

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
	<span class="sidebarTitle">도서관 서비스</span>
	
	<ul class="sidebarMenu">
		<li><a class="menuItem" href="<%=root %>/service/serviceInfo.jsp">이용 안내</a></li>
		<li><a class="menuItem" href="<%=root %>/reservation/reservationInfo.jsp">도서 예약</a></li>
		<li><a class="menuItem" href="<%=root %>/hopelist/hopelist.jsp">희망도서</a></li>
		<li><a class="menuItem" href="<%=root %>/plan/plan.jsp">행사 일정</a></li>
	</ul>
</div>

<jsp:include page="/template/sidebar2.jsp"></jsp:include>