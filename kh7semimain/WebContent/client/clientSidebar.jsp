<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String root = request.getContextPath();
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
	<span class="sidebarTitle">로그인/회원가입</span>
	
	<ul class="sidebarMenu">
		<li><a class="menuItem" href="<%=root %>/client/login.jsp">로그인</a></li>
		<li><a class="menuItem" href="<%=root %>/client/clientInsert.jsp">회원가입</a></li>
	</ul>
</div>

<jsp:include page="/template/sidebar2.jsp"></jsp:include>