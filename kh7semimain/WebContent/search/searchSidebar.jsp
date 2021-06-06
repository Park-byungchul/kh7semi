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
	<span class="sidebarTitle">자료 검색</span>
	
	<ul class="sidebarMenu">
		<li><a class="menuItem"  href="<%=root%>/search/searchInput.jsp">통합자료검색</a></li>
		<li><a class="menuItem"  href="<%=root%>/newbook/newbooklist.jsp">신착자료</a></li>
		<li><a class="menuItem"  href="<%=root%>/recommend/recommendList.jsp">추천도서</a></li>
		<li><a class="menuItem"  href="#">대출베스트</a></li>
	</ul>
</div>

<jsp:include page="/template/sidebar2.jsp"></jsp:include>